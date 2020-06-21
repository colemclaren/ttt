cur_random_round = cur_random_round or false
hook.Add("Move","Inverted",function(ply,mv)
    if ply ~= LocalPlayer() then return end
    if ply:Team() == TEAM_SPEC then return end
    if (GetRoundState() == ROUND_ACTIVE and ply:IsTraitor()) then return end
    if cur_random_round == "Inverted" then 
        mv:SetForwardSpeed(mv:GetForwardSpeed() * -1)
        mv:SetSideSpeed(mv:GetSideSpeed() * -1)
    elseif cur_random_round == "Crab" then
        mv:SetForwardSpeed(0)
    end
end)
local desc = "" 
net.Receive("RandomRound",function()
    local name = net.ReadString()
    if name == "nono" then 
        if (cur_random_round == "Third Person") then
            hook.Remove("CreateMove", "MOAT_THIRDPERSON.ThirdPersonMovement")
            hook.Remove("InputMouseApply", "MOAT_THIRDPERSON.ThirdPersonMouse")
            hook.Remove("CalcView", "MOAT_THIRDPERSON.ThirdPersonCamera")
            hook.Remove("PostPlayerDraw", "MOAT_THIRDPERSON.OverrideDepthEnableFalse")
            hook.Remove("PrePlayerDraw", "MOAT_THIRDPERSON.OverrideDepthEnableTrue")
        end

        cur_random_round = false 
        return
    end

	if (cur_random_round and cur_random_round == name) then
		return
	end

    cur_random_round = name

    chat.AddText(Color(255,0,0),"WACKY ROUND!")
    chat.AddText(Color(0,255,0),"WACKY ROUND!")
    chat.AddText(Color(0,0,255),"WACKY ROUND!")
    chat.AddText(Color(255,255,255),name .. " Round!")
    desc = net.ReadString()
    chat.AddText(Color(255,255,255),desc)
    cdn.PlayURL "https://static.moat.gg/f/e72vwYsUaKItOpmRF6B2zPpTDEvF.mp3"

    if (name == "Third Person") then
        hook.Add("CreateMove", "MOAT_THIRDPERSON.ThirdPersonMovement", MOAT_THIRDPERSON.ThirdPersonMovement)
        hook.Add("InputMouseApply", "MOAT_THIRDPERSON.ThirdPersonMouse", MOAT_THIRDPERSON.ThirdPersonAiming)
        hook.Add("CalcView", "MOAT_THIRDPERSON.ThirdPersonCamera", MOAT_THIRDPERSON.ThirdPersonCamera)
        hook.Add("PostPlayerDraw", "MOAT_THIRDPERSON.OverrideDepthEnableFalse", MOAT_THIRDPERSON.OverrideDepthEnableFalse)
        hook.Add("PrePlayerDraw", "MOAT_THIRDPERSON.OverrideDepthEnableTrue", MOAT_THIRDPERSON.OverrideDepthEnableTrue)
    end
end)

surface.CreateFont("WackyTitle",{
    "DermaLarge",
    size = 28,
    weight = 600
})

hook.Add("HUDPaint","Wacky",function()
    if cur_random_round then
        DrawGlowingText(false, cur_random_round .. " Round", "WackyTitle", ScrW()/2, ScrH() * 0.1, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(desc, "ChatFont", ScrW()/2, ScrH() * 0.1 + 30, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)

hook.Add("TTTEndRound","Wacky",function()
    cur_random_round = false
end)


local VEC_ZERO = Vector(0, 0, 0)
local ANG_ZERO = Angle(0, 0, 0)

MOAT_THIRDPERSON = MOAT_THIRDPERSON or {}

MOAT_THIRDPERSON.cam = MOAT_THIRDPERSON.cam or {}
MOAT_THIRDPERSON.cam.Preset = {}
MOAT_THIRDPERSON.cam.Preset.Main = Vector(-128, 0, 16)
MOAT_THIRDPERSON.cam.Preset.Focus = Vector(-64, 45, 8)
MOAT_THIRDPERSON.cam.Pos = MOAT_THIRDPERSON.cam.Pos or Vector(0, 0, 0)
MOAT_THIRDPERSON.cam.Target = MOAT_THIRDPERSON.cam.Target or MOAT_THIRDPERSON.cam.Preset.Main
MOAT_THIRDPERSON.cam.Dir = MOAT_THIRDPERSON.cam.Dir or -1
MOAT_THIRDPERSON.cam.Offset = MOAT_THIRDPERSON.cam.Offset or VEC_ZERO
MOAT_THIRDPERSON.cam.Comp = MOAT_THIRDPERSON.cam.Comp or VEC_ZERO
MOAT_THIRDPERSON.cam.HitPos = MOAT_THIRDPERSON.cam.HitPos or VEC_ZERO
MOAT_THIRDPERSON.cam.HitNormal = MOAT_THIRDPERSON.cam.HitNormal or VEC_ZERO
MOAT_THIRDPERSON.cam.Ang = MOAT_THIRDPERSON.cam.Ang or ANG_ZERO

MOAT_THIRDPERSON.IsInfected = true

function MOAT_THIRDPERSON.ThirdPersonCamera(ply, pos, ang, fov, znear, zfar)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or cur_random_round ~= "Third Person") then return end

    if (not ply:Alive()) then
        local calc = {}
        calc.origin = MOAT_THIRDPERSON.cam.Pos
        calc.angles = MOAT_THIRDPERSON.cam.Ang
        calc.fov = fov
        calc.drawviewer = true

        return calc
    end

    local active_wep = ply:GetActiveWeapon()

    if (active_wep and IsValid(active_wep) and active_wep.GetIronsights and active_wep:GetIronsights()) then
        MOAT_THIRDPERSON.cam.Target = MOAT_THIRDPERSON.cam.Preset.Focus * Vector(1, MOAT_THIRDPERSON.cam.Dir, 1)
    else
        MOAT_THIRDPERSON.cam.Target = MOAT_THIRDPERSON.cam.Preset.Main
    end

    MOAT_THIRDPERSON.cam.Offset = MOAT_THIRDPERSON.cam.Ang:Forward() * MOAT_THIRDPERSON.cam.Target.x
    MOAT_THIRDPERSON.cam.Offset = MOAT_THIRDPERSON.cam.Offset + MOAT_THIRDPERSON.cam.Ang:Right() * MOAT_THIRDPERSON.cam.Target.y
    MOAT_THIRDPERSON.cam.Offset = MOAT_THIRDPERSON.cam.Offset + MOAT_THIRDPERSON.cam.Ang:Up() * MOAT_THIRDPERSON.cam.Target.z

    local collisionTest = util.TraceLine({
        start = ply:EyePos(),
        endpos = pos + MOAT_THIRDPERSON.cam.Offset,
        filter = ply
    })

    if (collisionTest.Hit) then
        MOAT_THIRDPERSON.cam.Offset = collisionTest.HitPos - pos + collisionTest.Normal * -8 + collisionTest.HitNormal * 8
    end

    MOAT_THIRDPERSON.cam.Comp = MOAT_THIRDPERSON.cam.Offset
    MOAT_THIRDPERSON.cam.Pos = pos + MOAT_THIRDPERSON.cam.Comp

    local camTr = util.TraceLine({
        start = MOAT_THIRDPERSON.cam.Pos,
        endpos = MOAT_THIRDPERSON.cam.Pos + MOAT_THIRDPERSON.cam.Ang:Forward() * 32768,
        filter = ply,
        mask = MASK_SHOT
    })

    local eyeTr = util.TraceLine({
        start = ply:EyePos(),
        endpos = camTr.HitPos,
        filter = ply,
        mask = MASK_SHOT
    })

    local preAngle = (eyeTr.HitPos - ply:EyePos()):Angle()
    local angleTest = camTr.Normal:Angle().y - preAngle.y
    angleTest = Angle(0, angleTest, 0)
    angleTest:Normalize()
    angleTest.y = math.abs(angleTest.y)

    if (angleTest.y >= 70) then
        ply:SetEyeAngles(MOAT_THIRDPERSON.cam.Ang)
    else
        ply:SetEyeAngles((eyeTr.HitPos - ply:EyePos()):Angle())
    end

    local opacity = math.Clamp(ply:EyePos():Distance(MOAT_THIRDPERSON.cam.Pos) / 64 * 255 - 32, 0, 255)
    LocalPlayer():SetColor(Color(255, 255, 255, opacity))
    LocalPlayer():SetRenderMode(RENDERMODE_TRANSALPHA)
    local calc = {}
    calc.origin = MOAT_THIRDPERSON.cam.Pos
    calc.angles = MOAT_THIRDPERSON.cam.Ang
    calc.fov = fov
    calc.drawviewer = true

    return calc
end

function MOAT_THIRDPERSON.OverrideDepthEnableTrue()
    if (LocalPlayer():Team() ~= TEAM_SPEC and cur_random_round == "Third Person") then
        render.OverrideDepthEnable(true, true)
    end
end

local cur_health_width = 0

function MOAT_THIRDPERSON.OverrideDepthEnableFalse()
    if (LocalPlayer():Team() ~= TEAM_SPEC and cur_random_round == "Third Person") then
        render.OverrideDepthEnable(false)
    end
end

function MOAT_THIRDPERSON.ThirdPersonAiming(cmd, x, y, ang)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or cur_random_round ~= "Third Person") then return end
    MOAT_THIRDPERSON.cam.Ang.p = math.Clamp(math.NormalizeAngle(MOAT_THIRDPERSON.cam.Ang.p + y / 50), -90, 90)
    MOAT_THIRDPERSON.cam.Ang.y = math.NormalizeAngle(MOAT_THIRDPERSON.cam.Ang.y - x / 50)
end

function MOAT_THIRDPERSON.ThirdPersonMovement(cmd)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or cur_random_round ~= "Third Person") then return end

    local targetYaw = MOAT_THIRDPERSON.cam.Ang.y
    local currentYaw = LocalPlayer():EyeAngles().y
    local offsetYaw = targetYaw - currentYaw
    local mv = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), 0)
    local mvLen = mv:Length()
    local correctYaw = Angle(0, mv:Angle().y - offsetYaw, 0):Forward()
    cmd:SetForwardMove(correctYaw.x * mvLen)
    cmd:SetSideMove(correctYaw.y * mvLen)
end

hook.Add("RenderScreenspaceEffects", "RandomRoundJarate", function()
    if (cur_random_round ~= "Jarate") then return end
    
    local pl = LocalPlayer()

    if (pl:Team() == TEAM_SPEC) then return end
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
    if (pl:IsTraitor()) then return end

    DrawMaterialOverlay("effects/jarate_overlay", 0.1)
end)

hook.Add("RenderScreenspaceEffects", "RandomRoundCartoon", function()
    if (cur_random_round ~= "Cartoon") then return end
    
    local pl = LocalPlayer()
    if (pl:Team() == TEAM_SPEC) then return end

    DrawSobel(0.11)
end)

local bandw = Material("pp/texturize/plain.png")

hook.Add("RenderScreenspaceEffects", "RandomRoundOldTimey", function()
    if (cur_random_round ~= "Old Timey") then return end
    
    local pl = LocalPlayer()
    if (pl:Team() == TEAM_SPEC) then return end

    DrawTexturize(1, bandw)
end)

net.Receive("moat.hide.cosmetics", function()
    local pl = net.ReadEntity()

    for k, v in pairs(MOAT_CLIENTSIDE_MODELS) do
        if (k == pl and v and v.ModelEnt and v.ModelEnt:IsValid() and v.ModelEnt ~= NULL) then
            v.ModelEnt:Remove()
        end
    end

    MOAT_CLIENTSIDE_MODELS[pl] = {}
end)

-- so late players who weren't existant during preparing can be networked the wacky round
hook.Add("InitPostEntity", "RandomRoundLateCheck", function()
    timer.Simple(10, function()
		net.Start "randomround.late"
    	net.SendToServer()
	end)
end)