surface.CreateFont("moat_GunGameMedium", {
    font = "DermaLarge",
    size = 28,
    weight = 800,
    italic = true
})
surface.CreateFont("moat_GunGameSmall", {
    font = "DermaLarge",
    size = 18,
    weight = 800
})
surface.CreateFont("moat_GunGameLarge", {
    font = "DermaLarge",
    size = 52,
    weight = 800,
    italic = true
})

MG_CM = MG_CM or {}
MG_CM.IsInfected = false
MG_CM.Description = {
    "Exploding chickens will spawn on you.",
    "You will be shoved every time they spawn.",
    "Camping, swimming, and ladder climbing will cause instant explosions.",
    "Be the last alive to win!!"
}
MG_CM.InfectedPlayers = {}
MG_CM.Hooks = {}
MG_CM.ContagionOver = false
MG_CM.cols = {Color(255, 0, 0), Color(100, 255, 100), Color(100, 255, 100)}
MG_CM.TimeLeft = 120
MG_CM.WarningLabel = "INCOMING EXPLOSIVE CHICKENS!!!"
MG_CM.FirstInfected = nil
MOAT_CONTAGION_ROUND_ACTIVE = false

function MG_CM.ResetVars()
    //MOAT_DISABLE_BUNNY_HOP = false
    MG_CM.IsInfected = false
    MG_CM.PlayerInfo = {}
    MG_CM.InfectedPlayers = {}
    MG_CM.Hooks = {}
    MG_CM.ContagionOver = false
    MG_CM.TimeLeft = 0
    MG_CM.FirstInfected = nil
    MOAT_CONTAGION_ROUND_ACTIVE = false
end

local blur = Material("pp/blurscreen")

function MG_CM.DrawBlurScreen(amount)
    local x, y = 0, 0
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

function MG_CM.ActivePaint()
    if (GetRoundState() ~= ROUND_ACTIVE or MG_CM.ContagionOver) then
        hook.Remove("HUDPaint", "MG_CM_ACTIVEPAINT")
        return
    end
    if (LocalPlayer():Team() == TEAM_SPEC) then return end

    local x = ScrW() / 2
    local y = 50

    m_DrawShadowedText(1, "Dodge the expoding chickens until the time runs out!", "moat_ItemDesc", x, 25, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER)

    draw.SimpleTextOutlined("Time Left:", "moat_GunGameMedium", x, y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))

    local TimeLeftColor = Color(0, 255, 0)
    if (MG_CM.TimeLeft <= 30) then
        TimeLeftColor = Color(255, 0, 0)
    end

    draw.SimpleTextOutlined(string.FormattedTime( MG_CM.TimeLeft, "%02i:%02i" ), "moat_GunGameMedium", x, y + 25, TimeLeftColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))

    /*if (LocalPlayer():Team() == TEAM_SPEC) then
        draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0))
        draw.SimpleText("You are dead and respawning.", "moat_GunGameMedium", ScrW()/2, ScrH()/2, Color(255, 255, 255), TEXT_ALIGN_CENTER)
    end*/
end

function MG_CM.PrepPaint()
    if (GetRoundState() ~= ROUND_PREP) then
        hook.Remove("HUDPaint", "MG_CM_PREPPAINT")
        return
    end

    surface.SetFont("moat_BossWarning")
    local textw, texth = surface.GetTextSize(MG_CM.WarningLabel)

    m_DrawEnchantedText(MG_CM.WarningLabel, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, Color(255, 255, 255), Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
    draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255*size_change, 0, 0, 255*size_change))
    draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255*size_change, 0, 0, 255*size_change))
    
    surface.SetFont("moat_BossInfo")

    local x = ScrW() / 2
    local y = 250

    for i = 1, #MG_CM.Description do
        draw.SimpleTextOutlined(MG_CM.Description[i], "moat_GunGameMedium", x, y + (i * 25), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
    end
end

local VEC_ZERO = Vector(0, 0, 0)
local ANG_ZERO = Angle(0, 0, 0)
MG_CM.cam = MG_CM.cam or {}
MG_CM.cam.Preset = {}
MG_CM.cam.Preset.Main = Vector(-128, 0, 16)
MG_CM.cam.Preset.Focus = Vector(-64, 45, 8)
MG_CM.cam.Pos = MG_CM.cam.Pos or Vector(0, 0, 0)
MG_CM.cam.Target = MG_CM.cam.Target or MG_CM.cam.Preset.Main
MG_CM.cam.Dir = MG_CM.cam.Dir or -1
MG_CM.cam.Offset = MG_CM.cam.Offset or VEC_ZERO
MG_CM.cam.Comp = MG_CM.cam.Comp or VEC_ZERO
MG_CM.cam.HitPos = MG_CM.cam.HitPos or VEC_ZERO
MG_CM.cam.HitNormal = MG_CM.cam.HitNormal or VEC_ZERO
MG_CM.cam.Ang = MG_CM.cam.Ang or ANG_ZERO

MG_CM.IsInfected = true

function MG_CM.ThirdPersonCamera(ply, pos, ang, fov, znear, zfar)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or not MG_CM.IsInfected) then return end

    if (not ply:Alive()) then
        local calc = {}
        calc.origin = MG_CM.cam.Pos
        calc.angles = MG_CM.cam.Ang
        calc.fov = fov
        calc.drawviewer = true

        return calc
    end

    if (ply:KeyDown(IN_ATTACK2)) then
        MG_CM.cam.Target = MG_CM.cam.Preset.Focus * Vector(1, MG_CM.cam.Dir, 1)
    else
        MG_CM.cam.Target = MG_CM.cam.Preset.Main
    end

    MG_CM.cam.Offset = MG_CM.cam.Ang:Forward() * MG_CM.cam.Target.x
    MG_CM.cam.Offset = MG_CM.cam.Offset + MG_CM.cam.Ang:Right() * MG_CM.cam.Target.y
    MG_CM.cam.Offset = MG_CM.cam.Offset + MG_CM.cam.Ang:Up() * MG_CM.cam.Target.z

    local collisionTest = util.TraceLine({
        start = ply:EyePos(),
        endpos = pos + MG_CM.cam.Offset,
        filter = ply
    })

    if (collisionTest.Hit) then
        MG_CM.cam.Offset = collisionTest.HitPos - pos + collisionTest.Normal * -8 + collisionTest.HitNormal * 8
    end

    MG_CM.cam.Comp = MG_CM.cam.Offset
    MG_CM.cam.Pos = pos + MG_CM.cam.Comp

    local camTr = util.TraceLine({
        start = MG_CM.cam.Pos,
        endpos = MG_CM.cam.Pos + MG_CM.cam.Ang:Forward() * 32768,
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
        ply:SetEyeAngles(MG_CM.cam.Ang)
    else
        ply:SetEyeAngles((eyeTr.HitPos - ply:EyePos()):Angle())
    end

    local opacity = math.Clamp(ply:EyePos():Distance(MG_CM.cam.Pos) / 64 * 255 - 32, 0, 255)
    LocalPlayer():SetColor(Color(255, 255, 255, opacity))
    LocalPlayer():SetRenderMode(RENDERMODE_TRANSALPHA)
    local calc = {}
    calc.origin = MG_CM.cam.Pos
    calc.angles = MG_CM.cam.Ang
    calc.fov = fov
    calc.drawviewer = true

    return calc
end

function MG_CM.OverrideDepthEnableTrue()
    if (LocalPlayer():Team() ~= TEAM_SPEC and MG_CM.IsInfected) then
        render.OverrideDepthEnable(true, true)
    end
end

local cur_health_width = 0

local gradient_u = Material("vgui/gradient-u")
function MG_CM.OverrideDepthEnableFalse()
    if (LocalPlayer():Team() ~= TEAM_SPEC and MG_CM.IsInfected) then
        render.OverrideDepthEnable(false)

        local eyeangles = LocalPlayer():EyeAngles()
        eyeangles:RotateAroundAxis(eyeangles:Right(), 90)
        eyeangles:RotateAroundAxis(eyeangles:Up(), 270)

        cam.Start3D2D( LocalPlayer():GetShootPos() + Vector(0, 0, 25), eyeangles, 0.1 )
            local x = -100
            local h = 30
            local w = 200
            local y = 50

            local health_ratio = LocalPlayer():Health() / LocalPlayer():GetMaxHealth()
            health_ratio = math.Clamp(health_ratio, 0, 1)
            cur_health_width = Lerp(FrameTime() * 10, cur_health_width, (health_ratio) * (w - 2))
            local health_green = 255 * health_ratio
            local health_red = 255 - (255 * health_ratio)
            surface.SetDrawColor(50, 50, 50, 150)
            surface.DrawOutlinedRect(x, y, w, h)
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawRect(x + 1, y + 1, w - 2, h - 2)
            surface.SetDrawColor(health_red / 5, health_green / 5, 0, 255)
            surface.DrawRect(x + 1, y + 1, w - 2, h - 2)
            surface.SetDrawColor(health_red, health_green, 0, 60)
            surface.SetMaterial(gradient_u)
            surface.DrawTexturedRect(x + 1, y + 1, cur_health_width, h - 2)
        cam.End3D2D()
    end
end

function MG_CM.ThirdPersonAiming(cmd, x, y, ang)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or not MG_CM.IsInfected) then return end
    MG_CM.cam.Ang.p = math.Clamp(math.NormalizeAngle(MG_CM.cam.Ang.p + y / 50), -90, 90)
    MG_CM.cam.Ang.y = math.NormalizeAngle(MG_CM.cam.Ang.y - x / 50)
end

function MG_CM.ThirdPersonMovement(cmd)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or not MG_CM.IsInfected) then return end

    local targetYaw = MG_CM.cam.Ang.y
    local currentYaw = LocalPlayer():EyeAngles().y
    local offsetYaw = targetYaw - currentYaw
    local mv = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), 0)
    local mvLen = mv:Length()
    local correctYaw = Angle(0, mv:Angle().y - offsetYaw, 0):Forward()
    cmd:SetForwardMove(correctYaw.x * mvLen)
    cmd:SetSideMove(correctYaw.y * mvLen)
end

function MG_CM.PrepRound()
    MG_CM.ResetVars()
    //MOAT_DISABLE_BUNNY_HOP = true

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3", 0.3)

    hook.Add("HUDPaint", "MG_CM_PREPPAINT", MG_CM.PrepPaint)
    hook.Add("TTTBeginRound", "MG_CM_BEGINHOOK", MG_CM.BeginRound)
end

local last_time_tick = CurTime()
function MG_CM.TimeLeftUpdate()
    if (last_time_tick <= CurTime() - 1) then
        last_time_tick = CurTime()

        MG_CM.TimeLeft = math.Clamp(math.ceil(MG_CM.TimeLeft - 1), 0, 9999)
    end
end

function MG_CM.PlayMusic(num)
	cdn.PlayURL(table.Random({
		"https://static.moat.gg/servers/tttsounds/chicken_song1.mp3", 
		"https://static.moat.gg/servers/tttsounds/chicken_song2.mp3"
	}), 0.4)
end

function MG_CM.BeginRound()
    MG_CM.IsInfected = true

    MG_CM.PlayMusic()
    MOAT_CONTAGION_ROUND_ACTIVE = true

    hook.Add("HUDPaint", "MG_CM_ACTIVEPAINT", MG_CM.ActivePaint)
    hook.Add("Think", "MG_CM_TIMELEFTUPDATE", MG_CM.TimeLeftUpdate)

    /*hook.Add("CreateMove", "MG_CM.ThirdPersonMovement", MG_CM.ThirdPersonMovement)
    hook.Add("InputMouseApply", "MG_CM.ThirdPersonAiming", MG_CM.ThirdPersonAiming)
    hook.Add("CalcView", "MG_CM.ThirdPersonCamera", MG_CM.ThirdPersonCamera)
    hook.Add("PostPlayerDraw", "MG_CM.OverrideDepthEnableFalse", MG_CM.OverrideDepthEnableFalse)
    hook.Add("PrePlayerDraw", "MG_CM.OverrideDepthEnableTrue", MG_CM.OverrideDepthEnableTrue)*/

    hook.Remove("TTTBeginRound", "MG_CM_BEGINHOOK")
end

function MG_CM.EndPaint()
    if (GetRoundState() ~= ROUND_ACTIVE) then
        hook.Remove("HUDPaint", "MG_CM_ENDPAINT")

        return
    end

    local x = ScrW() / 2
    local y = ScrH() / 2

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 200))

    draw.SimpleTextOutlined("GAME OVER", "moat_GunGameMedium", x, y, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
end

function MG_CM.EndRound()
    MG_CM.ContagionOver = true
    MOAT_CONTAGION_ROUND_ACTIVE = false

    /*hook.Remove("CreateMove", "MG_CM.ThirdPersonMovement")
    hook.Remove("InputMouseApply", "MG_CM.ThirdPersonAiming")
    hook.Remove("CalcView", "MG_CM.ThirdPersonCamera")
    hook.Remove("PostPlayerDraw", "MG_CM.OverrideDepthEnableFalse")
    hook.Remove("PrePlayerDraw", "MG_CM.OverrideDepthEnableTrue")*/
    hook.Remove("Think", "MG_CM_TIMELEFTUPDATE")

    hook.Add("HUDPaint", "MG_CM_ENDPAINT", MG_CM.EndPaint)
end

function MG_CM.IsInfected()
    return MG_CM.IsInfected
end

function MG_CM.UpdateTime()
    MG_CM.TimeLeft = 180
    last_time_tick = CurTime()
end

net.Receive("MG_CM_PREP", MG_CM.PrepRound)
net.Receive("MG_CM_END", MG_CM.EndRound)
net.Receive("MG_CM_UPDATETIME", MG_CM.UpdateTime)

function MOAT_ReadChat()
    chat.AddText(unpack(net.ReadTable()))
end

net.Receive("MOAT_CHAT_SEND", MOAT_ReadChat)