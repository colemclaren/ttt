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
	local q = "SELECT * FROM player_bans WHERE steam_id='" .. util.SteamIDTo64(steamid) .. "'"
	
	local Bans = {}
	
	if (type(cb) == "function") then
		D3A.MySQL.Query(q, function(data)
			Bans = parseBans(data)

			cb(Bans)
		end)
	else
		local data = D3A.MySQL.QueryRet(q)
		
		Bans = parseBans(data)
		
		return Bans
	end
end

function D3A.Bans.IsBanned(steamid, callback)
	D3A.Bans.GetBans(steamid, function(data)
		callback(data.Current ~= nil, data)
	end)
end

function D3A.Bans.BanPlayer(steamid, a_steamid, len, unit, reason, override, cb)
	local units = {}
		units["perm"] = 0
		units["second"] = 1
		units["minute"] = 60
		units["hour"] = 3600
		units["day"] = 86400
		units["week"] = 604800
		units["month"] = 2419200
		units["year"] = 29030400
	
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
	
	local ret
	
	if (!override) then
		ret = D3A.MySQL.QueryRet("INSERT INTO player_bans (`time`, `steam_id`, `staff_steam_id`, `name`, `staff_name`, `length`, `reason`) VALUES('" .. os.time() .. "', '" .. util.SteamIDTo64(steamid) .. "', '" .. util.SteamIDTo64(a_steamid) .. "', '" .. daname .. "', '" .. daname2 .. "', '" .. banlen .. "', '" .. D3A.MySQL.Escape(reason) .. "')", function()
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
		
			return true
		end)
	else
		ret = D3A.MySQL.QueryRet("UPDATE player_bans SET time='" .. os.time() .. "', staff_steam_id='" .. util.SteamIDTo64(a_steamid) .. "', length='" .. banlen .. "', reason='" .. D3A.MySQL.Escape(reason) .. "' WHERE time='" .. override .. "' AND steam_id='" .. util.SteamIDTo64(steamid) .. "'", function()
			if (cb) then cb() end

			return true
		end)
	end
	
	return ret
end

function D3A.Bans.Unban(sid, reason, bantime, cb)
	local ret = D3A.MySQL.QueryRet("UPDATE player_bans SET unban_reason='" .. D3A.MySQL.Escape(reason) .. "' WHERE time='" .. bantime .. "' AND steam_id='" .. util.SteamIDTo64(sid) .. "'", function()
		if (cb) then cb() end
		
		return true
	end)
	
	return ret
end