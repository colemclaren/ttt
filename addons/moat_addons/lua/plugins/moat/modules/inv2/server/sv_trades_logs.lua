util.AddNetworkString "moat.logs.open"
util.AddNetworkString "moat.logs.opent"
util.AddNetworkString "moat.logs.search"

MOAT_TRADE_LOGS = MOAT_TRADE_LOGS or {}

function MOAT_TRADE_LOGS.CreateLog(tradetbl, my_steamid, my_nick, their_steamid, their_nick, num)
    local log = ""
    log = log .. "================\nCHAT LOG (ID: " .. num .. ")\n================\n\n"
    log = log .. table.concat(util.JSONToTable(tradetbl.chat), "\n")
    log = log .. "\n\n================\nTRADE LOG (ID: " .. num .. ")\n================\n\n"
    log = log .. my_nick .. " (" .. my_steamid .. ") Offered:\n"
    log = log .. "----------------------\n"
    log = log .. "IC:    " .. tradetbl.my_offer_ic .. "\n"
    log = log .. "----------------------\nITEMS:\n"
    local i = 1

    for k, v in pairs(tradetbl.my_offer_items) do
        if not v.c then continue end
        local tbl2 = v
        tbl2.item = GetItemFromEnum(tbl2.u)
		tbl2.Talents = GetItemTalents(tbl2)

        log = log .. "    ITEM #" .. i .. ":\n    " .. (moat_GetItemStats(tbl2, ""):gsub("`", ""):gsub("*", ""):gsub("\n", "\n    ") or "Unknown Item, ID: " .. v.u) .. "\n\n"
        i = i + 1
    end

    i = 1
    log = log .. "\n\n"
    log = log .. "============\n"
    log = log .. "\n\n"
    log = log .. their_nick .. " (" .. their_steamid .. ") Offered:\n"
    log = log .. "----------------------\n"
    log = log .. "IC:    " .. tradetbl.their_offer_ic .. "\n"
    log = log .. "----------------------\nITEMS:\n"
    local i = 1

    for k, v in pairs(tradetbl.their_offer_items) do
        if not v.c then continue end
        local tbl2 = v
        tbl2.item = GetItemFromEnum(tbl2.u)
		tbl2.Talents = GetItemTalents(tbl2)
        log = log .. "    ITEM #" .. i .. ":\n    " .. (moat_GetItemStats(tbl2, ""):gsub("`", ""):gsub("*", ""):gsub("\n", "\n    ") or "Unknown Item, ID: " .. v.u) .. "\n\n"
        i = i + 1
    end

    log = log .. "\n\nEnd of log. (ID: " .. num .. ")"

    return log
end

net.Receive("moat.logs.open", function(l, pl)
    if (pl.LogsOpenCooldown and pl.LogsOpenCooldown > CurTime()) then return end
    local id = pl:SteamID64() or "807"

    m_getTradeHistorySid(id,function(data)
        if #data < 1 then
            pl:ChatPrint("Could not find trade logs for yourself!")
            return
        end

        -- string.format("%.f", v.my_steamid)

        local logs = {}
        for k, v in pairs(data) do
            local id1, id2 = util.SteamIDFrom64(v.their_steamid), util.SteamIDFrom64(v.my_steamid)
            local str = id == v.their_steamid and v.my_nick .. "(" .. id2 .. ")" or v.their_nick .. "(" .. id1 .. ")"
            table.insert(logs, {v.time, str, v.ID})

            MOAT_TRADE_LOGS[v.ID] = {id1, id2, v.their_nick, v.my_nick, v.trade_tbl}
        end


        table.sort(logs,function(a,b)
            return a[1] > b[1]
        end)

        net.Start("moat.logs.open")
        net.WriteTable(logs)
        net.Send(pl)
    end)

    pl.LogsOpenCooldown = CurTime() + 1
end)

local staffgroups = {
	["moderator"] = true,
	["admin"] = true,
	["senioradmin"] = true,
	["headadmin"] = true,
	["communitylead"] = true,
	["owner"] = true,
	["techartist"] = true,
	["audioengineer"] = true,
	["softwareengineer"] = true,
	["gamedesigner"] = true,
	["creativedirector"] = true
}

net.Receive("moat.logs.opent", function(_, pl)
    if (pl.LogsOpenTCooldown and pl.LogsOpenTCooldown > CurTime()) then return end

    local num = net.ReadUInt(32)
    if (not num or not tonumber(num)) then return end

    local log = MOAT_TRADE_LOGS[num]

    if (log) then
        if (not staffgroups[pl:GetUserGroup()] and (log[1] ~= pl:SteamID() and log[2] ~= pl:SteamID())) then return end

        local text = MOAT_TRADE_LOGS.CreateLog(util.JSONToTable(log[5]), log[2], log[4], log[1], log[3], num)
        if (text) then
            net.Start("moat.logs.opent")
            local a = util.Compress(text)
            net.WriteInt(#a,32)
            net.WriteData(a,#a)
            net.WriteUInt(num, 32)
            net.Send(pl)
        end
    end

    pl.LogsOpenTCooldown = CurTime() + 0.1
end)

function MOAT_TRADE_LOGS.StaffSearch(str, pl)
    local src = util.SteamIDTo64(str)
    if (src == "0") then src = str end

    m_getSearchTradesStaff(src, function(data)
        if #data < 1 then
            net.Start("moat.logs.search")
			net.WriteBool(false)
            net.Send(pl)

            return
        end

        local logs = {}
        for k, v in pairs(data) do
            local id1, id2 = util.SteamIDFrom64(v.their_steamid), util.SteamIDFrom64(v.my_steamid)
            local str = v.their_nick .. "(" .. id1 .. ")  +  " .. v.my_nick .. "(" .. id2 .. ")"
            table.insert(logs, {v.time, str, v.ID})

            MOAT_TRADE_LOGS[v.ID] = {id1, id2, v.their_nick, v.my_nick, v.trade_tbl}
        end


        table.sort(logs,function(a,b)
            return a[1] > b[1]
        end)

        net.Start("moat.logs.search")
		net.WriteBool(true)
        net.WriteTable(logs)
        net.Send(pl)
    end)
end

function MOAT_TRADE_LOGS.RegularSearch(str, pl)
    local src = string.Trim(util.SteamIDTo64(str))
    if (src == "0") then src = str end

    m_getSearchTradesReg(src, pl:SteamID64(), function(data)
        if #data < 1 then
            net.Start("moat.logs.search")
			net.WriteBool(false)
            net.Send(pl)

            return
        end

        local logs = {}
        for k, v in pairs(data) do
            local id1, id2 = util.SteamIDFrom64(v.their_steamid), util.SteamIDFrom64(v.my_steamid)
            local str = pl:SteamID64() == v.their_steamid and v.my_nick .. "(" .. id2 .. ")" or v.their_nick .. "(" .. id1 .. ")"
            table.insert(logs, {v.time, str, v.ID})

            MOAT_TRADE_LOGS[v.ID] = {id1, id2, v.their_nick, v.my_nick, v.trade_tbl}
        end


        table.sort(logs,function(a,b)
            return a[1] > b[1]
        end)

        net.Start("moat.logs.search")
		net.WriteBool(true)
        net.WriteTable(logs)
        net.Send(pl)
    end)
end

net.Receive("moat.logs.search", function(_, pl)
    if (pl.LogsSearchCooldown and pl.LogsSearchCooldown > CurTime()) then return end

    local src = net.ReadString()
    if (not src) then return end

    if (staffgroups[pl:GetUserGroup()]) then
        MOAT_TRADE_LOGS.StaffSearch(src, pl)
    else
        MOAT_TRADE_LOGS.RegularSearch(src, pl)
    end

    pl.LogsSearchCooldown = CurTime() + 1
end)