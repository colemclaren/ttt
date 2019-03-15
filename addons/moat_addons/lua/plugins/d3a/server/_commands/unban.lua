COMMAND.Name = "Unban"

COMMAND.Flag = D3A.Config.Commands.Unban
COMMAND.AdminMode = true

COMMAND.Args = {{"string", "SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supp)
	local sid = tostring(args[1]):upper()

	if (string.sub(sid, 1, 8) != "STEAM_0:") then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Please input a SteamID!")
		return
	end

	D3A.Bans.IsBanned(sid, function(Banned, Bans)
		if (not Banned or not Bans.Current) then
			D3A.Chat.SendToPlayer2(pl, moat_red, sid .. " is not banned!")
		else
			local reason = table.concat(args, " ", 2)
			D3A.Bans.Unban(sid, reason, Bans.Current.time, function()
				D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has unbanned ", moat_green, sid, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = D3A.Commands.Name(pl) .. " (" .. ((IsValid(pl) and pl:SteamID()) or "CONSOLE") ..") has *unbanned* " .. sid.. ". Reason: " .. reason .. "."

				D3A.Commands.Discord("unban", D3A.Commands.NameID(pl), sid, reason)
			end)
		end
	end)
end