MOAT_TRADE_BANNED = {}
MOAT_TRADE_BANNED["STEAM_0:0:44950009"] = true

local Player = FindMetaTable "Player"
function Player:GetAimVector() -- prevents true silent aim
    return self:EyeAngles():Forward()
end

function game.GetIP()

    local hostip = GetConVarString( "hostip" ) -- GetConVarNumber is inaccurate
    hostip = tonumber( hostip )

    local ip = {}
    ip[ 1 ] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 )
    ip[ 2 ] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 )
    ip[ 3 ] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 )
    ip[ 4 ] = bit.band( hostip, 0x000000FF )

    return table.concat( ip, "." ) .. ":" .. GetConVarString("hostport")
end
-- meme hello

local round_detections = {}

local detections = {}

local function discordLog(sid,mouse)
    local s = ""
    for k,v in pairs(mouse[5]) do
        s = s .. "[" .. k .. "=" .. v .. "] "
    end
	local msg = "[I lost track v4] Detected: `" .. mouse[1] .. " (" .. sid .. ") [" .. mouse[2] .. "] lvl(" .. mouse[3] .. ")` Server: " .. game.GetIP() .. " Detections: `" .. s .. "` Info: ```" .. mouse[6] .. "```"
	discord.Send("Skid", msg)
end

local ban = true

local sv_allowcslua, sv_cheats = GetConVar "sv_allowcslua", GetConVar "sv_cheats"
local dev_server = GetHostName():lower():find("dev")

local function IsDev()
    return sv_allowcslua:GetBool() or sv_cheats:GetBool() or dev_server
end

hook.Add("TTTEndRound","Joystick",function()
    local i = 0
    for k,v in pairs(detections) do
        i = i + 1
        timer.Simple(i,function() discordLog(k,v) end)
        for l,o in pairs(v[5]) do
            if l == -100 and IsDev() then
                continue
            end
            if o > 15 and ban then
                RunConsoleCommand("mga","perma",k,"Cheating")
                break
            end
        end
        if round_detections[k] >= 4 and ban then
            RunConsoleCommand("mga","perma",k,"Cheating")
        end
    end
    detections = {}
end)

function make_mac_detections(p,mwheel)
    if not round_detections[p:SteamID()] then round_detections[p:SteamID()] = 0 end
    round_detections[p:SteamID()] = round_detections[p:SteamID()] + 1
    local wep = p:GetActiveWeapon()
    local wep_s = "Invalid"
    if IsValid(wep) then
        wep_s = wep:GetClass()
    end
    detections[p:SteamID()] = {
        p:Nick(),
        p:IPAddress(),
        p:GetNWInt("MOAT_STATS_LVL", -1),
        p:SteamID64(),
        {},
        string.format("First Detection (" .. tostring(mwheel) .. ")\nPing: %s\nWeapon: %s\nMap: %s\nOnGround: %s",tostring(p:Ping()),wep_s,game.GetMap(),tostring(p:OnGround()))
    }
end

hook.Add("StartCommand", "Joystick", function(p, c)
	if (p.MCoolDown or 0) > CurTime() then return end
	local mwheel = c:GetMouseWheel()
    if MOAT_MINIGAME_OCCURING or IsDev() then return end
    if p:IsSpec() then return end
    if (not p:InVehicle() and not c:IsForced() and not p:IsBot() and not (mwheel == 0 or mwheel == 127)) and (p:Alive()) and (mwheel <= -2) then
		p.MDetect = true
        p.MCoolDown = CurTime() + 1
        if not detections[p:SteamID()] then
           make_mac_detections(p,mwheel) 
        end
        if not detections[p:SteamID()][5][mwheel] then
            detections[p:SteamID()][5][mwheel] = 1
        else
            if (p:SteamID() == "STEAM_0:1:67697024") then -- TODO: REMOVE!!!
                p:MoatChat("please note what you have been doing!")
                return
            end
            detections[p:SteamID()][5][mwheel] = detections[p:SteamID()][5][mwheel] + 1
            if detections[p:SteamID()][5][mwheel] > 15 and (not p.v_snapped) then
                if mwheel == -100 then return end
                net.Start("moat-ab")
			    net.Send(p)
                p.snapper = "c"
                p.v_snapped = true
            end
        end
    end
end)
