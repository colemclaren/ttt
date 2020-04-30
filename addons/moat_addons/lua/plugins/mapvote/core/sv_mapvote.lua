util.AddNetworkString("RAM_MapVoteStart")
util.AddNetworkString("RAM_MapVoteUpdate")
util.AddNetworkString("RAM_MapVoteCancel")
util.AddNetworkString("RTV_Delay")

MapVote.Continued = false

local MAP_AVAILABLE = {}
function MapVote.MapAvailable(map_str)
	if (MAP_AVAILABLE[map_str] ~= nil) then return MAP_AVAILABLE[map_str] end

	local map_good = false
	local maps = file.Find("maps/*.bsp", "GAME")

	for k, v in pairs(maps) do
		local mapstr = v:sub(1, -5):lower()
		if (MAP_BLACKLIST[mapstr]) then continue end
		
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
/*
if file.Exists( "mapvote/recentmaps.txt", "DATA" ) then
    recentmaps = util.JSONToTable(file.Read("mapvote/recentmaps.txt", "DATA"))
else
    recentmaps = {}
end
recentmaps = {}
*/

local minutes = 45 -- Cooldown
if GetHostName():lower():match("minecraft") or GetHostName():lower():match("mc") then
    minutes = 120
end

sql.Begin()
sql.Query("CREATE TABLE IF NOT EXISTS `moat_mapcool` ( `map` STRING NOT NULL, `time_played` INT NOT NULL );")
sql.Commit()

if file.Exists( "mapvote/config.txt", "DATA" ) then
    MapVote.Config = util.JSONToTable(file.Read("mapvote/config.txt", "DATA"))
else
    MapVote.Config = {}
end


function GetFeedback() end
function GiveFeedback() end

local function loadSQL()
    local db = MINVENTORY_MYSQL

    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_feedback` ( `vote` int NOT NULL, `map` VARCHAR(100) NOT NULL, `steamid` VARCHAR(255) NOT NULL )")
    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end
    dq:start()

    local function mapfeedback(map,fun)
        local q = db:query("SELECT * FROM moat_feedback WHERE map = '" .. db:escape(map) .. "';" )
        function q:onSuccess(d)
            if #d < 1 then fun() return end
            local total = 0
            local good = 0
            for k,v in pairs(d) do
                if v.vote == 1 then
                    good = good + 1
                end
                total = total + 1
            end
       
            fun(good/total)
        end
        q:start()
    end

    local function feedback(sid,map,type)
        local q = db:query("SELECT * FROM moat_feedback WHERE steamid = '" .. sid .. "' AND `map` = '" .. db:escape(map) .. "';")
        function q:onSuccess(d)
            if #d < 1 then
                local q = db:query("INSERT INTO moat_feedback (vote, map, steamid) VALUES ('" .. type .. "', '" .. db:escape(map) .. "', '" .. sid .. "') ")
                q:start()
            else
                local q = db:query("UPDATE moat_feedback SET vote = '" .. type .. "' WHERE steamid = '" .. sid .. "' AND `map` = '" .. db:escape(map) .. "';")
                q:start()
                function q:onError(s)
                    print(s)
                end
            end
        end
        q:start()
    end

    function GiveFeedback(ply,up,map)
        local sid = ply:SteamID64()
        local type = (up and 1 ) or 0
        local map = map or game.GetMap()
        feedback(sid,map,type)
    end

    function GetFeedback(tbl,fun)
        local feed = {}
        for k,v in pairs(tbl) do
            mapfeedback(v,function(a)
                if not a then 
                    feed[v] = -1
                else
                    feed[v] = math.Round(a * 100)
                end
                if table.Count(feed) >= table.Count(tbl) then
                    fun(feed)
                end
            end)
        end
    end
    local cool = {}
    net.Receive("MapVote.Feedback",function(l,ply)
        if (cool[ply] or 0) > CurTime() then return end
        cool[ply] = CurTime() + 1
        local b = net.ReadBool()
        GiveFeedback(ply,b)
    end)
end
util.AddNetworkString("MapVote.Feedback")

local function c()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end

if MINVENTORY_MYSQL then
    if c() then
        loadSQL()
         --print(87551)
    end
end


local fails = 0
hook.Add("InitPostEntity","MSQL",function()
    if not c() then 
        timer.Create("CheckMSQL",1,0,function()
			if (fails >= 300) then
				RunConsoleCommand('changelevel', game.GetMap())

				return
			end

            print("JackPot timer",c())
            if c() then
                loadSQL()
                timer.Destroy("CheckMSQL")
            end

			fails = fails + 1
        end)
    else
        loadSQL()
    end

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

    GetFeedback(vote_maps,function(tbl)
        net.Start("MapVote.Feedback")
        net.WriteTable(tbl)
        net.Broadcast()
    end)

    net.Start("RAM_MapVoteStart")
        net.WriteUInt(#vote_maps, 32)
        
        for i = 1, #vote_maps do
            net.WriteString(vote_maps[i])
        end
        
        net.WriteUInt(length, 32)
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
            
            for k2, v2 in pairs(player.GetAll()) do
                if(v2:SteamID() == k) then
                    if(v2:GetUserGroup() ~= "user") then
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
end

hook.Add( "Shutdown", "RemoveRecentMaps", function()
        if file.Exists( "mapvote/recentmaps.txt", "DATA" ) then
            file.Delete( "mapvote/recentmaps.txt" )
        end
end )

function MapVote.Cancel()
	ServerLog("mapvote_cancel")

    if MapVote.Allow then
        MapVote.Allow = false
        ServerLog("mapvote_cancel")

        net.Start("RAM_MapVoteCancel")
        net.Broadcast()

        timer.Destroy("RAM_MapVote")
    end
end
