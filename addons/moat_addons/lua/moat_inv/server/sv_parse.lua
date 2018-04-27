--[[-----------------------------------
Parsing SQL > Table
------------------------------------]]--

function MOAT_INV:ParseInventoryQuery(d, q)
    local inv = {["cache"] = {}}

    for i = 1, #d do
        local r = d[i]
        inv[r["id"]] = {u = r["itemid"], w = r["classname"] or nil}
    end

    while (q:hasMoreResults()) do
        d = q:getData()
        if (not d[1]) then break end

        if (d[1]["statid"]) then self:ParseItemStatsQuery(d, inv) end
        if (d[1]["talentid"]) then self:ParseItemTalentssQuery(d, inv) end
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

function MOAT_INV:ParseItemPaintQuery(d, inv)
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