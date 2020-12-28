D3A.Bans = {}

local function ParseBans(data)
	local bans = {All = {},
		Past = {},
		Recent = {},
		Active = {},
		Unbanned = {}
	}

	for _, b in ipairs(data) do
		if (not b.status) then
			continue
		end

		local ban = {
			name = tostring(b.name),
			steam_id = tostring(b.steam_id),
			avatar_url = tostring(b.avatar_url):StartWith("http") and tostring(b.avatar_url) or D3A.DefaultAvatar,
			length = tonumber(b.length),
			reason = tostring(b.reason),
			staff_name = tostring(b.staff_name),
			staff_steam_id = tostring(b.staff_steam_id),
			staff_avatar_url = tostring(b.staff_avatar_url):StartWith("http") and tostring(b.staff_avatar_url) or D3A.DefaultAvatar,
			time = tonumber(b.time),
			time_date = tostring(b.time_date),
			date = tostring(b.time_date):Explode(" @ ")[1] or "???",
			unban_reason = b.unban_reason,
			status = tostring(b.status)
		}

		bans[ban.status] = bans[ban.status] or {}
		table.insert(bans[ban.status], ban)
		table.insert(bans.All, ban)
	end

	bans.Count = #bans.All
	return bans
end

function D3A.Bans.Get(steamid, staff, start, length, cb)
	local id64 = util.SteamIDTo64(steamid)
	if (not id64 or id64:len() == 1) then
		id64 = steamid
	end

	print(id64)

	moat.mysql("SELECT time, FROM_UNIXTIME(time, '%c/%d/%Y @ %I:%i %p') AS time_date, length, reason, unban_reason," ..
		" IF(unban_reason IS NOT NULL AND LENGTH(unban_reason) > 1, 'Unbanned', IF(length != 0 AND time + length <= UNIX_TIMESTAMP() - 5184000, 'Past', IF(length != 0 AND time + length <= UNIX_TIMESTAMP(), 'Recent', 'Active'))) AS status," ..
		" CAST(b.steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id," ..
		" p.name AS name, s.name AS staff_name, p.avatar_url AS avatar_url, s.avatar_url AS staff_avatar_url " ..
		"FROM " .. moat.cfg.sql.database .. ".player_bans AS b LEFT JOIN " .. moat.cfg.sql.database .. ".player AS p ON b.steam_id = p.steam_id LEFT JOIN " .. moat.cfg.sql.database .. ".player AS s ON b.staff_steam_id = s.steam_id " ..
		"WHERE " .. (staff and "b.staff_steam_id" or "b.steam_id").. " = ? ORDER BY b.time DESC " ..
		"LIMIT " ..(start or 0) .. "," .. (length or 50), id64, function(data)
		if (cb) then cb(ParseBans(data or {}), data) end
	end)
end

function D3A.Bans.GetBans(steamid, staffid, start, length, cb)
	local id64 = util.SteamIDTo64(steamid)
	if (not id64 or id64:len() == 1) then
		id64 = steamid
	end

	id64 = D3A.MySQL.Escape(id64)

	moat.mysql()
	local q = "SELECT time, CAST(steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id, name, staff_name, length, reason, unban_reason FROM player_bans WHERE steam_id = #;"
	local Bans = {}
	D3A.MySQL.FormatQuery(q, id64, function(data)
		Bans = parseBans(data)

		if (cb) then cb(Bans) end
	end)
end

function D3A.Bans.IsBanned(steamid, callback)
	D3A.Bans.Get(steamid, false, nil, nil, function(data)
		data.Current = data.Active and data.Active[1] or nil
		callback(data.Active and data.Active[1], data)
	end)
end

local units = {}
units["perm"] = 0
units["second"] = 1
units["minute"] = 60
units["hour"] = 3600
units["day"] = 86400
units["week"] = 604800
units["month"] = 2419200
units["year"] = 29030400

function D3A.Bans.Ban(steamid, a_steamid, daname, daname2, len, unit, reason, override, cb)
	local banlen = len * units[unit]

	if (override) then
		D3A.MySQL.Query("UPDATE player_bans SET time = UNIX_TIMESTAMP(), staff_steam_id='" .. a_steamid .. "', length='" .. banlen .. "', reason='" .. D3A.MySQL.Escape(reason) .. "' WHERE time='" .. override .. "' AND steam_id='" .. steamid .. "'", function()
			if (cb) then cb() end
		end)

		return
	end

	D3A.MySQL.Query("INSERT INTO player_bans (time, steam_id, staff_steam_id, name, staff_name, length, reason) VALUES (UNIX_TIMESTAMP(), '" .. steamid .. "', '" .. a_steamid .. "', '" .. utf8.force(daname) .. "', '" .. utf8.force(daname2) .. "', '" .. banlen .. "', '" .. D3A.MySQL.Escape(reason) .. "')", function()
		local pl = D3A.FindPlayer(a_steamid)
		local tg = D3A.FindPlayer(steamid)
		local nm = (pl and pl:Name()) or "Console"

		if (tg) then
			local exp

			if (type(len) == "boolean") then
				len = (len and tonumber(1)) or tonumber(0); -- idk why boolean is being implied
			end

			if (unit == "perm") then exp = "permanently"
			else exp = "for " .. len .. " " .. unit .. (((len != 1) and "s") or "") end
			tg:Kick("Banned by " .. nm .. " " .. exp .. ". Reason: " .. reason)
		end

		if (cb) then cb() end
	end)
end

function D3A.Bans.BanPlayer(steamid, a_steamid, len, unit, reason, override, cb)
	local daname = "John Doe"
	local daname2 = "Console"

	local bannedply = player.GetBySteamID(steamid)
	local banningply = player.GetBySteamID(a_steamid)

	if (bannedply) then
		daname = D3A.MySQL.Escape(bannedply:Nick())
	end

	if (banningply) then
		daname2 = D3A.MySQL.Escape(banningply:Nick())
	end

	local id = D3A.ParseSteamID(steamid)
	if (not id) then
		D3A.Chat.SendToPlayer2(banningply, moat_red, "Unknown player: " .. steamid)
		return
	end

	a_steamid = util.SteamIDTo64(a_steamid)
	steamid = D3A.MySQL.Escape(id)

	D3A.MySQL.Query("SELECT name FROM player WHERE steam_id = '" .. steamid .. "';", function(r)
		if (not r or not r[1]) then
			D3A.Chat.SendToPlayer2(banningply, moat_red, "No players exist with SteamID provided.")
			return
		end

		local n = r[1].name or daname
		D3A.Bans.Ban(steamid, a_steamid, D3A.MySQL.Escape(n), daname2, len, unit, reason, override, cb)
	end)
end

function D3A.Bans.Unban(sid, reason, bantime, cb)
	D3A.MySQL.Query("UPDATE player_bans SET unban_reason='" .. D3A.MySQL.Escape(reason) .. "' WHERE time='" .. bantime .. "' AND steam_id='" .. util.SteamIDTo64(sid) .. "'", function()
		if (cb) then cb() end
	end)
end

function D3A.Bans.CheckPlayers()
	local pls = player.GetAll()
	local qstr, frst = "SELECT id, CAST(steam_id AS CHAR) AS steam_id FROM player_bans WHERE (time + length > UNIX_TIMESTAMP() OR length = 0) AND (unban_reason IS NULL OR LENGTH(unban_reason) = 0) AND (", true
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
		for k, v in ipairs(r) do
			local id32 = util.SteamIDFrom64(v.steam_id)
			game.KickID(id32, "You were banned on another Moat beta server")
		end
	end)
end

timer.Create("D3A.Bans.CheckPlayers", 15, 0, D3A.Bans.CheckPlayers)