local SQL = MOAT_INV.SQL
hook.Add("InventoryPrepare", "MOAT_INV.Prepare", function(sql)
    print"\n\n\n\n\n\n\n\n\n\n\n\n\n"
    SQL = MOAT_INV.SQL
end)
--[[-----------------------------------
Parsing SQL > Table
------------------------------------]]--

if (GetHostName():lower():find "dev") then
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
    net.WriteBool(not not self.c)
    if (not self.c) then
        return
    end
    net.WriteUInt(self.c, 32)
    net.WriteUInt(self.u, 32)
    net.WriteBool(not not self.w)
    if (self.w) then
        net.WriteString(self.w)
    end
    -- item stats
    if (self.s) then
        for statid, value in pairs(self.s.real_data) do
            net.WriteUInt(statid:byte(1,1), 8)
            net.WriteFloat(value)
        end
    end
    net.WriteUInt(0, 8)

    -- item talents
    if (self.t) then
        for tier, data in pairs(self.t.real_data) do
            net.WriteUInt(tier, 8)
            net.WriteUInt(data.e, 16)
            net.WriteUInt(data.l, 16)
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
    net.WriteUInt(255, 8)

    -- item paints
    net.WriteBool(not not self.p1)
    if (self.p1) then
        net.WriteUInt(self.p1, 16)
    end
    net.WriteBool(not not self.p2)
    if (self.p2) then
        net.WriteUInt(self.p2, 16)
    end
    net.WriteBool(not not self.p3)
    if (self.p3) then
        net.WriteUInt(self.p3, 16)
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
function MOAT_INV:Blank()
    return blank
end

function MOAT_INV:ParseInventoryQuery(d, q)
    local inv = {["cache"] = {}}

    for i = 1, #d do
        local r = d[i]
        inv[r["id"]] = new_weapon {
            ["c"] = r["id"],
            ["u"] = r["itemid"],
            ["w"] = r["classname"] or nil,
            ["slotid"] = r["slotid"] or nil
        }
    end

    while (q:hasMoreResults()) do
        d = q:getData()
        if (not d[1]) then break end

        if (d[1]["statid"]) then self:ParseItemStatsQuery(d, inv) end
        if (d[1]["talentid"]) then self:ParseItemTalentsQuery(d, inv) end
        if (d[1]["paintid"]) then self:ParseItemPaintsQuery(d, inv) end
        if (d[1]["nickname"]) then self:ParseItemNamesQuery(d, inv) end

        q:getNextResults()
    end
    inv["cache"] = nil

    return inv
end

function MOAT_INV:ParseItemStatsQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        local wep = inv[r["id"]]
        if (not wep["s"]) then
            wep["s"] = new_stats(wep)
        end
        wep["s"][r["statid"]] = r["value"]
    end
end

function MOAT_INV:ParseItemTalentsQuery(d, inv)
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
            wep["t"][n]["m"][r["modification"]] = r["value"]
            continue
        end

        inv["cache"][c] = wep["t"][t] and t + 1 or t
        wep["t"][inv["cache"][c]] = {
            ["m"] = {
                r["value"]
            },
            ["e"] = r["talentid"],
            ["l"] = r["required"]
        }
    end
end

function MOAT_INV:ParseItemPaintsQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        inv[r["id"]]["p" .. r["type"]] = r["paintid"]
    end
end

function MOAT_INV:ParseItemNamesQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        inv[r["id"]]["n"] = r["nickname"]
    end
end


--[[-----------------------------------
Parsing Item > SQL
------------------------------------]]--

function MOAT_INV:QueryFromItem(i, o)
    if (i.s) then -- weapon
        if (i.t) then
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

function MOAT_INV:InsertItem(tbl, owner)
    return SQL:CreateQuery("call insertItem(?, ?!, ?);", tbl.u, owner, tbl.slot)
end


function MOAT_INV:InsertWeapon(tbl, owner)
    return SQL:CreateQuery("call insertWeapon(?, ?!, ?, ?);", tbl.u, owner, tbl.slot, tbl.w)
end

function MOAT_INV:InsertWeaponStats(tbl, owner)
    local data = {
        stat_count = 0,
        slot = tbl.slot,
        class_name = tbl.w,
        tbl.u,
        owner
    }
    for k, v in pairs(tbl["s"]) do
        data.stat_count = data.stat_count + 1
        table.insert(data, k)
        table.insert(data, v)
    end

    if (data.stat_count == 0) then
        return self:InsertWeapon(tbl, owner)
    end
    return SQL:CreateQuery("call insertWeapon?stat_count#Stats(?, ?!, ?slot, ?class_name"..string.rep(", ?, ?", data.stat_count)..");", data)
end

function MOAT_INV:InsertWeaponTalents(tbl, owner)
    local data = {
        stat_count = 0,
        talent_count = 0,
        slot = tbl.slot,
        class_name = tbl.w,
        tbl.u,
        owner,
    }
    for k, v in pairs(tbl["s"]) do
        table.insert(data, k)
        table.insert(data, v)
        data.stat_count = data.stat_count + 1
    end
    for k, v in ipairs(tbl["t"]) do
        for i = 1, #v["m"] do
            table.insert(data, v.e)
            table.insert(data, v.l)
            table.insert(data, i)
            table.insert(data, v.m[i])
            data.talent_count = data.talent_count + 1
        end
    end
    return SQL:CreateQuery("call insertWeapon?stat_count#Stats?talent_count#Talents(?, ?!, ?slot, ?class_name"..string.rep(", ?", data.stat_count * 2 + data.talent_count * 4)..");", data)
end

function MOAT_INV:LastInsertID()
    return SQL:Function("LAST_INSERT_ID")
end

function MOAT_INV:Raw(s)
    return SQL:Raw(s)
end

function MOAT_INV:QueryForName(n, u)
    return SQL:CreateQuery("call insertItemName(?, ?);", u, n)
end

function MOAT_INV:CreateQuery(...)
    return SQL:CreateQuery(...)
end

function MOAT_INV:QueryForPaint(i, u)
    local query = {}
    if (i["p"]) then
        table.insert(query, SQL:CreateQuery("call insertItemPaint(?, ?, ?);", u, 1, i.p))
    end

    if (i["p2"]) then
        table.insert(query, SQL:CreateQuery("call insertItemPaint(?, ?, ?);", u, 2, i.p2))
    end

    if (i["p3"]) then
        table.insert(query, SQL:CreateQuery("call insertItemPaint(?, ?, ?);", u, 3, i.p3))
    end

    return table.concat(query, "")
end

local function LoadInventory_Deprecated(ply, cb)
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_inventories WHERE steamid = 'STEAM_0:0:46558052'")

    function query1:onSuccess(data)
        if (#data > 0) then
            local MOAT_MAX_INVENTORY_SLOTS = data[1].max_slots
            local inv_tbl = {}
            local row = data[1]
            inv_tbl["credits"] = util.JSONToTable(row["credits"])

            for i = 1, 10 do
                inv_tbl["l_slot" .. i] = util.JSONToTable(row["l_slot" .. i])
            end

            local inventory_tbl = util.JSONToTable(row["inventory"])

            for i = 1, MOAT_MAX_INVENTORY_SLOTS do
                inv_tbl["slot" .. i] = inventory_tbl[i]

                if (i == MOAT_MAX_INVENTORY_SLOTS) then
                    cb(inv_tbl)
                end
            end
        end
    end

    function query1:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then

            MINVENTORY_MYSQL:connect()
            timer.Simple(1, function() LoadInventory_Deprecated(ply) end)
            --MINVENTORY_MYSQL:wait()


            --m_LoadInventoryForPlayer(ply)

            return
        end
    end

    query1:start()

    --UPDATE core_members SET last_activity = 1524525387 WHERE steamid = 76561198831932398
    local query2 = MINVENTORY_MYSQL:query("UPDATE core_members SET last_activity = UNIX_TIMESTAMP() WHERE steamid = '" .. ply:SteamID64() .. "'")
    query2:start()
end

concommand.Add("test_inventory", function(pl, cmd, args)
    LoadInventory_Deprecated(pl, function(inv)
        local LAST_INSERT_ID = MOAT_INV:LastInsertID()
        local id = pl:SteamID64()
        local qstr = ""
        for k, v in pairs(inv) do
            if (not v.u) then continue end

            if (k:StartWith("l")) then
                v["slot"] = tonumber(k:TrimLeft("l_slot"))
            end
            if (v["tr"] and v["s"]) then v["s"]["tr"] = nil v["s"]["j"] = "1" end

            local str = MOAT_INV:QueryFromItem(v, id)

            local var = MOAT_INV:Raw "@cid"

            str = str .. MOAT_INV:CreateQuery("set ? = ?;", var, LAST_INSERT_ID)

            if (v.n) then
                str = str .. MOAT_INV:QueryForName(v.n, var)
            end

            if (v.p or v.p2 or v.p3) then
                str = str .. MOAT_INV:QueryForPaint(v, var)
            end

            qstr = qstr .. str
        end
        MOAT_INV:SQLQuery(qstr, function(d)
            print("done")
        end)
    end)
end)

concommand.Add("test_inv1", function(pl, cmd, args)
    local start_time = SysTime()

    pl:LoadInventory(function(pl, inv)
        end_time = SysTime()

        PrintTable(inv)

        print(end_time - start_time, start_time, end_time)
    end)
end)