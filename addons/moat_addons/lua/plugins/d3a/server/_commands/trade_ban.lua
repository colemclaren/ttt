COMMAND.Name = "TradeBan"
COMMAND.Flag = D3A.Config.Commands.SetGroup
COMMAND.Args = {{"string", "SteamID"}, {"string", "Reason"}}

function GetTradeBanLength(sid64, cb)
	moat.mysql("SELECT staff_steam_id, reason, date FROM player_bans_trading WHERE steam_id = ?;", sid64, function(r)
		if (not r or not r[1]) then
			cb(false, nil)
		else
			cb(true, r[1].reason)
		end
	end)
end

local function UpdateTradeBan(p)
	GetTradeBanLength(p:SteamID64(), function(banned, reason)
		p.IsTradeBanned = banned
		p.TradeBanReason = reason
	end)
end

COMMAND.Run = function(pl, args, supp)
	local sid = D3A.ParseSteamID(tostring(args[1]))
	if (not sid) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Invalid SteamID: " .. tostring(args[1]) .. ".")
		return
	end

	local plname = D3A.Commands.Name(pl)
	local pid = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID64()) or "0"
	local rsn = tostring(table.concat(args, " ", 2))

	D3A.MySQL.FormatQuery("SELECT staff_steam_id, reason, date FROM player_bans_trading WHERE steam_id = #;", sid, function(r)
		if (not r or not r[1]) then
			D3A.MySQL.FormatQuery("INSERT INTO player_bans_trading (steam_id, staff_steam_id, reason) VALUES (#, #, #);", sid, pid, rsn)
			D3A.Chat.Broadcast2(pl, moat_cyan, tostring(args[1]), moat_white, " was trade banned by ", moat_cyan, plname, moat_white, " for ", moat_green, rsn, moat_white, ".")
			D3A.Commands.Discord("tradeban", D3A.Commands.NameID(pl), tostring(args[1]), rsn)

			local targ = player.GetBySteamID64(sid)
			if (IsValid(targ)) then
				targ.IsTradeBanned = true
				targ.TradeBanReason = rsn
			end

			return
		end

		D3A.MySQL.FormatQuery("UPDATE player_bans_trading SET staff_steam_id = #, reason = # WHERE steam_id = #;", pid, rsn, sid)
		D3A.Chat.Broadcast2(pl, moat_cyan, tostring(args[1]) .. "'s", moat_white, " trading ban was updated by ", moat_cyan, plname, moat_white, " to ", moat_green, rsn, moat_white, ".")
		D3A.Commands.Discord("tradeban_update", tostring(args[1]), D3A.Commands.NameID(pl), rsn)
	end)
end

hook.Add("PlayerInitialSpawn", "moat_TradeBans", UpdateTradeBan)