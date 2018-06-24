D3A.Bans = {}

local function parseBans(data)
	data = data or {}
	
	local Bans = {
		Current = nil,
		Past = {},
		Removed = {}
	}
	
	for k, v in pairs(data) do
		if (v.unban_reason and string.len(v.unban_reason) > 1) then
			table.insert(Bans.Removed, v)
			continue
		end

		if (tonumber(v.length) != 0) and (tonumber(v.time) + tonumber(v.length) <= os.time()) then
			table.insert(Bans.Past, v)
			continue
		else
			Bans.Current = v
		end
	end
	
	return Bans
end

function D3A.Bans.GetBans(steamid, cb)
	local id64 = util.SteamIDTo64(steamid)
	if (not id64 or id64:len() == 1) then id64 = steamid end
	id64 = D3A.MySQL.Escape(id64)

	local q = "SELECT time, CAST(steam_id AS CHAR) AS steam_id, CAST(staff_steam_id AS CHAR) AS staff_steam_id, name, staff_name, length, reason, unban_reason FROM player_bans WHERE steam_id = #;"
	local Bans = {}
	D3A.MySQL.FormatQuery(q, id64, function(data)
		Bans = parseBans(data)

		if (cb) then cb(Bans) end
	end)
end

function D3A.Bans.IsBanned(steamid, callback)
	D3A.Bans.GetBans(steamid, function(data)
		callback(data.Current ~= nil, data)
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

function D3A.Bans.BanPlayer(steamid, a_steamid, len, unit, reason, override, cb)
	local banlen = len * units[unit]
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
	
	if (override) then
		D3A.MySQL.Query("UPDATE player_bans SET time = UNIX_TIMESTAMP(), staff_steam_id='" .. util.SteamIDTo64(a_steamid) .. "', length='" .. banlen .. "', reason='" .. D3A.MySQL.Escape(reason) .. "' WHERE time='" .. override .. "' AND steam_id='" .. util.SteamIDTo64(steamid) .. "'", function()
			if (cb) then cb() end
		end)

		return
	end

	D3A.MySQL.Query("INSERT INTO player_bans (time, steam_id, staff_steam_id, name, staff_name, length, reason) VALUES (UNIX_TIMESTAMP(), '" .. util.SteamIDTo64(steamid) .. "', '" .. util.SteamIDTo64(a_steamid) .. "', '" .. daname .. "', '" .. daname2 .. "', '" .. banlen .. "', '" .. D3A.MySQL.Escape(reason) .. "')", function()
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
			game.KickID(id32, "You were banned on another Moat Gaming server")
		end
	end)
end

timer.Create("D3A.Bans.CheckPlayers", 15, 0, D3A.Bans.CheckPlayers)