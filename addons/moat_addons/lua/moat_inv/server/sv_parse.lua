--[[-----------------------------------
Parsing SQL > Table
------------------------------------]]--

function MOAT_INV:ParseInventoryQuery(d, q)
    local inv = {["cache"] = {}}

    for i = 1, #d do
        local r = d[i]
        inv[r["id"]] = {["u"] = r["itemid"], ["w"] = r["classname"] or nil}
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
        if (not inv[r["id"]]["s"]) then inv[r["id"]]["s"] = {} end
        inv[r["id"]]["s"][r["statid"]] = r["value"]
    end
end

function MOAT_INV:ParseItemTalentsQuery(d, inv)
    for i = 1, #d do
        local r = d[i]
        if (not inv[r["id"]]["t"]) then inv[r["id"]]["t"] = {} end
        local c = r["id"] .. r["talentid"] .. r["required"]
        local t = MOAT_TALENTS[r["talentid"]]["Tier"]

        if (r["modification"] > 1) then
            local n = inv["cache"][c] or t
            inv[r["id"]]["t"][n]["m"][r["modification"]] = r["value"]
            continue
        end

        inv["cache"][c] = inv[r["id"]]["t"][t] and t + 1 or t
        inv[r["id"]]["t"][inv["cache"][c]] = {
            ["m"] = {r["value"]},
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

--[[
{"t":[{"m":[1.0],"l":8.0,"e":85.0},
    {"m":[1.0,1.0],"l":14.0,"e":154.0},
    {"m":[1.0,1.0],"l":27.0,"e":3.0}],
 "u":1147.0,
 "c":"2197761330",
 "s":{"x":170.0,"k":0.197,"f":0.803
    "m":0.429,"w":0.682,"r":0.458,
    "l":13.0,"a":0.521,"d":0.183},
 "w":"weapon_ttt_te_sr25",
    "tr":1.0,
    "n":"Hitregs...",
    "l":1.0,
    "p":6035.0}
]]

function MOAT_INV:item(u)
    return "call insertItem(" .. u
end

function MOAT_INV:weapon(u)
    return "call insertWeapon(" .. u
end

function MOAT_INV:stats(u, s)
    return "call insertWeapon#Stats(" .. u
end

function MOAT_INV:talents(u)
    return "call insertWeapon#Stats#Talents(" .. u
end

function MOAT_INV:paint(u)
    return "call insertItemPaint(" .. u
end

function MOAT_INV:name(u)
    return "call insertItemName(" .. u
end

function MOAT_INV:InsertItem(tbl, owner)
    return self:item(tbl["u"]):add(owner):add(tbl["slot"] or "0"):finish()
end

function MOAT_INV:InsertWeapon(tbl, owner)
    return self:weapon(tbl["u"])
    :add(owner)
    :add(tbl["slot"] or "0")
    :add(self:Escape(tbl["w"]))
    :finish()
end

function MOAT_INV:InsertWeaponStats(tbl, owner)
    local n, s = 0, self:stats(tbl["u"])
    :add(owner)
    :add(tbl["slot"] or "0")
    :add(self:Escape(tbl["w"]))

    for k, v in pairs(tbl["s"]) do
        s = s:add(self:Escape(k)):add(v)
        n = n + 1
    end

    if (n == 0) then return self:InsertWeapon(tbl, owner) end
    return s:finish(n)
end

function MOAT_INV:InsertWeaponTalents(tbl, owner)
    local n, a, s = 0, 0, self:talents(tbl["u"])
    :add(owner)
    :add(tbl["slot"] or "0")
    :add(self:Escape(tbl["w"]))

    for k, v in pairs(tbl["s"]) do
        s = s:add(self:Escape(k)):add(v)
        n = n + 1
    end

    for k, v in ipairs(tbl["t"]) do
        for i = 1, #v["m"] do
            s = s:add(v["e"]):add(v["l"]):add(i):add(v["m"][i])
            a = a + 1
        end
    end

    return s:finish(n, a)
end

function MOAT_INV:QueryForName(n, u)
    local s = self:name(u)
    :add(self:Escape(n))
    return s:finish()
end

function MOAT_INV:QueryForPaint(i, u)
    local s, a = self:paint(u)

    if (i["p"]) then
        s = s:add(1):add(i["p"]):finish()
        a = 1
    end

    if (i["p2"]) then
        if (a) then s = s .. self:paint(u) end
        s = s:add(2):add(i["p2"]):finish()
        a = 1
    end

    if (i["p3"]) then
        if (a) then s = s .. self:paint(u) end
        s = s:add(3):add(i["p3"]):finish()
    end

    return s
end

function MOAT_INV:QueryFromItem(i, o)
    return i["s"] and (i["t"] and self:InsertWeaponTalents(i, o) or self:InsertWeaponStats(i, o)) or (i["w"] and self:InsertWeapon(i, o) or self:InsertItem(i, o))
end


concommand.Add("test_inventory", function(pl, cmd, args)
    local id = pl:SteamID64()

    local qstr = ""
    for k, v in pairs(MOAT_INVS[pl]) do
        if (not v.u) then continue end

        if (k:StartWith("l")) then v["slot"] = k:TrimLeft("l_slot") end
        if (v["tr"] and v["s"]) then v["s"]["tr"] = nil v["s"]["j"] = "1" end

        local str = MOAT_INV:QueryFromItem(v, id)

        if (v.n) then
            str = str .. MOAT_INV:QueryForName(v.n, "LAST_INSERT_ID()")
        end

        if (v.p or v.p2 or v.p3) then
            str = str .. MOAT_INV:QueryForPaint(v, "LAST_INSERT_ID()")
        end

        qstr = qstr .. str
    end

    MOAT_INV:Query(qstr, function(d)
        print("done")
    end)
end)

concommand.Add("test_inv1", function(pl, cmd, args)
    local start_time = SysTime()

    pl:LoadInventory(function()
        end_time = SysTime()

        print(end_time - start_time, start_time, end_time)
    end)
end)