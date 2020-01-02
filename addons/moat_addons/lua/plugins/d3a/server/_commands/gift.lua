COMMAND.Name = "Gift"

COMMAND.AdminMode = true
COMMAND.Flag = "?"

COMMAND.Args = {{"string", "Name/SteamID"}, {"number", "Support Credits"}}

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
		moat.mysql("UPDATE player SET donator_credits = donator_credits + ? WHERE steam_id = ?;", math.Round(args[2]), sid, function(r)
			D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has sent a gift to ", moat_green, d.name, 
			moat_white, " (", moat_green, util.SteamIDFrom64(sid), moat_white, ") ", moat_white, "that has ", moat_cyan, math.Round(args[2]) .. " ", moat_white, "support credits!")

			D3A.Commands.Discord("gift", D3A.Commands.NameID(pl), (IsValid(targ) and targ:NameID()) or (d.name .. " (" .. util.SteamIDFrom64(d.steam_id) .. ")"), math.Round(args[2]))
		end)
	end,
	function()
		D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player by SteamID: " .. sid .. ".")
	end)
end