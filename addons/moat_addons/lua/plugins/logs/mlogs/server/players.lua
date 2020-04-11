mlogs.players = mlogs.players or {["0"] = {id = 0, sid = 0, name = "Bot"}}

function mlogs.UnknownPlayer()
	return {[1] = {
		["pid"] = 0,
		["steam_id"] = "0",
		["name"] = "Unknown Player"
	}}
end

function mlogs.GetPlayer(steam_id)
	return mlogs.players[steam_id]
end

function mlogs.SteamID(steam_id)
	return mlogs.players[steam_id] and mlogs.players[steam_id].id
end

function mlogs.PlayerID(pl)
	if (not IsValid(pl)) then return 0 end

	if (pl:IsBot()) then
		return tonumber(pl:Nick():sub(4, #pl:Nick())) % 128
	end

	pl = pl:Steam()

	return mlogs.players[pl] and mlogs.players[pl].id or 0
end

function mlogs.PlayerFromID(pid, cb)
	if (mlogs.players[pid]) then
		cb(mlogs.players[pid].id, mlogs.players[pid].sid, mlogs.players[pid].name)
		return
	end

	mlogs:q("SELECT pid, steam_id, name FROM {database}.mlogs_players WHERE pid = ?;", pid, function(r)
		if (not r or not r[1]) then r = mlogs.UnknownPlayer() end
		local id, sid, name =  r[1].pid, r[1].steam_id, r[1].name
		mlogs.players[sid].id = id
		mlogs.players[sid].sid = sid
		mlogs.players[sid].name = name
		mlogs.players[id] = mlogs.players[sid]

		cb(id, sid, name)
	end)
end

function mlogs.LoadInfo(id, nick)
	mlogs:q("call {database}.GetPlayerInfo(?, ?);", id, nick, function(r)
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
		mlogs.players[info.id] = info
	end)
end

hook("PlayerAuthed", function(pl)
	local id, nick = pl:Steam(), pl:Nick() or "Unknown Name"
	mlogs.LoadInfo(id, nick)
end)