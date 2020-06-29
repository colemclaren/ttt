util.AddNetworkString("MapVote.Feedback")
util.AddNetworkString("RAM_MapVoteStart")
util.AddNetworkString("RAM_MapVoteUpdate")
util.AddNetworkString("RAM_MapVoteCancel")
util.AddNetworkString("RTV_Delay")

MapVote = MapVote or {}
MapVote.Feedback = MapVote.Feedback or {}
MapVote.Continued = false
MapVote.Limit = 8

local MAP_AVAILABLE = {}
function MapVote.MapAvailable(map_str)
	if (MAP_AVAILABLE[map_str] ~= nil) then return MAP_AVAILABLE[map_str] end

	local map_good = false
	local maps = file.Find("maps/*.bsp", "GAME")

	for k, v in pairs(maps) do
		local mapstr = v:sub(1, -5):lower()
		if (MAP_BLACKLIST[mapstr]) then continue end
		if (not file.Exists("maps/" .. mapstr .. ".bsp", "GAME")) then continue end
		
		if (map_str == mapstr) then
			map_good = true
			break
		end
	end

	MAP_AVAILABLE[map_str] = map_good

	return map_good
end

function MapVote.GetAvailableMaps()
	if (MapVote.AvailableMaps and MapVote.AvailableMapsCount) then
		return MapVote.AvailableMaps, MapVote.AvailableMapsCount
	end

	MapVote.AvailableMaps = {}
	local maps, num = MAP_WHITELIST, 0
	for k, v in pairs(maps) do
		local mapstr = v:lower()
		if (MAP_BLACKLIST[mapstr]) then continue end
		if (not file.Exists("maps/" .. mapstr .. ".bsp", "GAME")) then continue end

		num = num + 1
		MapVote.AvailableMaps[num] = mapstr
	end

	MapVote.AvailableMapsCount = num
	return MapVote.AvailableMaps, num
end

net.Receive("RAM_MapVoteUpdate", function(len, ply)
    if(MapVote.Allow) then
        if(IsValid(ply)) then
            local update_type = net.ReadUInt(3)
            
            if(update_type == MapVote.UPDATE_VOTE) then
                local map_id = net.ReadUInt(32)
                
                if(MapVote.CurrentMaps[map_id]) then
                    MapVote.Votes[ply:SteamID()] = map_id
                    
                    net.Start("RAM_MapVoteUpdate")
                        net.WriteUInt(MapVote.UPDATE_VOTE, 3)
                        net.WriteEntity(ply)
                        net.WriteUInt(map_id, 32)
                    net.Broadcast()
                end
            end
        end
    end
end)

sql.Begin()
sql.Query("CREATE TABLE IF NOT EXISTS `moat_mapcool` ( `map` STRING NOT NULL, `time_played` INT NOT NULL );")
sql.Commit()

local fails, check = 0, function()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end

hook("InitPostEntity", function()
	if (not check()) then
		timer.Create("CheckMSQL", 1, 0,function()
			if (fails >= 300) then
				if (player.GetCount() > 0) then
					local msg = (GetHostName() or "") .. " ( steam://connect/" .. (game.GetIP() or "") .. " ) is switching map to `" .. game.GetMap() .. "`"
					discord.Send("Server", msg)

					RunConsoleCommand('changelevel', game.GetMap())
				elseif (GetServerName():lower():match "minecraft") then
					local msg = (GetHostName() or "") .. " ( steam://connect/" .. (game.GetIP() or "") .. " ) is switching map to `" .. 'ttt_minecraft_b5' .. "`"
					discord.Send("Server", msg)

					RunConsoleCommand("changelevel", "ttt_minecraft_b5")
				else
					local msg = (GetHostName() or "") .. " ( steam://connect/" .. (game.GetIP() or "") .. " ) is switching map to `" .. 'ttt_rooftops_a2_f1' .. "`"
					discord.Send("Server", msg)

					RunConsoleCommand("changelevel", "ttt_rooftops_a2_f1")
				end

				return
			end

            print("MapVote timer", check())

            if (check()) then
                timer.Remove "CheckMSQL"

				return
            end

			fails = fails + 1
        end)
    end
end)

function GetFeedback(maps, cb)
	if (not check() and cb) then
		return cb()
	end

	if (type(maps) == "string") then
		maps = {maps}
	end

	local args = table.Copy(maps)
	args[#args + 1] = function(r)
		for i = 1, #r do
			if (not r[i].map) then continue end
			if (not r or not r[i] or not r[i].total) then
				MsgC(Color(103, 152, 235), "[MAP VOTING] ", Color(255, 105, 180), r[i].map .. " has zero map ratings | NULL | NULL |\n")
				MapVote.Feedback[r[i].map] = {Positive = 0, Negative = 0}

				continue
			end

			local total = r[i].total or 0
			local like = r[i].positive or 0
			local dislike = r[i].negative or 0

			local rate1 = like >= dislike and like or dislike
			local rate2 = like < dislike and like or dislike
			MsgC(Color(103, 152, 235), "[MAP VOTING] ", Color(255, 105, 180), r[i].map .. " has " .. total.." map ratings | " .. (rate1 == like and "+" or "-") .. rate1 .." | "..(rate2 == like and "+" or "-") .. rate2 .. " |\n")
			MapVote.Feedback[r[i].map] = {Positive = like, Negative = dislike}
		end

		for i = 1, #maps do
			if (not MapVote.Feedback[maps[i]]) then
				MapVote.Feedback[maps[i]] = {Positive = 0, Negative = 0}
			end
		end

		if (cb) then
			cb(MapVote.Feedback)
		end
	end

	args[#args + 1] = function(err)
		if (cb) then
			cb(MapVote.Feedback)
		end

		print(err)
	end

	MySQL("SELECT map, COUNT(1) AS `total`, SUM(CASE WHEN vote = 0 THEN 1 ELSE 0 END) AS `negative`, SUM(CASE WHEN vote > 0 THEN 1 ELSE 0 END) AS `positive` FROM moat_feedback WHERE map IN (" .. string.rep('?', #maps, ', ') .. ") GROUP BY map;", unpack(args))
end

function GiveFeedback(sid, map, rating, cb)
	if (not check() and cb) then
		return cb()
	end

	MySQL("REPLACE INTO moat_feedback (vote, map, steamid) VALUES (?, ?, ?);", rating, map, sid, cb)
end

local cool = {}
net.Receive("MapVote.Feedback",function(l,ply)
    if (cool[ply] and cool[ply] > CurTime()) then return end
    cool[ply] = CurTime() + 1

	local like = (net.ReadBool() and 1) or 0
    GiveFeedback(ply:SteamID64(), game.GetMap(), like, function()
		if (IsValid(ply)) then
			-- net.Start "MapVote.Feedback"
			-- 	net.WriteUInt(like)
			-- net.Send(ply)
		end
	end)
end)

function MapVote.Start(length, current, limit, prefix, callback)
    current = current or MapVote.Config.AllowCurrentMap or false
    length = length or MapVote.Config.TimeLimit or 28
    limit = 8
    prefix = prefix or MapVote.Config.MapPrefixes

    hook.Run("MapVoteStarted")

    local is_expression = false

    if not prefix then
        local info = file.Read(GAMEMODE.Folder.."/"..GAMEMODE.FolderName..".txt", "GAME")

        if(info) then
            local info = util.KeyValuesToTable(info)
            prefix = info.maps
        else
            error("MapVote Prefix can not be loaded from gamemode")
        end

        is_expression = true
    else
        if prefix and type(prefix) ~= "table" then
            prefix = {prefix}
        end
    end
    
    local maps = MapVote.GetAvailableMaps()
    
    local vote_maps = {}
    local amt = 0

    if (D3A and D3A.MapBoosts) then
        for k, v in pairs(D3A.MapBoosts) do
            vote_maps[#vote_maps + 1] = k
            amt = amt + 1
        end
    end

	
	local minutes = 45 -- Cooldown
	if GetHostName():lower():match("minecraft") or GetHostName():lower():match("mc") then
    	minutes = 120
	end

    sql.Query("DELETE FROM `moat_mapcool` WHERE time_played < '" .. (os.time() - (minutes * 60)) .. "';")

    for k, map in RandomPairs(maps) do
        local mapstr = map
        if sql.QueryRow("SELECT * FROM moat_mapcool WHERE map = " .. sql.SQLStr(mapstr) .. ";") then continue end
        if(not current and game.GetMap():lower()..".bsp" == map) then continue end
        if (table.HasValue(vote_maps, mapstr)) then continue end
	if (not MapVote.MapAvailable(mapstr)) then continue end

        if is_expression then
            if(string.find(map, prefix)) then -- This might work (from gamemode.txt)
                vote_maps[#vote_maps + 1] = map
                amt = amt + 1
            end
        else
            for k, v in pairs(prefix) do
                if string.find(map, "^"..v) then
                    vote_maps[#vote_maps + 1] = map
                    amt = amt + 1
                    break
                end
            end
        end
        
        if(limit and amt >= limit) then break end
    end

    if amt < limit then
        for k, map in RandomPairs(maps) do
            local mapstr = map
            if(not current and game.GetMap():lower()..".bsp" == map) then continue end
            if (table.HasValue(vote_maps, mapstr)) then continue end
	    	if (not MapVote.MapAvailable(mapstr)) then continue end

            if is_expression then
                if(string.find(map, prefix)) then -- This might work (from gamemode.txt)
                    vote_maps[#vote_maps + 1] = map
                    amt = amt + 1
                end
            else
                for k, v in pairs(prefix) do
                    if string.find(map, "^"..v) then
                        vote_maps[#vote_maps + 1] = map
                        amt = amt + 1
                        break
                    end
                end
            end

            if(limit and amt >= limit) then break end
        end
    end

	GetFeedback(vote_maps, function(feedback)
		feedback = feedback or MapVote.Feedback

		net.Start("RAM_MapVoteStart")
			net.WriteUInt(#vote_maps, 5)
			
			for i = 1, #vote_maps do
				local map = vote_maps[i]
				net.WriteString(map)
				net.WriteUInt(feedback[map] and feedback[map].Positive or 1, 12)
				net.WriteUInt(feedback[map] and feedback[map].Negative or 1, 12)
			end
			
			net.WriteUInt(length, 8)
		net.Broadcast()

		MapVote.Allow = true
		MapVote.CurrentMaps = vote_maps
		MapVote.Votes = {}

		timer.Create("RAM_MapVote", length, 1, function()
			MapVote.Allow = false
			local map_results = {}
			
			for k, v in pairs(MapVote.Votes) do
				if(not map_results[v]) then
					map_results[v] = 0
				end

				for k2, v2 in ipairs(player.GetAll()) do
					if(v2:SteamID() == k) then
						if (v2:GetUserGroup() ~= "user") then
							map_results[v] = map_results[v] + 2
						else
							map_results[v] = map_results[v] + 1
						end
					end
				end
			end

			local winner = table.GetWinningKey(map_results) or 1

			net.Start("RAM_MapVoteUpdate")
				net.WriteUInt(MapVote.UPDATE_WIN, 3)
				
				net.WriteUInt(winner, 32)
			net.Broadcast()

			local map = MapVote.CurrentMaps[winner]
			timer.Simple(4, function()
				if (hook.Run("MapVoteChange", map) != false) then
					if (callback) then
						callback(map)
					else
						sql.Query("INSERT INTO `moat_mapcool` (map, time_played) VALUES (" .. sql.SQLStr(game.GetMap():lower()) .. ",'" .. os.time() .. "');")

						local msg = (GetHostName() or "") .. " ( steam://connect/" .. (game.GetIP() or "") .. " ) is switching map to `" .. map .. "`"
						discord.Send("Server", msg)

						RunConsoleCommand("changelevel", map)
					end
				end
			end)
		end)
	end)
end

function MapVote.Cancel()
	ServerLog("mapvote_cancel")

    if (MapVote.Allow) then
        MapVote.Allow = false
        ServerLog("mapvote_cancel")

        net.Start("RAM_MapVoteCancel")
        net.Broadcast()

        timer.Remove("RAM_MapVote")
    end
end
