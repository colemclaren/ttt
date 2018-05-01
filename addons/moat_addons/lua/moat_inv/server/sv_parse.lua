local SQL
local mysqloo = include "sql_mysqloo.lua"
hook.Add("InventoryPrepare", "MOAT_INV.Prepare", function(sql)
    SQL = mysqloo(sql)
end)
--[[-----------------------------------
Parsing SQL > Table
------------------------------------]]--

function MOAT_INV:ParseInventoryQuery(d, q)
    local inv = {["cache"] = {}}

    for i = 1, #d do
        local r = d[i]
        inv[r["id"]] = {
            ["u"] = r["itemid"],
            ["w"] = r["classname"] or nil
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

concommand.Add("test_inventory", function(pl, cmd, args)
    local LAST_INSERT_ID = MOAT_INV:LastInsertID()
    local id = pl:SteamID64()
    local inv = table.Copy(MOAT_INVS[pl])

    local qstr = ""
    for k, v in pairs(inv) do
        if (not v.u) then continue end

        if (k:StartWith("l")) then v["loadoutslot"] = k:TrimLeft("l_slot")
        else v["slotid"] = k:TrimLeft("slot") end
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

    MOAT_INV:Query(qstr, function(d)
        print("done")
    end)
end)

concommand.Add("test_inv1", function(pl, cmd, args)
    local start_time = SysTime()

    pl:LoadInventory(function(pl, inv)
        end_time = SysTime()

        print(end_time - start_time, start_time, end_time)
    end)
end)