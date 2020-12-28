function D3A.LoadSteamID(id, succ, err)
	D3A.Player.LoadPlayerInfo(id, function(r)
		r.rank = r.rank or "user"

		if (r.rank_expire and r.rank_expire <= os.time() and r.rank_expire > 0) then
			r.rank = r.rank_expire_to or "user"
		end

		if (r.rank_expire and r.rank_expire == 0) then
			local pl = player.GetBySteamID64(id)
			if (IsValid(pl)) then
				pl:SetNW2Bool("adminmode", true)
			end
		end

		if (succ) then succ(r) end
	end, function()
		if (err) then err() end
	end)
end

util.AddNetworkString "D3A.Warn"

function D3A.NewWarning(targstid, plstid, targname, plname, reason, cb)
	D3A.MySQL.FormatQuery("INSERT INTO player_warns (steam_id, staff_steam_id, name, staff_name, time, reason, acknowledged) VALUES (#, #, #, #, UNIX_TIMESTAMP(), #, NULL)",
	targstid, plstid, utf8.force(targname), utf8.force(plname), reason, function()
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

	net.WriteArray(warns,  function(i) net.Start "D3A.Warn" net.WriteUInt(i, 8) end, function(w, i)
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

local function ParseWarns(data)
	local warns = {}

	for _, b in ipairs(data) do
		local warn = {
			name = tostring(b.name),
			steam_id = tostring(b.steam_id),
			avatar_url = tostring(b.avatar_url):StartWith("http") and tostring(b.avatar_url) or D3A.DefaultAvatar,
			reason = tostring(b.reason),
			staff_name = tostring(b.staff_name),
			staff_steam_id = tostring(b.staff_steam_id),
			staff_avatar_url = tostring(b.staff_avatar_url):StartWith("http") and tostring(b.staff_avatar_url) or D3A.DefaultAvatar,
			time = tonumber(b.time),
			time_date = tostring(b.time_date),
			status = tostring(b.seen),
		}

		table.insert(warns, warn)
	end

	warns.Count = #warns
	return warns
end

function D3A.Warns.Get(steamid, staff, start, length, cb)
	local id64 = util.SteamIDTo64(steamid)
	if (not id64 or id64:len() == 1) then
		id64 = steamid
	end

	-- "SELECT id, CAST(steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id, staff_name, time, FROM_UNIXTIME(time, '%c/%d/%Y @ %I:%i %p') as time_date, reason, acknowledged "..
	-- 	"FROM player_warns WHERE steam_id = '" .. D3A.MySQL.Escape(sid) .. "';"

	moat.mysql("SELECT id, time, FROM_UNIXTIME(time, '%c/%d/%Y @ %I:%i %p') AS time_date, reason," ..
		" IF(acknowledged IS NOT NULL AND LENGTH(acknowledged) > 1, FROM_UNIXTIME(acknowledged, '%c/%d/%Y @ %I:%i %p'), 'Offline') AS seen," ..
		" CAST(b.steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id," ..
		" p.name AS name, s.name AS staff_name, p.avatar_url AS avatar_url, s.avatar_url AS staff_avatar_url " ..
		"FROM " .. moat.cfg.sql.database .. ".player_warns AS b LEFT JOIN " .. moat.cfg.sql.database .. ".player AS p ON b.steam_id = p.steam_id LEFT JOIN " .. moat.cfg.sql.database .. ".player AS s ON b.staff_steam_id = s.steam_id " ..
		"WHERE " .. (staff and "b.staff_steam_id" or "b.steam_id").. " = ? ORDER BY b.time DESC " ..
		"LIMIT " ..(start or 0) .. "," .. (length or 50), id64, function(data)
		if (cb) then cb(ParseWarns(data or {}), data) end
	end, function(err, qq) print(err, qq) end)
	
	-- D3A.MySQL.Query("SELECT id, CAST(steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id, staff_name, time, FROM_UNIXTIME(time, '%c/%d/%Y @ %I:%i %p') as time_date, reason, acknowledged "..
	-- 	"FROM player_warns WHERE steam_id = '" .. D3A.MySQL.Escape(sid) .. "';", cb)
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