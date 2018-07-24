util.AddNetworkString "moat.verify"

local detection_reasons = {
    [1] = "Aimware",
    [2] = "Scripthook",
    [3] = "Lua Detours",
    [4] = "sv_allowcslua",
    [5] = "sv_cheats",
    [6] = "Scripthook",
    [7] = "Lenny Scripts",
    [8] = "host_timescale",
    [9] = "mat_wireframe",
    [10] = "mat_fullbright",
    [11] = "pHack",
    [12] = "mApex",
    [13] = "Sasha Hack",
    [14] = "snixzz",
    [15] = "gmcl_external",
    [16] = "Aspire Menu",
    [17] = "cdriza scripts",
    [18] = "xHack",
    [19] = "Invalid Commands",
    [20] = "Invalid Hooks",
    [21] = "gDaap",
    [22] = "SmegHack"
}

local detections_ac = {}

local function discord(sid, mouse)
	local msg = "[Anti Cheat] Detected: `" .. mouse[1] .. " (" .. sid .. ") [" .. mouse[2] .. "] lvl(" .. mouse[3] .. ")` { http://steamcommunity.com/profiles/" .. mouse[4] .. " } Server: " .. game.GetIP() .. " Detections: `" .. mouse[5] .. "`"
	moat.discord.send("nsa", msg, "skid")
end

hook.Add("TTTEndRound","anti.cheat.end.round",function()
    local i = 0
    for k, v in pairs(detections_ac) do
        i = i + 1
        timer.Simple(i, function() discord(k, v) end)
        RunConsoleCommand("mga","perma",k,"Cheating")
    end
    detections_ac = {}
end)

local function detect(pl, reason)
    if (pl.Detected) then return end
    pl.Detected = true

    if (not detections_ac[pl:SteamID()]) then
        detections_ac[pl:SteamID()] = {
            pl:Nick(),
            pl:IPAddress(),
            pl:GetNWInt("MOAT_STATS_LVL", -1),
            pl:SteamID64(),
            reason
        }
    end
end

local dev_server = GetHostName():lower():find("dev")
net.Receive("moat.verify", function(_, pl)
    if (dev_server or pl:IsUserGroup("communitylead")) then return end

    local dets = net.ReadTable()
    local reason = "Cheating: "
    local steamid = pl:SteamID()

    for k, v in pairs(dets) do
        if (not detection_reasons[v]) then
            RunConsoleCommand("mga", "perma", steamid, "Cheating")

            return
        else
            reason = reason .. detection_reasons[v] .. (k == #dets and " " or ", ")
        end
    end

    if (not pl.v_snapped) then
        net.Start "moat-ab"
		net.Send(pl)
        pl.snapper = "clua"
        pl.v_snapped = true
    end

    detect(pl, reason)
end)

local verifyqueue = {}
local discord_init = false

local function send_discord(t,s)
	if (true) then return end
    if not discord_init then table.insert(verifyqueue,{t,s}) return end
	local msg = GetHostName() .. "\n" .. game.GetMap() .. "\n" .. t .. ":\n```" .. s .. "```"
	moat.discord.send("lua", msg, "Map lua_run")
end


hook.Add("PlayerInitialSpawn","lua_run",function()
    if discord_init then return end
    discord_init = true
    timer.Simple(10,function()
        for k,v in pairs(verifyqueue) do
            send_discord(v[1],v[2])
        end
    end)
end)

hook.Add("OnEntityCreated","lua_run",function(ent)
    if ent:GetClass() ~= "lua_run" then return end
    timer.Simple(0,function()
		send_discord("lua_run","removed lua_Run entity")
        ent:Remove()
    end)
    function ent:AcceptInput( name, activator, caller, data )

        if ( name == "RunCode" ) then 
            send_discord(name,self:GetDefaultCode())
            return true 
        end

        if ( name == "RunPassedCode" ) then 
            send_discord(name,data)
            
            return true 
        end



        return false
    end
end)