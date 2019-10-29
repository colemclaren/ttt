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
local MAX_LIVES = 3

local LIVES_LEFT

MOAT_ACTIVE_BOSS = false
local MOAT_NEXT_SPAWN = 0
local boss_health_width = 0

local blur = Material "pp/blurscreen"

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

local function DrawRespawn()
	if (MOAT_CUR_BOSS == LocalPlayer() or LIVES_LEFT == 0 or GetRoundState() ~= ROUND_ACTIVE or MOAT_BOSS_ROUND_OVER or not IsValid(MOAT_CUR_BOSS)) then
		hook.Remove("HUDPaint", "moat_DrawRespawn")
		hook.Remove("HUDShouldDraw", "moat_HideDamageIndicator")
		return
	end

	local x = ScrW() / 2
    local y = 80

    local font = "TimeLeft"

	draw.SimpleTextOutlined(string.format("Next respawn in %.01f seconds", math.max(0, MOAT_NEXT_SPAWN - CurTime())), font,
		x, y, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
	draw.SimpleTextOutlined("Lives left: "..LIVES_LEFT, font, x, y + 50, Color(255, 255, 255, 255),
		TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    m_DrawShadowedText(1, "Team up and steal the baskets!", "moat_ItemDesc", ScrW() / 2, 30, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER)
end

local function moat_InitDrawBossHealth()
	hook.Add("HUDPaint", "moat_DrawRespawn", DrawRespawn)
end

local moat_BossWarningLabel = "INCOMING BUNNY ROUND!!!"
local moat_BossDirections = {"Team up with other players", "to defeat the boss and receive", "a prize only if you steal them!"}

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
		textw, texth = surface.GetTextSize(v)
		m_DrawShadowedText(1, v, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*k), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end

local function moat_PrepareBoss()
	MOAT_BOSS_ROUND_OVER = false
	MOAT_ACTIVE_BOSS = true

	hook.Add("HUDPaint", "moat_PrepareBoss", moat_DrawBossWarning)
	hook.Add("TTTBeginRound", "moat_StartBoss", moat_InitDrawBossHealth)
end

local END_ROUND_WIN = "PLAYERS ARE VICTORIOUS!!!"
local END_ROUND_LOSS = "THE BUNNY IS VICTORIOUS!!!"
local cols = {Color(0, 255, 0), Color(100, 255, 100), Color(100, 255, 100)}

local function moat_DrawBossEnd(MOAT_BOSS_LOSS)
	if (GetRoundState() ~= ROUND_ACTIVE) then
		hook.Remove("HUDPaint", "moat_DrawBossEnd")
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

	m_DrawEnchantedText(text, "moat_BossWarning", (ScrW() / 2) - (textw / 2), 100, textc, textc2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW() / 2) - (textw / 2), 100 + texth + 15, textw, 10, Color(255, 255, 255, 255 * size_change))
	draw.RoundedBox(0, (ScrW() / 2) - (textw / 2), 100 - 25, textw, 10, Color(255, 255, 255, 255 * size_change))
end

local function moat_InitBossEnd(BOSS_LOSS)
	hook.Add("HUDPaint", "moat_DrawBossEnd", function()
		moat_DrawBossEnd(BOSS_LOSS)
	end)
	hook.Remove("TTTBeginRound", "moat_StartBoss")
	hook.Remove("HUDShouldDraw", "moat_HideDamageIndicator")
	MOAT_ACTIVE_BOSS = false
end

net.Receive("MOAT_PREP_BUNNY", function(len)
	moat_PrepareBoss()
end)

net.Receive("MOAT_BEGIN_BUNNY", function(len)
	local ply = net.ReadEntity()
	MOAT_CUR_BOSS = ply

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

	timer.Simple(5, function()
		hook.Remove("CalcView", "moat_FocusBossView")
	end)

	if (IsValid(MOAT_CUR_BOSS) and IsValid(LocalPlayer()) and LocalPlayer() == MOAT_CUR_BOSS) then
		hook.Add("HUDShouldDraw", "moat_HideDamageIndicator", function(element)
			if (element == "CHudDamageIndicator") then return false end
		end)
	end
end)

net.Receive("MOAT_END_BUNNY", function(len)
	local BOSS_LOSS = net.ReadBool()
	MOAT_BOSS_ROUND_OVER = true

	moat_InitBossEnd(BOSS_LOSS)

	if (not BOSS_LOSS and MOAT_CUR_BOSS == LocalPlayer()) then
		-- m_ClearInventory()
		-- net.Start("MOAT_SEND_INV_ITEM")
		-- net.SendToServer()
	end
end)

net.Receive("MOAT_BUNNY_SPAWNS", function()
	MOAT_NEXT_SPAWN = net.ReadFloat()
end)

net.Receive("MOAT_BUNNY_LIVES", function()
	LIVES_LEFT = net.ReadUInt(8)
end)