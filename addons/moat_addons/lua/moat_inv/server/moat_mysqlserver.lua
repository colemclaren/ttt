require("mysqloo")
local DATABASE_HOST = "208.103.169.40"
local DATABASE_PORT = 3306
local DATABASE_NAME = "forum"
local DATABASE_USERNAME = "footsies"
local DATABASE_PASSWORD = "clkmTQF6bF@3V0NYjtUMoC6sF&17B$"
local MINVENTORY_CONNECTED = false

function m_InventoryTable(db)
end

local sql_queue = {}
MINVENTORY_MYSQL = MOAT_INV.SQL and MOAT_INV.SQL.mysqloo
local SQL = MOAT_INV.SQL

hook.Add("InventoryPrepare", "MINVENTORY_MYSQL", function()
    MINVENTORY_MYSQL = MOAT_INV.SQL.mysqloo -- TODO: REMOVE!!!
    SQL = MOAT_INV.SQL
    MINVENTORY_CONNECTED = true
    print("Connected to Database.")

    for k, v in pairs(sql_queue) do
        if (v:IsValid()) then
            m_LoadInventoryForPlayer(v)
            m_LoadStats(v)
        end
    end

    sql_queue = {}

    m_InventoryTable(MINVENTORY_MYSQL)
end)

hook.Add("SQLConnectionFailed", "MINVENTORY_MYSQL", function(db)
    MINVENTORY_CONNECTED = false
end)

function m_InsertCompTicket(c, cb, cbf)
    local q = MINVENTORY_MYSQL:query("INSERT INTO moat_comps ( time, steamid, admin, link, ic, ec, item, class, talent1, talent2, talent3, talent4, comment, approved ) VALUES ( UNIX_TIMESTAMP(), '" .. MINVENTORY_MYSQL:escape(c.steamid) .. "', '" .. MINVENTORY_MYSQL:escape(c.admin) .. "', '" .. MINVENTORY_MYSQL:escape(c.ticket) .. "', '" .. MINVENTORY_MYSQL:escape(c.ic) .. "', '" .. MINVENTORY_MYSQL:escape(c.ec) .. "', '" .. MINVENTORY_MYSQL:escape(c.item) .. "', '" .. MINVENTORY_MYSQL:escape(c.class) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent1) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent2) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent3) .. "', '" .. MINVENTORY_MYSQL:escape(c.talent4) .. "', '" .. MINVENTORY_MYSQL:escape(c.comments) .. "', '0')")

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
    local q = MINVENTORY_MYSQL:query("SELECT * FROM moat_comps WHERE (steamid = '" .. MINVENTORY_MYSQL:escape(pl:SteamID()).. "' AND approved = '2')")
    function q:onSuccess(d)
        if (#d > 0) then

            for i = 1, #d do
                local tbl = d[i]

                if (tbl.ec and #tbl.ec >= 1) then
                    timer.Simple(15, function()
                        give_ec(pl, tonumber(tbl.ec))

                        net.Start("moat.comp.chat")
                        net.WriteString("You have received " .. tbl.ec .. " event credits from a compensation ticket!")
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
                    talents = {
                        tbl.talent1,
                        (#tbl.talent2 > 1 and tbl.talent2) or nil,
                        (#tbl.talent3 > 1 and tbl.talent3) or nil,
                        (#tbl.talent4 > 1 and tbl.talent4) or nil
                    }
                end

                if (tbl.item and #tbl.item > 1) then
                    pl:m_DropInventoryItem(tbl.item, class, true, false, true, talents)

                    comp_msg = "You have received a " .. tbl.item .. " " .. class .. " from a compensation ticket!"
                end

                if (tbl.ic and #tbl.ic > 0) then
                    pl:m_GiveIC(tonumber(tbl.ic))

                    comp_msg = "You have received " .. tbl.ic .. " inventory credits from a compensation ticket!"
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

--[[-------------------------------------------------------------------------
Velkon Code
---------------------------------------------------------------------------]]

function m_getTradeHistorySid(steamid, fun)
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_trades WHERE my_steamid = '" .. MINVENTORY_MYSQL:escape(steamid) .. "' OR their_steamid = '" .. MINVENTORY_MYSQL:escape(steamid) .. "'") --SELECT * FROM moat_trades WHERE my_steamid = '76561198053381832' OR their_steamid = '76561198053381832'

    function query1:onSuccess(data)
        if (#data > 0) then
            --PrintTable(data)
            /*for k,v in pairs(data) do
                --PrintTable(v)
                local row = data[k]
                local tradetbl = util.JSONToTable(row["trade_tbl"])
                --PrintTable(tradetbl)
                --PrintTable(tradetbl)
            end*/
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
            /*for k,v in pairs(data) do
                --PrintTable(v)
                local row = data[k]
                local tradetbl = util.JSONToTable(row["trade_tbl"])
                --PrintTable(tradetbl)
                --PrintTable(tradetbl)
            end*/
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
            timer.Simple(1, function() m_getSearchTradesStaff(str, cb) end)
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
            timer.Simple(1, function() m_getSearchTradesReg(str, id, cb) end)
        end
    end

    q:start()
end

function m_saveTrade(steamid, mynick, theirsid, theirnick, tbl)
    mynick = mynick:lower()
    theirnick = theirnick:lower()
    if (steamid == "76561198069382821" or theirsid == "76561198069382821") then return end
    local trade = MINVENTORY_MYSQL:escape(util.TableToJSON(tbl), true)

    sq = MINVENTORY_MYSQL:query("INSERT INTO moat_trades ( time, my_steamid, my_nick, their_steamid, their_nick, trade_tbl ) VALUES ( UNIX_TIMESTAMP(), '" .. steamid .. "', '" .. MINVENTORY_MYSQL:escape(mynick) .. "', '" .. theirsid .. "', '" .. MINVENTORY_MYSQL:escape(theirnick) .. "', '" .. trade .. "' )")
    sq:start()

    function sq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == 2) then
            timer.Simple(1, function() m_saveTrade(steamid, mynick, theirsid, theirnick, tbl) end)
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
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_rollsave WHERE steamid = '" .. ply:SteamID() .. "'")

    function query1:onSuccess(data)
        if (#data > 0) then
            local row = data[1]
            local itemtbl = util.JSONToTable(row["item_tbl"])
            itemtbl.item = m_GetItemFromEnum(itemtbl.u)

            if (itemtbl.w) then
                m_RemoveRollSave(ply:SteamID())
                ply:m_DropInventoryItem(itemtbl.item.Name, itemtbl.w)
            else
                m_RemoveRollSave(ply:SteamID())
                ply:m_DropInventoryItem(itemtbl.item.Name)
            end

            m_RemoveRollSave(ply:SteamID())
        end
    end

    query1:start()
end

if (not MOAT_INVS) then
    MOAT_INVS = {}
end
function m_WriteWeaponForPlayer(wep, ply)
    local written = net.BytesWritten()
    wep:WriteToNet()
    return net.BytesWritten() - written
end

local interval = engine.TickInterval()
local max_per_interval = 30000 * interval

local function SendExtraInfo(ply, sending, cb)
    if (not IsValid(ply)) then
        cb(false)
        return
    end
    local overflow = false
    net.Start "MOAT_SEND_INV_ITEM"
        net.WriteBool(true) -- data
        for j = #sending.t, 1, -1 do
            net.WriteBool(true)
            net.WriteBool(false) -- talent
            local send = sending.t[j]
            net.WriteUInt(send[1], 32)
            net.WriteTable(send[2])
            table.remove(sending.t, j)
            if (net.BytesWritten() >= max_per_interval) then
                overflow = true
                break
            end
        end
        if (not overflow) then
            for j = #sending.i, 1, -1 do
                net.WriteBool(true)
                net.WriteBool(true) -- item
                local send = sending.i[j]
                net.WriteUInt(send[1], 32)
                net.WriteTable(send[2])
                table.remove(sending.i, j)
                if (net.BytesWritten() >= max_per_interval) then
                    overflow = true
                    break
                end
            end
        end
        net.WriteBool(false)
    net.Send(ply)
    if (overflow) then
        timer.Simple(0, function()
            SendExtraInfo(ply, sending, cb)
        end)
    else
        return cb()
    end
end

local function SendWeapons(ply, is_loadout, weps, cb, i)
    if (not IsValid(ply)) then
        cb(false)
        return
    end
    net.Start "MOAT_SEND_INV_ITEM"
        net.WriteBool(false) -- weapons
        net.WriteBool(is_loadout)
        net.WriteUInt(i, 32)
        while (true) do
            if (net.BytesWritten() >= max_per_interval or not weps[i]) then
                break
            end
            net.WriteBool(true)
            local wep = weps[i]
            wep:WriteToNet()
            i = i + 1
        end
        net.WriteBool(false)
    net.Send(ply)
    --print("wrote "..i.." weapons to "..ply:Nick())
    if (weps[i]) then
        timer.Simple(0, function()
            SendWeapons(ply, is_loadout, weps, cb, i)
        end)
    else
        return cb()
    end
end
local function m_WriteWeaponsToPlayer(ply, is_loadout, weps, cb)
    local needed = ply.MG_InfoSent or {
        t = {},
        i = {}
    }
    local sending = {
        t = {},
        i = {}
    }
    ply.MG_InfoSent = needed
    for _, wep in pairs(weps) do
        if (wep.u and not needed.i[wep.u]) then
            needed.i[wep.u] = m_GetItemFromEnum(wep.u)
            table.insert(sending.i, {wep.u, needed.i[wep.u]})
        end
        if (wep.t) then
            for _, talent in pairs(wep.t.real_data) do
                if (not needed.t[talent.e]) then
                    needed.t[talent.e] = m_GetTalentFromEnum(talent.e)
                    table.insert(sending.t, {talent.e, needed.t[talent.e]})
                end
            end
        end
    end
    SendExtraInfo(ply, sending, function()
        SendWeapons(ply, is_loadout, weps, cb, 1)
    end)
end
function m_SendInventoryToPlayer(ply)
    if (ply.Sending) then
        return
    end
    ply.Sending = true
    if (ply:IsValid()) then
        net.Start("MOAT_SEND_SLOTS")
        net.WriteDouble(ply:GetMaxSlots())
        net.Send(ply)
    end

    m_LoadInventoryForPlayer(ply, function()
        local ply_inv = MOAT_INVS[ply]

        local loadout = {}
        for i = 1, 10 do
            loadout[i] = ply_inv["l_slot"..i]
        end
        m_WriteWeaponsToPlayer(ply, true, loadout, function()
            local inv = {}

            for i = 1, ply:GetNWInt("MOAT_MAX_INVENTORY_SLOTS") do
                inv[i] = ply_inv["slot"..i]
            end
            m_WriteWeaponsToPlayer(ply, false, inv, function()
                MsgC(Color(0, 255, 0), "Inventory sent to " .. ply:Nick() .. "\n")
                ply.Sending = false
            end)
        end)
    end)
end

net.Receive("MOAT_SEND_INV_ITEM", function(len, ply)
    m_SendInventoryToPlayer(ply)
end)

function m_SendCreditsToPlayer(ply)
    local ply_creds = table.Copy(MOAT_INVS[ply]["credits"])
    net.Start("MOAT_SEND_CREDITS")
    net.WriteDouble(ply_creds.c)
    net.Send(ply)
end

function m_SaveCredits(ply)
    if (not ply or not ply:IsValid()) then return end
    
    local ply_creds = table.Copy(MOAT_INVS[ply]["credits"])
    local _credits = sql.SQLStr(util.TableToJSON(ply_creds), true)
    csq = MINVENTORY_MYSQL:query("UPDATE moat_inventories SET credits='" .. _credits .. "' WHERE steamid='" .. ply:SteamID() .. "'")
    csq:start()

    function csq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()
            timer.Simple(1, function() m_SaveCredits(ply) end)
            --MINVENTORY_MYSQL:wait()

            --m_SaveCredits(ply)
        end
    end

    m_SendCreditsToPlayer(ply)
end

function m_SetCreditsSteamID(_credits, _steamid)
    csq = MINVENTORY_MYSQL:query("UPDATE moat_inventories SET credits='" .. _credits .. "' WHERE steamid='" .. _steamid .. "'")
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

    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_inventories WHERE steamid = '" .. _steamid .. "'")

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
    local _steamid = sql.SQLStr(ply:SteamID(), true)
    local _maxslots = 40

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

    for i = 1, 40 do
        eslot2[i] = {}
    end

    local fs = string.format("INSERT INTO moat_inventories ( steamid, max_slots, credits, " .. fse .. " ) VALUES ( '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s' )", _steamid, _maxslots, _credits, eslot, eslot, eslot, eslot, eslot, eslot, eslot, eslot, eslot, eslot, util.TableToJSON(eslot2))
    iq = MINVENTORY_MYSQL:query(fs)
    iq:start()
    ply:SetNWInt("MOAT_MAX_INVENTORY_SLOTS", 40)

    local inventory_tbl = {
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_zm_improvised"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_zm_revolver"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_zm_pistol"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_zm_mac10"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_zm_rifle"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_zm_shotgun"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_zm_sledge"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_ttt_ak47"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_ttt_glock"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_ttt_m16"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_ttt_sg552"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_ttt_shotgun"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_ttt_galil"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 0,
            s = {},
            w = "weapon_ttt_aug"
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 22,
            s = {}
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 22,
            s = {}
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 22,
            s = {}
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 22,
            s = {}
        },
        {
            c = math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99) .. math.random(99),
            u = 22,
            s = {}
        }
    }

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

    for i = #inventory_tbl + 1, 40 do
        inv_tbl["slot" .. i] = {}

        if (i == ply:GetNWInt("MOAT_MAX_INVENTORY_SLOTS")) then
            MOAT_INVS[ply] = inv_tbl
            m_SendInventoryToPlayer(ply)
        end
    end

    m_SendCreditsToPlayer(ply)
    m_SaveInventory(ply)
end

function m_InsertNewStatsPlayer(ply)
    local _steamid = sql.SQLStr(ply:SteamID(), true)

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


function m_LoadInventoryForPlayer(ply, cb)
    ply:LoadInventory(function(_, inv)
        local inv_tbl = {
            credits = {
                c = 0
            } -- TODO: readd
        }
        MOAT_INVS[ply] = inv_tbl

        for i = 1, 10 do
            inv_tbl["l_slot"..i] = MOAT_INV:Blank()
        end
        local i = 0
        for uid, wep in pairs(inv) do
            if (wep.slotid) then
                inv_tbl["l_slot"..wep.slotid] = wep
            else
                i = i + 1
                inv_tbl["slot"..i] = wep
            end
        end

        ply.Inventory = inv_tbl

        ply:SetNWInt("MOAT_MAX_INVENTORY_SLOTS", i - 1)
        if (cb) then cb() end
    end)

    --UPDATE core_members SET last_activity = 1524525387 WHERE steamid = 76561198831932398
    local query2 = MINVENTORY_MYSQL:query("UPDATE core_members SET last_activity = UNIX_TIMESTAMP() WHERE steamid = '" .. ply:SteamID64() .. "'")
    query2:start()
end

function m_SaveInventory(ply)
    if (not ply or not ply:IsValid()) then return end
    
    local ply_inv = table.Copy(MOAT_INVS[ply])
    local string1 = ""
    local comma1 = "',"

    for i = 1, 10 do
        string1 = string1 .. "l_slot" .. tostring(i) .. "='" .. sql.SQLStr(util.TableToJSON(ply_inv["l_slot" .. i]), true) .. comma1
    end

    local inventory_table = {}

    for i = 1, ply:GetNWInt("MOAT_MAX_INVENTORY_SLOTS") do
        table.insert(inventory_table, ply_inv["slot" .. i])
    end

    string1 = string1 .. "inventory='" .. sql.SQLStr(util.TableToJSON(inventory_table), true) .. "'"
    sq = MINVENTORY_MYSQL:query("UPDATE moat_inventories SET " .. string1 .. " WHERE steamid='" .. ply:SteamID() .. "'")
    sq:start()

    function sq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()
            timer.Simple(1, function() m_SaveInventory(ply) end)
            --MINVENTORY_MYSQL:wait()

            --m_SaveInventory(ply)
        end
    end

    MsgC(Color(0, 255, 0), "Inventory saved for " .. ply:Nick() .. "\n")
end

function m_SaveMaxSlots(ply)
    local ply_inv = table.Copy(MOAT_INVS[ply])

    if (not ply_inv or (ply_inv and not ply_inv["slot1"])) then
        return
    end

    local max_slots = ply:GetMaxSlots() or 40
    local string1 = "max_slots=" .. max_slots
    sq = MINVENTORY_MYSQL:query("UPDATE moat_inventories SET " .. string1 .. " WHERE steamid='" .. ply:SteamID() .. "'")
    sq:start()

    function sq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()
            timer.Simple(1, function() m_SaveMaxSlots(ply) end)
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

    csq = MINVENTORY_MYSQL:query("UPDATE moat_stats SET stats_tbl='" .. ply_stats .. "' WHERE steamid='" .. ply:SteamID() .. "'")
    csq:start()

    function csq:onError(err)
        if (tonumber(MINVENTORY_MYSQL:status()) == mysqloo.DATABASE_NOT_CONNECTED) then
            MINVENTORY_MYSQL:connect()
            timer.Simple(1, function() m_SaveStats(ply) end)
        end
    end
end

function m_LoadStats(ply)
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_stats WHERE steamid = '" .. ply:SteamID() .. "'")

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