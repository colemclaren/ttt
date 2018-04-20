MOAT_TITLES = MOAT_TITLES or {}
MOAT_TITLES.Titles = {}

function MOAT_TITLES.ChatPrint()
	local failure = net.ReadBool()
	local str = net.ReadString()
	local col = Color(0, 255, 0)

	if (failure) then
		col = Color(255, 0, 0)
	end

	chat.AddText(Material("icon16/information.png"), col, str)
end

net.Receive("MoatTitleChatPrint", MOAT_TITLES.ChatPrint)

function MOAT_TITLES.LoadTitle()
	local ply = net.ReadEntity()
	local str = net.ReadString()
	local col = net.ReadColor()
	local changer = net.ReadString()

	MOAT_TITLES.Titles[ply] = {str, col, changer}
end

net.Receive("MoatLoadTitle", MOAT_TITLES.LoadTitle)

local MOAT_TITLES_BG

function MOAT_TITLES.OpenTitleMenu()
    if (MOAT_TITLES_BG) then
        MOAT_TITLES_BG:Remove()
    end

    local MOAT_BG_DATA = {
        x = (ScrW() / 2) - 200,
        y = (ScrH() / 2) - 225
    }

    MOAT_TITLES_BG = vgui.Create("DFrame")
    MOAT_TITLES_BG:SetSize(400, 450)
    MOAT_TITLES_BG:MakePopup()
    MOAT_TITLES_BG:ShowCloseButton(false)
    MOAT_TITLES_BG:SetBackgroundBlur(true)
    MOAT_TITLES_BG:SetDraggable(false)
    MOAT_TITLES_BG:SetTitle("")
    MOAT_TITLES_BG:SetPos(MOAT_BG_DATA.x, 0)
    MOAT_TITLES_BG:SetAlpha(0)
    MOAT_TITLES_BG.Paint = function(s, w, h)

    	Derma_DrawBackgroundBlur(s)

        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(0, 25, w, 25)
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(0, 26, w, 26)
        draw.SimpleTextOutlined("Title Change Menu - By Moat", "moat_LabelFont", 10, 12, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))

        draw.SimpleTextOutlined("Choose Player:", "moat_LabelFont", w/2, 40, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
        draw.SimpleTextOutlined("Write Title: (30 Character Limit, Insults = Week Ban)", "moat_LabelFont", w/2, 80, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
        draw.SimpleTextOutlined("Choose Color:", "moat_LabelFont", w/2, 120, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
    end

    local MOAT_CLOSE = vgui.Create("DButton", MOAT_TITLES_BG)
    MOAT_CLOSE:SetPos(MOAT_TITLES_BG:GetWide() - 36, 3)
    MOAT_CLOSE:SetSize(33, 19)
    MOAT_CLOSE:SetText("")
    MOAT_CLOSE.Paint = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(Color(137, 137, 137, 255))
        surface.SetMaterial(Material("vgui/gradient-d"))
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
        MOAT_TITLES_BG:MoveTo(MOAT_BG_DATA.x, ScrH() - 450, 0.5, 0, 1)
        MOAT_TITLES_BG:AlphaTo(0, 0.5, 0)

        timer.Simple(0.5, function()
            if (IsValid(MOAT_TITLES_BG)) then
                MOAT_TITLES_BG:Remove()
            end
        end)
    end

    local MOAT_CHOOSE_PLAYER = vgui.Create("DComboBox", MOAT_TITLES_BG)
    MOAT_CHOOSE_PLAYER:SetPos((MOAT_TITLES_BG:GetWide()/2) - 150, 50)
    MOAT_CHOOSE_PLAYER:SetSize(300, 20)
    for k, v in pairs(player.GetAll()) do
    	if (v == LocalPlayer()) then continue end
    	MOAT_CHOOSE_PLAYER:AddChoice(v:Nick(), v:SteamID64(), true)
    end

    local MOAT_WRITE_TITLE = vgui.Create("DTextEntry", MOAT_TITLES_BG)
    MOAT_WRITE_TITLE:SetPos((MOAT_TITLES_BG:GetWide()/2) - 150, 90)
    MOAT_WRITE_TITLE:SetSize(300, 20)
    MOAT_WRITE_TITLE.MaxChars = 30
    MOAT_WRITE_TITLE.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.sub(tostring(txt), #txt, #txt) == "#") then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end

    local settings = {
        x = 5,
        y = 30,
        w = MOAT_TITLES_BG:GetWide() - 10,
        h = MOAT_TITLES_BG:GetTall() - 35
    }

    local MOAT_COLOR = vgui.Create("DColorMixer", MOAT_TITLES_BG)
    MOAT_COLOR:SetPos(5 + 55, 130)
    MOAT_COLOR:SetSize(settings.w - 10 - 110, settings.h - 148)

	local hover_coloral = 0
	local btn_hovered = 1
    local btn_color_a = false

    local MOAT_SUBMIT = vgui.Create("DButton", MOAT_TITLES_BG)
    MOAT_SUBMIT:SetSize(MOAT_TITLES_BG:GetWide() - 20, 30)
    MOAT_SUBMIT:SetPos(10, MOAT_TITLES_BG:GetTall() - 40)
    MOAT_SUBMIT:SetText("")
    MOAT_SUBMIT.Paint = function(s, w, h)
        surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 200, 0, 20 + hover_coloral / 5)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 255, 0, 20 + hover_coloral / 5)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Submit Title Change (Costs 50,000 IC)", "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    MOAT_SUBMIT.Think = function(s)
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

    	MOAT_TITLES_BG:Remove()

    	local _, id = MOAT_CHOOSE_PLAYER:GetSelected()
    	local text = MOAT_WRITE_TITLE:GetText() or ""
    	local col = Color(MOAT_COLOR:GetColor().r, MOAT_COLOR:GetColor().g, MOAT_COLOR:GetColor().b)

    	net.Start("MoatTitlesChange")
		net.WriteString(id or LocalPlayer():SteamID64())
		net.WriteString(text:Trim())
		net.WriteColor(col)
		net.SendToServer()
    end

    MOAT_TITLES_BG:MoveTo(MOAT_BG_DATA.x, MOAT_BG_DATA.y, 0.5, 0, 1)
    MOAT_TITLES_BG:AlphaTo(255, 0.5, 0)
end

function MOAT_TITLES.OpenSelfTitleMenu()
    if (MOAT_TITLES_BG) then
        MOAT_TITLES_BG:Remove()
    end

    local MOAT_BG_DATA = {
        x = (ScrW() / 2) - 200,
        y = (ScrH() / 2) - 225
    }

    MOAT_TITLES_BG = vgui.Create("DFrame")
    MOAT_TITLES_BG:SetSize(400, 450)
    MOAT_TITLES_BG:MakePopup()
    MOAT_TITLES_BG:SetBackgroundBlur(true)
    MOAT_TITLES_BG:ShowCloseButton(false)
    MOAT_TITLES_BG:SetDraggable(false)
    MOAT_TITLES_BG:SetTitle("")
    MOAT_TITLES_BG:SetPos(MOAT_BG_DATA.x, 0)
    MOAT_TITLES_BG:SetAlpha(0)
    MOAT_TITLES_BG.Paint = function(s, w, h)

    	Derma_DrawBackgroundBlur(s)

        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(0, 25, w, 25)
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(0, 26, w, 26)
        draw.SimpleTextOutlined("Title Change Menu - By Moat", "moat_LabelFont", 10, 12, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))

        draw.SimpleTextOutlined("You're changing your own title!", "moat_LabelFont", w/2, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
        draw.SimpleTextOutlined("Write Title: (30 Character Limit)", "moat_LabelFont", w/2, 80, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
        draw.SimpleTextOutlined("Choose Color:", "moat_LabelFont", w/2, 120, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
    end

    local MOAT_CLOSE = vgui.Create("DButton", MOAT_TITLES_BG)
    MOAT_CLOSE:SetPos(MOAT_TITLES_BG:GetWide() - 36, 3)
    MOAT_CLOSE:SetSize(33, 19)
    MOAT_CLOSE:SetText("")
    MOAT_CLOSE.Paint = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(Color(137, 137, 137, 255))
        surface.SetMaterial(Material("vgui/gradient-d"))
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
        MOAT_TITLES_BG:MoveTo(MOAT_BG_DATA.x, ScrH() - 450, 0.5, 0, 1)
        MOAT_TITLES_BG:AlphaTo(0, 0.5, 0)

        timer.Simple(0.5, function()
            if (IsValid(MOAT_TITLES_BG)) then
                MOAT_TITLES_BG:Remove()
            end
        end)
    end

    local MOAT_WRITE_TITLE = vgui.Create("DTextEntry", MOAT_TITLES_BG)
    MOAT_WRITE_TITLE:SetPos((MOAT_TITLES_BG:GetWide()/2) - 150, 90)
    MOAT_WRITE_TITLE:SetSize(300, 20)
    MOAT_WRITE_TITLE.MaxChars = 30
    MOAT_WRITE_TITLE.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.sub(tostring(txt), #txt, #txt) == "#") then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end

    local settings = {
        x = 5,
        y = 30,
        w = MOAT_TITLES_BG:GetWide() - 10,
        h = MOAT_TITLES_BG:GetTall() - 35
    }

    local MOAT_COLOR = vgui.Create("DColorMixer", MOAT_TITLES_BG)
    MOAT_COLOR:SetPos(5 + 55, 130)
    MOAT_COLOR:SetSize(settings.w - 10 - 110, settings.h - 148)

	local hover_coloral = 0
	local btn_hovered = 1
    local btn_color_a = false

    local MOAT_SUBMIT = vgui.Create("DButton", MOAT_TITLES_BG)
    MOAT_SUBMIT:SetSize(MOAT_TITLES_BG:GetWide() - 20, 30)
    MOAT_SUBMIT:SetPos(10, MOAT_TITLES_BG:GetTall() - 40)
    MOAT_SUBMIT:SetText("")
    MOAT_SUBMIT.Paint = function(s, w, h)
        surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 200, 0, 20 + hover_coloral / 5)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 255, 0, 20 + hover_coloral / 5)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Submit Title Change (Costs 15,000 IC)", "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    MOAT_SUBMIT.Think = function(s)
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

    	MOAT_TITLES_BG:Remove()

    	local id = LocalPlayer():SteamID64()
    	local text = MOAT_WRITE_TITLE:GetText() or ""
    	local col = Color(MOAT_COLOR:GetColor().r, MOAT_COLOR:GetColor().g, MOAT_COLOR:GetColor().b)

    	net.Start("MoatTitlesChange")
		net.WriteString(id or LocalPlayer():SteamID64())
		net.WriteString(text:Trim())
		net.WriteColor(col)
		net.SendToServer()
    end

    MOAT_TITLES_BG:MoveTo(MOAT_BG_DATA.x, MOAT_BG_DATA.y, 0.5, 0, 1)
    MOAT_TITLES_BG:AlphaTo(255, 0.5, 0)
end

concommand.Add("moat_titles", function(ply, cmd, args)
	MOAT_TITLES.OpenTitleMenu()
end)

concommand.Add("moat_selftitles", function(ply, cmd, args)
	MOAT_TITLES.OpenSelfTitleMenu()
end)

-- TTS By Velkon (autorefresh)
local MOAT_TTS_BG

local price = 100

function MOAT_TTSMENU()
    if (MOAT_TTS_BG) then
        MOAT_TTS_BG:Remove()
    end

    local MOAT_BG_DATA = {
        x = (ScrW() / 2) - 200,
        y = (ScrH() / 2) - 84.5
    }

    MOAT_TTS_BG = vgui.Create("DFrame")
    MOAT_TTS_BG:SetSize(400, 169)
    MOAT_TTS_BG:MakePopup()
    MOAT_TTS_BG:SetBackgroundBlur(true)
    MOAT_TTS_BG:ShowCloseButton(false)
    MOAT_TTS_BG:SetDraggable(false)
    MOAT_TTS_BG:SetTitle("")
    MOAT_TTS_BG:SetPos(MOAT_BG_DATA.x, 0)
    MOAT_TTS_BG:SetAlpha(0)
    MOAT_TTS_BG.Paint = function(s, w, h)

    	Derma_DrawBackgroundBlur(s)

        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(0, 25, w, 25)
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(0, 26, w, 26)
        draw.SimpleTextOutlined("Send a TTS message.", "moat_LabelFont", 10, 12, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))

        draw.SimpleTextOutlined("Send a TTS message to everyone", "moat_LabelFont", w/2, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
        draw.SimpleTextOutlined("(Unless you're dead, which is only sent to dead people)", "moat_LabelFont", w/2, 65, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
        
        draw.SimpleTextOutlined("Write a message: (" .. price .. " IC per character)", "moat_LabelFont", w/2, 80, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
    end

    local MOAT_CLOSE = vgui.Create("DButton", MOAT_TTS_BG)
    MOAT_CLOSE:SetPos(MOAT_TTS_BG:GetWide() - 36, 3)
    MOAT_CLOSE:SetSize(33, 19)
    MOAT_CLOSE:SetText("")
    MOAT_CLOSE.Paint = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(Color(137, 137, 137, 255))
        surface.SetMaterial(Material("vgui/gradient-d"))
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
        MOAT_TTS_BG:MoveTo(MOAT_BG_DATA.x, ScrH() - 450, 0.5, 0, 1)
        MOAT_TTS_BG:AlphaTo(0, 0.5, 0)

        timer.Simple(0.5, function()
            if (IsValid(MOAT_TTS_BG)) then
                MOAT_TTS_BG:Remove()
            end
        end)
    end

    local MOAT_WRITE_TITLE = vgui.Create("DTextEntry", MOAT_TTS_BG)
    MOAT_WRITE_TITLE:SetPos((MOAT_TTS_BG:GetWide()/2) - 175, 90)
    MOAT_WRITE_TITLE:SetSize(350, 20)

    local settings = {
        x = 5,
        y = 30,
        w = MOAT_TTS_BG:GetWide() - 10,
        h = MOAT_TTS_BG:GetTall() - 35
    }

	local hover_coloral = 0
	local btn_hovered = 1
    local btn_color_a = false

    local MOAT_SUBMIT = vgui.Create("DButton", MOAT_TTS_BG)
    MOAT_SUBMIT:SetSize(MOAT_TTS_BG:GetWide() - 20, 30)
    MOAT_SUBMIT:SetPos(10, MOAT_TTS_BG:GetTall() - 40)
    MOAT_SUBMIT:SetText("")
    MOAT_SUBMIT.Paint = function(s, w, h)
        surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 200, 0, 20 + hover_coloral / 5)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 255, 0, 20 + hover_coloral / 5)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        local s = MOAT_WRITE_TITLE:GetText()
        m_DrawShadowedText(1, "Send Message (Costs " .. string.Comma(#s * price) .. " IC)", "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    MOAT_SUBMIT.Think = function(s)
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
        local text = MOAT_WRITE_TITLE:GetText()

        if #text < 1 then return end
    	MOAT_TTS_BG:Remove()

    	net.Start("Moat.TTS")
		net.WriteString(text:Trim())
		net.SendToServer()
    end

    MOAT_TTS_BG:MoveTo(MOAT_BG_DATA.x, MOAT_BG_DATA.y, 0.5, 0, 1)
    MOAT_TTS_BG:AlphaTo(255, 0.5, 0)
end

concommand.Add("moat_ttsmenu", function(ply, cmd, args)
	MOAT_TTSMENU()
end)
/*http.Fetch("https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=Hey%20there%20buddy&tl=en",function(a,b,c,d) print(d) end,function(e)
    print(e)
end)*/
net.Receive("Moat.TTS",function()
    local a = net.ReadString()
    sound.oPlayURL("https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=en&q=" .. a ,"mono",function(s)
        if not IsValid(s) then return end
        if (GetConVar("moat_text_to_speech"):GetBool()) then
            s:SetVolume(1)
            s:Play()
        else
            s:Stop()
        end
    end)
end)


-- begin discordrpc here cause why not







--





--

--

--
--







-- Credits to SpiralP and Tenrys
-- Edited by velkon
-- Fail message: Not authenticated or invalid scope

discordrpc = discordrpc or {}
discordrpc.enabled = true
discordrpc.debug = false
discordrpc.port = discordrpc.port

discordrpc.states = discordrpc.states or {}
discordrpc.state = discordrpc.state


function discordrpc.Print(...)
	local header = "[Discord RPC%s] "
	local args = {...}
	if type(args[1]) ~= "string" then
		if not discordrpc.debug then return end -- we are entering debug message land, don't show them if we don't want them to
		header = header:format(" DEBUG")
	else
		header = header:format("")
	end

	MsgC(Color(114, 137, 218), header)
	for k, v in next, args do
		if istable(v) then
			args[k] = table.ToString(v)
		end
	end
	print(unpack(args))
end

function discordrpc.Init(callback)
    print("init",discordrpc.port)
	if not discordrpc.port then
		local validPort
		for port = 6463, 6473 do
			local success = function(body)
				if body:match("Authorization Required") and not validPort then
					discordrpc.Print(("Connection success on port %s! "):format(port))
					validPort = port
					discordrpc.port = validPort

					discordrpc.SetActivity({ details = GetHostName(), state = game.GetIPAddress() }, function(body, err)
						if body == false then
							discordrpc.Print("First SetActivity test was unsuccessful, error: " .. err)
							if err:match("Not authenticated or invalid scope") then
								discordrpc.Print("Make sure you're using Discord Canary!")
							end
						else
							discordrpc.Print("First SetActivity test was successful, should be ready to work!")
						end
						discordrpc.Print(body, err)

						if callback then -- idk if we should cancel calling the call back if we error
							callback(body, err)
						end
					end)
				end
			end
			local failed = function(...)
				-- do nothing
			end
			http.Fetch(("http://127.0.0.1:%s"):format(port), success, failed)
		end
	else
        callback(true,nil)
    end
end
function discordrpc.SetActivity(activity, callback)
	if not discordrpc.enabled then return end

	if not discordrpc.port then
		ErrorNoHalt("DiscordRPC: port unset, did you Init?")
		return
	end

	HTTP{
		method = "POST",
		url = ("http://127.0.0.1:%s/rpc?v=1&client_id=%s"):format(discordrpc.port, discordrpc.clientID),

		type = "application/json",
		body = util.TableToJSON{
			cmd = "SET_ACTIVITY",
			args = {
				pid = math.random(11, 32768), -- This doesn't really matter though it would be nice if we could get GMod's process ID in Lua
				activity = activity
			},
			nonce = tostring(SysTime())
		},

		success = function(status, body)
			if not callback then return end

			local data = util.JSONToTable(body)
			if not data or data.evt == "ERROR" then
				callback(false, "Discord error: " .. tostring(data.data and data.data.message or "nil"))
			else
				callback(data)
			end
		end,
		failed = function(err)
			if not callback then return end

			callback(false, "HTTP error: " .. err)
		end,
	}
end
local defaultActivity = {
	details = "???",
	state = "Default state"
}
local start = os.time()
local ServerName = false

function discordrpc.GetActivity()
    if not ServerName then
        local s = ""
        if GetHostName():lower():match("ttc") then
            s = s .. "TTC"
        else
            s = s .. "TTT"
        end
        if GetHostName():lower():match("west") then
            s = s .. " West"
        elseif GetHostName():lower():match("eu") then
            s = s .. " EU"
        elseif GetHostName():lower():match("minecraft") then
            s = s .. " MC"
        end
        for i = 1,12 do
            if GetHostName():lower():match("%#" .. i) then
                s = s .. " #" .. i
            end
        end
        if (s == "TTT") or (s == "TTC") then s = s .. " Dev" end
        ServerName = s
    end

    local round = "Active Round"
    local r = GetRoundState()
    if r == ROUND_POST then round = "Ending Round" end
    if r == ROUND_PREP then round = "Preparing Round" end

	local activity = {}
        activity = {
            details = #player.GetAll()  .. "/" .. game.MaxPlayers() .. " Players | " .. math.max(0, GetGlobalInt("ttt_rounds_left", 6)) .. " Rounds Left | " .. round,
            state = ServerName ..  " | " .. game.GetMap() .. " | " .. game.GetIPAddress() .. "",
            timestamps = {
               -- start = start,
                ["end"] = os.time() + math.ceil(GetGlobalFloat("ttt_round_end", 0) - CurTime()) -- nothing?
            },
            assets = {
                large_image = "logo",
                large_text = "http://moat.gg/",
                small_image = "gmod",
                small_text = "Garry's Mod"
            }
            -- Other fields available that we can't use (atleast I don't think so): party, secrets, instance, application_id, flags
        }

	return activity
end


discordrpc.clientID = "430843529510649897" 
discordrpc.BotclientID = "432286257532633099"
discordrpc.state = "" 

http.Loaded = http.Loaded and http.Loaded or false
if http.Loaded then hook.Run("HTTPLoaded") end
local function checkHTTP()
	http.Fetch("http://google.com", function()
		http.Loaded = true
	end, function()
		http.Loaded = true
	end)
end
if not http.Loaded then
	timer.Create("HTTPLoadedCheck", 3, 0, function()
		if not http.Loaded then
			checkHTTP()
		else
			hook.Run("HTTPLoaded")
			timer.Remove("HTTPLoadedCheck")
		end
	end)
end

function discordrpc.Auth()
    HTTP({
        method = "POST",
        url = ("http://127.0.0.1:%s/rpc?v=1&client_id=%s"):format(discordrpc.port, discordrpc.BotclientID),

        type = "application/json",
        body = util.TableToJSON{
            cmd = "AUTHORIZE",
            args = {
                client_id = discordrpc.BotclientID,
                scopes = {
                    "identify",
                    "guilds.join"
                }
            },
            nonce = tostring(SysTime())
        },

        success = function(status, body)
            body = util.JSONToTable(body)
            PrintTable(body)
            if body.data.code == 5000 then print("User declined request") return end
            discordrpc.OAuth = body.data.code
            print("Got OAuth Code: " .. discordrpc.OAuth)
            net.Start("discord.OAuth")
            net.WriteString(discordrpc.OAuth)
            net.SendToServer()         
        end,
        failed = function(err)
            print(err)
        end,
    })
end

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
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


local function make_discord()
    dis_panel = vgui.Create("DFrame")
    dis_panel:SetSize(500,240)
    dis_panel:MakePopup()
    dis_panel:Center()
    dis_panel:SetTitle("Join our discord!")
    function dis_panel:Paint(w,h)
        surface.SetDrawColor(21, 28, 35, 150)
        surface.DrawRect(0, 0, w, h)

        DrawBlur(self, 3)
    end

    local lbl = vgui.Create("DLabel", dis_panel)
	lbl:SetPos(10, 30)
	lbl:SetText("We've noticed that you have Discord!\n\nWould you like to join our Discord for a free 3,000 Inventory Credits?")
	lbl:SetWide(dis_panel:GetWide() - 20)
	lbl:SetWrap(true)
	lbl:SetAutoStretchVertical(true)
	lbl:SetTextColor(Color(255, 255, 255))
	lbl:SetFont("DermaLarge")

    local yes = vgui.Create("DButton",dis_panel)
    yes:SetWide(dis_panel:GetWide() - 20)
    yes:SetTall(50)
    yes:SetPos(10,175)
    yes:SetText("YES!")
    yes:SetFont("DermaLarge")
    function yes.DoClick()
        dis_panel:Close() 
        Derma_Message("Please click 'Authorize' in your Discord client and enjoy the free IC!","Last step for Discord","Done!")
        timer.Simple(0.5,function()
            discordrpc.Auth()
        end)
    end
end
concommand.Add("discord_popup",make_discord)

net.Receive("discord.OAuth",function()
    local p = net.ReadEntity()
    if p == LocalPlayer() then
        cookie.Set("MG_Discord",1)
    end
    chat.AddText(Color(255,255,255),"[",Color(75,0,130),"DISCORD",Color(255,255,255),"] ",Color(0,255,0),p:Nick(),Color(255,255,255)," Just joined our discord and got ",Color(255,255,0),"3,000 IC!!!")
end)

hook.Add("HTTPLoaded", "discordrpc_init", function()
    if (GetHostName():lower():find("dev")) then return end

	discordrpc.Init(function(succ, err)
		if succ then
            print("Discord RPC Loaded")
            timer.Simple(10,function()
                if cookie.GetNumber("MG_Discord", 0) ~= 1 then
                    net.Receive("AmIDiscord",function()
                        local d = net.ReadBool()
                        if d then
                            cookie.Set("MG_Discord",1)
                        else
                            make_discord()
                        end
                    end)
                    net.Start("AmIDiscord")
                    net.SendToServer()
                end
            end)
			discordrpc.SetActivity(discordrpc.GetActivity(), print)
            hook.Add("ShutDown","Discord",function()
                HTTP{
                    method = "POST",
                    url = ("http://127.0.0.1:%s/rpc?v=1&client_id=%s"):format(discordrpc.port, discordrpc.clientID),

                    type = "application/json",
                    body = util.TableToJSON{
                        cmd = "SET_ACTIVITY",
                        args = {
                        },
                        nonce = tostring(SysTime())
                    },

                    success = function(status, body)
                    end,
                    failed = function(err)
                    end,
                }          
            end)
            timer.Create("discordrpc", 20, 0, function()
                discordrpc.SetActivity(discordrpc.GetActivity(), discordrpc.Print)
            end)
		end
	end)
end)
