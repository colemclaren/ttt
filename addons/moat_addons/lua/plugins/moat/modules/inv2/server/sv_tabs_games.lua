util.AddNetworkString("MOAT_GAMBLE_CHAT")
util.AddNetworkString("MOAT_GAMBLE_NEW_CHAT")

function m_AddGambleChat(...)
    net.Start("MOAT_GAMBLE_CHAT")
    net.WriteTable({...})
    net.Broadcast()
end

function m_AddGambleChatPlayer(ply, ...)
    net.Start("MOAT_GAMBLE_CHAT")
    net.WriteTable({...})
    net.Send(ply)
end

function versus_tax(am)
    if am > 99999 then 
        am = math.floor(am * 0.9) 
    elseif am > 9999 then
        am = math.floor(am * 0.975)
    elseif am > 1000 then 
        am = math.floor(am * 0.99) 
    end
    return am
end

local gamble_net_cd = 1 -- 1 sec net cooldown
local gamble_net = {}
function gamble_net_spam(ply, msg)
	return false/*
	if (not gamble_net[ply]) then
		gamble_net[ply] = {}
		return false
	end

	if (not gamble_net[ply][msg]) then
		gamble_net[ply][msg] = CurTime() + gamble_net_cd
		return false
	end

	if (gamble_net[ply][msg] and gamble_net[ply][msg] > CurTime()) then
		return true
	end

	gamble_net[ply][msg] = CurTime() + gamble_net_cd

	return false*/
end

util.AddNetworkString("MOAT_GAMBLE_CAT")
util.AddNetworkString("MOAT_GAMBLE_GLOBAL")
util.AddNetworkString("Moat.GlobalAnnouncement")
util.AddNetworkString("Moat.JackpotWin")
util.AddNetworkString("Moat.PlanetaryDrop")
util.AddNetworkString("Moat.LotteryChat")
local MOAT_GAMBLE_CATS = {
    {"Versus", Color(0, 255, 255)},
    {"Blackjack", Color(255, 255, 0)},
    {"Roulette", Color(255, 0, 50)},
    {"Jackpot", Color(0, 255, 0)},
    {"Mines", Color(150, 0, 255)}
}


local function DiscordGamble(msg)
	discord.Send("Gamble Win", msg)
end

GG_DISABLE = CreateConVar("moat_disable_sv_gamble",0)

/*
    ADD CATEGORY IF U ADD NEW ONE 
    ADD CATEGORY IF U ADD NEW ONE 
    ADD CATEGORY IF U ADD NEW ONE 
    ADD CATEGORY IF U ADD NEW ONE 
    ADD CATEGORY IF U ADD NEW ONE 
    ADD CATEGORY IF U ADD NEW ONE 
*/

net.Receive("MOAT_GAMBLE_CAT", function(len, ply)
    local num = math.Clamp(net.ReadUInt(4), 1, #MOAT_GAMBLE_CATS)
    ply.MoatGambleCat = num

    net.Start("MOAT_GAMBLE_CAT")
    net.WriteUInt(num, 4)
    net.Send(ply)
end)

--util.AddNetworkString("MOAT_GAMBLE_DICE")

local moat_rigged = {}
local moat_wonlog = {}

function m_GambleRollDice(ply, amt, bet, under)
    local random_num = math.Rand(0, 100)
    local won = false

    if (moat_rigged[ply:SteamID()] or (bet <= 5 and under) or (bet >= 95 and not under)) then
        if ((bet <= 5 and under) or (bet >= 95 and not under)) then
            moat_rigged[ply:SteamID()] = 1
        end

        if (under) then
            random_num = math.Rand(bet, 100)
        else
            random_num = math.Rand(bet, 0)
        end

        local numrolls = tonumber(moat_rigged[ply:SteamID()])

        moat_rigged[ply:SteamID()] = numrolls - 1

        if (moat_rigged[ply:SteamID()] <= 0) then
            moat_rigged[ply:SteamID()] = nil
        end
    end
    
    local multiplier = math.Round(100/bet, 2)
    if (not under) then
        multiplier = math.Round(100/(100-bet), 2)
    end

    if (((under and random_num <= bet) or (not under and random_num >= bet))) then
        won = true

        if (moat_wonlog[ply:SteamID()]) then
            moat_wonlog[ply:SteamID()] = moat_wonlog[ply:SteamID()] + 1
        else
            moat_wonlog[ply:SteamID()] = 1
        end

        if (moat_wonlog[ply:SteamID()] % math.random(7, 12) == 0) then
            moat_rigged[ply:SteamID()] = 1
        end
    end

    if (won) then
        local won_amt = math.Round((amt * multiplier) - amt, 2)

        ply:m_GiveIC(won_amt)
        local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    	m_AddGambleChat(
			Color(255,255,255), "[",
			room[2], room[1][1],
			Color(255,255,255), "]",
			Color(0, 150, 0), "+" .. won_amt .. " ",
			Color(180, 180, 180), ply:Nick()
		)

        if (won_amt > 2000) then
            moat_rigged[ply:SteamID()] = math.Round(won_amt/amt) + 1
        end
    else
        ply:m_TakeIC(math.Round(amt, 2))
        local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    	m_AddGambleChat(
			Color(255,255,255), "[",
			room[2], room[1][1],
			Color(255,255,255), "]",
			Color(150, 0, 0), "-" .. amt .. " ", 
			Color(180, 180, 180), ply:Nick()
		)
    end

    net.Start("MOAT_GAMBLE_DICE")
    net.WriteBool(true)
    net.WriteBool(won)
    net.WriteDouble(math.Round(random_num, 2))
    local amt_float = amt
    if (won) then
        amt_float = math.Round((amt * multiplier) - amt, 2)
    end
    net.WriteDouble(amt_float)
    net.Send(ply)
end

net.Receive("MOAT_GAMBLE_DICE", function(len, ply)
	if (gamble_net_spam(ply, "MOAT_GAMBLE_DICE")) then return end

    local amt = math.Clamp(net.ReadDouble(), 1, 5000)
    local bet = math.Clamp(net.ReadDouble(), 0, 100)
    local under = net.ReadBool()

    if (not ply:m_HasIC(amt)) then
        m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!")

        net.Start("MOAT_GAMBLE_DICE")
        net.WriteBool(false)
        net.Send(ply)
        return
    end

    m_GambleRollDice(ply, math.Round(amt, 2), math.Round(bet, 2), under)
end)

concommand.Add("moat_rollthecrate", function(ply, cmd, args)
    if (not moat.isdev(ply)) then
        return
    end

    local steamid = args[1] or "NONE"
    local number = args[2] or 2

    moat_rigged[steamid] = tonumber(number)
end)



-- Blackjack



MOAT_BLACK_GAMES = {}

function m_GambleBlackjackRemoveGame(ply)
    if (MOAT_BLACK_GAMES[ply:SteamID()]) then
        MOAT_BLACK_GAMES[ply:SteamID()] = nil
    end
end
hook.Add("PlayerDisconnected", "moat_BlackjackDisconnect", m_GambleBlackjackRemoveGame)

function m_GambleBlackjackDraw(ply)
    local amt = math.floor(MOAT_BLACK_GAMES[ply:SteamID()].bet)

    local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    ply:m_GiveIC(amt)

    m_AddGambleChat(--a
		Color(255,255,255), "[",
		room[2], room[1][1],
		Color(255,255,255), "]",
		Color(150, 150, 0), "+" .. amt .. " ", 
		Color(180, 180, 180), ply:Nick()
	)

    net.Start("MOAT_GAMBLE_BLACKOVER")
    net.WriteUInt(3, 2)
    net.WriteDouble(amt)
    net.Send(ply)

    MOAT_BLACK_GAMES[ply:SteamID()] = nil
end

function m_GambleBlackjackWon(ply, blackjack)
    local amt = MOAT_BLACK_GAMES[ply:SteamID()].bet
    local won_amt = math.Round(amt * 1.5)
    if (blackjack) then
        won_amt = math.Round(amt * 1.75)
    end
    ply:m_GiveIC(won_amt)
    local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    m_AddGambleChat(
		Color(255,255,255), "[",
		room[2], room[1][1], 
		Color(255,255,255), "]",
		Color(0, 150, 0), "+" .. won_amt .. " ", 
		Color(180, 180, 180), ply:Nick()
	)

    net.Start("MOAT_GAMBLE_BLACKOVER")
    net.WriteUInt(2, 2)
    net.WriteDouble(won_amt)
    net.Send(ply)

    MOAT_BLACK_GAMES[ply:SteamID()] = nil
end

function m_GambleBlackjackLoss(ply)
    local amt = MOAT_BLACK_GAMES[ply:SteamID()].bet

    net.Start("MOAT_GAMBLE_BLACKOVER")
    net.WriteUInt(1, 2)
    net.WriteDouble(amt)
    net.Send(ply)

    MOAT_BLACK_GAMES[ply:SteamID()] = nil
end

function m_GambleBlackjackCheckForGameOver(ply)
    local pl = MOAT_BLACK_GAMES[ply:SteamID()].plycards
    local plstand = MOAT_BLACK_GAMES[ply:SteamID()].plystand
    local dl = MOAT_BLACK_GAMES[ply:SteamID()].dealcards
    local pltotal, dltotal = 0, 0

    for i = 1, #pl do
        pltotal = pltotal + pl[i]
    end

    for i = 1, #dl do
        dltotal = dltotal + dl[i]
    end

    for i = 1, #pl do
        if (pl[i] == 1 and pltotal + 10 <= 21) then
            pltotal = pltotal + 10
        end
    end

    for i = 1, #dl do
        if (dl[i] == 1 and dltotal + 10 <= 21) then
            dltotal = dltotal + 10
        end
    end

    if (pltotal == 21 or dltotal == 21) then
        if (pltotal == 21 and dltotal ~= 21) then
            m_GambleBlackjackWon(ply, true)
        elseif (pltotal == 21 and dltotal == 21) then
            m_GambleBlackjackDraw(ply)
        else
            m_GambleBlackjackLoss(ply)
        end
        return
    end

    if (dltotal > 21 or pltotal > 21) then
        if (pltotal > 21) then
            m_GambleBlackjackLoss(ply)
        else
            m_GambleBlackjackWon(ply)
        end
        return
    end

    if (plstand and dltotal > pltotal) then
        m_GambleBlackjackLoss(ply)
        return
    end

    if (plstand and dltotal < 17) then
        m_GambleBlackjackNewCard(ply, true)
    elseif (plstand and dltotal > 16) then
        if (pltotal > dltotal) then
            m_GambleBlackjackWon(ply)
        elseif (dltotal == pltotal) then
            m_GambleBlackjackDraw(ply)
        else
            m_GambleBlackjackLoss(ply)
        end
    end
end

function m_GambleBlackjackNewCard(ply, dealer, XX)
    if (XX) then
        net.Start("MOAT_BLACK_CARD")
        net.WriteBool(dealer)
        net.WriteUInt(0, 4)
        net.Send(ply)

        return
    end

    local num = math.random(1, 10)

    if (dealer) then
        table.insert(MOAT_BLACK_GAMES[ply:SteamID()].dealcards, num)
    else
        table.insert(MOAT_BLACK_GAMES[ply:SteamID()].plycards, num)
    end

    net.Start("MOAT_BLACK_CARD")
    net.WriteBool(dealer)
    net.WriteUInt(num, 4)
    net.Send(ply)

    m_GambleBlackjackCheckForGameOver(ply)
end

function m_GambleNewBlackjack(ply, amt)
    MOAT_BLACK_GAMES[ply:SteamID()] = {
        bet = amt,
        dealcards = {},
        plycards = {},
        plystand = false
    }
    ply.BlackDealing = true

    ply:m_TakeIC(amt)
    local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    m_AddGambleChat(
		Color(255,255,255), "[",
		room[2], room[1][1],
		Color(255,255,255), "]",
		Color(150, 0, 0), "-" .. amt .. " ", 
		Color(180, 180, 180), ply:Nick()
	)

    m_GambleBlackjackNewCard(ply, false)
    timer.Simple(0.5, function()
        m_GambleBlackjackNewCard(ply, true)
    end)
    timer.Simple(1, function()
        m_GambleBlackjackNewCard(ply, false)
    end)
    timer.Simple(1.5, function()
        m_GambleBlackjackNewCard(ply, true, true)
        ply.BlackDealing = false
    end)
end

net.Receive("MOAT_GAMBLE_ACTION", function(len, ply)
	-- if (gamble_net_spam(ply, "MOAT_GAMBLE_ACTION")) then return end
    if (not MOAT_BLACK_GAMES[ply:SteamID()]) then return end
    if ply.BlackDealing then return end
    local act = net.ReadBool()
    if (act) then
        m_GambleBlackjackNewCard(ply, false)
    else
        if (MOAT_BLACK_GAMES[ply:SteamID()].plystand) then
            m_GambleBlackjackLoss(ply)
            return
        end

        MOAT_BLACK_GAMES[ply:SteamID()].plystand = true
        m_GambleBlackjackNewCard(ply, true)
    end
end)

util.AddNetworkString("MOAT_GAMBLE_ACTION")
util.AddNetworkString("MOAT_GAMBLE_BLACK")
util.AddNetworkString("MOAT_BLACK_CARD")
util.AddNetworkString("MOAT_GAMBLE_BLACKOVER")

net.Receive("MOAT_GAMBLE_BLACK", function(len, ply)
	if (gamble_net_spam(ply, "MOAT_GAMBLE_BLACK")) then return end
    local amt = net.ReadUInt(32)
    if amt < 10 then
        m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You must bet atleast 10 IC!")
        return
    end
    if (not ply:m_HasIC(amt)) then
        m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!")

        net.Start("MOAT_GAMBLE_BLACK")
        net.Send(ply)
        return
    elseif (MOAT_BLACK_GAMES[ply:SteamID()]) then
        m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You're already in a blackjack game!")

        return
    end

    m_GambleNewBlackjack(ply, math.Round(amt, 2))
end)


net.Receive("MOAT_GAMBLE_NEW_CHAT", function(len, ply)
	if (gamble_net_spam(ply, "MOAT_GAMBLE_NEW_CHAT")) then return end

    local text = net.ReadString()

	local safe = FamilyFriendly(text, ply)
	if (not safe) then
		return 
	end

    local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    m_AddGambleChat(
		Color(255,255,255), "[",
		room[2], room[1][1],
		Color(255,255,255),"]", 
		Color(0, 255, 0), ply:Nick(), 
		Color(255, 255, 255), ": " .. safe:Trim()
	)
end)


/*---------------------------------------------------------------------------
Roulette by Velkon
---------------------------------------------------------------------------*/

util.AddNetworkString("roulette.bet")
util.AddNetworkString("roulette.SyncMe")
util.AddNetworkString("roulette.roll")
util.AddNetworkString("roulette.finishroll")
util.AddNetworkString("roulette.player")

local function round(num)
    return tonumber(string.format("%.2f", num))
end -- used in crash too -- Versus too

--[[
    replace these
]]

local function addIC(ply,amount)
    ply:m_GiveIC(math.floor(amount))
    local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    m_AddGambleChat(
		Color(255,255,255), "[",
		room[2], room[1][1],
		Color(255,255,255), "]",
		Color(0, 150, 0), "+" .. math.floor(amount) .. " ", 
		Color(180, 180, 180), ply:Nick()
	)
end

local function removeIC(ply,amount)
    ply:m_TakeIC(math.floor(amount))
    local room = MOAT_GAMBLE_CATS[ply.MoatGambleCat or 1]

    m_AddGambleChat(
		Color(255,255,255), "[",
		room[2], room[1][1],
		Color(255,255,255), "]",
		Color(150, 0, 0), "-" .. math.floor(amount) .. " ", 
		Color(180, 180, 180), ply:Nick()
	)
end

local roulette_spinterval = 20 -- How many seconds between spins

----------------------------------


local spin_duration = 12


local roulette_players = {}

local function getplayers()
    local plys = {}
    for k,v in pairs(roulette_players) do
        plys[#plys+1] = k
    end
    return plys
end

local function getwinners(num)
    if num < 1 then 
        num = 0 
    elseif num >= 1 and num < 8 then 
        num = 1 
    else 
        num = 2 
    end
    --print("Getting winners for " .. num )
    local winners = {}
    for k,v in pairs(roulette_players) do
        ----print("n:")
        ----print(tostring(v[num]))
        if v[num] then
            winners[k] = v[num]
        end
    end
    return winners, table.Count(winners)
end

local roulette_rolltime = roulette_spinterval -- USedi nternally
local roulette_number = 0
local roulette_rolling = false
local roulette_nextroll = roulette_spinterval -- Used for telling client

net.Receive("roulette.bet",function(l,ply)
    if roulette_rolling then return end -- Clients already know number.
    local num = net.ReadInt(8)
    -- 0 for green, 1 for red, 2 for black
    if num > 2 or num < 0 then return end
    local amount = math.Clamp(net.ReadDouble(), 1, 5000)
    if (GetGlobal("ttt_rounds_left") < 2) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Please wait until map change to use roulette. Map is changing soon, don't want you to lose IC!") return end
    if amount < 1 or not ply:m_HasIC(amount) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!") return end
    if (gamble_net_spam(ply, "roulette.bet")) then return end

	if roulette_players[ply] then 
        if roulette_players[ply][num] then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You can only bet on a color once per spin!") return end
        roulette_players[ply][num] = amount
    else
        roulette_players[ply] = {[num] = amount}
    end
    removeIC(ply,amount)

    net.Start("roulette.player")
    net.WriteEntity(ply)
    net.WriteInt(num,8)
    net.WriteDouble(amount)
    net.Broadcast()
    ----print(ply,"placed",amount,"ic on",num)
end)

net.Receive("roulette.SyncMe", function(l,ply)
    net.Start("roulette.SyncMe")
    net.WriteDouble(roulette_nextroll)
    net.WriteBool(roulette_rolling)
    net.WriteDouble(roulette_number)
    net.Send(ply)
    ----print("Synced",ply,roulette_nextroll)
end)

hook.Add("Think","Roulette think",function()
    ------print("Rolling in " .. roulette_rolltime - CurTime() .. " seconds.")
    if roulette_rolltime < CurTime() and not roulette_rolling then
        -- Start rolling 
        local pre_meme = math.random() * 15 
        if (math.floor(pre_meme) == 0 and math.random(1, 100) > 40) then pre_meme = math.Rand(1, 14) end
        roulette_number = pre_meme
        roulette_rolling = true
        roulette_rolltime = CurTime() + spin_duration
        roulette_nextroll = CurTime() + spin_duration + roulette_spinterval
        net.Start("roulette.roll")
        net.WriteDouble(roulette_number)
        net.Broadcast()
        ----print("started rolling,",roulette_number)
    elseif roulette_rolltime < CurTime() and roulette_rolling then
        ----print("finished roll, waiting for next roll.")
        -- Dish out rewards, roll is over.
        roulette_rolltime = CurTime() + roulette_spinterval
        roulette_rolling = false
        local winners,am = getwinners(roulette_number)
        net.Start("roulette.finishroll")
        net.Broadcast()
        roulette_players = {}
        if am < 1 then return end
        local m = 2
        for k,v in pairs(winners) do
            if roulette_number < 1 then m = 14 end -- green.
            if not IsValid(k) then continue end
            addIC(k,v*m)
            if (v*m) > 100 then
                local msg = k:Nick() .. " (" .. k:SteamID() .. ") won " .. round(v*m) .. " IC in roulette."

				discord.Send("Gamble", msg)
            end
            if roulette_number < 1 then
                DiscordGamble(k:Nick() .. " (" .. k:SteamID() .. ") won **" .. round(v*m) .. "** IC on Green in Roulette.")
            end
            ----print(k,"won",v*m)
        end
    end
end)
----print("roulette loaded")

--[[
    Crash section
]]
-- util.AddNetworkString("crash.bet")
-- util.AddNetworkString("crash.syncme")
-- util.AddNetworkString("crash.player")
-- util.AddNetworkString("crash.start")
-- util.AddNetworkString("crash.finish")
-- util.AddNetworkString("crash.getout")

local crash_delay = 20

local crash_nextcrash = 0

local crash_players = {}

local crash_crashing = true

local crash_number = 1

local crash_tocrash = 0

local crash_startcrash = 0

local function getcrashnumber()
    local a = math.random(1, 100)
    if a < 22.5 then
        return 0
    elseif a < 85 then
        return math.Rand(1, 2.5)
    elseif a <= 100 then
        return math.Rand(1, 14)
    else
        return 0
    end
end

net.Receive("crash.syncme",function(l,ply)
    if crash_crashing then
        net.Start("crash.syncme")
        net.WriteBool(true)
        net.WriteDouble(crash_number)
        net.Send(ply)
    else
        net.Start("crash.syncme")
        net.WriteBool(false)
        net.WriteDouble(crash_tocrash)
        net.WriteDouble(crash_nextcrash)
        net.Send(ply)
    end
end)

net.Receive("crash.bet", function(l,ply)
	if (true) then return end
    if crash_crashing then return end
    local amount = math.Clamp(net.ReadDouble(), 1, 5000)
    if (GetGlobal("ttt_rounds_left") < 2) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Please wait until map change to use crash. Map is changing soon, don't want you to lose IC!") return end
    if amount < 1 or not ply:m_HasIC(amount) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!") return end
    if (gamble_net_spam(ply, "crash.bet")) then return end

	if crash_players[ply] then  
        m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You already bet for this round!")
        return
    else--sd
        crash_players[ply] = amount
    end
    removeIC(ply,amount)

    net.Start("crash.player")
    net.WriteEntity(ply)
    net.WriteBool(false)
    net.WriteDouble(amount)
    net.Broadcast()
end)--sd

net.Receive("crash.getout", function(l,ply)
    if not crash_players[ply] then return end
    if not crash_crashing then return end
	if (gamble_net_spam(ply, "crash.getout")) then return end

    local a = crash_players[ply] * round(crash_number)
    addIC(ply,a)
    if (a) > 100 then
        local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") won " .. round(a) .. " IC in crash."
		discord.Send("Gamble", msg)
	end
    crash_players[ply] = nil
    net.Start("crash.player")
    net.WriteEntity(ply)
    net.WriteBool(true)
    net.WriteDouble(a)
    net.Broadcast()
end)

-- hook.Add("Think","Crash think",function()
--     --print(crash_nextcrash,CurTime())
--     if crash_nextcrash < CurTime() and not crash_crashing then
--         crash_tocrash = getcrashnumber()
--         --print("Started crashing: " .. crash_tocrash)
--         crash_crashing = true
--         crash_number = 1
--         crash_startcrash = CurTime()
--         net.Start("crash.start")
--         net.Broadcast()
--     elseif crash_nextcrash < CurTime() and crash_crashing then
--         crash_number = round((CurTime() - crash_startcrash) * 0.1) + 1
--         if crash_number >= crash_tocrash then
--             crash_tocrash = round(crash_tocrash)
--             crash_players = {}
--             crash_nextcrash = CurTime() + crash_delay
--             crash_crashing = false
--             --print("crashed @ " .. crash_tocrash .. "x")
--             net.Start("crash.finish")
--             net.WriteDouble(crash_tocrash)
--             net.Broadcast()
--         end
--     end
-- end)

--[[
    Versus
]]

util.AddNetworkString("versus.CreateGame")
util.AddNetworkString("versus.JoinGame")
util.AddNetworkString("versus.FinishGame")
util.AddNetworkString("versus.Sync")
util.AddNetworkString("versus.Cancel")
util.AddNetworkString("versus.CancelGame")

local versus_players = {}--s

local versus_wait = 10
--a
function versus_opponent(ply)
    for k,v in pairs(versus_players) do
        if k == ply then 
            return k
        end
        if v[1] == ply then return k end
    end
    return false
end

net.Receive("versus.CreateGame",function(l,ply)
    if versus_players[ply] then return end
	if (gamble_net_spam(ply, "versus.CreateGame")) then return end

    local amount = round(net.ReadDouble())
    if (GetGlobal("ttt_rounds_left") < 2) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Please wait until map change to use roulette. Map is changing soon, don't want you to lose IC!") return end
    if amount < 1 or not ply:m_HasIC(amount) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!") return end
    versus_players[ply] = {nil,amount}
    net.Start("versus.CreateGame")
    net.WriteEntity(ply)
    net.WriteDouble(amount)
    net.Broadcast()
end)

net.Receive("versus.Sync",function(l,ply)
    net.Start("versus.Sync")
    net.WriteTable(versus_players)
    net.Send(ply)
end)

net.Receive("versus.CancelGame",function(l,ply)
	if (gamble_net_spam(ply, "versus.CancelGame")) then return end
    if versus_players[ply] then
        if IsValid(versus_players[ply][1]) then return end
        net.Start("versus.Cancel")
        net.WriteEntity(ply)
        net.Broadcast()
        versus_players[ply] = nil
    end
end)

net.Receive("versus.JoinGame",function(l,ply)
    if true then return end
    local t = net.ReadEntity()
    if t == ply then return end
    if not versus_players[t] then return end
    if IsValid(versus_players[t][1]) then return end
    local amt = versus_players[t][2]
    if (GetGlobal("ttt_rounds_left") < 2) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Please wait until map change to use roulette. Map is changing soon, don't want you to lose IC!") return end
    if amt < 1 or not ply:m_HasIC(amt) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!") return end
    if not t:m_HasIC(amt) then m_AddGambleChatPlayer(ply, Color(255, 0, 0), "The game was cancelled due to the other player losing the required IC!") 
        versus_players[t] = nil
        net.Start("versus.Cancel")
        net.WriteEntity(t)
        net.Broadcast()
    return end
    versus_players[t][1] = ply
    removeIC(ply,amt)--3
    removeIC(t,amt)--s
    net.Start("versus.JoinGame")
    net.WriteEntity(t)
    net.WriteEntity(ply)
    net.Broadcast()
    timer.Simple(versus_wait,function()--s
        if (not IsValid(t)) and IsValid(ply) then
            addIC(ply,round(amt))
            return
        elseif (not IsValid(ply)) and IsValid(t) then
            addIC(t,round(amt))
            return
        else
            local winner = ply
            if math.random() > 0.5 then
                winner = t
            end	
            local winamt = amt *2
            if (winamt) > 50 then--s
                winamt = winamt * 0.99
            end
            
            addIC(winner,round(winamt))
            net.Start("versus.FinishGame")
            net.WriteEntity(t)
            net.WriteEntity(winner)
            net.Broadcast()
            timer.Simple(3,function()
                versus_players[t] = nil
            end)
            local other = ply
            if winner == ply then
                other = t
            end
            if winamt > 100 then
                local msg = winner:Nick() .. " (" .. winner:SteamID() .. ") won " .. round(winamt) .. " IC in versus from " .. other:Nick() .. " (" .. other:SteamID() .. ")"
				discord.Send("Gamble", msg)
            end
        end
    end)
end)


/*
    JackPot - Cross server
*/

util.AddNetworkString("gversus.CreateGame")
util.AddNetworkString("gversus.FinishGame")
util.AddNetworkString("gversus.JoinGame")
util.AddNetworkString("gversus.Cancel")
util.AddNetworkString("gversus.CancelGame")
util.AddNetworkString("gversus.Sync")
util.AddNetworkString("gversus.FullGame")


util.AddNetworkString("jackpot.players")
util.AddNetworkString("jackpot.info")
util.AddNetworkString("jackpot.join")
util.AddNetworkString("jackpot.win")

util.AddNetworkString("versus.logs")
util.AddNetworkString("versus.last")
util.AddNetworkString("versus.total")
util.AddNetworkString("versus.stats")

net.Receive("versus.logs",function(l,ply)
    if (ply.vlogs_cool or 0) > CurTime() then return end
    ply.vlogs_cool = CurTime() + 1
    local id = net.ReadInt(32)
    versus_getlogs(ply,id)
end)

net.Receive("versus.last",function(l,ply)
    if (ply.vlogs_last or 0) > CurTime() then return end
    ply.vlogs_last = CurTime() + 1
    versus_getlast(ply)
end)

net.Receive("versus.total",function(l,ply)
    if (ply.vtot_cool or 0) > CurTime() then return end
    ply.vtot_cool = CurTime() + 1
    versus_gettotal(ply)
end)

versus_stats = {
    top = {},
    streak = {}
}

net.Receive("versus.stats",function(l,ply)
    if (ply.stats_cool or 0) > CurTime() then return end
    ply.stats_cool = CurTime() + 1
    net.Start("versus.stats")
    net.WriteTable(versus_stats)
    net.Send(ply)
end)

local dev_suffix = ""

local jpl = false
jp = {}
local versus_rewarded = {}
function jackpot_()
    if jpl then return end jpl = true
    local db = MINVENTORY_MYSQL

    local q = db:query("CREATE TABLE IF NOT EXISTS `moat_versus" .. dev_suffix .. "` ( `steamid` varchar(100) NOT NULL, `money` INT NOT NULL, `time` INT, `other` varchar(255), `winner` varchar(255), `rewarded` BOOLEAN, PRIMARY KEY (steamid) )")
    q:start()
    versus_curgames = {}
    versus_knowngames = {}

    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_versuslogs` ( ID int NOT NULL AUTO_INCREMENT, `steamid` varchar(255) NOT NULL, `other` varchar(255) NOT NULL, `winner` varchar(255) NOT NULL, `amount` INT NOT NULL, `time` INT NOT NULL, PRIMARY KEY (ID) ) ")
    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end
    dq:start()

    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_versusstreaks` ( `steamid` varchar(100) NOT NULL, `streak` INT NOT NULL, PRIMARY KEY (steamid) ) ")
    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end
    dq:start()

    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_versusstreaks_history` ( ID int NOT NULL AUTO_INCREMENT, `steamid` varchar(255) NOT NULL, `streak` INT NOT NULL, `time` INT NOT NULL, PRIMARY KEY (ID) ) ")
    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end
    dq:start()

    function versus_log(steamid,other,winner, amount, tax)
        local q = db:query("INSERT INTO moat_versuslogs (steamid,other,winner,amount,time,tax) VALUES ('" .. db:escape(steamid) .. "', '" .. db:escape(other) .. "', '" .. db:escape(winner) .. "', '" .. tonumber(amount) .. "', UNIX_TIMESTAMP(), '" .. tonumber(tax) .. "' );")
        q:start()
    end

    function versus_getlogs(ply,id)
        if not id then id = 0 end
        local limit = 50
        if id == 0 then
            id = ""
        else
            id = "AND (ID < " .. id .. ")"
        end
        local q = db:query("SELECT * FROM moat_versuslogs WHERE (steamid = '" .. ply:SteamID64() .. "' OR other = '" .. ply:SteamID64() .. "') AND (winner = '" .. ply:SteamID64() .. "') " .. id .. " ORDER BY time DESC LIMIT " .. limit .. ";")
        function q:onSuccess(d)
            if not IsValid(ply) then return end
            net.Start("versus.logs")
            net.WriteBool(id == 0)
            net.WriteTable(d)
            net.Send(ply)
        end
        function q:onError(s)
        end
        q:start()
    end

    function versus_getlast(ply)
        local q = db:query("SELECT * FROM moat_versuslogs WHERE (steamid = '" .. ply:SteamID64() .. "' OR other = '" .. ply:SteamID64() .. "') ORDER BY time DESC LIMIT 1;")
        function q:onSuccess(d)
            if not IsValid(ply) then return end
            if (#d > 0) then
                net.Start("versus.last")
                net.WriteTable(d)
                net.Send(ply)
            end
        end
        function q:onError(s)
        end
        q:start()
    end

    function versus_gettotal(ply)
        local q = db:query("SELECT SUM(amount) as total FROM moat_versuslogs WHERE (steamid = '" .. ply:SteamID64() .. "' OR other = '" .. ply:SteamID64() .. "') AND (winner = '" .. ply:SteamID64() .. "') LIMIT 1;")
        function q:onSuccess(d)
            if not IsValid(ply) then return end
            net.Start("versus.total")
            net.WriteTable(d)
            net.Send(ply)
        end
        q:start()
    end

    function versus_updatestats()
        local q = db:query([[SELECT SUM(amount) AS total,winner 
        FROM moat_versuslogs 
        WHERE time > (UNIX_TIMESTAMP() - 3600) 
        GROUP BY winner 
        ORDER BY SUM(amount) DESC
        LIMIT 1]])
        function q:onSuccess(d)
            versus_stats.top = d[1] or {
                steamid = "76561198154133184",
                total = 1
            }
            local b = db:query([[SELECT steamid,streak FROM moat_versusstreaks_history
            WHERE time > (UNIX_TIMESTAMP() - 3600) 
            ORDER BY streak DESC
            LIMIT 1]])
            function b:onSuccess(c)
                versus_stats.streak = c[1] or {
                    steamid = "76561198154133184",
                    streak = 2
                }
                net.Start("versus.stats")
                net.WriteTable(versus_stats)
                net.Broadcast()
            end
            b:start()
        end
        q:start()
    end
    versus_updatestats()

    function versus_creategame(id,am,fun)
        local q = db:query("INSERT INTO moat_versus" .. dev_suffix .. " (steamid, money) VALUES ('" .. id .. "','" .. am .. "');")
        function q:onSuccess(d)
            fun()
        end
        q:start()
    end

    function versus_getgame(sid,fun)
        local q = db:query("SELECT * FROM moat_versus" .. dev_suffix .. " WHERE steamid = '" .. db:escape(sid) .. "';")
        function q:onSuccess(d)
            fun(d)
        end
        function q:onErorr(d)
            fun({})
        end
        q:start()
    end

    function versus_getgames(fun)
        local q = db:query("SELECT *, UNIX_TIMESTAMP() AS curtime FROM moat_versus" .. dev_suffix .. ";")
        function q:onSuccess(d)
            fun(d)
        end
        q:start()
    end
    local versus_queue = {}
    function versus_cancel(ply)
        versus_getgame(ply:SteamID64(),function(d)
            versus_joins[ply:SteamID64()] = false
            if #d < 1 then 
            versus_queue[ply] = nil
            return end
            d = d[1]
            if d.winner or d.other then 
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Someone already joined the game!")
                net.Start("gversus.FullGame")
                net.WriteString(ply:SteamID64())
				net.InvsBroadcast(ply:SteamID64(), ply)
                versus_queue[ply] = nil
                return
            end
            local q = db:query("SELECT steamid FROM moat_versus" .. dev_suffix .. " WHERE steamid = '" .. ply:SteamID64().. "' AND other IS NULL;DELETE FROM moat_versus" .. dev_suffix .. " WHERE steamid = '" .. ply:SteamID64().. "' AND other IS NULL;")
            function q:onSuccess(b)
                if #b < 1 then return end -- someone already joined
                versus_queue[ply] = nil
                addIC(ply,d.money)
                versus_curgames[ply:SteamID64()] = nil
                net.Start("gversus.Cancel")
                net.WriteString(ply:SteamID64())
                net.InvsBroadcast(ply:SteamID64(), ply)
            end
            function q:onError()
                versus_queue[ply] = nil
            end
            q:start()
        end)
    end

    net.Receive("gversus.CancelGame",function(l,ply)
	if (gamble_net_spam(ply, "gversus.CancelGame")) then return end
        if versus_queue[ply] then return end
        if (ply.VersCool and ply.VersCool > CurTime()) then
		m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Please wait " .. math.Round(ply.VersCool - CurTime(),3) .. " seconds before performing that action.")
		return
	end
        	
	ply.VersCool = CurTime() + 2

        versus_joins[ply:SteamID64()] = true
        versus_queue[ply] = true
        versus_cancel(ply)
    end)

    function versus_forcedelete(sid,fun) -- not really force but to double check with uncached results
        local q = db:query("SELECT * FROM moat_versus" .. dev_suffix .. " WHERE steamid = '" .. db:escape(sid) .. "';")
        function q:onSuccess(d)
            if #d < 1 then
                fun(true)
                return
            end
            local b = db:query("DELETE FROM moat_versus" .. dev_suffix .. " WHERE steamid = '" .. sid .. "' AND money = '" .. d[1].money .. "' AND (rewarded = '1' OR (UNIX_TIMESTAMP() - time > 40));")
            function b:onSuccess()
                fun(true)
            end
            b:start()
        end
        q:start()
    end

    function versus_joingame(ply,sid,amt)
        versus_getgame(sid,function(d)
            if not IsValid(ply) then return end
            ply.VersT[sid] = false
            versus_joins[sid] = false
            if #d < 1 then 
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "That player canceled that game!")
                net.Start("gversus.Cancel")
                net.WriteString(sid)
				net.InvsBroadcast(sid, ply)
                return 
            end
            d = d[1]
            if d.winner then 
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Someone already joined that game!")
                net.Start("gversus.FullGame")
                net.WriteString(sid)
				net.InvsBroadcast(sid, ply)
                return
            end
            if not ply:m_HasIC(d.money) then
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!")
                return
            end
            if tonumber(versus_curgames[sid][1]) ~= tonumber(d.money) or tonumber(versus_curgames[sid][1]) ~= amt or tonumber(d.money) ~= amt then
                net.Start("gversus.CreateGame")
                net.WriteString(sid)
                net.WriteDouble(d.money)
                net.InvsBroadcast(sid, ply)
                versus_curgames[sid][1] = d.money
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "That game changed amount!")
                return
            end
            local winner = ply:SteamID64()
            if not ply.VERSUS_R and math.random() > 0.5 then
                winner = sid
            end	
            local plyz = ply:SteamID64()
            local qs = "UPDATE moat_versus" .. dev_suffix .. " SET winner = '" .. db:escape(winner) .. "', other = '" .. plyz .. "', time = UNIX_TIMESTAMP() WHERE steamid = '" .. db:escape(sid) .. "' AND winner IS NULL;"
            local q = db:query(qs)
            function q:onSuccess(qd)
                versus_getgame(sid,function(d)
                    if not IsValid(ply) then
                        local q = db:query("UPDATE moat_versus" .. dev_suffix .. " SET winner = NULL, other = NULL, time = NULL WHERE steamid = '" .. db:escape(sid) .. "';")
                        q:start()
                        return
                    end
                    d = d[1]
                    if d.other ~= plyz then 
                        m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Someone already joined that game!")
                        net.Start("gversus.FullGame")
                        net.WriteString(sid)
                        net.InvsBroadcast(sid, ply)
                        return
                    end
                    if not ply:m_HasIC(d.money) then
                        local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") attempted to join versus with not enough money (" .. d.money .. "). Exploit"
                        discord.Send("Anti Cheat", msg)
                        -- RunConsoleCommand("mga","ban",ply:SteamID(),"12","hours","Exploiting (v:j)")
                        return
                    end
                    removeIC(ply,d.money)
                    versus_knowngames[sid] = true
                    net.Start("gversus.JoinGame")
                    net.WriteString(sid)
                    net.WriteString(ply:SteamID64())
                    net.WriteString(winner)
					net.InvsBroadcast(sid, ply)

                    local am = d.money * 2
                    am = versus_tax(am)
                    -- versus tax
                    if not versus_curgames[sid] then versus_curgames[sid] = {} end
                    versus_curgames[sid].rolled = true
                    timer.Simple(versus_wait,function()
                        versus_knowngames[sid] = false
                        net.Start("gversus.FinishGame")
                        net.WriteString(sid)
                        net.WriteString(winner)
                        net.InvsBroadcast(sid, ply)
                        versus_curgames[sid] = {rolled = true}

                        local q = db:query("UPDATE moat_versus" .. dev_suffix .. " SET rewarded = 1 WHERE steamid = '" .. db:escape(sid) .. "';")
                        q:start()
                        print("Versus Log:",d.money,(d.money*2) - am)
                        versus_log(sid,plyz,winner,d.money,(d.money*2) - am)

                        local q = db:query([[INSERT INTO moat_versusstreaks (steamid,streak) VALUES(']] .. db:escape(winner) .. [[', 1) ON DUPLICATE KEY UPDATE streak = streak + 1]])
                        q:start()
                        local other = sid
                        if other == winner then other = plyz end
                        local q = db:query("SELECT * FROM moat_versusstreaks WHERE steamid = '" .. db:escape(other) .. "';")
                        function q:onSuccess(d)
                            if d[1] then
                                local q = db:query("DELETE FROM moat_versusstreaks WHERE steamid = '" .. db:escape(other) .. "';")
                                q:start()
                                if d[1].streak > 1 then
                                    local q = db:query("INSERT INTO moat_versusstreaks_history (steamid,streak,time) VALUES ('" .. db:escape(other) .. "','" .. d[1].streak .. "',UNIX_TIMESTAMP());")
                                    q:start()
                                end
                            end
                        end
                        q:start()

                        local v = player.GetBySteamID64(winner)
                        if (IsValid(v)) then
                            addIC(v,am)
                            return
                        end

                        db:query("INSERT INTO moat_vswinners (steamid, money) VALUES ('" .. db:escape(winner) .. "','" .. am .. "');"):start()
                    end)
                    local plyz_name = "?"
                    if IsValid(player.GetBySteamID64(plyz)) then
                        plyz_name = player.GetBySteamID64(plyz):Nick()
                    else
                        http.Fetch("https://steamcommunity.com/profiles/" .. plyz .. "/?xml=1",function(d)
                            if d:match("%<steamID%>%<%!%[CDATA%[(.*)%]%]%>%<%/steamID%>") then
                                plyz_name = d:match("%<steamID%>%<%!%[CDATA%[(.*)%]%]%>%<%/steamID%>")
                            end
                        end)
                    end

                    local sid_name = "?"
                    if IsValid(player.GetBySteamID64(sid)) then
                        sid_name = player.GetBySteamID64(sid):Nick()
                    else
                        http.Fetch("https://steamcommunity.com/profiles/" .. sid .. "/?xml=1",function(d)
                            if d:match("%<steamID%>%<%!%[CDATA%[(.*)%]%]%>%<%/steamID%>") then
                                sid_name = d:match("%<steamID%>%<%!%[CDATA%[(.*)%]%]%>%<%/steamID%>")
                            end
                        end)
                    end
                    timer.Simple(versus_wait - 2,function()
                        if am < 100 then return end
                        local other = plyz
                        local other_nick = plyz_name
                        local win_nick = sid_name
                        if other == winner then 
                            other = sid 
                            other_nick = sid_name
                            win_nick = plyz_name
                        end
                        local msg = "[Versus] (" .. win_nick .. ") " .. util.SteamIDFrom64(winner) .. " won " .. am .. " IC from " .. util.SteamIDFrom64(other) .. " (" .. other_nick .. ")"
                        discord.Send("Gamble", msg)
                    end)
                end)
            end
            function q:onError(e)
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Someone already joined that game!")
                net.Start("gversus.FullGame")
                net.WriteString(sid)
                net.InvsBroadcast(sid, ply)
            end
            q:start()
        end)
    end
    versus_joins = {}
    local versus_block = false
    hook.Add("MapVoteStarted","Disable Versus",function()
        versus_block = true
    end)
    net.Receive("gversus.JoinGame",function(l,ply)
        -- if Server then
        --     if Server.IsDev then return end
        -- end
        if versus_block then return end
	    if (gamble_net_spam(ply, "gversus.JoinGame")) then return end
        local sid = net.ReadString()
		local amt = math.floor(net.ReadDouble())
        if (versus_joins[sid]) then return end
        if not sid:match("765") then return end
        if sid == ply:SteamID64() then return end

        if (ply.VersCool and ply.VersCool > CurTime()) then
            m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Please wait " .. math.Round(ply.VersCool - CurTime(),3) .. " seconds before performing that action.")
            return
        end
                
        ply.VersCool = CurTime() + 0.3

        if (not ply.VersT) then ply.VersT = {} end
        if (ply.VersT[sid]) then return end
        ply.VersT[sid] = true
        versus_joins[sid] = true
        versus_joingame(ply,sid, amt)
    end)

    net.Receive("gversus.CreateGame",function(l,ply)
        if ply.VersusCreateCool then return end
        ply.VersusCreateCool = true 
        if (gamble_net_spam(ply, "gversus.CreateGame")) then ply.VersusCreateCool = false return end						
        local amount = math.floor(net.ReadDouble())

        if amount < 1 or not ply:m_HasIC(amount) then
            m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You don't have enough IC to gamble that much!")
            ply.VersusCreateCool = false
            return
        end
        
        local id = ply:SteamID64()

        versus_getgame(id,function(d)
            if #d > 0 then
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "You already have a game up!")
                ply.VersusCreateCool = false
                return
            end

            if (ply.VersCool and ply.VersCool > CurTime()) then
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "Please wait " .. math.Round(ply.VersCool - CurTime(),3) .. " seconds before performing that action.")
                ply.VersusCreateCool = false
                return
            end
                
            ply.VersCool = CurTime() + 2
            versus_creategame(id, amount, function()
                ply.VersusCreateCool = false
                if (not IsValid(ply)) then
                    local q = db:query("DELETE FROM moat_versus" .. dev_suffix .. " WHERE steamid = '" .. id.. "';")
                    q:start()
                    discord.Send("Gamble Log", id .. " attempted to leave after creating versus game")
                    return
                end
                if not ply:m_HasIC(amount) then
                    local q = db:query("DELETE FROM moat_versus" .. dev_suffix .. " WHERE steamid = '" .. id.. "';")
                    q:start()
                    local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") attempted to create versus with not enough money"
                    discord.Send("Anti Cheat", msg)
                    -- RunConsoleCommand("mga","ban",ply:SteamID(),"12","hours","Exploiting (v:c)")
                    return
                end

                removeIC(ply, amount)
                versus_curgames[id] = {[1] = amount}
                net.Start("gversus.CreateGame")
                net.WriteString(id)
                net.WriteDouble(amount)
				net.InvsBroadcast(id, ply)
            end)
        end)
    end)

    local q = db:query("CREATE TABLE IF NOT EXISTS `moat_vswinners` ( `ID` int NOT NULL AUTO_INCREMENT, `steamid` varchar(255) NOT NULL, `money` INT NOT NULL, PRIMARY KEY (ID) ) ")
    q:start()
    local ov = 0

    versus_suspense = {}
    net.Receive("gversus.Sync",function(l,ply)
		if (gamble_net_spam(ply, "gversus.Sync")) then return end
        if not ply.gvSyn then
            local t = {}
            for k,v in pairs(versus_curgames) do
				if (v.rolled) then continue end
                t[k] = {nil,v[1]}
            end
            net.Start("gversus.Sync")
            net.WriteTable(t)
            net.Send(ply)
            ply.gvSyn = true
        end
    end)
    timer.Create("Versus.Rewards",20,0,function()
		local pls, str = 0, "SELECT ID, steamid, money FROM moat_vswinners WHERE steamid = '"
		for k, v in ipairs(player.GetAll()) do
			if (not v:SteamID64()) then continue end -- bots gay
			if (versus_suspense[v:SteamID64()] or 0) > CurTime() then continue end
			if (pls > 0) then str = str .. " OR steamid = '" end

			str = str .. v:SteamID64() .. "'"
			pls = pls + 1
		end

		if (pls == 0) then return end
		str = str .. ";"

		local rq = db:query(str)
		function rq:onSuccess(d)
			if (not d or not d[1]) then return end
			local bq = ""

			for i = 1, #d do
				local v = player.GetBySteamID64(d[i].steamid)
				if (not IsValid(v)) then continue end
				if (not MOAT_INVS[v] or not MOAT_INVS[v]["credits"]) then continue end
				d[i].money = tonumber(d[i].money)

				local id = d[i].ID

				if (not versus_rewarded[id]) then
					addIC(v, d[i].money)
					m_AddGambleChatPlayer(v, Color(0, 255, 0), "You won " .. string.Comma(d[i].money) .. " IC in versus!")
					versus_rewarded[id] = true
				end
				
				bq = bq .. "DELETE FROM moat_vswinners WHERE ID = " .. id .. ";"
			end

			if (bq == "") then return end

			local b = db:query(bq)
			b:start()
		end

		rq:start()

		/*
        for k,v in ipairs(player.GetAll()) do
            if (versus_suspense[v:SteamID64()] or 0) > CurTime() then continue end
            local q = db:query("SELECT * FROM moat_vswinners WHERE steamid = '" .. v:SteamID64() .. "';")
            function q:onSuccess(d)
                if #d < 1 then return end
                if not IsValid(v) then return end
				if (not MOAT_INVS[v] or not MOAT_INVS[v]["credits"]) then return end
				
                for i,o in pairs(d) do
                    o.money = tonumber(o.money)
					addIC(v,o.money)
					m_AddGambleChatPlayer(v, Color(0, 255, 0), "You won " .. string.Comma(o.money) .. " IC in versus!")
                end
                local b = db:query("DELETE FROM moat_vswinners WHERE steamid = '" .. v:SteamID64() .. "';")
                b:start()
            end
            q:start()
        end
		*/
    end)

    timer.Create("Fun Versus Stats",60,0,versus_updatestats)

    timer.Create("Versus.Watchdog",5,0,function()
        if GG_DISABLE:GetBool() then return false end
        if not GetHostName():lower():match("moat") then return end
        versus_getgames(function(d)
            local games = {}
            -- PrintTable(d)
            for k,v in pairs(d) do
                games[v.steamid] = v.money
                if versus_curgames[v.steamid] then
                    if (tonumber(versus_curgames[v.steamid][1]) ~= tonumber(v.money)) and (not v.winner) then
                        net.Start("gversus.CreateGame")
                        net.WriteString(v.steamid)
                        net.WriteDouble(v.money)
                        net.InvsBroadcast(v.steamid)
                        versus_curgames[v.steamid][1] = v.money
                    end
                end
                
                if (not versus_curgames[v.steamid]) then
                    versus_curgames[v.steamid] = {}
                    versus_curgames[v.steamid][1] = v.money
                    net.Start("gversus.CreateGame")
                    net.WriteString(v.steamid)
                    net.WriteDouble(v.money)
                    net.InvsBroadcast(v.steamid)
                end
                if not v.winner then continue end
                if v.winner and (not (versus_knowngames[v.steamid])) and (not versus_curgames[v.steamid].rolled) and ((v.curtime - v.time) < 25) then
                    versus_knowngames[v.steamid] = true
                    net.Start("gversus.JoinGame")
                    net.WriteString(v.steamid)
                    net.WriteString(v.other)
                    net.WriteString(v.winner)
                    net.InvsBroadcast(v.steamid, v.other)

                    versus_curgames[v.steamid].rolled = true
                    -- print("Joingame 1",v.steamid)
                    versus_suspense[v.winner] = CurTime() + versus_wait
                    timer.Simple(versus_wait,function()
                        versus_knowngames[v.steamid] = false
                        versus_suspense[v.winner] = nil
                        -- print("Finishgame 1",v.steamid)
                        net.Start("gversus.FinishGame")
                        net.WriteString(v.steamid)
                        net.WriteString(v.winner)
                        net.InvsBroadcast(v.steamid)
                        versus_curgames[v.steamid] = {rolled = true}
                    end)
                elseif ((v.curtime - v.time) > 25) and (v.winner) then
					-- print("attempting force delete")
					versus_forcedelete(v.steamid,function(s)
						-- print("Force delete: " .. tostring(s))
						if s then
							net.Start("gversus.Cancel")
							net.WriteString(v.steamid)
							net.InvsBroadcast(v.steamid)
							versus_curgames[v.steamid] = nil
						end
					end)
                end
            end
            for k,v in pairs(versus_curgames) do
                if (not games[k]) and (not v.winner) then
                    -- print("Cancel 2")
                    -- print("Sid: " .. k)
                    versus_curgames[k] = nil
                    --PrintTable(games[k])
                    net.Start("gversus.Cancel")
                    net.WriteString(k)
                    net.InvsBroadcast(k)
                    --PrintTable(versus_curgames[k])
                end
            end
        end)
    end)

    local anim_time = 20

    function gglobalchat_jack(name,ic,percent)
        local s = name .. "{forsenE}" .. ic .. "{forsenE}" .. percent
        local q = db:query("INSERT INTO moat_gchat (steamid,time,name,msg) VALUES ('-1000',UNIX_TIMESTAMP(),'Console','" .. db:escape(s) .. "');")
        q:start()
    end

    function gglobalchat_planetary(name,gun)
        if (Server and Server.IsDev) then
            return
        end
        local s = name .. "{420}" .. gun
        local q = db:query("INSERT INTO moat_gchat (steamid,time,name,msg) VALUES ('-420',UNIX_TIMESTAMP(),'Console','" .. db:escape(s) .. "');")
        q:start()
    end

    function gglobalchat_lottery(num,amount,winners)
        local s =  num .. "{f0}" .. amount .. "{f0}" .. winners
        local q = db:query("INSERT INTO moat_gchat (steamid,time,name,msg) VALUES ('-10',UNIX_TIMESTAMP(),'Console','" .. db:escape(s) .. "');")
        q:start()
    end

    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_jpgames` ( ID int NOT NULL AUTO_INCREMENT, `time_end` int NOT NULL, `active` int NOT NULL, `cool` int, PRIMARY KEY (ID) ) ")
    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end
    dq:start()

    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_jpservers` ( ID int NOT NULL AUTO_INCREMENT, `crc` TEXT NOT NULL, PRIMARY KEY (ID) ) ")
    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end
    dq:start()

    local q = db:query("CREATE TABLE IF NOT EXISTS `moat_jpwinners` ( `steamid` varchar(255) NOT NULL, `money` TEXT NOT NULL, PRIMARY KEY (steamid) ) ")
    q:start()
    local server_id = 1
    local q = db:query("SELECT *, UNIX_TIMESTAMP() AS ostime FROM moat_jpservers;")
    function q:onSuccess(d)
        if #d > 0 then
            local f = false
            for k,v in pairs(d) do
                if v.crc == game.GetIP() then
                    server_id = v.ID
                    f = true
                end
            end
            if not f then
                local qq = db:query("INSERT INTO moat_jpservers (crc) VALUES ('" .. game.GetIP() .. "');")
                qq:start()
                server_id = #d + 1
            end
        else
            local qq = db:query("INSERT INTO moat_jpservers (crc) VALUES ('" .. game.GetIP() .. "');")
            qq:start()
            server_id = #d + 1
        end
    end
    q:start()

    local function getactive(fun)
       -- --print("Getactive")
        local q = db:query("SELECT *, UNIX_TIMESTAMP() AS ostime FROM `moat_jpgames` WHERE active = '1';")
        function q:onSuccess(d)
          --  --print("Getactive success") 
            fun(#d > 0,d)
        end
        function q:onError(err)
            ----print("Getactive error",err)
        end
        q:start()
    end

    local function getplayers(fun)
        local q = db:query("SELECT *, UNIX_TIMESTAMP() AS ostime FROM `moat_jpplayers`;")
        function q:onSuccess(d)
            fun(d)
          --  --print("GetPlayers")
          --  --printTable(d)
        end
        q:start()
    end

    local function startgame(fun)
        local q = db:query("CREATE TABLE IF NOT EXISTS `moat_jpplayers` ( `steamid` varchar(255) NOT NULL, `money` TEXT NOT NULL, `winner` int, PRIMARY KEY (`steamid`) ) ")
        q:start()
        ----print("Startgame")
        getactive(function(active)
            ----print("Startgame active",active)
            if active then if fun then fun() end return end
            local q = db:query("INSERT INTO `moat_jpgames` (time_end, active) VALUES ('0', '1');")
            function q:onSuccess()
                if fun then fun() end
            end
            q:start()
        end)
    end
    local pendingply = {}
    function jp.joingame(ply, am)
        local j = function()
            if not IsValid(ply) then return end
            local q = db:query("INSERT INTO `moat_jpplayers` (steamid, money) VALUES ('" .. ply:SteamID64() .. "','" .. am .. "') ON DUPLICATE KEY UPDATE money = money + '" .. am .. "';")
            q:start()
            if am > 999 then
                local q = db:query([[UPDATE moat_jpgames SET time_end = UNIX_TIMESTAMP() + 45 WHERE active = 1 AND ((time_end - UNIX_TIMESTAMP()) < 45) AND time_end != 0;]])
                q:start()
            end
            pendingply[ply] = nil
            getplayers(function(p)
                net.Start("jackpot.players", true)
                net.WriteTable(p)
                net.Broadcast()
            end)
            ----print(ply,"Joined game",am)
        end
        ----print("Jpg")
        getactive(function(active,game)
            if not active then startgame(function() j() end) return end
            for k,v in pairs(game) do
                if v.cool then  pendingply[ply] = nil return end
            end
            j()
        end)
    end
    local multiple_cool = {}
    net.Receive("jackpot.join",function(l,ply)
        -- if Server then
        --     if Server.IsDev then return end
        -- end
		if (gamble_net_spam(ply, "jackpot.join")) then return end
        if (multiple_cool[ply] or 0) > CurTime() then return end 
        local am = net.ReadInt(32)
        if am < 1 then return end
        ----print(ply)
        if not ply:m_HasIC(am) then return end
        ----print(1)
        if pendingply[ply] then return end
        ----print(2)
        pendingply[ply] = true
        multiple_cool[ply] = CurTime() + 1
        getactive(function(a,b)
            if not a then 
                net.Start("jackpot.players", true)
                net.WriteTable({
                    [1] = {
                        steamid = ply:SteamID64(),
                        money = am
                    }
                })
                net.Broadcast()
                if not ply:m_HasIC(am) then
                    local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") attempted to join jackpot with not enough money (" .. am .. "). Exploit"
                    discord.Send("Anti Cheat", msg)
                    -- RunConsoleCommand("mga","ban",ply:SteamID(),"12","hours","Exploiting (j:j)")
                    return
                end
                jp.joingame(ply,am) 
                removeIC(ply,am) 
                return 
            end
            b = b[1]
            if b.cool then 
                pendingply[ply] = nil
                m_AddGambleChatPlayer(ply, Color(255, 0, 0), "The match has already started rolling.")
            return end
            getplayers(function(d)
                ----print(3)
                if not IsValid(ply) then return end
                ----print(5)
                for k,v in pairs(d) do
                    if v.steamid == ply:SteamID64() then
                        pendingply[ply] = nil
                    end
                end
                if not ply:m_HasIC(am) then
                    local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") attempted to join jackpot with not enough money (" .. am .. "). Exploit"
                    discord.Send("Anti Cheat", msg)
                    -- RunConsoleCommand("mga","ban",ply:SteamID(),"12","hours","Exploiting (j:j)")
                    return
                end
                jp.joingame(ply,am)
                removeIC(ply,am)
            end)
        end)
    end)
    local synced = {}
    net.Receive("jackpot.info",function(l,ply)
        if synced[ply] then return end

        synced[ply] = true
        getactive(function(a,d)
            d = d[1]
            if not a then 
                net.Start("jackpot.info")
                net.WriteBool(false)
                net.Send(ply)
                return
            end
            if tonumber(d.time_end) ~= 0 then
                net.Start("jackpot.info")
                net.WriteBool(true)
                local f = d.time_end - d.ostime
                net.WriteInt(CurTime() + f,32)
                net.Send(ply)
            end
            getplayers(function(p)
                net.Start("jackpot.players", true)
                net.WriteTable(p)
                net.Send(ply)
            end)
        end)
    end)

    local jp_down = false
    local jp_ours = false
    local jp_active = false
    local jp_know = false
    local jp_broad = false
    local jp_rewarding = false
    local jp_rewards = {}
    timer.Create("JPGrand",10,0,function()
        if GG_DISABLE:GetBool() then return end
        local q = db:query("SELECT * FROM moat_jpwinners;")
        function q:onSuccess(p)
            --print("Winmners",#p)
            if #p < 1 then return end
            for k,v in ipairs(p) do
                local vp = player.GetBySteamID64(v.steamid)
                if IsValid(vp) then
                    if (jp_rewards[vp] or 0) > CurTime() then continue end
                    jp_rewards[vp] = CurTime() + 80
                    --print("Fouind winner")
                    vp:m_GiveIC(v.money)
                    player_found = true
                    local room = MOAT_GAMBLE_CATS[vp.MoatGambleCat or 1]
                    m_AddGambleChat(
						Color(255,255,255), "[", 
						room[2], room[1][1],
						Color(255,255,255),"]",
						Color(0, 150, 0),"+" .. math.Round(v.money) .. " ",
						Color(180, 180, 180), vp:Nick()
					)
                    
                    local b = db:query("DELETE FROM moat_jpwinners WHERE steamid = '" .. v.steamid .. "';")
                    b:start()
                    local msg = "Rewarding " .. vp:Nick() .. " " .. vp:SteamID() .. " jackpot: " .. v.money .. " IC (" .. game.GetIP() .. ")"
					discord.Send("Gamble Log", msg)
                end
            end
        end
        q:start()
        if jp_active then return end
        getactive(function(a,d)
            if not a then return end
            ----printTable(d)
            if a then jp_active = true end
            d = d[1]
            if tonumber(d.time_end) == 0 then
                jp_down = false
                ----print("JPAS")
            else
                ----print("JP!@#")
                jp_down = true
                net.Start("jackpot.info")
                net.WriteBool(true)
                local f = d.time_end - d.ostime
                net.WriteInt(CurTime() + f,32)
                net.Broadcast()
            end
            if a then
                local old_p = {}
                timer.Create("JPWatch",1,0,function()
                    getactive(function(a,s)
                    if not a then
                        net.Start("jackpot.info")
                        net.WriteBool(false)
                        net.Broadcast()
                        --print("noinfo")
                        jp_down = false
                        jp_ours = false
                        jp_active = false
                        jp_know = false
                        jp_broad = false
                        jp_rewarding = false
                        --print("Resetting jackpot")
                        timer.Destroy("JPWatch")
                        return
                    end
                        getplayers(function(p)
                            net.Start("jackpot.players", true)
                            net.WriteTable(p)
                            net.Broadcast()
                            s = s[1]
                            s.time_end = tonumber(s.time_end)
                            if s.time_end ~= 0 then
                                ----print("Setting JPT")
                                jp_down = true
                            end
                            if (s.time_end ~= 0 ) and (jp_broad ~= s.time_end) then
                                net.Start("jackpot.info")
                                net.WriteBool(true)
                                local f = s.time_end - s.ostime
                                net.WriteInt(CurTime() + f,32)
                                net.Broadcast()
                                jp_broad = s.time_end
                            end
                            if (s.time_end ~= 0) and (not jp_know) then
                                --print("Jackpot rolling in " .. math.Round(s.time_end - os.time()))
                            end
                            if s.cool and (not jp_ours) and (not jp_know) then
                                for k,v in pairs(p) do
                                    if v.winner then 
                                        net.Start("jackpot.win")
                                        net.WriteString(v.steamid)
                                        net.Broadcast()
                                        jp_know = true
                                    end
                                end
                            end
                            if ((s.time_end + (server_id*10)) < s.ostime) and (s.time_end ~= 0) and (not s.cool) and (not jp_know) then--va
                                for k,v in pairs(p) do
                                    if v.winner then
                                        return
                                    end
                                end
                                local t = {}
                                jp_ours = true
                                jp_know = true
                                jp_tt = 0
                                for k,v in pairs(p) do
                                    jp_tt = jp_tt + tonumber(v.money)
                                    for i = 1,tonumber(v.money) do
                                        table.insert(t,k)
                                    end
                                end
                                local i = table.Random(t)
                                jp_w = p[i].steamid
                                local q = db:query("UPDATE `moat_jpplayers` SET winner = '1' WHERE steamid = '" .. jp_w .. "';")
                                q:start()
                                timer.Simple(anim_time,function()
                                    local q = db:query("SELECT * FROM player WHERE steam_id = '" .. (jp_w) .. "';")
                                    function q:onSuccess(d)
                                        if #d < 1 then return end
                                        d = d[1]
                                        gglobalchat_jack(d.name,math.Round(jp_tt * 0.95),round((p[i].money/jp_tt) * 100 ))
                                        local msg = d.name .. " (" .. util.SteamIDFrom64(jp_w) .. ") won **" .. string.Comma(math.Round(jp_tt * 0.95)) .. "** IC (" .. round((p[i].money/jp_tt) * 100 ) .."%) in Jackpot."
                                        discord.Send("Gamble Win", msg)
                                    end
                                    q:start()
                                    
                                    local q = db:query("SELECT * FROM moat_jpwinners WHERE steamid = '" .. jp_w .. "';")
                                    function q:onSuccess(d)
                                        if #d > 0 then return end
                                        local b = db:query("INSERT INTO moat_jpwinners (steamid,money) VALUES ('" .. jp_w .. "','" ..math.Round(jp_tt * 0.95).."');" )
                                        b:start()
                                    end
                                    q:start()

                                end)
                                
                                ---print("Winner: " .. w)
                                net.Start("jackpot.win")
                                net.WriteString(jp_w)
                                net.Broadcast()
                                local q = db:query("UPDATE `moat_jpgames` SET cool = '1', time_end = UNIX_TIMESTAMP() + " .. anim_time .. " WHERE ID = '" .. s.ID .. "';")
                                q:start()
                            end
                            if tonumber(s.cool) == 1 and ((s.time_end + (server_id*10) ) < s.ostime ) and (s.active == 1) and (s.time_end ~= 0)  then
                                local q = db:query("DROP TABLE moat_jpplayers;")
                                q:start()
                                local q = db:query("UPDATE moat_jpgames SET active = '0';")
                                q:start()
                            end
                            if #p ~= #old_p then
                                --print("Sending ply")
                                net.Start("jackpot.players", true)
                                net.WriteTable(p)
                                net.Broadcast() 
                                old_p = p
                            end
                            ----print("P",#p,"JP",jp_down)
                            if (#p > 1) and (not jp_down) then
                                --print("Mroe than one player")
                                if tonumber(s.time_end) ~= 0 then 
                                    net.Start("jackpot.info")
                                    net.WriteBool(true)
                                    local f = s.time_end - s.ostime
                                    net.WriteInt(CurTime() + f,32)
                                    net.Broadcast()
                                    jp_down = true 
                                    return 
                                end
                                --print("Setting time: " .. (os.time() + 120))
                                local t = 120--va
                                local q = db:query("UPDATE `moat_jpgames` SET time_end = UNIX_TIMESTAMP() + " .. t .. " WHERE ID = '" .. s.ID .. "';")
                                q:start()
                                net.Start("jackpot.info")
                                net.WriteBool(true)
                                net.WriteInt(CurTime() + 120,32)
                                net.Broadcast()
                            end
                        end)
                    end)
                end)
            end
        end)
    end)
    print("Loaded Cross-server jackpot")

end
local function c()
    if GG_DISABLE:GetBool() then return false end
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end


local function chat_()
    local db = MINVENTORY_MYSQL
    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_gchat` ( ID int NOT NULL AUTO_INCREMENT, `steamid` varchar(255) NOT NULL, `time` INT NOT NULL, `name` varchar(255) NOT NULL, `msg` TEXT NOT NULL, PRIMARY KEY (ID) ) ")
    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end
    dq:start()


    function gglobalchat(ply,msg)
        if (ply.gChat or 0) > CurTime() then return end
        local q = db:query("INSERT INTO moat_gchat (steamid,time,name,msg) VALUES ('" .. ply:SteamID64() .. "',UNIX_TIMESTAMP(),'" .. utf8.force(db:escape(ply:Nick())) .. "','" .. db:escape(msg) .. "');")
        q:start()
        local msg = "" .. ply:Nick() .. " (" .. ply:SteamID() .. ") said in global gamble: " .. msg
		discord.Send("Gamble Chat", msg)
		ply.gChat = CurTime() + 3
    end

    function gglobalchat_real(msg)
        local q = db:query("INSERT INTO moat_gchat (steamid,time,name,msg) VALUES ('-1337',UNIX_TIMESTAMP(),'Console','" .. db:escape(msg) .. "');")
        q:start()

        if msg == "[MapVote]" then
            msg = "Developers have instructed all servers to change maps! Sorry!"
        elseif msg == "[EndRound]" then
            msg = "Developers have instructed all servers to change maps at the end of their rounds!"
        end

		discord.Send("Moat TTT Announcement", markdown.WrapBold(
				string (":satellite_orbital::satellite: ",
					markdown.Bold "Global TTT Announcement",
					" :satellite::satellite_orbital:",
					markdown.LineStart(":construction_worker::loudspeaker: " .. msg)
				)
			)
		)
    end


    concommand.Add("moat_global_chat",function(ply,cmd,args,s)
		if (not moat.isdev(ply)) then
			return
		end

        gglobalchat_real(s)
        if IsValid(ply) then
            ply:ChatPrint("Done.")
        else
            print("Done message")
        end
    end)

    concommand.Add("moat_global_mapvote",function(ply,cmd,args,s)
        if (not moat.isdev(ply)) then
			return
		end

        gglobalchat_real("[MapVote]")
        if IsValid(ply) then
            ply:ChatPrint("Done mapvote.")
        else
            print("Done mapvote")
        end
    end)


    local function getlatestmessages(fun)
        local q = db:query("SELECT * FROM `moat_gchat` WHERE time > (UNIX_TIMESTAMP() - 10);")
        function q:onSuccess(d)
            fun(d)
        end
        q:start()
    end

    net.Receive("MOAT_GAMBLE_GLOBAL",function(l,ply)
		if (gamble_net_spam(ply, "MOAT_GAMBLE_GLOBAL")) then return end
        if (ply.gChat or 0) > CurTime() then return end
        local msg = net.ReadString():gsub("\n",""):sub(1,128)
		if msg:len() < 1 then return end
		local safe = FamilyFriendly(msg, ply)
		if (not safe) then
			return 
		end

        gglobalchat(ply,msg)
        perspective_post(ply:Nick(),"[Global Gamble] " .. ply:SteamID(),msg,ply)
    end)


    local function broadcastmsg(d)
        local time = d.time
        local msg = d.msg
        local name = d.name
        
        time = os.date("%H:%M",time)
        if moat.isdev(d.steamid) then
            time = time .. "CL"
        end
        net.Start("MOAT_GAMBLE_GLOBAL")
        net.WriteString(time)
        net.WriteString(name)
        net.WriteString(msg)
        net.Broadcast()
    end

    local seenmsgid = {}

    local sentmsgtext = {}

    timer.Create("GambleGlobalChat",2.5,0,function()
       -- print("GTimer")
        getlatestmessages(function(d)
            --PrintTable(d)
            if #d < 1 then return end
            for k,v in pairs(d) do
                --print("LOOP",v.ID,v.name,v.msg)
                if seenmsgid[v.ID] then continue end
                if sentmsgtext[v.name] == v.msg then continue end
                if tostring(v.steamid) == "-1337" then
                    if v.msg == "[MapVote]" then
                        MapVote.Start()
                    elseif v.msg == "[EndRound]" then
						if (player.GetCount() > 0) then
							net.Start("Moat.GlobalAnnouncement")
							net.WriteString("A map vote has been forced at the end of this round.")
							net.Broadcast()
							hook.Add("TTTEndRound", "EndRoundMapVote", function(res)
								MapVote.Start()
								hook.Remove("TTTEndRound", "EndRoundMapVote")
							end)
						elseif (GetServerName():lower():match "minecraft") then
							local msg = (GetHostName() or "") .. " ( steam://connect/" .. (game.GetIP() or "") .. " ) is switching map to `" .. 'ttt_minecraft_b5' .. "`"
							discord.Send("Server", msg)

							RunConsoleCommand("changelevel", "ttt_minecraft_b5")
						else
							local msg = (GetHostName() or "") .. " ( steam://connect/" .. (game.GetIP() or "") .. " ) is switching map to `" .. 'ttt_rooftops_a2_f1' .. "`"
							discord.Send("Server", msg)

							RunConsoleCommand("changelevel", "ttt_rooftops_a2_f1")
						end
                    else
                        net.Start("Moat.GlobalAnnouncement")
                        net.WriteString(v.msg)
                        net.Broadcast()
                    end
                elseif tostring(v.steamid) == "-1000" then
                    local t = string.Explode("{forsenE}", v.msg)
                    net.Start("Moat.JackpotWin")
                    net.WriteString(t[1])
                    net.WriteInt(t[2],32)
                    net.WriteDouble(t[3])
                    net.Broadcast()
                elseif tostring(v.steamid) == "-420" then
                    local t = string.Explode("{420}",v.msg)
                    net.Start("Moat.PlanetaryDrop")
                    net.WriteString(t[1])
                    net.WriteString(t[2])
                    net.Broadcast()
                elseif tostring(v.steamid) == "-10" then
                    local t = string.Explode("{f0}",v.msg)
                    net.Start("Moat.LotteryChat")
                    net.WriteTable(t)
                    net.Broadcast()
                elseif tostring(v.steamid):match("^765") then
                    broadcastmsg(v)
                end
                seenmsgid[v.ID] = true
            end
        end)
    end)

    print("Loaded global gamble chat")
end


if MINVENTORY_MYSQL then
    if c() then
        jackpot_()
        chat_()
         --print(87551)
    end
end

hook.Add("InitPostEntity","JackPot",function()
    print("Jackpot init",c())
    if not c() then 
        timer.Create("CheckJackPot",1,0,function()
            if c() then
                jackpot_()
                chat_()
                timer.Destroy("CheckJackPot")
            end
        end)
    else
        jackpot_()
        chat_()
    end

end)

-- Mines
util.AddNetworkString("mines.Uncover")
util.AddNetworkString("mines.CreateGame")
util.AddNetworkString("mines.SelectBombs")
util.AddNetworkString("mines.Start")
util.AddNetworkString("mines.CashOut")

MINES_GAMES = {}

local cbombs = {
    1,3,5,24
}

local function uniquerandom(ply,t)
    local b = cbombs[MINES_GAMES[ply][2]]
    if #t == b then
        return true
    end
    local i = math.random(1,25)
    if table.HasValue(t,i) then return false end
    table.insert(t,i)
end 
local e = {0.02,0.02,0.02,0.03,0.03,0.03,0.03,0.04,0.04,0.05,0.05,0.05,0.06,0.06,0.1,0.2,0.3,0.4,0.5,0.7,1,2.0,3.0,5.0}
local function getprofit(ply)
    local d = MINES_GAMES[ply][2]
    local amt = MINES_GAMES[ply][1]
    local orig = MINES_GAMES[ply][0]
    local times = #MINES_GAMES[ply][4] + 1
    local bombs = #MINES_GAMES[ply][3]
    if d == 4 then return orig * 12.5 end 
    local l = bombs / (25 - times)
    local m = 1
    if d == 2 then
        m = 1.25
    end
    if d == 3 then
        m = 1.5
    end
    return math.Round((orig * e[times]) * m)
end

net.Receive("mines.CreateGame",function(l,ply)
    local amt = net.ReadInt(16)
    local bombs = net.ReadInt(8)
	if (gamble_net_spam(ply, "mines.CreateGame")) then return end
    if MINES_GAMES[ply] then return end
    if amt > 2500 then return end
    if amt < 100 then return end
    if bombs > 4 then return end
    if bombs < 1 then return end
    if not ply:m_HasIC(amt) then
        return
    end
    removeIC(ply,amt)
    local bombamount = cbombs[bombs]
    MINES_GAMES[ply] = {
        amt, -- [1]profit
        bombs, -- [2]difficulty
        {}, -- [3]where the bombs are 
        {} --[4]uncovered places
    }
    MINES_GAMES[ply][0] = amt --[0]original bet
    local tbombs = {}
    repeat
        uniquerandom(ply,tbombs)
    until (#tbombs >= bombamount) -- shouldn't be > but to avoid infinite loop
    MINES_GAMES[ply][3] = tbombs
    net.Start("mines.Start")
    net.WriteInt(getprofit(ply),32)
    net.Send(ply)
end)

net.Receive("mines.CashOut",function(l,ply)
	if (gamble_net_spam(ply, "mines.CashOut")) then return end
    if not MINES_GAMES[ply] then return end
    if (MINES_GAMES[ply][1] - MINES_GAMES[ply][0]) > 100 then
        local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") won " .. round(MINES_GAMES[ply][1] - MINES_GAMES[ply][0]) .. " IC in mines."
    	discord.Send("Gamble", msg)
    end
    if MINES_GAMES[ply][1]> 10000 then
        DiscordGamble(ply:Nick() .. " (" .. ply:SteamID() .. ") won **" .. string.Comma(round(MINES_GAMES[ply][1])) .. "** IC in Mines.")
    end
    addIC(ply,MINES_GAMES[ply][1])
    for k,v in pairs(MINES_GAMES[ply][3]) do
        net.Start("mines.Uncover")
        net.WriteInt(-1,32)
        net.WriteInt(v,8)
        net.WriteBool(true)
        net.Send(ply)
    end
    MINES_GAMES[ply] = nil
    
end)

net.Receive("mines.Uncover",function(l,ply)
    if not MINES_GAMES[ply] then return end
    if ply.MineLock then return end
    local i = net.ReadInt(8)
    if i < 1 then return end
    if i > 25 then return end
    if table.HasValue(MINES_GAMES[ply][4],i) then return end
    if table.HasValue(MINES_GAMES[ply][3],i) then
        for k,v in pairs(MINES_GAMES[ply][3]) do
            net.Start("mines.Uncover")
            net.WriteInt(-1,32)
            net.WriteInt(v,8)
            net.WriteBool(true)
            net.Send(ply)
        end
        MINES_GAMES[ply] = nil
    else
        local profit = getprofit(ply)
        MINES_GAMES[ply][1] = MINES_GAMES[ply][1] + profit
        table.insert(MINES_GAMES[ply][4],i)
        net.Start("mines.Uncover")
        net.WriteInt(profit,32)
        net.WriteInt(i,8)
        net.WriteBool(false)
        net.WriteInt(getprofit(ply),32)
        net.Send(ply)
    end
end)
