D3A.Player = D3A.Player or {}

local staff = {
	["trialstaff"] = true,
	["moderator"] = true,
	["admin"] = true,
	["senioradmin"] = true,
	["headadmin"] = true,
	["communitylead"] = true,
	["owner"] = true,
	["techartist"] = true,
	["audioengineer"] = true,
	["softwareengineer"] = true,
	["gamedesigner"] = true,
	["creativedirector"] = true
}

local max_players, hostname = GetConVarNumber("maxplayers"), GetHostName():lower()
local beta_server, maintenance_server = hostname:find "TTC", hostname:find("maintenance")

local players_connecting = {}
local kick_reasons = {}
kick_reasons["banned"] = "\nYou are banned!\n==================\nTime left: #\nReason: #\n==================\nThink it's an unfair ban?\nHead to https://moat.gg/unban to make an unban appeal"
kick_reasons["full"] = "Server Full!\n\nThere is a reserved slot for staff members only, sorry! We still love you <3"
kick_reasons["ttc"] = "This is the Moat.GG Terror City server.\n\nYou must be at least level 10 to join, as it's a bit more advanced than regular TTT. Please join one of our regular servers, sorry <3"
kick_reasons["maintenance"] = "Maintenance mode is active on this server! Sit tight while we work on things. Please try again later <3"
kick_reasons["karma"] = "\nKarma too low!\n==================\nYour karma is below #.\nYour karma will be reset in #.\n==================\nThink it's an unfair ban?\nDon't sweat it, you can appeal the enforcement @ https://moat.gg/unban"

function D3A.Player.KickID(steamid32, type, ...)
	local args, arg, str = {...}, 0, kick_reasons[type] or "Whoopsies! Something went wrong!"
	str = str:gsub("#", function() arg = arg + 1 return tostring(args[arg]) end)

	game.KickID(steamid32, tostring(str))
end

function D3A.Player.InsertNewPlayerToTable(SteamID, SteamID32, IP, Name, AvatarURL)
	AvatarURL = AvatarURL or D3A.DefaultAvatar
	local qstr = "INSERT INTO player "
	qstr = qstr .. "(steam_id, name, rank, first_join, last_join, avatar_url, playtime, inventory_credits, event_credits, donator_credits)"
	qstr = qstr .. " VALUES (?, ?, NULL, UNIX_TIMESTAMP(), NULL, ?, 0, 0, 0, 0);"

	qstr = qstr .. "INSERT INTO player_iplog (SteamID, Address, LastSeen) VALUES (?, ?, UNIX_TIMESTAMP());"

	moat.sql:q(qstr, SteamID, utf8.force(Name), AvatarURL, SteamID, IP, function(r)
		http.Fetch("https://moat.gg/api/steam/avatar/" .. SteamID)
		
		D3A.Player.LoadPlayerInfo(SteamID, function() end, function()
			game.KickID(SteamID32, 'Please change your name')
		end)
	end)

	D3A.Print(SteamID32 .. " | Connecting for the first time.")
end

function D3A.Player.LoadPlayerInfo(id64, res, empty)
	return moat.mysql("SELECT * FROM player WHERE steam_id = ? LIMIT 1;", id64, function(d)
		if (d and d[1]) then
			http.Fetch("https://moat.gg/api/steam/avatar/" .. id64)

			return res and res(d[1])
		else
			return empty and empty(d)
		end
	end)
end

function D3A.Player.CheckReserved(steamid, rank)
	if (maintenance_server and (rank and rank ~= "communitylead")) then
		D3A.Player.KickID(steamid, "maintenance")
		return
	end

	local cnt = player.GetCount() + 2
	if (cnt < max_players) then return end
	if (staff[rank]) then return end
	local pls = player.GetAll()
	local staff_found = false

	for i = 1, #pls do
		local g = pls[i]:GetUserGroup()

		if (g and staff[g]) then
			staff_found = true
			break
		end
	end

	if (staff_found) then return end
	D3A.Player.KickID(steamid, "full")
end

function D3A.Player.CheckConnecting(SteamID, SteamID32)
	if (not SteamID) then return end
	SteamID32 = SteamID32 or util.SteamIDFrom64(SteamID)

	if (players_connecting[SteamID] and players_connecting[SteamID][1] > CurTime()) then
		if (players_connecting[SteamID][2]) then
			D3A.Player.KickID(SteamID32, "banned", players_connecting[SteamID][3] or "", players_connecting[SteamID][4] or "")
		elseif (players_connecting[SteamID][6]) then
			D3A.Player.KickID(SteamID32, "karma", (KARMA and KARMA.cv) and KARMA.cv.kicklevel or 450, players_connecting[SteamID][6])
		elseif (players_connecting[SteamID][5]) then
			D3A.Player.KickID(SteamID32, "ttc")
		end

		return
	end

	if (players_connecting[SteamID]) then
		players_connecting[SteamID][1] = CurTime() + 5
	else
		players_connecting[SteamID] = {CurTime() + 5}
	end
end

function D3A.Player.CheckIfBanned(SteamID, SteamID32)
	if (not SteamID) then return end
	SteamID32 = SteamID32 or util.SteamIDFrom64(SteamID)

	D3A.Bans.IsBanned(SteamID32, function(isbanned, data)
		if (not isbanned) then return end
		local time, length, reason = tonumber(data.Current.time), tonumber(data.Current.length), data.Current.reason
		local exp = (length == 0 and "permanently") or tostring(string.NiceTime(length))
		if (not reason) then reason = "Visit https://moat.gg/bans." end

		players_connecting[SteamID][2] = true
		players_connecting[SteamID][3] = exp
		players_connecting[SteamID][4] = reason
		D3A.Player.KickID(SteamID32, "banned", exp, reason)
	end)
end

function D3A.Player.TTTKarma(SteamID, SteamID32)
	if (not SteamID) then return end
	SteamID32 = SteamID32 or util.SteamIDFrom64(SteamID)

	moat.mysql("SELECT level, karma, UNIX_TIMESTAMP(last_updated) + 3600 - UNIX_TIMESTAMP() AS reset_in FROM player WHERE steam_id = ? AND (3600 + UNIX_TIMESTAMP(last_updated) > UNIX_TIMESTAMP() OR karma = 0);", SteamID, function(d)
		if (d and d[1]) then
			local kick_level = (KARMA and KARMA.cv) and KARMA.cv.kicklevel or 450
			local karma_resets = d[1].reset_in
			local lvl = d[1].level or 1
			local live = d[1].karma

			KARMA.RememberedPlayers[SteamID] = {Karma = live or KARMA.cv.starting:GetFloat(), Time = 0}

			if (Server.IP and Server.IP == "208.103.169.54:27020" and lvl < 10) then
				D3A.Player.KickID(SteamID32, "ttc")

				return
			end

			if (live and kick_level and live < kick_level and (karma_resets > 0 or live == 0)) then
				players_connecting[SteamID][6] = (live == 0) and "30 days" or tostring(string.NiceTime(karma_resets))
				D3A.Player.KickID(SteamID32, "karma", (KARMA and KARMA.cv) and KARMA.cv.kicklevel or 450, players_connecting[SteamID][6])
			end
		end
	end)
end

function D3A.Player.Initialize(SteamID, SteamID32, Name, IP)
	D3A.Player.LoadPlayerInfo(SteamID, function(data)
		D3A.Player.Cache[SteamID] = data

		D3A.Print(SteamID32 .. " | Connecting")
		D3A.Player.CheckReserved(SteamID32, data.rank or "user")
	end, function()
		D3A.Player.InsertNewPlayerToTable(SteamID, SteamID32, IP, Name)
		D3A.Player.CheckReserved(SteamID32, "user")
	end)
end

function D3A.Player.CheckPassword(SteamID, IP, sv_Pass, cl_Pass, Name)
	local SteamID32 = util.SteamIDFrom64(SteamID)
	IP = IP and string.Explode(":", IP)[1] or "0.0.0.0"

	if (sv_Pass != "") and (cl_Pass != sv_Pass) then
		D3A.Print((IP or "0.0.0.0") .. " | " ..(Name or "Player") .. " (" .. (SteamID .. "PLAYER") .. ") | " .. (cl_Pass .. ""))
		return false, "Invalid password: " .. (cl_Pass .. "")
	end

	-- Check if joining too fast
	D3A.Player.CheckConnecting(SteamID, SteamID32)

	-- Check if banned
	D3A.Player.CheckIfBanned(SteamID, SteamID32)

	-- Load or create player data
	D3A.Player.Initialize(SteamID, SteamID32, Name, IP)

	if (Server.IP and Server.IP == "208.103.169.54:27020") then
		D3A.Player.TTTKarma(SteamID, SteamID32)
	end

	players_connecting[SteamID][1] = CurTime() + 5
end
hook("CheckPassword", D3A.Player.CheckPassword)