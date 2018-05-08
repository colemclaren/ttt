util.AddNetworkString("RAM_MapVoteStart")
util.AddNetworkString("RAM_MapVoteUpdate")
util.AddNetworkString("RAM_MapVoteCancel")
util.AddNetworkString("RTV_Delay")

MapVote.Continued = false

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

if file.Exists( "mapvote/recentmaps.txt", "DATA" ) then
    recentmaps = util.JSONToTable(file.Read("mapvote/recentmaps.txt", "DATA"))
else
    recentmaps = {}
end
recentmaps = {}

if file.Exists( "mapvote/config.txt", "DATA" ) then
    MapVote.Config = util.JSONToTable(file.Read("mapvote/config.txt", "DATA"))
else
    MapVote.Config = {}
end

function CoolDownDoStuff()
    cooldownnum = 7
 
    if table.Count(recentmaps) > cooldownnum then 
        table.remove(recentmaps)
    end

    local curmap = game.GetMap():lower()..".bsp"

    if not table.HasValue(recentmaps, curmap) then
        table.insert(recentmaps, 1, curmap)
    end

    file.Write("mapvote/recentmaps.txt", util.TableToJSON(recentmaps))
end

function GetFeedback() end
function GiveFeedback() end

local function loadSQL()
    local db = MINVENTORY_MYSQL

    local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_feedback` ( `vote` int NOT NULL, `map` VARCHAR(255) NOT NULL, `steamid` VARCHAR(255) NOT NULL ) ENGINE=MyISAM DEFAULT CHARSET=latin1;")
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
        print("Feedback",sid,map,type)
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
        cool[ply] = CurTime() + 2
        local b = net.ReadBool()
        GiveFeedback(ply,b)
        local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") Voted " .. tostring(b) .. " on " .. game.GetMap()
		SVDiscordRelay.SendToDiscordRaw("MapVote bot",false,msg,"https://discordapp.com/api/webhooks/381964496136306688/d-s9h8MLL6Xbxa7XLdh9q1I1IAcJ3cniQAXnZczqFT0wLsc3PypyO6fMNlrtxV3C4hUK")

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

hook.Add("InitPostEntity","MSQL",function()
    if not c() then 
        timer.Create("CheckMSQL",1,0,function()
            print("JackPot timer",c())
            if c() then
                loadSQL()
                timer.Destroy("CheckMSQL")
            end
        end)
    else
        loadSQL()
    end

end)

function MapVote.Start(length, current, limit, prefix, callback)
    current = current or MapVote.Config.AllowCurrentMap or false
    length = length or MapVote.Config.TimeLimit or 28
    limit = 8
    cooldown = MapVote.Config.EnableCooldown or MapVote.Config.EnableCooldown == nil and true
    prefix = prefix or MapVote.Config.MapPrefixes

    hook.Run("MapVoteStarted")

    ServerLog("mapvote1")

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
    
    local maps = file.Find("maps/*.bsp", "GAME")
    
    local vote_maps = {}
    local amt = 0

    if (D3A and D3A.MapBoosts) then
        for k, v in pairs(D3A.MapBoosts) do
            vote_maps[#vote_maps + 1] = k
            amt = amt + 1
        end
    end

    ServerLog("mapvote2")

    for k, map in RandomPairs(maps) do
        local mapstr = map:sub(1, -5):lower()
        if(not current and game.GetMap():lower()..".bsp" == map) then continue end
        if(cooldown and table.HasValue(recentmaps, map)) then continue end
        if (table.HasValue(vote_maps, mapstr)) then continue end


        if is_expression then
            if(string.find(map, prefix)) then -- This might work (from gamemode.txt)
                vote_maps[#vote_maps + 1] = map:sub(1, -5)
                amt = amt + 1
            end
        else
            for k, v in pairs(prefix) do
                if string.find(map, "^"..v) then
                    vote_maps[#vote_maps + 1] = map:sub(1, -5)
                    amt = amt + 1
                    break
                end
            end
        end
        
        if(limit and amt >= limit) then break end
    end

    GetFeedback(vote_maps,function(tbl)
        net.Start("MapVote.Feedback")
        net.WriteTable(tbl)
        net.Broadcast()
    end)

    ServerLog("mapvote3")
    
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
    
    ServerLog("mapvote4")

    timer.Create("RAM_MapVote", length, 1, function()
        MapVote.Allow = false
        local map_results = {}

        ServerLog("mapvote5")
        
        for k, v in pairs(MapVote.Votes) do
            if(not map_results[v]) then
                map_results[v] = 0
            end
            
            for k2, v2 in pairs(player.GetAll()) do
                if(v2:SteamID() == k) then
                    if(MapVote.HasExtraVotePower(v2)) then
                        map_results[v] = map_results[v] + 2
                    else
                        map_results[v] = map_results[v] + 1
                    end
                end
            end
            
        end

        ServerLog("mapvote6")
        
        CoolDownDoStuff()

        local winner = table.GetWinningKey(map_results) or 1
        
        net.Start("RAM_MapVoteUpdate")
            net.WriteUInt(MapVote.UPDATE_WIN, 3)
            
            net.WriteUInt(winner, 32)
        net.Broadcast()
        
        local map = MapVote.CurrentMaps[winner]

        ServerLog("mapvote7")
        
        timer.Simple(4, function()
        	ServerLog("mapvote8")

            if (hook.Run("MapVoteChange", map) != false) then
            	ServerLog("mapvote      9")

                if (callback) then
                	ServerLog("mapvote10")
                    callback(map)
                else
                	ServerLog("mapvote11")
                	ServerLog(map)
                    local msg = (GetHostName() or "") .. " ( steam://connect/" .. (game.GetIP() or "") .. " ) is switching map to `" .. map .. "`"
	                SVDiscordRelay.SendToDiscordRaw("Map bot",false,msg,"https://discordapp.com/api/webhooks/443280941037912064/HrTLiALn7ggtDSomZA45VlxbQsxiZsx2Wazs7qqofHc77DLIQSe-CE40F4ai4qLGvhS7")
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
