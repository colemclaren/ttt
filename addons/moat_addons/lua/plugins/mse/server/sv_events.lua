MSE.Events = MSE.Events or {}
MSE.Events.CurAmount = 0

local net_WriteUInt = net.WriteUInt
local net_ReadUInt 	= net.ReadUInt
local net_WriteString = net.WriteString
local net_ReadString = net.ReadString
local net_Start 	= net.Start
local net_Send 		= (SERVER) and net.Send or net.SendToServer
local net_Broadcast = net.Broadcast

util.AddNetworkString "MSE.Notify"
util.AddNetworkString "MSE.Start"
util.AddNetworkString "MSE.Menu"


function MSE.Events.Started(pl, amt, cmd, args, cmd_name, ec)
	MSE.Events.CurAmount = MSE.Events.CurAmount + 1

	net_Start "MSE.Notify"
		net_WriteString(MSE.Config.Messages.Started:Replace("{name}", pl:Nick()):Replace("{minigame}", cmd_name))
	net_Broadcast()

	local da_cmd = cmd

	for i = 1, #args do
		da_cmd = da_cmd .. ", " .. args[i]
	end

	MSE.MySQL.FormatQuery("INSERT INTO mse_logs (steamid, cmd, time) VALUES ('#', '#', '#')", pl:SteamID64(), da_cmd, os.date("%d/%m/%Y - %H:%M:%S" , os.time()))

	if (ec) then
		pl:SetDataVar("EC", pl:GetDataVar("EC") - 1, true, true)

		return
	end

	local gp = pl:GetUserGroup()
	if (amt + 1 < MSE.Ranks.Stored[gp].MaxAmount) then
		MSE.MySQL.FormatQuery("UPDATE mse_players SET amount = amount + 1 WHERE steamid = #", pl:SteamID64())

		net_Start "MSE.Notify"
			net_WriteString(MSE.Config.Messages.SlotUsed:Replace("{num}", MSE.Ranks.Stored[gp].MaxAmount - (amt + 1)):Replace("{time}", MSE.FormatTimeSingle(MSE.Ranks.Stored[gp].Cooldown)))
		net_Send(pl)
	else
		MSE.MySQL.FormatQuery("UPDATE mse_players SET cooldown = #, amount = 0 WHERE steamid = #", os.time() + MSE.Ranks.Stored[gp].Cooldown, pl:SteamID64())

		net_Start "MSE.Notify"
			net_WriteString(MSE.Config.Messages.CooldownStarted:Replace("{time}", MSE.FormatTimeSingle(MSE.Ranks.Stored[gp].Cooldown)))
		net_Send(pl)
	end
end


function MSE.Events.Start(pl, amt, cmd, args, cmd_name, ec)

	-- recheck whether or not we can start the minigame after querying (so people can't start them a sec before round starts)
	local halt, msg = MSE.Config.CanStartMinigame(pl)

	if (halt) then
		net_Start "MSE.Notify"
			net_WriteString(msg)
		net_Send(pl)

		return
	end

	if (GetGlobal("MOAT_MINIGAME_ACTIVE") or MSE.Events.Active) then
		net_Start "MSE.Notify"
			net_WriteString(MSE.Config.Messages.Active)
		net_Send(pl)

		return
	end

	MSE.Events.Active = true
	MSE.Player = pl

	RunConsoleCommand(cmd, unpack(args))

	timer.Simple(15, function()
		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then
			MSE.Events.Started(pl, amt, cmd, args, cmd_name, ec)
			MSE.Player = nil
			return
		end

		if (IsValid(MSE.Player)) then
			net_Start "MSE.Notify"
				net_WriteString("Your event did not start for some reason.")
			net_Send(MSE.Player)
		end

		MSE.Player = nil
		MSE.Events.Active = false
	end)
end

function MSE.Events.CanStart(l, pl)
	local cmd = net.ReadString()

	if (not MSE.Commands.IsRegistered(cmd)) then 
		return
	end

	local gp = pl:GetUserGroup()

	if ((not pl:GetDataVar("EC") or (pl:GetDataVar("EC") and pl:GetDataVar("EC") < 1)) and not MSE.Ranks.Stored[gp]) then return end

	local cmd_tb = MSE.Commands.Stored[cmd]
	local bl, wr, blr = cmd_tb.WhitelistedRanks, cmd_tb.BlacklistRanks

	if ((wr and not blr and not wr[gp]) or (wr and blr and wr[gp])) then
		net_Start "MSE.Notify"
			net_WriteString(bl and MSE.Config.Messages.Permission or MSE.Config.Messages.MPermission)
		net_Send(ply)

		return
	end

	local wlm, blm, map = cmd_tb.WhitelistedMaps, cmd_tb.BlacklistMaps, game.GetMap()

	if ((wlm and not blm and not wlm[map]) or (wlm and blm and wlm[map])) then
		net_Start "MSE.Notify"
			net_WriteString(MSE.Config.Messages.Map)
		net_Send(pl)

		return
	end

	local minp = tonumber(cmd_tb.MinPlayers)

	if (minp and (#player.GetAll() < cmd_tb.MinPlayers)) then
		net_Start "MSE.Notify"
			net_WriteString(MSE.Config.Messages.Players:Replace("{amount}", minp))
		net_Send(pl)

		return
	end

	local halt, msg = MSE.Config.CanStartMinigame(pl)

	if (halt) then
		net_Start "MSE.Notify"
			net_WriteString(msg)
		net_Send(pl)

		return
	end

	local arg_table = {}

	for i = 1, net_ReadUInt(4) do
		arg_table[i] = net_ReadString()
	end

	if (pl:GetDataVar("EC") and pl:GetDataVar("EC") > 0) then
		MSE.Events.Start(pl, amt, MSE.Commands.Stored[cmd].StartCommand, arg_table, cmd, true)

		return
	end

	if (not MSE.Ranks.Stored[gp]) then return end

	MSE.MySQL.FormatQuery("SELECT cooldown, amount FROM mse_players WHERE steamid = #", pl:SteamID64(), function(d)
		if (not pl:IsValid()) then return end

		if (not d or #d < 1) then
			MSE.MySQL.FormatQuery("INSERT INTO mse_players (steamid, rank, cooldown, amount) VALUES ('#', '#', 0, 0)", pl:SteamID64(), gp)

			MSE.Events.Start(pl, 0, MSE.Commands.Stored[cmd].StartCommand, arg_table, cmd)
		else
			local amt, cld = d[1].amount, d[1].cooldown

			if (cld > os.time()) then
				if (pl:GetDataVar("EC") and pl:GetDataVar("EC") > 0) then
					MSE.Events.Start(pl, amt, MSE.Commands.Stored[cmd].StartCommand, arg_table, cmd, true)

					return
				end

				net_Start "MSE.Notify"
					net_WriteString(MSE.Config.Messages.Cooldown:Replace("{time}", MSE.FormatTimeSingle(cld - os.time())))
				net_Send(pl)

				return
			end

			MSE.Events.Start(pl, amt, MSE.Commands.Stored[cmd].StartCommand, arg_table, cmd)
		end
	end)
end

net.Receive("MSE.Start", MSE.Events.CanStart)

function MSE.Events.Menu(pl)
	net_Start "MSE.Menu"
	net_Send(pl)
end

concommand.Add("mse", MSE.Events.Menu)

local key_bind = {}
key_bind[KEY_F4] = true

function MSE.Events.Bind(pl, btn)
	if (key_bind[btn]) then
		net_Start "MSE.Menu"
		net_Send(pl)
	end
end

hook.Add("PlayerButtonDown", "MSE.PlayerKey", MSE.Events.Bind)

function MSE.Events.Command(pl, t)
	if (MSE.Config.ChatCommand[t:sub(2)]) then
		MSE.Events.Menu(pl)

		return ""
	end
end

hook.Add("PlayerSay", "MSE.PlayerSay", MSE.Events.Command)

function MSE.Events.EventGoing()
	MSE.Events.Active = false
end

hook.Add("TTTBeginRound", "MSE.EventGoing", MSE.Events.EventGoing)

concommand.Add("moat_ec", function(pl, cmd, args)
	if (not moat.isdev(pl)) then return end

	pl:SetDataVar("EC", tonumber(args[1]), true, true)
end)

function give_ec(pl, num)
	local ec = pl:GetDataVar("EC")

	if (not ec) then ec = 0 end

	pl:SetDataVar("EC", ec + tonumber(num), true, true)
end

/*
function MSE.SendEvents(pl, data)
	pl:SetDataVar("EC", data.Vars.EC or 0, true, true)
end
hook.Add("PlayerDataLoaded", "MSE.PlayerDataLoaded", MSE.SendEvents)
*/


hook.Add("PostPlayerDeath", "moat_fix_ragdolls", function(ply)
	local rag_ent = ply.server_ragdoll or ply:GetRagdollEntity()

	if (GetGlobal("MOAT_MINIGAME_ACTIVE") and rag_ent and IsValid(rag_ent)) then
		local pl = player.GetByUniqueID(rag_ent.uqid)
        if (not IsValid(pl)) then return end
        pl:SetCleanRound(false)
        pl:SetNW2Bool("body_found", true)
        CORPSE.SetFound(rag_ent, true)
		rag_ent:Remove()
	end
end)