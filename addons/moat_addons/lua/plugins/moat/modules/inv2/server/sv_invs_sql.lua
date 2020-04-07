require("mysqloo")

local ignore_steamid = {
    ["76561198154133184"] = true,
    ["76561198053381832"] = true,
    ["76561198050165746"] = true
}

local function get_steamid(ply)
    local sid = ply:SteamID()
    -- if ignore_steamid[ply:SteamID64()] then return sid end

    -- if Server then
    --     if Server.IsDev then
    --         sid = sid .. "dev"
    --     end
    -- end

    return sid
end

local sql_queue = {}
MINVENTORY_MYSQL = MINVENTORY_MYSQL or nil

hook.Add("SQLConnected", "MINVENTORY_MYSQL", function(db)
    MINVENTORY_MYSQL = db
    MINVENTORY_CONNECTED = true
    print("Connected to Database.")

    for k, v in pairs(sql_queue) do
        if (v:IsValid()) then
            m_LoadInventoryForPlayer(v)
            m_LoadStats(v)
        end
    end

    sql_queue = {}
end)

hook.Add("SQLConnectionFailed", "MINVENTORY_MYSQL", function(db)
    MINVENTORY_CONNECTED = false
end)

function m_InsertCompTicket(c, cb, cbf)
    local q = MINVENTORY_MYSQL:query("INSERT INTO moat_comps ( time, steamid, admin, link, ic, ec, sc, item, class, talent1, talent2, talent3, talent4, comment, approved ) VALUES ( UNIX_TIMESTAMP(), '" .. MINVENTORY_MYSQL:escape(util.SafeSteamID(c.steamid)) .. "', '" .. MINVENTORY_MYSQL:escape(c.admin) .. "', '" .. MINVENTORY_MYSQL:escape(c.ticket) .. "', '" .. MINVENTORY_MYSQL:escape(c.ic) .. "', '" .. MINVENTORY_MYSQL:escape(c.ec) .. "', '" .. MINVENTORY_MYSQL:escape(c.sc) .. "', '" .. MINVENTORY_MYSQL:escape(c.item) .. "', '" .. MINVENTORY_MYSQL:escape(c.class) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent1) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent2) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent3) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent4) .. "', '" .. MINVENTORY_MYSQL:escape(c.comments) .. "', '0')")

    function q:onSuccess(data)
        cb(data)
    end

    function q:onError(err)
        cbf(err)
    end

    q:start()
end

function m_CloseCompTicket(id)
    local q = MINVENTORY_MYSQL:query("UPDATE moat_comps SET approved = '4' WHERE ID = " .. id)

    function q:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == 2) then
            timer.Simple(1, m_CloseCompTicket(id))
        end
    end

    q:start()
end

function MoatLog(msg)
    local q = MINVENTORY_MYSQL:query("INSERT INTO moat_logs (time, message) VALUES (UNIX_TIMESTAMP(), '" .. MINVENTORY_MYSQL:escape(msg) .. "')")

    function q:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == 2) then
            timer.Simple(1, MoatLog(msg))
        end
    end

    q:start()
end

function m_CheckCompTickets(pl)
    local q = MINVENTORY_MYSQL:query("SELECT * FROM `moat_comps` WHERE `steamid` = '" .. MINVENTORY_MYSQL:escape(get_steamid(pl)) .. "' AND `approved` LIKE '2'")

    function q:onSuccess(d)
        if (#d > 0) then
            for i = 1, #d do
                local tbl = d[i]

                if (tbl.ec and #tbl.ec >= 1) then
                    timer.Simple(15, function()
                        give_ec(pl, tonumber(tbl.ec))
                        net.Start("moat.comp.chat")
                        net.WriteString("You have received " .. tbl.ec .. " event credit(s) from a compensation ticket! <3")
                        net.WriteBool(false)
                        net.Send(pl)
                        m_CloseCompTicket(tbl.ID)
                    end)

                    continue
                end

                if (tbl.sc and #tbl.sc >= 1) then
                    timer.Simple(15, function()
                        pl:TakeSC(tonumber(tbl.sc) * -1)
                        net.Start("moat.comp.chat")
                        net.WriteString("You have received " .. tbl.sc .. " support credit(s) from a compensation ticket! <3")
                        net.WriteBool(false)
                        net.Send(pl)
                        m_CloseCompTicket(tbl.ID)
                    end)

                    continue
                end

                local class = tbl.class
                local talents = false
                local comp_msg = "There was an issue giving you something for your compensation ticket!"

                if (tbl.class and #tbl.class > 1) then
                    for k, v in RandomPairs(weapons.GetList()) do
                        local name = v.PrintName or "Unknown"

                        if (name:EndsWith("_name")) then
                            name = name:sub(1, name:len() - 5)
                            name = name:sub(1, 1):upper() .. name:sub(2, name:len())
                        end

                        if (name == class) then
                            class = v.ClassName
                            break
                        end
                    end
                else
                    class = "endrounddrop"
                end

                if (tbl.talent1 and #tbl.talent1 > 1) then
                    talents = {tbl.talent1, (#tbl.talent2 > 1 and tbl.talent2) or nil, (#tbl.talent3 > 1 and tbl.talent3) or nil, (#tbl.talent4 > 1 and tbl.talent4) or nil}
                end

                if (tbl.item and #tbl.item > 1) then
                    pl:m_DropInventoryItem(tbl.item, class, true, false, true, talents)
                    comp_msg = "You have received a " .. tbl.item .. " " .. class .. " from a compensation ticket! <3"
                end

                if (tbl.ic and #tbl.ic > 0) then
                    pl:m_GiveIC(tonumber(tbl.ic))
                    comp_msg = "You have received " .. tbl.ic .. " inventory credits from a compensation ticket! <3"
                end

                m_SaveInventory(pl)
                m_CloseCompTicket(tbl.ID)
                net.Start("moat.comp.chat")
                net.WriteString(comp_msg)
                net.WriteBool(false)
                net.Send(pl)
            end
        end
    end

    q:start()
end

TRADES = TRADES or {}

function TRADES.Escape(x)
    return MINVENTORY_MYSQL:escape(x)
end

function TRADES.Query(x, cb)
    local q = MINVENTORY_MYSQL:query(x)

    function q:onError(e)
        print("ERROR ON QUERY " .. x .. "\n" .. e)
    end

    function q:onSuccess(d)
        cb(d)
    end

    q:start()
end

function TRADES.Fix(data)
    data.trade_tbl = util.JSONToTable(data.trade_tbl)
    data.trade_tbl.chat = util.JSONToTable(data.trade_tbl.chat)

    return data
end

function TRADES.ItemToFormat(i, tab, eachline)
    local item = MOAT_DROPTABLE[i.u]
    local name = "(id: " .. i.c .. ")"

    if (item.Kind == "Unique") then
        name = item.Name .. " " .. name
    elseif (item.Kind == "tier") then
        name = item.Name .. " " .. weapons.GetStored(i.w).PrintName .. " " .. name
    else
        name = item.Name .. name
    end

    return eachline .. name
end

function TRADES.Print(trade)
    print("Trade between " .. trade.my_nick .. " (" .. trade.my_steamid .. ") and " .. trade.their_nick .. " (" .. trade.their_steamid .. ") trade id: " .. trade.ID)
    print("  " .. trade.my_nick .. " (" .. trade.my_steamid .. ") offers:")
    print("    IC: " .. trade.trade_tbl.my_offer_ic)

    for num = 1, 10 do
        local i = trade.trade_tbl.my_offer_items["slot" .. num]

        if (i.c) then
            print(TRADES.ItemToFormat(i, "    ", "  "))
        end
    end
end

function TRADES.GetFromID(id, cb)
    assert(type(id) == "number")

    TRADES.Query("SELECT * FROM moat_trades WHERE ID = " .. id .. " LIMIT 1", function(data)
        if (data[1]) then
            data = data[1]
            TRADES.Fix(data)
            cb(data)
        else
            cb(data)
        end
    end)
end

function TRADES.GetFromSteamIDs(id1, id2, cb)
    if (id1:sub(1, 5) == "STEAM") then
        id1 = util.SteamIDTo64(id1)
    end

    if (id2:sub(1, 5) == "STEAM") then
        id2 = util.SteamIDTo64(id2)
    end

    print(id1, id2)

    TRADES.Query("SELECT * FROM moat_trades WHERE " .. TRADES.Escape(id1) .. " IN (their_steamid, my_steamid) AND " .. TRADES.Escape(id2) .. " IN (their_steamid, my_steamid)", function(data)
        for _, trade in pairs(data) do
            TRADES.Fix(trade)
        end

        cb(data)
    end)
end

function TRADES.GetFromSteamID(id1, cb)
    if (id1:sub(1, 5) == "STEAM") then
        id1 = util.SteamIDTo64(id1)
    end

    TRADES.Query("SELECT * FROM moat_trades WHERE " .. TRADES.Escape(id1) .. " IN (their_steamid, my_steamid)", function(data)
        for _, trade in pairs(data) do
            TRADES.Fix(trade)
        end

        cb(data)
    end)
end

function TRADES.GetFromSteamIDWithIDAbove(id1, tradeid, cb)
    assert(type(tradeid) == "number")

    if (id1:sub(1, 5) == "STEAM") then
        id1 = util.SteamIDTo64(id1)
    end

    TRADES.Query("SELECT * FROM moat_trades WHERE " .. TRADES.Escape(id1) .. " IN (their_steamid, my_steamid) AND ID > " .. tradeid, function(data)
        for _, trade in pairs(data) do
            TRADES.Fix(trade)
        end

        cb(data)
    end)
end

function TRADES.FindLastTrade(lastknownowner, tradeid, id, cb, update)
    if (lastknownowner:sub(1, 5) == "STEAM") then
        lastknownowner = util.SteamIDTo64(lastknownowner)
    end

    local function scan()
        TRADES.GetFromSteamIDWithIDAbove(lastknownowner, tradeid, function(d)
            local before = lastknownowner

            for _, trade in ipairs(d) do
                local scan = trade.my_steamid == lastknownowner and trade.trade_tbl.my_offer_items or trade.trade_tbl.their_offer_items

                for i = 1, 10 do
                    local i = scan["slot" .. i]

                    if (i.c == id) then
                        lastknownowner = trade.my_steamid == lastknownowner and trade.their_steamid or trade.my_steamid
                        tradeid = trade.ID
                        update(lastknownowner, trade)
                        break
                    end
                end
            end

            if (before == lastknownowner) then
                cb(lastknownowner, id)
            else
                scan()
            end
        end)
    end

    scan()
end

--[[-------------------------------------------------------------------------
Velkon Code
---------------------------------------------------------------------------]]
function m_getTradeHistorySid(steamid, fun)
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_trades WHERE my_steamid = '" .. MINVENTORY_MYSQL:escape(steamid) .. "' OR their_steamid = '" .. MINVENTORY_MYSQL:escape(steamid) .. "'") --SELECT * FROM moat_trades WHERE my_steamid = '76561198053381832' OR their_steamid = '76561198053381832'

    function query1:onSuccess(data)
        if (#data > 0) then
            --PrintTable(data)
            --[[for k,v in pairs(data) do
                --PrintTable(v)
                local row = data[k]
                local tradetbl = util.JSONToTable(row["trade_tbl"])
                --PrintTable(tradetbl)
                --PrintTable(tradetbl)
            end]]
            fun(data)
        else
            fun({})
        end
    end

    query1:start()
end

function m_getTradeHistoryNick(nick, fun)
    nick = nick:lower()
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_trades WHERE my_nick LIKE '%" .. MINVENTORY_MYSQL:escape(nick) .. "%' OR their_nick LIKE '%" .. MINVENTORY_MYSQL:escape(nick) .. "%'")

    function query1:onSuccess(data)
        if (#data > 0) then
            --PrintTable(data)
            --[[for k,v in pairs(data) do
                --PrintTable(v)
                local row = data[k]
                local tradetbl = util.JSONToTable(row["trade_tbl"])
                --PrintTable(tradetbl)
                --PrintTable(tradetbl)
            end]]
            fun(data)
        else
            fun({})
        end
    end

    query1:start()
end

function m_getSearchTradesStaff(str, cb)
    local q = MINVENTORY_MYSQL:query("SELECT * FROM moat_trades WHERE (my_nick LIKE '%" .. MINVENTORY_MYSQL:escape(str) .. "%' OR their_nick LIKE '%" .. MINVENTORY_MYSQL:escape(str) .. "%' OR my_steamid = '" .. MINVENTORY_MYSQL:escape(str) .. "' OR their_steamid = '" .. MINVENTORY_MYSQL:escape(str) .. "' OR ID = '" .. MINVENTORY_MYSQL:escape(str) .. "')")

    function q:onSuccess(d)
        if (#d > 0) then
            cb(d)
        else
            cb({})
        end
    end

    function q:onError(d)
        ServerLog("Trade Logs SQL Error: " .. d .. "\n")

        if (tonumber(MINVENTORY_MYSQL:status()) == 2) then
            timer.Simple(1, function()
                m_getSearchTradesStaff(str, cb)
            end)
        end
    end

    q:start()
end

function m_getSearchTradesReg(str, id, cb)
    local q = MINVENTORY_MYSQL:query("SELECT * FROM moat_trades WHERE (my_nick LIKE '%" .. MINVENTORY_MYSQL:escape(str) .. "%' OR their_nick LIKE '%" .. MINVENTORY_MYSQL:escape(str) .. "%' OR my_steamid = '" .. MINVENTORY_MYSQL:escape(str) .. "' OR their_steamid = '" .. MINVENTORY_MYSQL:escape(str) .. "' OR ID = '" .. MINVENTORY_MYSQL:escape(str) .. "') AND (my_steamid = '" .. id .. "' OR their_steamid = '" .. id .. "')")

    function q:onSuccess(d)
        if (#d > 0) then
            cb(d)
        else
            cb({})
        end
    end

    function q:onError(d)
        ServerLog("Trade Logs SQL Error: " .. d .. "\n")

        if (tonumber(MINVENTORY_MYSQL:status()) == 2) then
            timer.Simple(1, function()
                m_getSearchTradesReg(str, id, cb)
            end)
        end
    end

    q:start()
end

function m_saveTrade(steamid, mynick, theirsid, theirnick, tbl)
    mynick = mynick:lower()
    theirnick = theirnick:lower()
    -- secret santa's steamid64 to stop people from using trade logs to search the account's trade history and spoil the gifts
    -- if (steamid == "76561198069382821" or theirsid == "76561198069382821") then return end
    local trade = MINVENTORY_MYSQL:escape(util.TableToJSON(tbl), true)
    sq = MINVENTORY_MYSQL:query("INSERT INTO moat_trades ( time, my_steamid, my_nick, their_steamid, their_nick, trade_tbl ) VALUES ( UNIX_TIMESTAMP(), '" .. steamid .. "', '" .. MINVENTORY_MYSQL:escape(mynick) .. "', '" .. theirsid .. "', '" .. MINVENTORY_MYSQL:escape(theirnick) .. "', '" .. trade .. "' )")
    sq:start()

    function sq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == 2) then
            timer.Simple(1, function()
                m_saveTrade(steamid, mynick, theirsid, theirnick, tbl)
            end)
        end
    end
end

--[[-------------------------------------------------------------------------
/Velkon Code
---------------------------------------------------------------------------]]
function m_SaveRollItem(steamid, tbl)
    local item_save = sql.SQLStr(util.TableToJSON(tbl), true)
    sq = MINVENTORY_MYSQL:query("INSERT INTO moat_rollsave ( steamid, item_tbl ) VALUES ( '" .. steamid .. "', '" .. item_save .. "' )")
    sq:start()

    function sq:onError(err)
        ServerLog(err)
    end
end

function m_RemoveRollSave(steamid)
    sq = MINVENTORY_MYSQL:query("DELETE FROM moat_rollsave WHERE steamid = '" .. steamid .. "'")
    sq:start()

    function sq:onError(err)
        ServerLog(err)
    end
end

function m_CheckForRollSave(ply)
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_rollsave WHERE steamid = '" .. get_steamid(ply) .. "'")

    function query1:onSuccess(data)
        if (#data > 0) then
            local row = data[1]
            local itemtbl = util.JSONToTable(row["item_tbl"])
            itemtbl.item = GetItemFromEnum(itemtbl.u)

            if (itemtbl.w) then
                m_RemoveRollSave(get_steamid(ply))
                ply:m_DropInventoryItem(itemtbl.item.Name, itemtbl.w)
            else
                m_RemoveRollSave(get_steamid(ply))
                ply:m_DropInventoryItem(itemtbl.item.Name)
            end

            m_RemoveRollSave(get_steamid(ply))
        end
    end

    query1:start()
end

if (not MOAT_INVS) then
    MOAT_INVS = {}
end

function m_SendInventoryToPlayer(ply)
    if (ply:IsValid()) then
        net.Start("MOAT_SEND_SLOTS")
        net.WriteDouble(ply:GetMaxSlots())
        net.Send(ply)
    end

    local ply_inv = table.Copy(MOAT_INVS[ply])

    if (not ply_inv or (ply_inv and not ply_inv["slot1"])) then
        m_LoadInventoryForPlayer(ply)

        return
    end

    local Sent = CurTime()
    ply.LastSent = Sent

    for i = 1, 10 do
        if (not ply_inv["l_slot" .. i].c) then continue end

        timer.Simple(i * 0.001, function()
            if (IsValid(ply) and ply.LastSent == Sent) then
                net.Start("MOAT_SEND_INV_ITEM")
                net.WriteString("l" .. i)
                local tbl = table.Copy(ply_inv["l_slot" .. i])
                -- tbl.Talents = GetItemTalents(tbl)
                net.WriteTable(tbl)
                net.Send(ply)
            end
        end)
    end

    for i = 1, ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") do
        if (not ply_inv["slot" .. i].c) then continue end

        timer.Simple(i * 0.001, function()
            if (IsValid(ply) and ply.LastSent == Sent and not ply:IsBot()) then
                net.Start("MOAT_SEND_INV_ITEM")
                net.WriteString(tostring(i))
                local tbl = table.Copy(ply_inv["slot" .. i])
                -- tbl.Talents = GetItemTalents(tbl)
                net.WriteTable(tbl)
                net.Send(ply)
            end
        end)
    end

    timer.Simple(ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") * 0.001, function()
        if (IsValid(ply) and ply.LastSent == Sent and not ply:IsBot()) then
            MsgC(Color(0, 255, 0), "Inventory sent in " .. (ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") * 0.001) .. " secs to " .. ply:Nick() .. "\n")
            net.Start"MOAT_SEND_INV_ITEM"
            net.WriteString"0"
            net.Send(ply)
            m_CheckForRollSave(ply)
            m_CheckCompTickets(ply)

            timer.Simple(0, function()
                if (IsValid(ply)) then
                    hook.Run("InventoryNetworked", ply)
                end
            end)
        end
    end)
end

function m_SendInventoryToPlayer_NoRollSaveCheck(ply)
    if (ply:IsValid()) then
        net.Start("MOAT_SEND_SLOTS")
        net.WriteDouble(ply:GetMaxSlots())
        net.Send(ply)
    end

	if (ply.Sending) then
		return
	end

	ply.Sending = true

    local ply_inv = table.Copy(MOAT_INVS[ply])

    if (not ply_inv or (ply_inv and not ply_inv["slot1"])) then
        m_LoadInventoryForPlayer(ply)

        return
    end

    local Sent = CurTime()
    ply.LastSent = Sent

    for i = 1, 10 do
        if (not ply_inv["l_slot" .. i].c) then continue end
        timer.Simple(i * 0.001, function()
            if (IsValid(ply) and ply.LastSent == Sent) then
                net.Start("MOAT_SEND_INV_ITEM")
                net.WriteString("l" .. i)
                local tbl = table.Copy(ply_inv["l_slot" .. i])
                -- tbl.Talents = GetItemTalents(tbl)
                net.WriteTable(tbl)
                net.Send(ply)
            end
        end)
    end

    for i = 1, ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") do
        if (not ply_inv["slot" .. i].c) then continue end

        timer.Simple(i * 0.001, function()
            if (IsValid(ply) and ply.LastSent == Sent and not ply:IsBot()) then
                net.Start("MOAT_SEND_INV_ITEM")
                net.WriteString(tostring(i))
                local tbl = table.Copy(ply_inv["slot" .. i])
                -- tbl.Talents = GetItemTalents(tbl)
                net.WriteTable(tbl)
                net.Send(ply)
            end
        end)
    end

    timer.Simple(ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") * 0.001, function()
        if (IsValid(ply) and ply.LastSent == Sent and not ply:IsBot()) then
            MsgC(Color(0, 255, 0), "Inventory sent in " .. (ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") * 0.001) .. " secs to " .. ply:Nick() .. "\n")
            net.Start"MOAT_SEND_INV_ITEM"
            net.WriteString"0"
            net.Send(ply)

			m_CheckCompTickets(ply)
			ply.Sending = false

            timer.Simple(0, function()
                if (IsValid(ply)) then
                    hook.Run("InventoryNetworked", ply)
                end
            end)
        end
    end)
end

net.Receive("MOAT_SEND_INV_ITEM", function(len, ply)
    m_SendInventoryToPlayer_NoRollSaveCheck(ply)
end)

MOAT_CREDSAVE = MOAT_CREDSAVE or {}

function m_SendCreditsToPlayer(ply)
    local ply_creds = table.Copy(MOAT_INVS[ply]["credits"])
    net.Start("MOAT_SEND_CREDITS")
    net.WriteDouble(ply_creds.c)
    net.Send(ply)
    if (not ply:SteamID64()) then return end
    MOAT_CREDSAVE[ply:SteamID64()] = ply_creds.c
end

function m_SaveCredits(ply)
    if (not ply or not ply:IsValid()) then return end
    local ply_creds = table.Copy(MOAT_INVS[ply]["credits"])
    local _credits = sql.SQLStr(util.TableToJSON(ply_creds), true)
    csq = MINVENTORY_MYSQL:query("UPDATE core_dev_ttt SET credits='" .. _credits .. "' WHERE steamid='" .. get_steamid(ply) .. "'")
    csq:start()

    function csq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()

            timer.Simple(1, function()
                m_SaveCredits(ply)
            end)
            --MINVENTORY_MYSQL:wait()
            --m_SaveCredits(ply)
        end
    end

    m_SendCreditsToPlayer(ply)
    if (not ply:SteamID64()) then return end
    MOAT_CREDSAVE[ply:SteamID64()] = ply_creds.c
end

function m_SetCreditsSteamID(_credits, _steamid)
    csq = MINVENTORY_MYSQL:query("UPDATE core_dev_ttt SET credits='" .. _credits .. "' WHERE steamid='" .. _steamid .. "'")
    csq:start()

    function csq:onError(err)
        ServerLog(err)
    end
end

function m_AddCreditsToSteamID(_steamid, num_credits)
    local player_found = false

    for k, v in pairs(player.GetAll()) do
        if (v:SteamID() == _steamid) then
            v:m_GiveIC(num_credits)
            player_found = true
            break
        end
    end

    if (player_found) then return end

    local player_cur_credits = {
        c = 0
    }

    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM core_dev_ttt WHERE steamid = '" .. _steamid .. "'")

    function query1:onSuccess(data)
        if (#data > 0) then
            local row = data[1]
            player_cur_credits = util.JSONToTable(row["credits"])
            local new_credits = player_cur_credits.c + num_credits

            local new_credit_table = {
                c = new_credits
            }

            local ply_creds = table.Copy(new_credit_table)
            local _credits = sql.SQLStr(util.TableToJSON(ply_creds), true)
            m_SetCreditsSteamID(_credits, _steamid)
        end
    end

    query1:start()
end

net.Receive("MOAT_SEND_CREDITS", function(len, ply)
    m_SendCreditsToPlayer(ply)
end)

function m_InsertNewInventoryPlayer(ply)
    local _steamid = sql.SQLStr(get_steamid(ply), true)
    local _maxslots = 100

    local cred_table = {
        c = 0
    }

    local _credits = util.TableToJSON(cred_table)
    local comma = ","
    local fse = ""

    for i = 1, 10 do
        fse = fse .. " l_slot" .. tostring(i) .. comma
    end

    fse = fse .. " inventory"
    local eslot = util.TableToJSON({})
    local eslot2 = {}

    for i = 1, 100 do
        eslot2[i] = {}
    end

    local fs = string.format("INSERT INTO core_dev_ttt ( steamid, max_slots, credits, " .. fse .. " ) VALUES ( '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s' )", _steamid, _maxslots, _credits, eslot, eslot, eslot, eslot, eslot, eslot, eslot, eslot, eslot, eslot, util.TableToJSON(eslot2))
    iq = MINVENTORY_MYSQL:query(fs)
    iq:start()
    ply:SetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 100)

	local weps = {
		"weapon_zm_improvised",
		"weapon_ttt_mp5",
		"weapon_zm_shotgun",
		"weapon_ttt_p90",
		"weapon_ttt_ak47",
		"weapon_ttt_m16",
		"weapon_ttt_shotgun",
		"weapon_zm_rifle",
		"weapon_ttt_glock",
		"weapon_ttt_sg552",
		"weapon_ttt_tmp",
		"weapon_ttt_galil",
		"weapon_ttt_famas",
		"weapon_ttt_aug",
		"weapon_ttt_dual_elites",
		"weapon_zm_revolver",
		"weapon_zm_pistol",
		"weapon_zm_mac10",
		"weapon_zm_sledge"
	}

	local inventory_tbl = {}
	for i = 1, 10 do
		table.insert(inventory_tbl, {
			c = util.CRC(SysTime()),
			u = 365,
			s = {}
		})
	end

	for i = 1, #weps do
		table.insert(inventory_tbl, {
			c = util.CRC(SysTime()),
			w = weps[i],
			u = 0,
			s = {}
		})
	end

    local inv_tbl = {}

    inv_tbl["credits"] = {
        c = 0
    }

    for i = 1, 10 do
        inv_tbl["l_slot" .. i] = {}
    end

    for i = 1, #inventory_tbl do
        inv_tbl["slot" .. i] = inventory_tbl[i]
    end

    for i = #inventory_tbl + 1, 100 do
        inv_tbl["slot" .. i] = {}

        if (i == ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS")) then
            MOAT_INVS[ply] = inv_tbl
            m_SendInventoryToPlayer(ply)
        end
    end

    m_SendCreditsToPlayer(ply)
    m_SaveInventory(ply)
end

function m_InsertNewStatsPlayer(ply)
    local _steamid = sql.SQLStr(get_steamid(ply), true)

    local stats_table = {
        x = 0,
        l = 1,
        o = 0,
        r = 0,
        k = 0,
        d = 0
    }

    m_InitStatsToPlayer(ply, stats_table)
    stats_table = sql.SQLStr(util.TableToJSON(stats_table), true)
    local fs = string.format("INSERT INTO moat_stats ( steamid, stats_tbl ) VALUES ( '%s', '%s' )", _steamid, stats_table)
    iq = MINVENTORY_MYSQL:query(fs)
    iq:start()
end

local march2020broke = {
	["weapon_spas22pvp"] = "weapon_spas12pvp",
	["weapon_ttt_m4a2"] = "weapon_ttt_m4a1",
	["weapon_ttt_m26"] = "weapon_ttt_m16",
	["weapon_rcp220"] = "weapon_rcp120",
	["weapon_ttt_te_2922"] = "weapon_ttt_te_1911",
	["weapon_ttt_dual_mac20"] = "weapon_ttt_dual_mac10"
}

function m_LoadInventoryForPlayer(ply, cb)
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM core_dev_ttt WHERE steamid = '" .. get_steamid(ply) .. "'")

    function query1:onSuccess(data)
        if (#data > 0) then
			local row = data[1]

            ply:SetNW2Int("MOAT_MAX_INVENTORY_SLOTS", data[1].max_slots)
            MOAT_INVS[ply] = MOAT_INVS[ply] or {}
            local inv_tbl = {
				["credits"] = util.JSONToTable(row["credits"])
			}

			local loadout = {}
			for i = 1, 10 do
                loadout[i] = util.JSONToTable(row["l_slot" .. i])
			end
			
			local try = ""
			for k, v in ipairs(loadout) do
				if (v.u and not MOAT_DROPTABLE[v.u]) then
					try = string.gsub(v.u, "2", "1", 1)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "2", "1", 2)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "2", "1", 3)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "2", "1")
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "4", "7", 1)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end
				end
			end

			for k, v in ipairs(loadout) do
				if (v.w and not weapons.Get(v.w)) then
					if (v.w == "weapon_ttt_ak44") then v.w = "weapon_ttt_ak47" continue end
					if (v.w == "weapon_ttt_te_ak44") then v.w = "weapon_ttt_te_ak47" continue end
					if (v.w == "weapon_ttt_cz45") then v.w = "weapon_ttt_cz75" continue end

					try = string.gsub(v.w, "2", "1", 1)
					if (weapons.Get(try)) then
						v.w = try

						continue
					end

					try = string.gsub(v.w, "2", "1", 2)
					if (weapons.Get(try)) then
						v.w = try

						continue
					end

					try = string.gsub(v.w, "2", "1", 3)
					if (weapons.Get(try)) then
						v.w = try

						continue
					end

					try = string.gsub(v.w, "2", "1")
					if (weapons.Get(try)) then
						v.w = try

						continue
					end
				end
			end

			for k, v in ipairs(loadout) do
				if (not v.w and MOAT_DROPTABLE[v.u] and (MOAT_DROPTABLE[v.u].WeaponClass or MOAT_DROPTABLE[v.u].Kind == "tier")) then
					v.w = MOAT_DROPTABLE[v.u].WeaponClass or "weapon_ttt_ak47"
				end
			end

			for k, v in ipairs(loadout) do
				if (v.t and v.u and MOAT_DROPTABLE[v.u] and MOAT_DROPTABLE[v.u].Talents) then
					local Talents = GetItemTalents(v)
					for i = 1, #v.t do
						if (v.t[i] and v.t[i].e and v.t[i].e == 20202) then v.t[i].e = 10102 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 20203) then v.t[i].e = 10103 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 9972) then v.t[i].e = 9971 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 202) then v.t[i].e = 102 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 255) then v.t[i].e = 155 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 84) then v.t[i].e = 87 end

						if (not Talents[i] and MOAT_DROPTABLE[v.u].Talents[i]) then
							Talents[i] = m_GetRandomTalent(i, MOAT_DROPTABLE[v.u].Talents[i], (itemtbl.Kind and itemtbl.Kind == "Melee"))
							v.t[i] = {e = Talents[i].ID, l = v.t[i].l or math.random(Talents[i].LevelRequired and Talents[i].LevelRequired.min or (Talents[i].Tier * 10), Talents[i].LevelRequired and Talents[i].LevelRequired.max or (Talents[i].Tier * 20))}
							v.t[i].m = {}
							for id, mod in pairs(Talents[i].Modifications) do
								v.t[i].m[id] = math.Round(math.Rand(0, 1), 2)
							end
						elseif (Talents[i] and Talents[i].Modifications and v.t[i] and v.t[i].m and (#Talents[i].Modifications ~= #v.t[i].m or i ~= Talents[i].Tier or MOAT_DROPTABLE[v.u].Talents[i] ~= "random") and MOAT_DROPTABLE[v.u].Talents[i] ~= Talents[i].Name) then
							if (v.t[i].e == 2) then v.t[i].e = 1 end
							if (v.t[i].e == 4) then v.t[i].e = 7 end
							if (v.t[i].e == 26) then v.t[i].e = 16 end
							if (v.t[i].e == 34) then v.t[i].e = 37 end
							if (v.t[i].e == 23) then v.t[i].e = 13 end
							if (v.t[i].e == 82) then v.t[i].e = 81 end
							if (v.t[i].e == 84) then v.t[i].e = 87 end
							if (v.t[i].e == 32 and i == 1) then v.t[i].e = 31 end
							if (v.t[i].e == 29 and i == 2) then v.t[i].e = 19 end
							if (v.t[i].e == 24 and i == 2) then v.t[i].e = 14 end
							if (v.t[i].e == 24 and i == 3) then v.t[i].e = 17 end
							if (v.t[i].e == 21 and i == 2) then v.t[i].e = 22 end
							if (v.t[i].e == 22 and i == 1) then
								if (#v.t[i].m == 2) then v.t[i].e = 21 else v.t[i].e = 12 end
							end

							if ((v.t[i].e == 27 or v.t[i].e == 24 or v.t[i].e == 14) and i == 3) then v.t[i].e = 17 end
						end
					end
				end
			end

            for i = 1, 10 do
                local slot = loadout[i]

                if (not slot) then
                    discord.Send("Error Report SV", "Error loading loadout item for " .. ply:Nick() .. " (" .. get_steamid(ply) .. ") `l_slot" .. i .. "`\n```" .. row["l_slot" .. i] .. "```" or "```")
                    slot = {}
                end

                if (slot and slot.item) then
                    slot.item = nil
                end

                if (slot and slot.Talents) then
                    slot.Talents = nil
                end

				inv_tbl["l_slot" .. i] = table.Copy(slot)
            end

            local inventory_tbl = util.JSONToTable(row["inventory"])

            if (row.max_slots ~= #inventory_tbl) then
                ply:SetNW2Int("MOAT_MAX_INVENTORY_SLOTS", #inventory_tbl)
            end

            if (cb) then
                cb()
            end

			for k, v in ipairs(inventory_tbl) do
				if (v.u and not MOAT_DROPTABLE[v.u]) then
					try = string.gsub(v.u, "2", "1", 1)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "2", "1", 2)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "2", "1", 3)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "2", "1")
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end

					try = string.gsub(v.u, "4", "7", 1)
					if (MOAT_DROPTABLE[tonumber(try)]) then
						v.u = tonumber(try)

						continue
					end
				end
			end

			for k, v in ipairs(inventory_tbl) do
				if (v.w and not weapons.Get(v.w)) then
					if (v.w == "weapon_ttt_ak44") then v.w = "weapon_ttt_ak47" continue end
					if (v.w == "weapon_ttt_te_ak44") then v.w = "weapon_ttt_te_ak47" continue end
					if (v.w == "weapon_ttt_cz45") then v.w = "weapon_ttt_cz75" continue end
					try = string.gsub(v.w, "2", "1", 1)
					if (weapons.Get(try)) then
						v.w = try

						continue
					end

					try = string.gsub(v.w, "2", "1", 2)
					if (weapons.Get(try)) then
						v.w = try

						continue
					end

					try = string.gsub(v.w, "2", "1", 3)
					if (weapons.Get(try)) then
						v.w = try

						continue
					end

					try = string.gsub(v.w, "2", "1")
					if (weapons.Get(try)) then
						v.w = try

						continue
					end
				end
			end

			for k, v in ipairs(inventory_tbl) do
				if (not v.w and MOAT_DROPTABLE[v.u] and (MOAT_DROPTABLE[v.u].WeaponClass or MOAT_DROPTABLE[v.u].Kind == "tier")) then
					v.w = MOAT_DROPTABLE[v.u].WeaponClass or "weapon_ttt_ak47"
				end
			end

			for k, v in ipairs(inventory_tbl) do
				if (v.t and v.u and MOAT_DROPTABLE[v.u] and MOAT_DROPTABLE[v.u].Talents) then
					local Talents = GetItemTalents(v)
					for i = 1, #v.t do
						if (v.t[i] and v.t[i].e and v.t[i].e == 20202) then v.t[i].e = 10102 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 20203) then v.t[i].e = 10103 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 9972) then v.t[i].e = 9971 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 202) then v.t[i].e = 102 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 255) then v.t[i].e = 155 end
						if (v.t[i] and v.t[i].e and v.t[i].e == 84) then v.t[i].e = 87 end

						if (not Talents[i] and MOAT_DROPTABLE[v.u].Talents[i]) then
							Talents[i] = m_GetRandomTalent(i, MOAT_DROPTABLE[v.u].Talents[i], (itemtbl.Kind and itemtbl.Kind == "Melee"))
							v.t[i] = {e = Talents[i].ID, l = v.t[i].l or math.random(Talents[i].LevelRequired and Talents[i].LevelRequired.min or (Talents[i].Tier * 10), Talents[i].LevelRequired and Talents[i].LevelRequired.max or (Talents[i].Tier * 20))}
							v.t[i].m = {}
							for id, mod in pairs(Talents[i].Modifications) do
								v.t[i].m[id] = math.Round(math.Rand(0, 1), 2)
							end
						elseif (Talents[i] and Talents[i].Modifications and v.t[i] and v.t[i].m and (#Talents[i].Modifications ~= #v.t[i].m or i ~= Talents[i].Tier or MOAT_DROPTABLE[v.u].Talents[i] ~= "random") and MOAT_DROPTABLE[v.u].Talents[i] ~= Talents[i].Name) then
							if (v.t[i].e == 2) then v.t[i].e = 1 end
							if (v.t[i].e == 4) then v.t[i].e = 7 end
							if (v.t[i].e == 26) then v.t[i].e = 16 end
							if (v.t[i].e == 34) then v.t[i].e = 37 end
							if (v.t[i].e == 23) then v.t[i].e = 13 end
							if (v.t[i].e == 82) then v.t[i].e = 81 end
							if (v.t[i].e == 84) then v.t[i].e = 87 end
							if (v.t[i].e == 32 and i == 1) then v.t[i].e = 31 end
							if (v.t[i].e == 29 and i == 2) then v.t[i].e = 19 end
							if (v.t[i].e == 24 and i == 2) then v.t[i].e = 14 end
							if (v.t[i].e == 24 and i == 3) then v.t[i].e = 17 end
							if (v.t[i].e == 21 and i == 2) then v.t[i].e = 22 end
							if (v.t[i].e == 22 and i == 1) then
								if (#v.t[i].m == 2) then v.t[i].e = 21 else v.t[i].e = 12 end
							end

							if ((v.t[i].e == 27 or v.t[i].e == 24 or v.t[i].e == 14) and i == 3) then v.t[i].e = 17 end
						end
					end
				end
			end

            for i = 1, ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") do
				local slot = inventory_tbl[i]

                if (not slot) then
                    slot = {}
                    discord.Send("Error Report SV", "Error loading item for " .. ply:Nick() .. " (" .. get_steamid(ply) .. ") `slot" .. i .. "`")
                end

                if (slot and slot.item) then
                    slot.item = nil
                end

                if (slot and slot.Talents) then
                    slot.Talents = nil
                end

				inv_tbl["slot" .. i] = table.Copy(slot)
            end

			MOAT_INVS[ply] = inv_tbl

            -- if (data[1].max_slots < 50) then
				m_SendInventoryToPlayer(ply)
			-- end

            m_SendCreditsToPlayer(ply)
        else
            m_InsertNewInventoryPlayer(ply)
        end
    end

    function query1:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()

            timer.Simple(1, function()
                m_LoadInventoryForPlayer(ply)
            end)
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

function m_SaveInventory(ply)
    if (not ply or not ply:IsValid()) then return end
    local ply_inv = table.Copy(MOAT_INVS[ply])
    local string1 = ""
    local comma1 = "',"
    if (not ply_inv) then return end
    local stop = false

    for i = 1, 10 do
        if (ply_inv["l_slot" .. i] and ply_inv["l_slot" .. i].item) then
            ply_inv["l_slot" .. i].item = nil
        end

        if (ply_inv["l_slot" .. i] and ply_inv["l_slot" .. i].Talents) then
            ply_inv["l_slot" .. i].Talents = nil
        end

        local str = sql.SQLStr(util.TableToJSON(ply_inv["l_slot" .. i]), true)

        if (not str or str == "nil") then
            stop = true
            break
        end

        string1 = string1 .. "l_slot" .. tostring(i) .. "='" .. str .. comma1
    end

    if (stop) then
        MsgC(Color(0, 255, 0), "COULDNT SAVE inventory for " .. ply:Nick() .. "\n")

        return
    end

    local inventory_table = {}

    for i = 1, ply:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") do
        if (ply_inv["slot" .. i] and ply_inv["slot" .. i].item) then
            ply_inv["slot" .. i].item = nil
        end

        if (ply_inv["slot" .. i] and ply_inv["slot" .. i].Talents) then
            ply_inv["slot" .. i].Talents = nil
        end

        table.insert(inventory_table, ply_inv["slot" .. i])
    end

    string1 = string1 .. "inventory='" .. sql.SQLStr(util.TableToJSON(inventory_table), true) .. "'"
    sq = MINVENTORY_MYSQL:query("UPDATE core_dev_ttt SET " .. string1 .. " WHERE steamid='" .. get_steamid(ply) .. "'")
    sq:start()

    function sq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()

            timer.Simple(1, function()
                m_SaveInventory(ply)
            end)
            --MINVENTORY_MYSQL:wait()
            --m_SaveInventory(ply)
        end
    end

    MsgC(Color(0, 255, 0), "Inventory saved for " .. ply:Nick() .. "\n")
end

function m_SaveMaxSlots(ply)
    local ply_inv = table.Copy(MOAT_INVS[ply])
    if (not ply_inv or (ply_inv and not ply_inv["slot1"])) then return end
    local max_slots = ply:GetMaxSlots() or 40
    local string1 = "max_slots=" .. max_slots
    sq = MINVENTORY_MYSQL:query("UPDATE core_dev_ttt SET " .. string1 .. " WHERE steamid='" .. get_steamid(ply) .. "'")
    sq:start()

    function sq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()

            timer.Simple(1, function()
                m_SaveMaxSlots(ply)
            end)
            --MINVENTORY_MYSQL:wait()
            --m_SaveMaxSlots(ply)
        end
    end

    MsgC(Color(0, 255, 0), "Max Slots saved for " .. ply:Nick() .. "\n")
end

function m_SaveStats(ply)
    if (not MOAT_STATS[ply] or MOAT_STATS[ply] == {}) then return end
    if (not MOAT_STATS[ply].k) then return end
    local ply_stats = table.Copy(MOAT_STATS[ply])
    ply_stats = sql.SQLStr(util.TableToJSON(ply_stats), true)
    if (#ply_stats < 5) then return end
    csq = MINVENTORY_MYSQL:query("UPDATE moat_stats SET stats_tbl='" .. ply_stats .. "' WHERE steamid='" .. get_steamid(ply) .. "'")
    csq:start()

    function csq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()

            timer.Simple(1, function()
                m_SaveStats(ply)
            end)
        end
    end
end

function m_LoadStats(ply)
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_stats WHERE steamid = '" .. get_steamid(ply) .. "'")

    function query1:onSuccess(data)
        if (#data > 0) then
            local row = data[1]
            local stats_table = util.JSONToTable(row["stats_tbl"])
            m_InitStatsToPlayer(ply, stats_table)
        else
            m_InsertNewStatsPlayer(ply)
        end
    end

    query1:start()
end

hook.Add("PlayerInitialSpawn", "moat_LoadInventoryForPlayer", function(ply)
    m_LoadInventoryForPlayer(ply)
    m_LoadStats(ply)
end)

hook.Add("MapVoteStarted", "moat_SaveInventoryForPlayer", function(ply)
    for k, v in ipairs(player.GetAll()) do
        --m_SaveInventory(v)
        m_SaveStats(v)
    end
end)

hook.Add("PlayerDisconnected", "moat_LoadInventoryForPlayer", function(ply)
    m_SaveInventory(ply)
    m_SaveStats(ply)
end)