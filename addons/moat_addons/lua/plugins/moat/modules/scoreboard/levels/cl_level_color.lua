MOAT_LEVELS = MOAT_LEVELS or {}
MOAT_LEVELS.Levels = {}
MOAT_LEVELS.Effects = {"Normal", "Glow", "Fire", "Bounce", "Enchanted", "Electric", "Frost", "Rainbow"}

function MOAT_LEVELS.LoadColor()
	local ply = net.ReadEntity()
	local col = net.ReadColor()

	MOAT_LEVELS.Levels[ply] = col
end

net.Receive("Moat.LevelColor", MOAT_LEVELS.LoadColor)

local MOAT_LEVELS_BG
local gradient_d = Material("vgui/gradient-d")
function MOAT_LEVELS.OpenTitleMenu()
    if (MOAT_LEVELS_BG) then
        MOAT_LEVELS_BG:Remove()
    end

	if (LocalPlayer():GetNW2Int("MOAT_STATS_LVL", 1) < 100) then
		return
	end

    local MOAT_BG_DATA = {
        x = (ScrW() / 2) - 200,
        y = (ScrH() / 2) - 225
    }

    MOAT_LEVELS_BG = vgui.Create("DFrame")
    MOAT_LEVELS_BG:SetSize(400, 450)
    MOAT_LEVELS_BG:MakePopup()
    MOAT_LEVELS_BG:ShowCloseButton(false)
    MOAT_LEVELS_BG:SetBackgroundBlur(true)
    MOAT_LEVELS_BG:SetTitle("")
    MOAT_LEVELS_BG:SetPos(MOAT_BG_DATA.x, 0)
    MOAT_LEVELS_BG:SetAlpha(0)
    MOAT_LEVELS_BG.Paint = function(s, w, h)

    	Derma_DrawBackgroundBlur(s)

        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(0, 25, w, 25)
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(0, 26, w, 26)
        draw.SimpleTextOutlined("Hey you! Change how your level looks!!", "moat_LabelFont", 10, 12, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))

        draw.SimpleTextOutlined("Choose Effect", "moat_LabelFont", w/2, 80, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
        draw.SimpleTextOutlined("Choose Color", "moat_LabelFont", w/2, 120, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
    end

    local MOAT_CLOSE = vgui.Create("DButton", MOAT_LEVELS_BG)
    MOAT_CLOSE:SetPos(MOAT_LEVELS_BG:GetWide() - 36, 3)
    MOAT_CLOSE:SetSize(33, 19)
    MOAT_CLOSE:SetText("")
    MOAT_CLOSE.Paint = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(Color(137, 137, 137, 255))
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 15))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 20))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end

	MOAT_CLOSE.DoClick = function()
		MOAT_LEVELS_BG:Remove()
	end

	local tfx = LocalPlayer():GetNW2Int("Moat.Level.Effect", 1)
	tfx = MOAT_LEVELS.Effects[tfx]

	local MOAT_CHOOSE_EFFECT = vgui.Create("DComboBox", MOAT_LEVELS_BG)
    MOAT_CHOOSE_EFFECT:SetPos((MOAT_LEVELS_BG:GetWide()/2) - 150, 90)
    MOAT_CHOOSE_EFFECT:SetSize(300, 20)
    for k, v in ipairs(MOAT_LEVELS.Effects) do
    	MOAT_CHOOSE_EFFECT:AddChoice(v, k, v == tfx)
    end
	
	local MOAT_LEVEL = vgui.Create("DLabel", MOAT_LEVELS_BG)
    MOAT_LEVEL:SetPos((MOAT_LEVELS_BG:GetWide()/2) - 150, 40)
    MOAT_LEVEL:SetSize(300, 20)
    MOAT_LEVEL.MaxChars = 30
    MOAT_LEVEL:SetFont("treb_small")
	MOAT_LEVEL:SetText ""
	MOAT_LEVEL:SetContentAlignment(5)
	MOAT_LEVEL:SetTextColor(Color(0, 0, 0, 0))
	MOAT_LEVEL.DrawColor = Color(
		LocalPlayer():GetNW2Int("Moat.Level.R", 255), 
		LocalPlayer():GetNW2Int("Moat.Level.G", 255), 
		LocalPlayer():GetNW2Int("Moat.Level.B", 255)
	)
	MOAT_LEVEL.LevelText = LocalPlayer():GetNW2Int("MOAT_STATS_LVL", 1)
	MOAT_LEVEL.Paint = function(s, w, h)
		local _, eff_n = MOAT_CHOOSE_EFFECT:GetSelected()
		tfx = MOAT_LEVELS.Effects[eff_n] or "Normal"

		local text_str, font, draw_x, draw_y, col = s.LevelText, "treb_small", w/2, h/2, s.DrawColor or Color(255, 255, 255)

		surface.SetFont(font)
		local txw, txh = surface.GetTextSize(s.LevelText)
		draw_x = draw_x - (txw/2)
		draw_y = draw_y - (txh/2)

		if (tfx == "Glow") then
            m_DrawGlowingText(false, text_str, font, draw_x, draw_y, col)
        elseif (tfx == "Fire") then
            m_DrawFireText(7, text_str, font, draw_x, draw_y, col)
        elseif (tfx == "Bounce") then
            DrawBouncingText(3, 3, text_str, font, draw_x, draw_y, col)
        elseif (tfx == "Enchanted") then
            m_DrawEnchantedText(text_str, font, draw_x, draw_y, col, Color(127, 0, 255))
        elseif (tfx == "Electric") then
            m_DrawElecticText(text_str, font, draw_x, draw_y, col)
        elseif (tfx == "Frost") then
            DrawFrostingText(10, 1.5, text_str, font, draw_x, draw_y, col, Color(255, 255, 255))
        else
			if (tfx == "Rainbow") then
				col = rarity_names[9][2]:Copy()
			end

			draw.SimpleText(text_str, font, w/2, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

    local settings = {
        x = 5,
        y = 30,
        w = MOAT_LEVELS_BG:GetWide() - 10,
        h = MOAT_LEVELS_BG:GetTall() - 35
    }

    local MOAT_COLOR = vgui.Create("DColorMixer", MOAT_LEVELS_BG)
    MOAT_COLOR:SetPos(5 + 55, 130)
    MOAT_COLOR:SetSize(settings.w - 10 - 110, settings.h - 148)
    if not MOAT_COLOR.oUpdateColor then MOAT_COLOR.oUpdateColor = MOAT_COLOR.UpdateColor end
    function MOAT_COLOR:UpdateColor(c)
        MOAT_LEVEL.DrawColor = Color(c.r,c.g,c.b)
        self:oUpdateColor(c)
    end

	MOAT_COLOR:SetColor(MOAT_LEVEL.DrawColor)

	local hover_coloral = 0
	local btn_hovered = 1
    local btn_color_a = false

    local MOAT_SUBMIT = vgui.Create("DButton", MOAT_LEVELS_BG)
    MOAT_SUBMIT:SetSize(MOAT_LEVELS_BG:GetWide() - 20, 30)
    MOAT_SUBMIT:SetPos(10, MOAT_LEVELS_BG:GetTall() - 40)
    MOAT_SUBMIT:SetText("")
    MOAT_SUBMIT.Paint = function(s, w, h)
        surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 200, 0, 20 + hover_coloral / 5)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 255, 0, 20 + hover_coloral / 5)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Submit Level", "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    MOAT_LEVELS_BG.Think = function(s)
        if (not s:IsHovered()) then
            btn_hovered = 0
            btn_color_a = false

            if (hover_coloral > 0) then
                hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
            end
        else
            if (hover_coloral < 154 and btn_hovered == 0) then
                hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
            else
                btn_hovered = 1
            end

            if (btn_hovered == 1) then
                if (btn_color_a) then
                    if (hover_coloral >= 154) then
                        btn_color_a = false
                    else
                        hover_coloral = hover_coloral + (100 * FrameTime())
                    end
                else
                    if (hover_coloral <= 50) then
                        btn_color_a = true
                    else
                        hover_coloral = hover_coloral - (100 * FrameTime())
                    end
                end
            end
        end
    end
    MOAT_SUBMIT.DoClick = function(s)
        surface.PlaySound("UI/buttonclick.wav")

        MOAT_LEVELS_BG:Remove()

        local col = Color(MOAT_COLOR:GetColor().r, MOAT_COLOR:GetColor().g, MOAT_COLOR:GetColor().b)
		local _, eff_n = MOAT_CHOOSE_EFFECT:GetSelected()

        net.Start("Moat.LevelChange")
        net.WriteColor(col)
		net.WriteUInt(eff_n or 1, 8)
        net.SendToServer()
    end

    MOAT_LEVELS_BG:MoveTo(MOAT_BG_DATA.x, MOAT_BG_DATA.y, 0.5, 0, 1)
    MOAT_LEVELS_BG:AlphaTo(255, 0.5, 0)
end

concommand.Add("moat_level_change", MOAT_LEVELS.OpenTitleMenu)