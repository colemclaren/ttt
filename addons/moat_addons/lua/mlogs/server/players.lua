mlogs.players = mlogs.players or {}

function mlogs.GetPlayer(steam_id)
	return mlogs.players[steam_id]
end

mlogs:hook("PlayerAuthed", function(pl)
	local id, nick = pl:Steam(), pl:Nick() or "Unknown Name"
	if (mlogs.players[id] and (mlogs.players[id].disconnected and mlogs.players[id].disconnected > (CurTime() - 30))) then return end

	mlogs:q("call GetPlayerInfo(?, ?);", id, nick, function(r)
		if (not r or not r[1]) then return end
		local info = {}
		info.sid = id
		info.id = r[1].player_id
		info.name = nick
		info.slays = {}

		for i = 1, #r do
			if (not r[i].slay_id) then continue end
			table.insert(info.slays, r[i])
		end
		if (not info.slays[1]) then info.slays = false end

		mlogs.players[id] = info
	end)
end)