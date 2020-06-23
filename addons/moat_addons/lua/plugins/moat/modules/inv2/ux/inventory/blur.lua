local math              = math
local draw              = draw
local IsValid           = IsValid
local CurTime           = CurTime
local draw_DrawText = draw.DrawText
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local blur = Material("pp/blurscreen")
local mat_coins = Material("icon16/coins.png")

local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface_SetDrawColor(255, 255, 255)
    surface_SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface_DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

local MenuColors = {
	Text = Color(154, 156, 160, 255),
	Disabled = Color(128, 128, 128, 255),
	Border = Color(42, 43, 46, 255),
	Menu = Color(24, 25, 28, 255),
	Hover = Color(4, 4, 5, 255),
	TextHover = Color(246, 246, 246, 255)
}

MOAT_THEME = MOAT_THEME or {}
MOAT_THEME.Themes = MOAT_THEME.Themes or {}
MOAT_THEME.Themes["Blur"] = {
    Background = Color(22, 23, 30, 150),
    Header = Color(46, 49, 54),
    TextColor = Color(255, 255, 255),
    TextShadow = false,
    TradePlayerColor = {0, 200, 0},
    BG_PAINT = function(s, w, h)
        DrawBlur(s, 5)

		surface.SetDrawColor(s.Theme.Background)
		surface.DrawRect(0, 0, w, h)
		surface.DrawRect(1, 1, w - 2, h - 2)

		cdn.DrawImage("https://static.moat.gg/f/413567786280d852aaf0abec6e188865.png", 0, 0, 1024, 1024, Color(220, 220, 255, 50))
    end,
    INV_PANEL_PAINT = function(s, w, h)
        local m_DrawCredits = "Inventory Credits: " .. string.Comma(MOAT_INVENTORY_CREDITS or 0)
        draw.SimpleTextOutlined(m_DrawCredits, "moat_ItemDesc", w, 10, s.Theme.TextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 25))

		surface.SetFont("moat_ItemDesc")
		local cred_w = surface.GetTextSize(m_DrawCredits)

        surface.SetMaterial(mat_coins)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(w - cred_w - 5 - 16, 9, 16, 16)
    end,
    CloseB = {727, 3, 20, 20},
    CLOSE_PAINT = function(s, w, h)
        draw.SimpleTextOutlined("r", "marlett", 10, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw.SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw.SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end,
    CatSpacing = 0,
    CatInfo = {0, 90, 30},
    CAT_PAINT = function(s, w, h, cur_cat)
		if (s.CatLabel == "Store") then
			draw.RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8, (h/2)-8, 16, 16, ux.ShiftColor(ux.p.mg.shop, ux.p.mg.shop2, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1))

            return
        end

        if (cur_cat == s.CAT_NUM) then
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        else
            draw.RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
        end

        draw.SimpleText(s.CatLabel, "moat_Medium10", w / 2, h / 2, ux.ShiftColor(ux.p.mg.light, ux.p.white, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,
    CATBAR_PAINT = function(s, w, h)
        if (s.cur_cat ~= s.new_cat) then
			s.cur_cat = Lerp(FrameTime() * 10, s.cur_cat, s.new_cat)
        end
		
		local ww = w / s.cat_num
        draw.RoundedBox(0, (ww * s.cur_cat) - ww, h - 3, ww, 3, HSVToColor(s.cur_cat * 65 % 360, 1, 1))
    end,
    VBAR_PAINT = {
        PAINT = function(s, w, h)
            draw.RoundedBox(0, 0, 4, 11, h - 8, Color(0, 0, 0, 100))
        end,
        GRIP = function(s, w, h, sbar)
            local draw_color = Color(150, 150, 150, 50)

            if (not input.IsMouseDown(MOUSE_LEFT) and sbar.moving) then
                sbar.moving = false
            end

            if (s:IsHovered()) then
                draw_color = Color(150, 150, 150, 100)

                if (input.IsMouseDown(MOUSE_LEFT)) then
                    sbar.moving = true
                end

                s:SetCursor("hand")
            end

            if (sbar.moving) then
                s:SetCursor("hand")
                draw_color = Color(200, 200, 200, 100)
                sbar.LerpTarget = sbar:GetScroll()
            end

            draw.RoundedBox(0, 0, 0, 11, h, draw_color)
        end,
        UP = function(s, w, h)
            local draw_color = Color(150, 150, 150)

            if (s:IsHovered()) then
                draw_color = Color(255, 255, 255)
            end

            surface.SetDrawColor(draw_color)
            surface.DrawLine(1, 4 + 6, 6, 5)
            surface.DrawLine(9, 4 + 6, 4, 5)
            surface.DrawLine(2, 4 + 6, 6, 6)
            surface.DrawLine(8, 4 + 6, 4, 6)
        end,
        DOWN = function(s, w, h)
            local draw_color = Color(150, 150, 150)

            if (s:IsHovered()) then
                draw_color = Color(255, 255, 255)
            end

            surface.SetDrawColor(draw_color)
            surface.DrawLine(1, 4, 6, 4 + 5)
            surface.DrawLine(9, 4, 4, 4 + 5)
            surface.DrawLine(2, 4, 6, 4 + 4)
            surface.DrawLine(8, 4, 4, 4 + 4)
        end
    },
    CHAT = {
        CHAT_BG = function(s, w, h, mc, b)
            b(s, 5)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50 * mc.alpha))
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50 * mc.alpha))
            surface.SetDrawColor(150, 150, 150, 50 * mc.alpha)
            surface.DrawRect(0, 0, w, 21)
            draw_DrawText(mc.header, mc.font, 6, 2, Color(255, 255, 255, 255 * mc.alpha))
            local chat_str = "Say :"
            local chat_type = 1

            if (#mc.chattype > 1) then
                chat_str = "Say (TEAM) :"
                chat_type = 2
            end

            draw_DrawText(chat_str, mc.font, 10, mc.config.h - 24, Color(255, 255, 255, 255 * mc.alpha))
        end,
        CHAT_PANEL = function(s, w, h, mc) end,
        CHAT_ENTRY = function(s, w, h, mc)
            surface.SetDrawColor(150, 150, 150, 50 * mc.alpha)
            surface.DrawRect(0, 0, w, h)
            s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))
        end,
        DefaultColor = Color(255, 255, 255, 255)
    },
    TradeRequest = {
        BG = function(s, w, h)
            DrawBlur(s, 5)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
            local other_cols = (200 / 30) * s.Timer
            draw.SimpleText("has requested to trade.", "GModNotify", w / 2, 195, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER)
            local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
            draw.RoundedBox(0, 1, h - 4, w - 2, 3, Color(0, 0, 0, 100))
            draw.RoundedBox(0, 1, h - 4, timer_vis, 3, Color(255, 255, 255, 255))
        end,
        Close = false,
        Background = true
    },
    Crate = {
        BG = function(s, w, h, itemtbl)
            DrawBlur(s, 5)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
            m_DrawShadowedText(1, itemtbl.item.Name, "GModNotify", w / 2, 26, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            m_DrawShadowedText(1, s.TitleText, "moat_ItemDesc", 13, 5, Color(255, 255, 255))
        end,
        Panel = function(s, w, h, crate_contents)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
            m_DrawShadowedText(1, "This crate contains one of the following " .. #crate_contents .. " items:", "moat_ItemDesc", 5, 2, Color(200, 200, 200))
        end,
        CloseB = {23, 3, 20, 20},
        CLOSE_PAINT = function(s, w, h)
            draw.SimpleTextOutlined("r", "marlett", 10, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

            if (s:IsHovered()) then
                draw.SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
            end

            if (s:IsDown()) then
                draw.SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
            end
        end,
        Open_Background = true
    }
}

local pmeta = FindMetaTable("Panel")
function pmeta:SetFestive(x, y, w, h)
    -- if (not IsValid(self.festivepanel) and holiday:GetInt() == 1) then
    --     createFestive(self, x, y, w, h)
    -- end
end