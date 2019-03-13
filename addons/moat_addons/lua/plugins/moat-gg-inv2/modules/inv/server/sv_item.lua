if (not mi.invs) then
	mi.invs = {}
end

local SQL = mi.SQL
hook("InventoryPrepare", function(sql)
    print"\n\n\n\n\n\n\n\n\n\n\n\n\n"
    SQL = mi.SQL
end)
--[[-----------------------------------
Parsing SQL > Table
------------------------------------]]--

if (Server and Server.IsDev) then
    --[[PAIRS_REAL = PAIRS_REAL or pairs
    local p = PAIRS_REAL
    function pairs(d)
        local mt = debug.getmetatable(d)
        if (mt and mt.__pairs) then
            return mt.__pairs(d)
        end
        return p(d)
    end]]
end

local weapon_mt = {
    __tostring = function(self)
        return "Weapon linked to SQL"
    end,
    __index = function(self, k)
        local real_data = rawget(self, "real_data")
        if (real_data) then
            return real_data[k]
        end
    end,
    __newindex = function(self, k, v)
        assert(k ~= "uid", "UID set")
        if (self.Update) then
            self:Update(k, v)
        end
        local real_data = rawget(self, "real_data")
        if (real_data) then
            real_data[k] = v
        end
    end
}
local stats_mt = {
    __tostring = function(self)
        return "Weapon stats linked to SQL"
    end,
    __index = function(self, k)
        local real_data = rawget(self, "real_data")
        if (real_data) then
            return real_data[k]
        end
    end,
    __newindex = function(self, k, v)
        local wep = self.wep
        if (wep and wep.UpdateStat) then
            wep:UpdateStat(k, v)
        end
        local real_data = rawget(self, "real_data")
        if (real_data) then
            real_data[k] = v
        end
    end
}
local talents_mt = {
    __tostring = function(self)
        return "Weapon talents linked to SQL"
    end,
    __index = function(self, k)
        local real_data = rawget(self, "real_data")
        if (real_data) then
            return real_data[k]
        end
    end,
    __newindex = function(self, k, v)
        local wep = self.wep
        if (wep and wep.UpdateTalent) then
            wep:UpdateTalent(k, v)
        end
        local real_data = rawget(self, "real_data")
        if (real_data) then
            real_data[k] = v
        end
    end
}
local function new_stats(wep)
    return setmetatable({real_data = {}, wep = wep}, stats_mt)
end
local function new_talents(wep)
    return setmetatable({real_data = {}, wep = wep}, talents_mt)
end

local function WriteWeaponToNet(self)
	if (self and istable(self)) then
		print "writing..."
	end

    net.WriteBool(not not self.c)
    if (not self.c) then
        return
    end

    net.WriteLong(self.c, 32)
    net.WriteLong(self.u, 32)

    net.WriteBool(not not self.w)
    if (self.w) then
		net.WriteString(isstring(self.w) and self.w or tostring(mi:WepFromID(self.w)))
    end


    -- item stats
    if (self.s) then
        for statid, modifier in pairs(self.s.real_data or self.s) do
            net.WriteByte(statid)
            net.WriteFloat(modifier)
        end
    end
    net.WriteByte(0)


    -- item talents
    if (self.t) then
        for tier, data in pairs(self.t.real_data or self.t) do
			net.WriteByte(tier)
            net.WriteShort(data.e)
            net.WriteShort(data.l)

            local mods = data.m
            for i = 1, 255 do
                if (not mods[i]) then
                    break
                end

                net.WriteBool(true)
                net.WriteFloat(mods[i])
            end

            net.WriteBool(false)
        end
    end
    net.WriteByte(0)


    -- item paints
    net.WriteBool(not not self.p1)
    if (self.p1) then
        net.WriteShort(self.p1)
    end

    net.WriteBool(not not self.p2)
    if (self.p2) then
        net.WriteShort(self.p2)
    end

    net.WriteBool(not not self.p3)
    if (self.p3) then
        net.WriteShort(self.p3)
    end


    -- item nickname
    net.WriteBool(not not self.n)
    if (self.n) then
        net.WriteString(self.n)
    end
end
local function new_weapon(init)
    return setmetatable({
        real_data = init or {},
        WriteToNet = WriteWeaponToNet
    }, weapon_mt)
end

local blank = new_weapon {}
function mi:Blank()
    return blank
end

local buildable = {}
function buildable:CreateStats(data)
    self.s = new_stats(data)
end
function buildable:CreateTalents(data)
    self.t = new_talents(data)
end

function mi:Buildable()
    return new_weapon(table.Copy(buildable))
end

local function UpdateStat(self, statid, modifier)
    mi:SQLQuery("REPLACE INTO moat_inv.items_stats (weaponid, statid, modifier) VALUES (?, ?, ?);", self.c, statid, modifier, function()
        print("saved stat for ", self)
    end)
end

function mi:ParseInventoryQuery(d, q)
    local inv = {["cache"] = {}}

    for i = 1, #d do
        local r = d[i]
        inv[r["id"]] = new_weapon {
            ["c"] = r["id"],
            ["u"] = r["itemid"],
            ["w"] = r["classid"] and self:WepFromID(r["classid"]) or nil,
            ["slotid"] = r["slotid"] or nil,
			["finderid"] = r["finderid"] or nil,
			["locked"] = r["locked"] and true or nil
        }
    end

    while (q:hasMoreResults()) do
        d = q:getData()
        if (not d[1]) then
			break
		end

        if (d[1]["statid"]) then self:ParseItemStatsQuery(d, inv) end
        if (d[1]["talentid"]) then self:ParseItemTalentsQuery(d, inv) end
        if (d[1]["paintid"]) then self:ParseItemPaintsQuery(d, inv) end
        if (d[1]["nickname"]) then self:ParseItemNamesQuery(d, inv) end

        q:getNextResults()
    end
    inv["cache"] = nil

    for id, wep in pairs(inv) do
        wep.UpdateStat = UpdateStat
    end

    return inv
end

function mi:ParseItemStatsQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        local wep = inv[r["id"]]
        if (not wep["s"]) then
            wep["s"] = new_stats(wep)
        end
        wep["s"][tonumber(r["statid"]) or r["statid"]] = r["modifier"]
    end
end

function mi:ParseItemTalentsQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        local wep = inv[r["id"]]
        if (not wep["t"]) then
            wep["t"] = new_talents(wep)
        end
        local c = r["id"] .. r["talentid"] .. r["required"]
        local t = MOAT_TALENTS[r["talentid"]]["Tier"]

        if (r["modification"] > 1) then
            local n = inv["cache"][c] or t
            wep["t"][n]["m"][r["modification"]] = r["modifier"]
            continue
        end

        inv["cache"][c] = wep["t"][t] and t + 1 or t
        wep["t"][inv["cache"][c]] = {
            ["m"] = {
                r["modifier"]
            },
            ["e"] = r["talentid"],
            ["l"] = r["required"]
        }
    end
end

function mi:ParseItemPaintsQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        inv[r["id"]]["p" .. r["type"]] = r["paintid"]
    end
end

function mi:ParseItemNamesQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        inv[r["id"]]["n"] = r["nickname"]
    end
end


--[[-----------------------------------
Parsing Item > SQL
------------------------------------]]--

function mi:QueryFromItem(i, o)
    if (i.s and ((not i.s.real_data and next(i.s) ~= nil) or (i.s.real_data and next(i.s.real_data) ~= nil))) then -- weapon
        if (i.t and ((not i.t.real_data and next(i.t) ~= nil) or (i.t.real_data and next(i.t.real_data) ~= nil))) then
            return self:InsertWeaponTalents(i, o)
        else
            return self:InsertWeaponStats(i, o)
        end
    else
        if (i.w) then
            return self:InsertWeapon(i, o)
        else
            return self:InsertItem(i, o)
        end
    end
end

function mi:InsertItem(tbl, ownerid)
    return SQL:CreateQuery("call moat_inv.item_add(?, ?!, ?, ?);", tbl.u, ownerid, tbl.slot, (tbl.l and tbl.l == 1) and "" or nil)
end


function mi:InsertWeapon(tbl, ownerid)
    return SQL:CreateQuery("call moat_inv.weapon_add(?, ?!, ?, ?, ?);", tbl.u, ownerid, tbl.slot, tbl.w and self:WepToID(tbl.w) or nil, (tbl.l and tbl.l == 1) and "" or nil)
end

function mi:InsertWeaponStats(tbl, ownerid)
    local data = {
        stat_count = 0,
        slot = tbl.slot,
        class_id = tbl.w and self:WepToID(tbl.w) or nil,
		is_locked = (tbl.l and tbl.l == 1) and "" or nil,
        tbl.u,
        ownerid
    }

    for k, v in pairs(tbl.s.real_data or tbl.s) do
        data.stat_count = data.stat_count + 1

        table.insert(data, k)
        table.insert(data, v)
    end

    if (data.stat_count == 0) then
        return self:InsertWeapon(tbl, ownerid)
    end

    return SQL:CreateQuery("call moat_inv.weapon_add_?stat_countStats(?, ?!, ?slot, ?class_id, ?is_locked" .. string.rep(", ?, ?", data.stat_count) .. ");", data)
end

function mi:InsertWeaponTalents(tbl, ownerid)
	local data = {
        stat_count = 0,
		talent_count = 0,
        slot = tbl.slot,
        class_id = tbl.w and self:WepToID(tbl.w) or nil,
		is_locked = (tbl.l and tbl.l == 1) and "" or nil,
        tbl.u,
        ownerid
    }

    for k, v in pairs(tbl.s.real_data or tbl.s) do
        table.insert(data, k)
        table.insert(data, v)

        data.stat_count = data.stat_count + 1
    end

    for k, v in ipairs(tbl.t.real_data or tbl.t) do
        for i = 1, #v["m"] do
            table.insert(data, v.e)
            table.insert(data, v.l)
            table.insert(data, i)
            table.insert(data, v.m[i])

            data.talent_count = data.talent_count + 1
        end
    end

    return SQL:CreateQuery("call moat_inv.weapon_add_?stat_countStats_?talent_countTalents(?, ?!, ?slot, ?class_id, ?is_locked" .. string.rep(", ?", (data.stat_count * 2) + (data.talent_count * 4)) .. ");", data)
end

function mi:LastInsertID()
    return SQL:Function("LAST_INSERT_ID")
end

function mi:Raw(s)
    return SQL:Raw(s)
end

function mi:QueryForName(name, weaponid, ownerid)
    return SQL:CreateQuery("call moat_inv.item_names_add(?, ?, ?!);", weaponid, name, ownerid)
end

function mi:CreateQuery(...)
    return SQL:CreateQuery(...)
end

function mi:QueryForPaint(tbl, weaponid)
    local query = {}
    if (tbl["p"]) then
        table.insert(query, SQL:CreateQuery("call moat_inv.item_paints_add(?, ?, ?);", weaponid, tbl.p, 1))
    end

    if (tbl["p2"]) then
        table.insert(query, SQL:CreateQuery("call moat_inv.item_paints_add(?, ?, ?);", weaponid, tbl.p2, 2))
    end

    if (tbl["p3"]) then
        table.insert(query, SQL:CreateQuery("call moat_inv.item_paints_add(?, ?, ?);", weaponid, tbl.p3, 3))
    end

    return table.concat(query, "")
end

local function BuildQuery(steamid, y, inv_tbl, LAST_INSERT_ID, slots, qstr)
	slots = slots or 0
	qstr = qstr or ""

	for k, v in ipairs(inv_tbl) do
        if (not v.u) then
			continue
		end
		
		slots = slots + 1
		v["slot"] = k * y

        if (v["tr"] and v["s"]) then
			v["s"]["tr"] = ""
		end

		if (v.s) then
			for char, id in pairs(mi.Stat.OldChars) do
				if (v.s[char]) then
					v.s[id] = v.s[char]
					v.s[char] = nil
				end
			end
		end

		v = new_weapon(v)
		
        local str = mi:QueryFromItem(v, steamid)
        local var = mi:Raw "@cid"
        str = str .. mi:CreateQuery("set ? = ?;", var, LAST_INSERT_ID)

        if (v.n) then
            str = str .. mi:QueryForName(v.n, var, steamid)
        end

        if (v.p or v.p2 or v.p3) then
            str = str .. mi:QueryForPaint(v, var)
        end

        qstr = qstr .. str
    end

	return qstr, slots
end

function mi:GetOldInvQuery(inv_tbl, loadout, steamid)
    local LAST_INSERT_ID = mi:LastInsertID()
    local qstr, slots = "", 0

	qstr = qstr .. BuildQuery(steamid, -1, loadout, LAST_INSERT_ID, slots, qstr)
	qstr, slots = BuildQuery(steamid, 1, inv_tbl, LAST_INSERT_ID, slots, qstr)

	return qstr
end

concommand.Add("test_inv1", function(pl, cmd, args)
    local start_time = SysTime()

    pl:LoadInventory(function(pl, inv)
        local end_time = SysTime()
        print(end_time - start_time)
    end)
end)