COMMAND.Name = "RemoveTitle"

COMMAND.AdminMode = true
COMMAND.Flag = D3A.Config.Commands.SetGroup

COMMAND.Args = {{"string", "SteamID"}}

COMMAND.Run = function(pl, args, supp)
	local sid = D3A.ParseSteamID(tostring(args[1]))
	if (not sid) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Invalid SteamID: " .. tostring(args[1]) .. ".")
		return
	end

	D3A.MySQL.FormatQuery("SELECT title, changerid FROM titles WHERE steamid = #;", sid, function(r)
		if (not r or not r[1]) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player title for SteamID: " .. sid .. ".")
			return
		end
		
		local plid = player.GetBySteamID64(sid)
		if (plid) then
			game.KickID(util.SteamIDFrom64(sid), "Your scoreboard title has been removed by a staff member")
		end

		D3A.MySQL.FormatQuery("UPDATE titles SET title = '', color = '' WHERE steamid = #;", sid, function()
			D3A.Chat.SendToPlayer2(pl, moat_green, "Removed " .. tostring(args[1]) .. "'s title, which was changed by " .. util.SteamIDFrom64(r[1].changerid) .. ".")
			D3A.Commands.Discord("removetitle", D3A.Commands.NameID(pl), tostring(args[1]), util.SteamIDFrom64(r[1].changerid))
		end)
	end)
end