function D3A.LoadSteamID(id, succ, err)
	D3A.Player.LoadPlayerInfo(id, function(r)
		r.rank = r.rank or "user"

		if (r.rank_expire and r.rank_expire <= os.time()) then
			r.rank = r.rank_expire_to or "user"
		end

		if (succ) then succ(r) end
	end, function()
		if (err) then err() end
	end)
end

util.AddNetworkString "D3A.Warn"

function D3A.NewWarning(targstid, plstid, targname, plname, reason, cb)
	D3A.MySQL.FormatQuery("INSERT INTO player_warns (steam_id, staff_steam_id, name, staff_name, time, reason, acknowledged) VALUES (#, #, #, #, UNIX_TIMESTAMP(), #, NULL)",
	targstid, plstid, sql_fixname(targname), sql_fixname(plname), reason, function()
		if (cb) then cb() end
	end)
end
function D3A.GetWarningPos(warnid, sid)
	local pos = false

	if (sid and D3A.Warns[sid]) then
		for k, v in ipairs(D3A.Warns[sid]) do
			if (v.id == warnid) then
				pos = k

				break 
			end
		end
	end

	return pos
end

function D3A.UpdateWarning(warnid, sid)
	if (sid and D3A.Warns[sid]) then
		local pos = D3A.GetWarningPos(warnid, sid)
		if (pos) then
			table.remove(D3A.Warns[sid], pos)
		end
	end

	return D3A.MySQL.FormatQuery("UPDATE player_warns SET acknowledged = UNIX_TIMESTAMP() WHERE id = #;", warnid)
end

net.Receive("D3A.Warn", function(_, pl)
	local id = net.ReadUInt(32)
	local sid = pl:SteamID64()
	if (not sid) then return end
	
	if (D3A.Warns.Lookup[id] and D3A.Warns.Lookup[id].steam_id and D3A.Warns.Lookup[id].steam_id == sid) then
		D3A.Warns.Lookup[id].acknowledged = true
		D3A.UpdateWarning(id, sid)
	end
end)

D3A.Warns = D3A.Warns or {Lookup = {}}
function D3A.WarnPlayer(pl)
	local sid = pl:SteamID64()
	if (not sid) then return end

	D3A.MySQL.FormatQuery("SELECT id, CAST(steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id, staff_name, time, reason, acknowledged FROM player_warns WHERE steam_id = # AND acknowledged IS NULL;", 
	sid, function(r)
		if (not r or not r[1]) then return end
		if (not IsValid(pl)) then
			return
		end

		net.WriteArray(r,  function(i) net.Start "D3A.Warn" net.WriteUInt(i, 8) end, function(w, i)
			D3A.Warns.Lookup[w.id] = w

			net.WriteUInt(w.id, 32)
			net.WriteString(w.staff_steam_id)
			net.WriteString(w.staff_name)
			net.WriteString(tostring(w.time))
			net.WriteString(w.reason)
		end, function() net.Send(pl) end)
	end)
end

function D3A.SendWarnings(sid, pl)
	pl = IsValid(pl) and pl or player.GetBySteamID64(sid)
	if (not IsValid(pl)) then
		return
	end

	local warns = D3A.Warns[sid]
	if (#warns <= 0) then
		return
	end

	net.WriteArrayy(warns,  function(i) net.Start "D3A.Warn" net.WriteUInt(i, 8) end, function(w, i)
		net.WriteUInt(w.id, 32)
		net.WriteString(w.staff_steam_id)
		net.WriteString(w.staff_name)
		net.WriteString(tostring(w.time))
		net.WriteString(w.reason)
	end, function() net.Send(pl) end)
end

hook.Add("PlayerInitialSpawn", "D3A.Check.Warns", D3A.WarnPlayer)

function D3A.Warns.Okay(sid, id)
	return
end

function D3A.Warns.CheckPlayers()
	local pls = player.GetAll()
	if (#pls <= 0) then
		return
	end

	local qstr, frst = "SELECT id, CAST(steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id, staff_name, time, reason, acknowledged FROM player_warns WHERE acknowledged IS NULL AND (", true
	for k = 1, #pls do
		local v = pls[k]
		if (not IsValid(v)) then continue end
		local id = v:SteamID64()
		if (not id) then continue end

		if (not frst) then qstr = qstr .. " OR " end
		qstr = qstr .. "steam_id = '" .. D3A.MySQL.Escape(id) .. "'"

		frst = false
	end
	if (frst) then return end
	qstr = qstr .. ");"

	D3A.MySQL.Query(qstr, function(r)
		if (not r) then return end
		local sids = {}

		for k, v in ipairs(r) do
			if (not v.steam_id) then
				continue
			end
			
			if (not sids[v.steam_id]) then
				sids[v.steam_id] = true 
			end

			if (not D3A.Warns[v.steam_id]) then
				D3A.Warns[v.steam_id] = {v}
			else
				local pos = D3A.GetWarningPos(v.id, v.steam_id)
				if (not pos) then
					D3A.Warns.Lookup[v.id] = D3A.Warns.Lookup[v.id] or v
	
					if (not D3A.Warns.Lookup[v.id].acknowledged) then
						table.insert(D3A.Warns[v.steam_id], v)
					end
				end
			end
		end

		for k, v in pairs(sids) do
			D3A.SendWarnings(k)
		end
	end)
end

timer.Create("D3A.Warns.CheckPlayers", 15, 0, D3A.Warns.CheckPlayers)