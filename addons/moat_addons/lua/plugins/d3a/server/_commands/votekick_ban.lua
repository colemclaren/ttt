COMMAND.Name = "VotekickBan"

COMMAND.AdminMode = true
COMMAND.Flag = D3A.Config.Commands.SetGroup

COMMAND.Args = {{"string", "SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supp)
	local sid = D3A.ParseSteamID(tostring(args[1]))
	if (not sid) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Invalid SteamID: " .. tostring(args[1]) .. ".")
		return
	end

	local pid = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID64()) or "0"
	local rsn = table.concat(args, " ", 2)
	D3A.MySQL.FormatQuery("SELECT staff_steam_id, reason, date FROM player_bans_votekick WHERE steam_id = #;", sid, function(r)
		if (not r or not r[1]) then
			D3A.MySQL.FormatQuery("INSERT INTO player_bans_votekick (steam_id, staff_steam_id, reason) VALUES (#, #, #);", sid, pid, rsn)
			D3A.Chat.SendToPlayer2(pl, moat_green, "Added " .. tostring(args[1]) .. " to the votekick ban list for: " .. tostring(rsn) .. ".")
			D3A.Commands.Discord("votekickban", D3A.Commands.NameID(pl), args[1], rsn)
			return
		end

		D3A.MySQL.FormatQuery("UPDATE player_bans_votekick SET staff_steam_id = #, reason = # WHERE steam_id = #;", pid, rsn, sid)
		D3A.Chat.SendToPlayer2(pl, moat_green, "Updated " .. tostring(args[1]) .. "'s votekick ban reason.")
		D3A.Commands.Discord("votekickban_update", args[1], D3A.Commands.NameID(pl), rsn)
	end)
end