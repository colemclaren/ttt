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

MG_CG = MG_CG or {}
MG_CG.IsInfected = false
MG_CG.Description = {
    "One player is chosen to be the first infected.",
    "If touched by infected, you will become infected!",
    "Kill the infected and let the time run out to win!",
}
MG_CG.InfectedPlayers = {}
MG_CG.Hooks = {}
MG_CG.ContagionOver = false
MG_CG.cols = {Color(255, 0, 0), Color(100, 255, 100), Color(100, 255, 100)}
MG_CG.TimeLeft = 120
MG_CG.WarningLabel = "INCOMING CONTAGION ROUND!!!"
MG_CG.FirstInfected = nil
MOAT_CONTAGION_ROUND_ACTIVE = false

function MG_CG.ResetVars()
    MG_CG.IsInfected = false
    MG_CG.PlayerInfo = {}
    MG_CG.InfectedPlayers = {}
    MG_CG.Hooks = {}
    MG_CG.ContagionOver = false
    MG_CG.TimeLeft = 0
    MG_CG.FirstInfected = nil
    MOAT_CONTAGION_ROUND_ACTIVE = false
end

local blur = Material("pp/blurscreen")

function MG_CG.DrawBlurScreen(amount)
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

function MG_CG.ActivePaint()
    if (GetRoundState() ~= ROUND_ACTIVE or MG_CG.ContagionOver) then
        hook.Remove("HUDPaint", "MG_CG_ACTIVEPAINT")
        return
    end

    local x = ScrW() / 2
    local y = 50

    m_DrawShadowedText(1, "Run away from and kill the infected until time runs out!", "moat_ItemDesc", x, 25, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER)

    draw.SimpleTextOutlined("Time Left:", "moat_GunGameMedium", x, y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))

    local TimeLeftColor = Color(0, 255, 0)
    if (MG_CG.TimeLeft <= 30) then
        TimeLeftColor = Color(255, 0, 0)
    end

    draw.SimpleTextOutlined(string.FormattedTime( MG_CG.TimeLeft, "%02i:%02i" ), "moat_GunGameMedium", x, y + 25, TimeLeftColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))

    if (LocalPlayer():Team() == TEAM_SPEC) then
        draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0))
        draw.SimpleText("You are dead and respawning.", "moat_GunGameMedium", ScrW()/2, ScrH()/2, Color(255, 255, 255), TEXT_ALIGN_CENTER)
    end
end

function MG_CG.PrepPaint()
    if (GetRoundState() ~= ROUND_PREP) then
        hook.Remove("HUDPaint", "MG_CG_PREPPAINT")
        return
    end

    surface.SetFont("moat_BossWarning")
    local textw, texth = surface.GetTextSize(MG_CG.WarningLabel)

    m_DrawEnchantedText(MG_CG.WarningLabel, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, Color(0, 255, 0), Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
    draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(0, 255*size_change, 0, 255*size_change))
    draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(0, 255*size_change, 0, 255*size_change))
    
    surface.SetFont("moat_BossInfo")

    local x = ScrW() / 2
    local y = 250

    for i = 1, #MG_CG.Description do
        draw.SimpleTextOutlined(MG_CG.Description[i], "moat_GunGameMedium", x, y + (i * 25), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
    end
end

local VEC_ZERO = Vector(0, 0, 0)
local ANG_ZERO = Angle(0, 0, 0)
MG_CG.cam = MG_CG.cam or {}
MG_CG.cam.Preset = {}
MG_CG.cam.Preset.Main = Vector(-128, 0, 16)
MG_CG.cam.Preset.Focus = Vector(-64, 45, 8)
MG_CG.cam.Pos = MG_CG.cam.Pos or Vector(0, 0, 0)
MG_CG.cam.Target = MG_CG.cam.Target or MG_CG.cam.Preset.Main
MG_CG.cam.Dir = MG_CG.cam.Dir or -1
MG_CG.cam.Offset = MG_CG.cam.Offset or VEC_ZERO
MG_CG.cam.Comp = MG_CG.cam.Comp or VEC_ZERO
MG_CG.cam.HitPos = MG_CG.cam.HitPos or VEC_ZERO
MG_CG.cam.HitNormal = MG_CG.cam.HitNormal or VEC_ZERO
MG_CG.cam.Ang = MG_CG.cam.Ang or ANG_ZERO

MG_CG.IsInfected = true

function MG_CG.ThirdPersonCamera(ply, pos, ang, fov, znear, zfar)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or not MG_CG.IsInfected) then return end
	MOAT_IGNORE_FOV = true

    if (not ply:Alive()) then
        local calc = {}
        calc.origin = MG_CG.cam.Pos
        calc.angles = MG_CG.cam.Ang
        calc.fov = fov
        calc.drawviewer = true

        return calc
    end

    if (ply:KeyDown(IN_ATTACK2)) then
        MG_CG.cam.Target = MG_CG.cam.Preset.Focus * Vector(1, MG_CG.cam.Dir, 1)
    else
        MG_CG.cam.Target = MG_CG.cam.Preset.Main
    end

    MG_CG.cam.Offset = MG_CG.cam.Ang:Forward() * MG_CG.cam.Target.x
    MG_CG.cam.Offset = MG_CG.cam.Offset + MG_CG.cam.Ang:Right() * MG_CG.cam.Target.y
    MG_CG.cam.Offset = MG_CG.cam.Offset + MG_CG.cam.Ang:Up() * MG_CG.cam.Target.z

    local collisionTest = util.TraceLine({
        start = ply:EyePos(),
        endpos = pos + MG_CG.cam.Offset,
        filter = ply
    })

    if (collisionTest.Hit) then
        MG_CG.cam.Offset = collisionTest.HitPos - pos + collisionTest.Normal * -8 + collisionTest.HitNormal * 8
    end

    MG_CG.cam.Comp = MG_CG.cam.Offset
    MG_CG.cam.Pos = pos + MG_CG.cam.Comp

    local camTr = util.TraceLine({
        start = MG_CG.cam.Pos,
        endpos = MG_CG.cam.Pos + MG_CG.cam.Ang:Forward() * 32768,
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
        ply:SetEyeAngles(MG_CG.cam.Ang)
    else
        ply:SetEyeAngles((eyeTr.HitPos - ply:EyePos()):Angle())
    end

    local opacity = math.Clamp(ply:EyePos():Distance(MG_CG.cam.Pos) / 64 * 255 - 32, 0, 255)
    LocalPlayer():SetColor(Color(0, 255, 0, opacity))
    LocalPlayer():SetRenderMode(RENDERMODE_TRANSALPHA)
    local calc = {}
    calc.origin = MG_CG.cam.Pos
    calc.angles = MG_CG.cam.Ang
    calc.fov = fov
    calc.drawviewer = true

    return calc
end

function MG_CG.OverrideDepthEnableTrue()
    if (LocalPlayer():Team() ~= TEAM_SPEC and MG_CG.IsInfected) then
        render.OverrideDepthEnable(true, true)
    end
end

local cur_health_width = 0
local gradient_u = Material("vgui/gradient-u")
function MG_CG.OverrideDepthEnableFalse()
    if (LocalPlayer():Team() ~= TEAM_SPEC and MG_CG.IsInfected) then
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

function MG_CG.ThirdPersonAiming(cmd, x, y, ang)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or not MG_CG.IsInfected) then return end
    MG_CG.cam.Ang.p = math.Clamp(math.NormalizeAngle(MG_CG.cam.Ang.p + y / 50), -90, 90)
    MG_CG.cam.Ang.y = math.NormalizeAngle(MG_CG.cam.Ang.y - x / 50)
end

function MG_CG.ThirdPersonMovement(cmd)
    if (not IsValid(LocalPlayer()) or LocalPlayer():Team() == TEAM_SPEC or not MG_CG.IsInfected) then return end

    local targetYaw = MG_CG.cam.Ang.y
    local currentYaw = LocalPlayer():EyeAngles().y
    local offsetYaw = targetYaw - currentYaw
    local mv = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), 0)
    local mvLen = mv:Length()
    local correctYaw = Angle(0, mv:Angle().y - offsetYaw, 0):Forward()
    cmd:SetForwardMove(correctYaw.x * mvLen)
    cmd:SetSideMove(correctYaw.y * mvLen)
end

function MG_CG.PrepRound()
    MG_CG.ResetVars()

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/virus/prepare.mp3")

    hook.Add("HUDPaint", "MG_CG_PREPPAINT", MG_CG.PrepPaint)
    hook.Add("TTTBeginRound", "MG_CG_BEGINHOOK", MG_CG.BeginRound)
end

local last_time_tick = CurTime()
function MG_CG.TimeLeftUpdate()
    if (last_time_tick <= CurTime() - 1) then
        last_time_tick = CurTime()

        MG_CG.TimeLeft = math.Clamp(math.ceil(MG_CG.TimeLeft - 1), 0, 9999)
    end
end

local dem_color = Color(0, 255, 0)
local red_color = Color(255, 0, 0)

function MG_CG.InfectedHalos()
    if (MG_CG.ContagionOver) then return end

    local dem_halos = {}
    local red_halos = {}
    for k, v in pairs(MG_CG.InfectedPlayers) do
        if (IsValid(k) and k:Team() ~= TEAM_SPEC) then
        	if (MG_CG.FirstInfected and k == MG_CG.FirstInfected) then
        		table.insert(red_halos, k)
        	else
				table.insert(dem_halos, k)
        	end
        end
    end

    halo.Add(dem_halos, dem_color, 0, 0, 1, true, false)
    halo.Add(red_halos, red_color, 0, 0, 1, true, false)
end


local function complementColor(color, add)
	return color + add <= 255 and color + add or color + add - 255
end

function MG_CG.InfectedChams()
    if (MG_CG.ContagionOver) then return end

    cam.Start3D()
		for k, v in pairs(MG_CG.InfectedPlayers) do
			if (not IsValid(v) or v:Team() == TEAM_SPEC) then continue end
			
			local color = dem_color
			if (MG_CG.FirstInfected and k == MG_CG.FirstInfected) then
				color = red_color
			end
			
			local modColor = Color(color.r / 255, color.g / 255, color.b / 255)

			render.SuppressEngineLighting(true)

			render.SetColorModulation(modColor.r, modColor.g, modColor.b)
			render.MaterialOverride(mat)
			v:DrawModel()
			
			render.SetColorModulation(modColor.r, modColor.g, modColor.b)
			render.MaterialOverride()
			render.SetModelLighting(BOX_TOP, modColor.r, modColor.g, modColor.b)
			v:DrawModel()

			render.SuppressEngineLighting(false)
		end
	cam.End3D()
end

local music_urls = {
	"https://static.moat.gg/servers/tttsounds/virus/song1.mp3",
	"https://static.moat.gg/servers/tttsounds/virus/song2.mp3",
	"https://static.moat.gg/servers/tttsounds/virus/song3.mp3",
	"https://static.moat.gg/servers/tttsounds/virus/song4.mp3"
}
local music_nums = {
    288,
    256,
    220,
    290
}

function MG_CG.PlayMusic(num)
    num = num or math.random(#music_nums)
    local next_num = num + 1

    if (not music_nums[next_num]) then
        next_num = 1
    end

	cdn.PlayURL(music_urls[num])
	timer.Simple(music_nums[num], function()
        if (MG_CG.ContagionOver) then return end

        MG_CG.PlayMusic(next_num)
    end)
end

function MG_CG.BeginRound()
    MG_CG.PlayMusic()
    MOAT_CONTAGION_ROUND_ACTIVE = true

    hook.Add("HUDPaint", "MG_CG_ACTIVEPAINT", MG_CG.ActivePaint)
    hook.Add("Think", "MG_CG_TIMELEFTUPDATE", MG_CG.TimeLeftUpdate)

    hook.Add("CreateMove", "MG_CG.ThirdPersonMovement", MG_CG.ThirdPersonMovement)
    hook.Add("InputMouseApply", "MG_CG.ThirdPersonMouse", MG_CG.ThirdPersonAiming)
    hook.Add("CalcView", "MG_CG.ThirdPersonCamera", MG_CG.ThirdPersonCamera)
    hook.Add("PostPlayerDraw", "MG_CG.OverrideDepthEnableFalse", MG_CG.OverrideDepthEnableFalse)
    hook.Add("PrePlayerDraw", "MG_CG.OverrideDepthEnableTrue", MG_CG.OverrideDepthEnableTrue)

    hook.Remove("TTTBeginRound", "MG_CG_BEGINHOOK")
end

function MG_CG.EndPaint()
    if (GetRoundState() ~= ROUND_ACTIVE) then
        hook.Remove("HUDPaint", "MG_CG_ENDPAINT")

        return
    end

    local x = ScrW() / 2
    local y = ScrH() / 2

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 200))

    draw.SimpleTextOutlined("GAME OVER", "moat_GunGameMedium", x, y, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
end

function MG_CG.EndRound()
    MG_CG.ContagionOver = true
    MOAT_CONTAGION_ROUND_ACTIVE = false
    
    hook.Remove("CreateMove", "MG_CG.ThirdPersonMovement")
    hook.Remove("InputMouseApply", "MG_CG.ThirdPersonMouse")
    hook.Remove("CalcView", "MG_CG.ThirdPersonCamera")
    hook.Remove("PostPlayerDraw", "MG_CG.OverrideDepthEnableFalse")
    hook.Remove("PrePlayerDraw", "MG_CG.OverrideDepthEnableTrue")
    hook.Remove("Think", "MG_CG_TIMELEFTUPDATE")

	MOAT_IGNORE_FOV = false

    hook.Add("HUDPaint", "MG_CG_ENDPAINT", MG_CG.EndPaint)
end

function MG_CG.IsInfected()
    return MG_CG.IsInfected
end

function MG_CG.UpdateTime()
    MG_CG.TimeLeft = 120
    last_time_tick = CurTime()
end

function MG_CG.NewInfected()
    local ply = net.ReadEntity()

    if (ply == LocalPlayer()) then
        MG_CG.IsInfected = true
    end

    if (table.Count(MG_CG.InfectedPlayers) < 1) then
    	MG_CG.FirstInfected = ply
    end
    
    MG_CG.InfectedPlayers[ply] = true
end

net.Receive("MG_CG_PREP", MG_CG.PrepRound)
net.Receive("MG_CG_END", MG_CG.EndRound)
net.Receive("MG_CG_KILLS", MG_CG.IncreaseCurKills)
net.Receive("MG_CG_UPDATETIME", MG_CG.UpdateTime)
net.Receive("MG_CG_NEWINFECTED", MG_CG.NewInfected)

function MOAT_ReadChat()
    chat.AddText(unpack(net.ReadTable()))
end

net.Receive("MOAT_CHAT_SEND", MOAT_ReadChat)