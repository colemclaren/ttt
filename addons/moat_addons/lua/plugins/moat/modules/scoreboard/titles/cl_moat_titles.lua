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
local gradient_d = Material("vgui/gradient-d")
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
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
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
    MOAT_WRITE_TITLE:SetFont("Default")
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
    if not MOAT_COLOR.oUpdateColor then MOAT_COLOR.oUpdateColor = MOAT_COLOR.UpdateColor end
    function MOAT_COLOR:UpdateColor(c)
        MOAT_WRITE_TITLE:SetTextColor(Color(c.r,c.g,c.b))
        self:oUpdateColor(c)
    end
    MOAT_WRITE_TITLE:SetTextColor(MOAT_COLOR:GetColor())

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
        surface.SetMaterial(gradient_d)
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
        Derma_Query("Are you sure you want to purchase a title for 50,000 IC?", "Are you sure?", "Yes", function()
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
        end,"Nevermind")
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
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
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
    MOAT_WRITE_TITLE:SetFont("Default")
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
    if not MOAT_COLOR.oUpdateColor then MOAT_COLOR.oUpdateColor = MOAT_COLOR.UpdateColor end
    function MOAT_COLOR:UpdateColor(c)
        MOAT_WRITE_TITLE:SetTextColor(Color(c.r,c.g,c.b))
        self:oUpdateColor(c)
    end
    MOAT_WRITE_TITLE:SetTextColor(MOAT_COLOR:GetColor())

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
        surface.SetMaterial(gradient_d)
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
        Derma_Query("Are you sure you want to purchase a title for 15,000 IC?", "Are you sure?", "Yes", function()
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
        end, "Nevermind")
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
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
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
        surface.SetMaterial(gradient_d)
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

/*
    Profile cards
*/

surface.CreateFont("profile.name", {
    font = "DermaLarge",
    italic = true,
    size = 40,
    shadow = true
})

surface.CreateFont("profile.steamid", {
    font = "DermaLarge",
    italic = false,
    size = 20,
    shadow = true
})


local function GetScoreboardGroup(info)
	local r, id = info.rank, info.steamid
	if (id and OPERATION_LEADS[id]) then r = "operationslead" end
	if (id and TECH_LEADS[id]) then r = "techlead" end

	return MOAT_RANKS[r] or MOAT_RANKS["user"]
end

function populate_profile_card(MOAT_PROFILE,info)
    local profile = vgui.Create("AvatarImage",MOAT_PROFILE)
    profile:SetSize(128,128)
    profile:SetPos(5,30)
    profile:SetSteamID(info.steamid,128)
    local rank = GetScoreboardGroup(info)
    -- Name
    local name = vgui.Create("DButton",MOAT_PROFILE)
    name:SetPos(138,30)
    name:SetSize(355,40)
    name:SetText("")
    name.info = info.name
    function name:Paint(w,h)
        draw.DrawText(name.info,"profile.name",w/2,0,rank[2],TEXT_ALIGN_CENTER)
    end
    function name:DoClick()
        SetClipboardText(self.info)
        self.info = "Copied to clipboard!"
        timer.Simple(0.5,function()
            self.info = info.name
        end)
    end

    -- SteamID
    local name = vgui.Create("DButton",MOAT_PROFILE)
    name:SetPos(138,75)
    name:SetSize(200,30)
    name:SetText("")
    name.info = util.SteamIDFrom64(info.steamid)
    function name:Paint(w,h)
        draw.DrawText(name.info,"profile.steamid",6,0,Color(255,255,255))
    end
    function name:DoClick()
        SetClipboardText(self.info)
        self.info = "Copied to clipboard!"
        timer.Simple(0.5,function()
            self.info = util.SteamIDFrom64(info.steamid)
        end)
    end

    -- Rank
    local name = vgui.Create("DButton",MOAT_PROFILE)
    name:SetPos(338,75)
    name:SetSize(155,30)
    name:SetText("")
    name.info = rank[1]
    function name:Paint(w,h)
        draw.DrawText(self.info,"profile.steamid",w,0,rank[2],TEXT_ALIGN_RIGHT)
    end
    function name:DoClick()
        SetClipboardText(self.info)
        self.info = "Copied to clipboard!"
        timer.Simple(0.5,function()
            self.info = rank[1]
        end)
    end

    -- IC
    local name = vgui.Create("DButton",MOAT_PROFILE)
    name:SetPos(138,105)
    name:SetSize(200,30)
    name:SetText("")
    name.info = string.Comma(info.ic)
    function name:Paint(w,h)
        draw.DrawText(name.info,"profile.steamid",6,0,Color(255,255,255))
        local tw = surface.GetTextSize(name.info)
        if self.copying then return end
        draw.DrawText("IC","profile.steamid",tw + 12,0,Color(255,255,0))
    end
    function name:DoClick()
        SetClipboardText(self.info)
        self.info = "Copied to clipboard!"
        self.copying = true
        timer.Simple(0.5,function()
            self.copying = false
            self.info = string.Comma(info.ic)
        end)
    end

    -- Playtime
    local name = vgui.Create("DButton",MOAT_PROFILE)
    name:SetPos(328,105)
    name:SetSize(165,30)
    name:SetText("")
    name.info = D3A.FormatTimeSingle(info.playtime)
    function name:Paint(w,h)
        -- draw.DrawText(name.info,"profile.steamid",6,0,Color(255,255,255))
        -- local tw = surface.GetTextSize(name.info)
        -- if self.copying then return end
        -- draw.DrawText("IC","profile.steamid",tw + 12,0,Color(255,255,0))
        if not self.copying then
            draw.DrawText("of playtime","profile.steamid",w,0,Color(0,255,255,100),TEXT_ALIGN_RIGHT)
        end
        local tw = surface.GetTextSize("of playtime")
        if self.copying then tw = -6 end
        draw.DrawText(name.info,"profile.steamid",w - (tw + 6),0,Color(255,255,255),TEXT_ALIGN_RIGHT)
    end
    function name:DoClick()
        SetClipboardText(self.info)
        self.info = "Copied to clipboard!"
        self.copying = true
        timer.Simple(0.5,function()
            self.copying = false
            self.info = D3A.FormatTimeSingle(info.playtime)
        end)
    end

    -- last online
    local name = vgui.Create("DButton",MOAT_PROFILE)
    name:SetPos(138,135)
    name:SetSize(355,40)
    name:SetText("")
    if info.lastonline == 0 then
        name.info = "Online on this server!"
    else
        name.info = "Last seen " .. D3A.FormatTimeSingle(info.lastonline) .. " ago"
    end
    function name:Paint(w,h)
        draw.DrawText(name.info,"profile.steamid",w/2,0,Color(255,255,255),TEXT_ALIGN_CENTER)
    end
    function name:DoClick()
        SetClipboardText(self.info)
        self.info = "Copied to clipboard!"
        timer.Simple(0.5,function()
            if info.lastonline == 0 then
                self.info = "Online on this server!"
            else
                self.info = "Last seen " .. D3A.FormatTimeSingle(info.lastonline) .. " ago"
            end
        end)
    end

    if (info.banlength) then
        local caution = CreateMaterial("moat_CautionMaterial2D2", "UnlitGeneric", {
            ["$basetexture"] = "phoenix_storms/stripes",
            ["$noclamp"] = 1
        })
        local mat = Matrix()
        mat:SetScale(Vector(6, 1))
        caution:SetMatrix("$basetexturetransform", mat)
        caution:Recompute()
        local c = vgui.Create("DImage", MOAT_PROFILE)
        c:SetPos(6, 165)
        c:SetSize(MOAT_PROFILE:GetWide() - 12, 60 - 6)
        c:SetMaterial(caution)

        local name = vgui.Create("DButton", MOAT_PROFILE)
        name:SetPos(0,170)
        name:SetSize(MOAT_PROFILE:GetWide(),30)
        name:SetTextColor(Color(240, 20, 20, 255))
        name:SetText ""
        local len = "Currently trade banned"
        name.info = len
        function name:Paint(w,h)
            draw.SimpleTextOutlined(name.info, "profile.steamid", w / 2, 0, Color(240, 20, 20, 255), TEXT_ALIGN_CENTER, nil, 2, color_black)
        end
        function name:DoClick()
            SetClipboardText(self.info)
            self.info = "Copied to clipboard!"
            timer.Simple(0.5,function()
                self.info = len
            end)
        end

        local name = vgui.Create("DButton", MOAT_PROFILE)
        name:SetPos(0,195)
        name:SetSize(MOAT_PROFILE:GetWide(), 30)
        name:SetTextColor(Color(240, 20, 20, 255))
        name:SetText ""
        local reason = info.banreason
        name.info = reason
        function name:Paint(w,h)
            draw.SimpleTextOutlined(name.info,"profile.steamid",w/2,0,Color(240, 20, 20, 255),TEXT_ALIGN_CENTER, nil, 2, color_black)
        end
        function name:DoClick()
            SetClipboardText(self.info)
            self.info = "Copied to clipboard!"
            timer.Simple(0.5,function()
                self.info = reason
            end)
        end
    end
end

function make_profile_card(info)
    if IsValid(MOAT_PROFILE) then 
        MOAT_PROFILE:Remove()
    end
    MOAT_PROFILE = vgui.Create("DFrame")
    local w,h = 500,164 + (info.banlength and 60 or 0)
    if ScrW() < w then w = ScrW() end
    if ScrH() < h then h = ScrH() end
    MOAT_PROFILE:SetSize(w,h)
    MOAT_PROFILE:SetPos(ScrW(),(ScrH()/2) - (h/2))
    MOAT_PROFILE:MoveTo(ScrW()-w,(ScrH()/2) - (h/2),0.1,0,-1,function()
        MOAT_PROFILE:MakePopup()
    end)
    function MOAT_PROFILE:Close()
        MOAT_PROFILE:MoveTo(ScrW(),(ScrH()/2) - (h/2),0.1,0,-1,function()
            MOAT_PROFILE:Remove()
        end)
    end
    MOAT_PROFILE:SetTitle(info.name .. " (" .. util.SteamIDFrom64(info.steamid) .. ") | Click to copy")
    populate_profile_card(MOAT_PROFILE,info)
end

function open_profile_card(steamid)
    net.Start("player_card")
    net.WriteString(steamid)
    net.SendToServer()
end

net.Receive("player_card",function()
    make_profile_card(net.ReadTable())
end)

concommand.Add("profile_card_test",function()
    open_profile_card(LocalPlayer():SteamID64())
end)