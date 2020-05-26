COMMAND.Name = "Wipe"

COMMAND.AdminMode = true
COMMAND.Flag = D3A.Config.Commands.SetGroup

COMMAND.Args = {{"string", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	local plname = D3A.Commands.Name(pl)

	local targ, sid = D3A.FindPlayer(args[1])
	if (targ) then
		sid = targ:SteamID64()
	else
		sid = D3A.ParseSteamID(args[1])
		if (not sid) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player by SteamID: " .. args[1] .. ".")
			return
		end
	end

	D3A.LoadSteamID(sid, function(d)
		D3A.Bans.IsBanned(sid,function(isbanned, ban)
			if (not isbanned) then
				D3A.Chat.SendToPlayer2(pl, moat_red, "Player must be banned first.")
				return
			end

			D3A.MySQL.FormatQuery("UPDATE core_dev_ttt SET steamid = '" .. util.SteamIDFrom64(sid) .. ">" .. os.time() .. "' WHERE steamid = #;UPDATE core_ttt_oct SET steamid = '" .. util.SteamIDFrom64(sid) .. ">" .. os.time() .. "' WHERE steamid = #;UPDATE core_ttt_old SET steamid = '" .. util.SteamIDFrom64(sid) .. ">" .. os.time() .. "' WHERE steamid = #;", util.SteamIDFrom64(sid), util.SteamIDFrom64(sid), util.SteamIDFrom64(sid), function(r)
				D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has wiped ", moat_green, d.name, 
				moat_white, " (", moat_green, util.SteamIDFrom64(sid), moat_white, ")")

				D3A.Commands.Discord("wipe", D3A.Commands.NameID(pl), (IsValid(targ) and targ:NameID()) or (d.name .. " (" .. util.SteamIDFrom64(d.steam_id) .. ")"))
			end)
		end)
	end,
	function()
		D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player by SteamID: " .. sid .. ".")
	end)
end