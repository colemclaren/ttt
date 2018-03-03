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

local detections = {}

local function discord(sid,mouse)
    local s = ""
    for k,v in pairs(mouse[5]) do
        s = s .. "[" .. k .. "=" .. v .. "] "
    end
	local msg = "[I lost track v4] Detected: `" .. mouse[1] .. " (" .. sid .. ") [" .. mouse[2] .. "] lvl(" .. mouse[3] .. ")` { http://steamcommunity.com/profiles/" .. mouse[4] .. " } Server: " .. game.GetIP() .. " Detections: `" .. s .. "`"
	SVDiscordRelay.SendToDiscordRaw("Skid bot",false,msg,"https://discordapp.com/api/webhooks/381964496136306688/d-s9h8MLL6Xbxa7XLdh9q1I1IAcJ3cniQAXnZczqFT0wLsc3PypyO6fMNlrtxV3C4hUK")
end

local ban = true

hook.Add("TTTEndRound","Joystick",function()
    local i = 0
    for k,v in pairs(detections) do
        i = i + 1
        timer.Simple(i,function() discord(k,v) end)
        for l,o in pairs(v[5]) do
            if o > 5 and ban then
                RunConsoleCommand("mga","perma",k,"Cheating")
                break
            end
        end
    end
    detections = {}
end)

hook.Add("StartCommand", "Joystick", function(p, c)
	if (p.MCoolDown or 0) > CurTime() then return end
	local mwheel = c:GetMouseWheel()
    if (not c:IsForced() and not p:IsBot() and not (mwheel == 0 or mwheel == 127)) and (p:Alive()) and (mwheel <= -2) then
		p.MDetect = true
        p.MCoolDown = CurTime() + 1
        if not detections[p:SteamID()] then
            detections[p:SteamID()] = {
                p:Nick(),
                p:IPAddress(),
                p:GetNWInt("MOAT_STATS_LVL", -1),
                p:SteamID64(),
                {}
            }
        end
        if not detections[p:SteamID()][5][mwheel] then
            detections[p:SteamID()][5][mwheel] = 1
        else
            detections[p:SteamID()][5][mwheel] = detections[p:SteamID()][5][mwheel] + 1
        end
    end
end)