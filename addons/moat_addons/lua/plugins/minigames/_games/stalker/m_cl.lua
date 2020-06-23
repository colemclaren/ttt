surface.CreateFont("moat_BossWarning", {
    font = "DermaLarge",
    size = 52,
    weight = 800,
    italic = true
})
surface.CreateFont("moat_BossInfo", {
    font = "DermaLarge",
    size = 28,
    weight = 800,
    italic = true
})
surface.CreateFont("moat_BossInfo2", {
    font = "DermaLarge",
    size = 18,
    weight = 800,
    italic = true
})

local MOAT_BOSS_ROUND_OVER = false
local MOAT_CUR_BOSS = nil
local MOAT_BOSS_DMG = {}
MOAT_ACTIVE_BOSS = false
local boss_health_width = 0
if (MOAT_DAMAGE_AVATARS) then
	for k, v in pairs(MOAT_DAMAGE_AVATARS) do
		v:Remove()
	end
end
MOAT_DAMAGE_AVATARS = {}

local blur = Material("pp/blurscreen")

local function DrawBlurScreen(amount)
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

local gradient_u = Material("vgui/gradient-u")
local function moat_DrawBossHealth()
	if (GetRoundState() ~= ROUND_ACTIVE or MOAT_BOSS_ROUND_OVER or not IsValid(MOAT_CUR_BOSS)) then
		hook.Remove("HUDPaint", "moat_DrawBossHealth")
		hook.Remove("HUDShouldDraw", "moat_HideDamageIndicator")
		return
	end

	local x = (ScrW() / 2) - 300
    local h = 30
    local w = 600
    local y = 50

	local health_ratio = MOAT_CUR_BOSS:Health() / MOAT_CUR_BOSS:GetMaxHealth()
    health_ratio = math.Clamp(health_ratio, 0, 1)
    boss_health_width = Lerp(FrameTime() * 10, boss_health_width, (health_ratio) * (w - 2))
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
    surface.DrawTexturedRect(x + 1, y + 1, boss_health_width, h - 2)
    local font = "TimeLeft"

    local health_text = math.max(0, MOAT_CUR_BOSS:Health())
    draw.SimpleTextOutlined(MOAT_CUR_BOSS:Nick() .. ": " .. health_text, font, x + (w / 2), y + (h / 2), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    m_DrawShadowedText(1, "Run from the stalker and collect eggs! Kill him to win!", "moat_ItemDesc", (ScrW()/2), 30, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER)
end

local function moat_InitDrawBossHealth()
	hook.Add("HUDPaint", "moat_DrawBossHealth", moat_DrawBossHealth)

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/stalker/stalker_music.mp3")
	timer.Simple(5, function() if (IsValid(LocalPlayer())) then LocalPlayer():ConCommand('record stalker;stop;') end end)
end

local moat_BossWarningLabel = "YOU'RE GOING TO DIE!!!"
local moat_BossDirections = {"Team up with other players", "to defeat the stalker and receive", "a prize only if you win!"}

local function moat_DrawBossWarning()
	if (GetRoundState() ~= ROUND_PREP) then
		hook.Remove("HUDPaint", "moat_PrepareBoss")
		return
	end

	surface.SetFont("moat_BossWarning")
	local textw, texth = surface.GetTextSize(moat_BossWarningLabel)

	m_DrawEnchantedText(moat_BossWarningLabel, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, Color(255, 0, 0), Color(255, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255*size_change, 0, 0, 255*size_change))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255*size_change, 0, 0, 255*size_change))
	
	surface.SetFont("moat_BossInfo")

	for k, v in pairs(moat_BossDirections) do
		local textw, texth = surface.GetTextSize(v)
		m_DrawShadowedText(1, v, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*k), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end

local function moat_PrepareBoss()

	MOAT_BOSS_ROUND_OVER = false
	MOAT_ACTIVE_BOSS = true

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/stalker/stalker_preround.mp3")
	
	hook.Add("HUDPaint", "moat_PrepareBoss", moat_DrawBossWarning)
	hook.Add("TTTBeginRound", "moat_StartBoss", moat_InitDrawBossHealth)

end

local END_ROUND_WIN = "PLAYERS ARE VICTORIOUS!!!"
local END_ROUND_LOSS = "THE BOSS IS VICTORIOUS!!!"
local cols = {Color(0, 255, 0), Color(100, 255, 100), Color(100, 255, 100)}

local function moat_DrawBossEnd(MOAT_BOSS_LOSS)

	if (GetRoundState() ~= ROUND_ACTIVE) then
		hook.Remove("HUDPaint", "moat_DrawBossEnd")
		hook.Remove("HUDShouldDraw", "moat_HideDamageIndicator")

		for k, v in pairs(MOAT_DAMAGE_AVATARS) do
			if (IsValid(v)) then v:Remove() end
		end

		MOAT_DAMAGE_AVATARS = {}
		return
	end

	draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	DrawBlurScreen(5)

	local text = END_ROUND_LOSS
	local textc = Color(255, 0, 0)
	local textc2 = Color(50, 0, 0)
	if (MOAT_BOSS_LOSS) then
		text = END_ROUND_WIN
		textc = Color(0, 255, 0)
		textc2 = Color(0, 50, 0)
	end

	surface.SetFont("moat_BossWarning")
	local textw, texth = surface.GetTextSize(text)

	m_DrawEnchantedText(text, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, textc, textc2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255, 255, 255, 255*size_change))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255, 255, 255, 255*size_change))


	if (not MOAT_BOSS_DMG or #MOAT_BOSS_DMG < 1) then return end

	surface.SetFont("moat_BossInfo")
	local num = math.Clamp(#MOAT_BOSS_DMG, 1, 10)
	for i = 1, num do

		if (i == 1) then

			surface.SetFont("moat_BossInfo")
			local txt = "Top Damage"
			local col = Color(255, 255, 255)
			if (cols[i]) then
				col = cols[i]
			end

			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MOAT_BOSS_DMG[i][1])
			m_DrawShadowedText(1, MOAT_BOSS_DMG[i][1], "moat_BossInfo2", (ScrW()/2)-(textw/2), 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MOAT_BOSS_DMG[i][2])) .. " Damage"
			local col = Color(255, 255, 255)
			if (cols[i]) then
				col = cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2), 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]) then
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]] = vgui.Create("AvatarImage")
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetPos((ScrW()/2)-32, 155+(texth*3)-10)
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetSize(64, 64)
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetPlayer(Entity(MOAT_BOSS_DMG[i][3]), 64)
			end
			
			continue
		elseif (i == 2) then

			surface.SetFont("moat_BossInfo")
			local txt = "2nd Place"
			local col = Color(255, 255, 255)
			if (cols[i]) then
				col = cols[i]
			end

			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2)-200, 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MOAT_BOSS_DMG[i][1])
			m_DrawShadowedText(1, MOAT_BOSS_DMG[i][1], "moat_BossInfo2", (ScrW()/2)-(textw/2)-200, 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MOAT_BOSS_DMG[i][2])) .. " Damage"
			local col = Color(255, 255, 255)
			if (cols[i]) then
				col = cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2)-200, 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]) then
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]] = vgui.Create("AvatarImage")
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetPos((ScrW()/2)-232, 155+(texth*3)-10)
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetSize(64, 64)
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetPlayer(Entity(MOAT_BOSS_DMG[i][3]), 64)
			end
			
			continue
		elseif (i == 3) then

			local txt = "3rd Place"
			local col = Color(255, 255, 255)
			if (cols[i]) then
				col = cols[i]
			end

			surface.SetFont("moat_BossInfo")
			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2)+200, 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MOAT_BOSS_DMG[i][1])
			m_DrawShadowedText(1, MOAT_BOSS_DMG[i][1], "moat_BossInfo2",(ScrW()/2)-(textw/2)+200, 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MOAT_BOSS_DMG[i][2])) .. " Damage"
			local col = Color(255, 255, 255)
			if (cols[i]) then
				col = cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2)+200, 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]) then
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]] = vgui.Create("AvatarImage")
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetPos((ScrW()/2)+200-32, 155+(texth*3)-10)
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetSize(64, 64)
				MOAT_DAMAGE_AVATARS[MOAT_BOSS_DMG[i][3]]:SetPlayer(Entity(MOAT_BOSS_DMG[i][3]), 64)
			end
			
			continue
		end

		local txt = MOAT_BOSS_DMG[i][1] .. ": " .. string.Comma(math.Round(MOAT_BOSS_DMG[i][2])) .. " Damage"
		local col = Color(255, 255, 255)
		if (cols[i]) then
			col = cols[i]
		end

		surface.SetFont("moat_BossInfo2")

		local textw, texth = surface.GetTextSize(txt)
		m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw/2), 155+(texth*(i+6)), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

end

local function moat_InitBossEnd(BOSS_LOSS)
	hook.Add("HUDPaint", "moat_DrawBossEnd", function() moat_DrawBossEnd(BOSS_LOSS) end)
	hook.Remove("TTTBeginRound", "moat_StartBoss")
	hook.Remove("HUDShouldDraw", "moat_HideDamageIndicator")
	hook.Remove("PlayerFootstep", "moat_ScreenShake")
	MOAT_ACTIVE_BOSS = false

	-- if (MOAT_CUR_BOSS and IsValid(MOAT_CUR_BOSS)) then
	-- 	MOAT_CUR_BOSS:DrawShadow(true)
	-- end
end

net.Receive("MOAT_PREP_STALKER", function(len)
	moat_PrepareBoss()
	MOAT_BOSS_DMG = {}
end)

net.Receive("MOAT_BEGIN_STALKER", function(len)
	MOAT_CUR_BOSS = net.ReadEntity()

	hook.Add("CalcView", "moat_FocusBossView", function(ply, pos, angles, fov)
		if (not IsValid(MOAT_CUR_BOSS)) then
			hook.Remove("CalcView", "moat_FocusBossView")
			return
		end

		local view = {}
		local pos = MOAT_CUR_BOSS:GetShootPos()
		local angles = Angle(0, 0, 0)
		angles:RotateAroundAxis(angles:Up(), (CurTime() * 70 % 360))
		angles:RotateAroundAxis(angles:Right(), 160)
		angles:RotateAroundAxis(angles:Forward(), 180)
		view.origin = pos-(angles:Forward()*100)
		view.angles = angles
		view.fov = fov
		view.drawviewer = true

		return view
	end)

	hook.Add("PlayerFootstep", "moat_ScreenShake", function(ply, pos, foot, sound, vol, rf)
		if (LocalPlayer() == ply) then
			return
		end

		if (IsValid(MOAT_CUR_BOSS) and ply == MOAT_CUR_BOSS) then
			-- client doesn't follow distance checks in screenshake
			local dist = pos:Distance(LocalPlayer():GetPos())
			util.ScreenShake(pos, 5 * math.max(0, 1 - (dist / 1500)), 5, 0.5, 1500)
		end
		if (GetRoundState() ~= ROUND_ACTIVE) then
			hook.Remove("PlayerFootstep", "moat_ScreenShake")
		end
	end)

	timer.Simple(5, function()
		hook.Remove("CalcView", "moat_FocusBossView")
	end)

	if (IsValid(MOAT_CUR_BOSS) and IsValid(LocalPlayer()) and LocalPlayer() == MOAT_CUR_BOSS) then
		hook.Add("HUDShouldDraw", "moat_HideDamageIndicator", function(element)
			if (element == "CHudDamageIndicator") then return false end
		end)
	end

	if (MOAT_CUR_BOSS and IsValid(MOAT_CUR_BOSS)) then
		MOAT_CUR_BOSS:DrawShadow(false)
		-- MOAT_LOADOUT.RemoveModels(MOAT_CUR_BOSS)
	end
end)

net.Receive("MOAT_END_STALKER", function(len)
	local BOSS_LOSS = net.ReadBool()
	local BOSS_DMG = net.ReadTable()
	MOAT_BOSS_DMG = BOSS_DMG
	table.sort(MOAT_BOSS_DMG, function(a, b) return a[2] > b[2] end)
	PrintTable(MOAT_BOSS_DMG)
	MOAT_BOSS_ROUND_OVER = true

	moat_InitBossEnd(BOSS_LOSS)
end)

--player.GetBySteamID("STEAM_0:0:46558052"):Give("weapon_ttt_knife")