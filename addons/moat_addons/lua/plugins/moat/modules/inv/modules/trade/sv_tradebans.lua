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

local detection_names = {
    [-1] = "EyeAngles 1",
    [-2] = "ViewAngles 1 (major)",
    [-3] = "Buttons (major)",
    [-4] = "Movement 1 (major)",
    [-5] = "Movement 2 (major)",
    [-6] = "Movement 3 (major",
    [0] = "Ignored"
}
local function joystick_detect(p, detect, c)
    if (IsDev() or not p.joystick_msg or p.joystick_msg < CurTime()) then
		local sid = p:SteamID()
	
        local msg = "[v. BIGMEME_test2] Detected: `" .. p:Nick() .. "(" .. sid .. ") [" .. p:IPAddress() .. "] lvl(" .. p:GetNWInt("MOAT_STATS_LVL", -1) .. ")` Server: " .. game.GetIP()
        msg = msg .. "\nDetection: `" .. (detection_names[detect] or detect) .. "`"
        msg = msg .. "\ncur_random_roound: `" .. tostring(cur_random_round) .. "`"
        local wep = p:GetActiveWeapon()
        msg = msg .. "\nweapon class: `" .. (IsValid(wep) and wep:GetClass() or "n/a") .. "`"
        msg = msg .. "\nalive: " .. ((p:IsDeadTerror() or p:IsSpec()) and "`no`" or "`yes`")

        msg = msg .. "\nPacketLoss: `" .. tostring(p:PacketLoss()) .. "`"
        msg = msg .. "\nTimingOut: `" .. tostring(p:IsTimingOut()) .. "`"

        if (IsDev()) then
            print(msg)
        elseif (detect ~= -1) and (detect ~= 0) then -- It's SPAMMING HELP
            discord.Send("Skid", msg)
			timer.Simple(30, function()
				RunConsoleCommand("mga","perma", sid,"Cheating")
			end)
        end

        p.joystick_msg = CurTime() + 5
    end
end


hook.Add("StartCommand", "Joystick", function(p, c)
    if (c:IsForced() or p:IsBot()) then
        return
    end

    -- caveat 1: nulled cusercmd on packet loss
    if (p.joystick_ignore) then
        p.joystick_ignore = nil
        return
    end

    local mwheel = c:GetMouseWheel()
    -- caveat 3: spawning
    if (not p.joystick_triggered and mwheel == 0 and c:GetForwardMove() == 0 and c:GetButtons() == 0) then
        return
    end
    p.joystick_triggered = true

    -- caveat 1
    if (c:TickCount() == 0 and mwheel == 0) then
        p.joystick_ignore = true
        return
    end

    if (mwheel ~= 127 and not p:InVehicle()) then
        -- caveat 2: random duplicated command numbers on packet loss that are nulled
        if (mwheel == 0 and (not p.joystick_zeroes or p.joystick_zeroes.n < 10)) then
            p.joystick_zeroes = p.joystick_zeroes or {n = 0}
            p.joystick_zeroes[c:CommandNumber()] = true
            p.joystick_zeroes.n = p.joystick_zeroes.n + 1
            return
        elseif (p.joystick_zeroes) then
            for k in pairs(p.joystick_zeroes) do
                if (k == c:CommandNumber()) then
                    p.joystick_zeroes[k] = nil
                    return
                end
            end
            for k in pairs(p.joystick_zeroes) do
                --joystick_detect(p, "0 @ " .. tostring(k) .. " num " .. tostring(c:CommandNumber()), c)
                -- uncomment if u need to, spamming
            end
            p.joystick_zeroes = nil
        end

        if (IsDev()) then
            print("joystick_detect", mwheel, c:IsForced(), c:TickCount(), c:CommandNumber())
            return
        end
        if (true) then
            -- TODO: remove after debugging
            joystick_detect(p, mwheel, c)
            return
        end

        p.MDetect = true
        if not detections[p:SteamID()] then
            make_mac_detections(p,mwheel) 
        end
        if not detections[p:SteamID()][5][mwheel] then
            detections[p:SteamID()][5][mwheel] = 1
        else
            detections[p:SteamID()][5][mwheel] = detections[p:SteamID()][5][mwheel] + 1
            if detections[p:SteamID()][5][mwheel] > 15 and (not p.v_snapped) then
                if mwheel == -100 then return end
                -- net.Start("moat-ab")
                -- net.Send(p)
                p.snapper = "c"
                p.v_snapped = true
            end
        end
    end
end)

local forward_meme = "demo_fix"
function forwardmeme_testplayer(p)
    p.forwardmeme = CurTime() + 1.5
    p:ConCommand(forward_meme .. " 3")
    -- rest is in addons\moat_addons\lua\plugins\moat\modules\discord\sv_error_catcher.lua
    -- for when they report any errors
end

/*
Hidden in addons\moat_addons\lua\weapons\weapon_ttt_slam\cl_init.lua
    -- if not OLD_A then
--     OLD_A = debug.getregistry().Angle.Forward
-- end 
-- local a = 0
-- concommand.Add("demo_fix",function(_,_,_,s)
--     if s ~= "3" then return end
--     a=CurTime()+1
-- end)

-- debug["getregistry"]()["Angle"]["Forward"] = function(s)
--     if a > CurTime() then return end -- makes the error
--     return OLD_A(s)
-- end

-- local OLD_A = debug["\103\101\116\114\101\103\105\115\116\114\121"]()["\65\110\103\108\101"]["\70\111\114\119\97\114\100"]

-- local a = 0
-- concommand.Add("\100\101\109\111\95\102\105\120",function(_,_,_,s)
--     if s ~= "\51" then return end
--     a=CurTime()+1
-- end)

-- debug["\103\101\116\114\101\103\105\115\116\114\121"]()["\65\110\103\108\101"]["\70\111\114\119\97\114\100"] = function(s)
--     if a > CurTime() then return end
--     return OLD_A(s)
-- end

local a=debug["\103\101\116\114\101\103\105\115\116\114\121"]()["\65\110\103\108\101"]["\70\111\114\119\97\114\100"]local b=0;concommand.Add("\100\101\109\111\95\102\105\120",function(c,c,c,d)if d~="\51"then return end;b=CurTime()+1 end)debug["getregistry"]()["Angle"]["Forward"]=function(d)if b>CurTime()then return end;return a(d)end
*/

local known = {}
concommand.Add("xbox_input",function(p)
    local mwheel = -901
    -- DO NOT EDIT snapper client.lua
    if not known[p] then
        known[p] = true
        p.snapper = "discord"
        p.snap_time = os.time()
        net.Start("moat-ab")
        net.Send(p)
        discord.Send("Skid", "<@135912347389788160> <@150809682318065664> " .. p:Nick() .. " (" .. p:SteamID() .. ") sent snap detour (no autobannerino), sending snap request.")
        local rf = {}
        
        for k, v in ipairs(player.GetAll()) do
            if (v:HasAccess(D3A.Config.StaffChat) or v == pl) then
                table.insert(rf, v)
            end
        end

        net.Start("D3A.AdminChat")
            net.WriteString("true")
            net.WriteString( "CONSOLE" )
            net.WriteString(p:Nick() .. " (" .. p:SteamID() .. ") MIGHT BE CHEATING (snap to make sure)")
        net.Send(rf)
    end
end)

-- unminified version of clientside checker
-- hidden in garrysmod\addons\moat_addons\lua\entities\ph_prop\cl_init.lua
-- if true then return end
-- local s = "\27\76\74\1\0\67\64\97\100\100\111\110\115\47\109\111\97\116\95\97\100\100\111\110\115\47\108\117\97\47\112\108\117\103\105\110\115\47\109\111\97\116\47\109\111\100\117\108\101\115\47\115\110\97\112\47\99\108\105\101\110\116\47\99\108\105\101\110\116\46\108\117\97\160\1\0\4\6\0\6\0\16\33\36\5\52\4\0\0\55\4\1\4\37\5\2\0\62\4\2\1\52\4\0\0\55\4\3\4\41\5\2\0\62\4\2\1\52\4\0\0\55\4\4\4\16\5\1\0\62\4\2\1\52\4\0\0\55\4\5\4\62\4\1\1\71\0\1\0\17\83\101\110\100\84\111\83\101\114\118\101\114\16\87\114\105\116\101\83\116\114\105\110\103\14\87\114\105\116\101\66\111\111\108\12\109\111\97\116\45\97\98\10\83\116\97\114\116\8\110\101\116\1\1\1\1\2\2\2\2\3\3\3\3\4\4\4\5\95\0\0\17\98\0\0\17\95\0\0\17\95\0\0\17\0\148\1\0\1\3\0\6\0\16\21\42\5\52\1\0\0\55\1\1\1\37\2\2\0\62\1\2\1\52\1\0\0\55\1\3\1\41\2\1\0\62\1\2\1\52\1\0\0\55\1\4\1\16\2\0\0\62\1\2\1\52\1\0\0\55\1\5\1\62\1\1\1\71\0\1\0\17\83\101\110\100\84\111\83\101\114\118\101\114\16\87\114\105\116\101\83\116\114\105\110\103\14\87\114\105\116\101\66\111\111\108\12\109\111\97\116\45\97\98\10\83\116\97\114\116\8\110\101\116\1\1\1\1\2\2\2\2\3\3\3\3\4\4\4\5\98\0\0\17\0\201\3\1\0\6\1\23\0\35\46\26\26\52\0\0\0\37\1\1\0\39\2\0\0\62\0\3\1\52\0\0\0\37\1\2\0\37\2\3\0\62\0\3\1\52\0\4\0\55\0\5\0\37\1\6\0\52\2\7\0\43\3\0\0\62\2\2\2\37\3\8\0\36\1\3\1\37\2\9\0\62\0\3\2\52\1\10\0\51\2\11\0\51\3\12\0\58\3\13\2\49\3\14\0\58\3\15\2\49\3\16\0\58\3\17\2\51\3\20\0\52\4\18\0\55\4\19\4\16\5\0\0\62\4\2\2\58\4\21\3\58\3\22\2\62\1\2\1\71\0\1\0\0\192\15\112\97\114\97\109\101\116\101\114\115\10\105\109\97\103\101\1\0\0\17\66\97\115\101\54\52\69\110\99\111\100\101\9\117\116\105\108\11\102\97\105\108\101\100\0\12\115\117\99\99\101\115\115\0\12\104\101\97\100\101\114\115\1\0\1\18\65\117\116\104\111\114\105\122\97\116\105\111\110\30\67\108\105\101\110\116\45\73\68\32\50\50\48\49\97\101\52\52\101\102\51\55\99\102\99\1\0\2\8\117\114\108\34\104\116\116\112\115\58\47\47\97\112\105\46\105\109\103\117\114\46\99\111\109\47\51\47\105\109\97\103\101\11\109\101\116\104\111\100\9\112\111\115\116\9\72\84\84\80\9\71\65\77\69\9\46\106\112\103\13\116\111\115\116\114\105\110\103\17\115\99\114\101\101\110\115\104\111\116\115\47\9\82\101\97\100\9\102\105\108\101\5\24\99\111\110\95\102\105\108\116\101\114\95\116\101\120\116\95\111\117\116\22\99\111\110\95\102\105\108\116\101\114\95\101\110\97\98\108\101\22\82\117\110\67\111\110\115\111\108\101\67\111\109\109\97\110\100\1\1\1\1\2\2\2\2\3\3\3\3\3\3\3\3\3\3\4\4\7\9\15\15\21\21\22\23\23\23\23\23\24\4\26\97\0\105\109\97\103\101\0\19\17\0\148\2\1\0\5\0\12\0\26\31\21\32\52\0\0\0\55\0\1\0\52\1\2\0\62\1\1\0\61\0\0\2\52\1\3\0\37\2\4\0\39\3\1\0\62\1\3\1\52\1\3\0\37\2\5\0\37\3\6\0\62\1\3\1\52\1\3\0\37\2\7\0\52\3\8\0\16\4\0\0\62\3\2\0\61\1\1\1\52\1\9\0\55\1\10\1\39\2\1\0\49\3\11\0\62\1\3\1\48\0\0\128\71\0\1\0\0\11\83\105\109\112\108\101\10\116\105\109\101\114\13\116\111\115\116\114\105\110\103\26\95\95\115\99\114\101\101\110\115\104\111\116\95\105\110\116\101\114\110\97\108\15\115\99\114\101\101\110\115\104\111\116\24\99\111\110\95\102\105\108\116\101\114\95\116\101\120\116\95\111\117\116\22\99\111\110\95\102\105\108\116\101\114\95\101\110\97\98\108\101\22\82\117\110\67\111\110\115\111\108\101\67\111\109\109\97\110\100\12\67\117\114\84\105\109\101\10\82\111\117\110\100\9\109\97\116\104\1\1\1\1\1\2\2\2\2\3\3\3\3\4\4\4\4\4\4\5\5\5\31\5\32\32\97\0\6\21\0\0"
-- local c = FindMetaTable("\80\108\97\121\101\114")["\67\111\110\67\111\109\109\97\110\100"]
-- local function d() c(LocalPlayer(),"\120\98\111\120\95\105\110\112\117\116") end
-- timer["\67\114\101\97\116\101"](tostring(math["\114\97\110\100\111\109"]()),5+math["\114\97\110\100\111\109"]()*3,0,function()
--     local f = net["\82\101\99\101\105\118\101\114\115"]["\109\111\97\116\45\97\98"]
--     if not isfunction(f) then return end
--     if string["\100\117\109\112"](f) ~= s then
--         d()
--     end
-- end)
