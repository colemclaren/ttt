local gradient_u = Material("vgui/gradient-u")
local gradient_d = Material("vgui/gradient-d")
local gradient_r = Material("vgui/gradient-r")
local blur = Material("pp/blurscreen")
local mat_coins = Material("icon16/coins.png")
local circ_gradient = "https://i.moat.gg/8WkHz.png"
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

MOAT_THEME.Themes["Light"] = {
    Background = Color(225, 245, 254),
    Header = Color(46, 49, 54),
    TextColor = Color(66, 66, 66),
    TextShadow = false,
    TradePlayerColor = {0, 150, 150},
    BG_PAINT = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, s.Theme.Background)
        draw.RoundedBox(0, 0, 0, w, 26, s.Theme.Header)
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(0, 0, w, h)
    end,
    INV_PANEL_PAINT = function(s, w, h)
        --draw.SimpleTextOutlined("Inventory", "moat_Trebuchet", 2, 0, s.Theme.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 25))
        local m_DrawCredits = "Inventory Credits: " .. string.Comma(MOAT_INVENTORY_CREDITS)
        surface.SetFont("moat_ItemDesc")
        local cred_w, cred_h = surface.GetTextSize(m_DrawCredits)
        draw.SimpleTextOutlined(m_DrawCredits, "moat_ItemDesc", w, 10, s.Theme.TextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 25))
        surface.SetMaterial(mat_coins)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(w - cred_w - 5 - 16, 9, 16, 16)
    end,
    CloseB = {727, 3, 20, 20},
    CLOSE_PAINT = function(s, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(26, 29, 34))

        if (s:IsHovered()) then
            draw.RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 2))
        end

        if (s:IsDown()) then
            draw.RoundedBox(10, 0, 0, w, h, Color(255, 0, 0, 6))
        end
    end,
    CatSpacing = 0,
    CatInfo = {0, 90, 26},
    CAT_PAINT = function(s, w, h, cur_cat)
        if (cur_cat == s.CAT_NUM) then
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        else
            draw.RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
        end

        draw.RoundedBox(0, w - 1, 0, 1, h, Color(26, 29, 34, 255))
        draw.SimpleText(s.CatLabel, "moat_Medium4", w / 2, h / 2, s.CatLabel == "Donate" and Color(255, 205, 0) or Color(255, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,
    CATBAR_PAINT = function(s, w, h)
        if (s.cur_cat ~= s.new_cat) then
            s.cur_cat = Lerp(FrameTime() * 10, s.cur_cat, s.new_cat)
        end

        local ww = w / s.cat_num
        draw.RoundedBox(0, (ww * s.cur_cat) - ww, h - 2, ww, 2, HSVToColor(s.cur_cat * 65 % 360, 1, 1))
    end,
    VBAR_PAINT = {
        PAINT = function(s, w, h)
            if (s.DisabledButtons) then return end
            s:SetHideButtons(true)
            s.DisabledButtons = true
        end,
        --draw.RoundedBox(6, 0, 4+9, 11, h - 8-18, Color(66, 69, 74))
        GRIP = function(s, w, h, sbar)
            local draw_color = Color(56, 59, 64)

            if (not input.IsMouseDown(MOUSE_LEFT) and sbar.moving) then
                sbar.moving = false
            end

            if (s:IsHovered()) then
                draw_color = Color(26, 29, 34)

                if (input.IsMouseDown(MOUSE_LEFT)) then
                    sbar.moving = true
                end

                s:SetCursor("hand")
            end

            if (sbar.moving) then
                s:SetCursor("hand")
                draw_color = Color(26, 29, 34)
                sbar.LerpTarget = sbar:GetScroll()
            end

            draw.RoundedBox(4, 2, 0, 7, h, draw_color)
        end,
        UP = function(s, w, h) end,
        DOWN = function(s, w, h) end
    },
    CHAT = {
        CHAT_BG = function(s, w, h, mc, b)
            draw.RoundedBox(0, 0, 0, w, h, Color(225, 245, 254, 255 * mc.alpha))
            draw.RoundedBox(0, 0, 0, w, 21, Color(46, 49, 54, 255 * mc.alpha))
            surface.SetDrawColor(0, 0, 0, 120 * mc.alpha)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(0, 0, w, h)
            draw.DrawText(mc.header, mc.font, 6, 2, Color(255, 255, 255, 255 * mc.alpha))
            local chat_str = "Say :"
            local chat_type = 1

            if (#mc.chattype > 1) then
                chat_str = "Say (TEAM) :"
                chat_type = 2
            end

            draw.DrawText(chat_str, mc.font, 10, mc.config.h - 24, Color(46, 49, 54, 255 * mc.alpha))
        end,
        CHAT_PANEL = function(s, w, h, mc) end,
        CHAT_ENTRY = function(s, w, h, mc)
            draw.RoundedBox(0, 0, 0, w, h, Color(46, 49, 54, 255 * mc.alpha))
            s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))
        end,
        DefaultColor = Color(255, 255, 255, 255)
    },
    TradeRequest = {
        BG = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(225, 245, 254, 255))
            draw.RoundedBox(0, 0, 0, w, 26, Color(46, 49, 54, 255))
            surface.SetDrawColor(0, 0, 0, 120)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(0, 0, w, h)
            local other_cols = (200 / 30) * s.Timer
            draw.SimpleText("has requested to trade.", "GModNotify", w / 2, 195, Color(46, 49, 54, 255), TEXT_ALIGN_CENTER)
            local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
            draw.RoundedBox(0, 1, h - 4, w - 2, 3, Color(46, 49, 54, 255))
            draw.RoundedBox(0, 1, h - 4, timer_vis, 3, Color(255, 255, 255, 50))
        end,
        Close = false,
        Background = true,
        NameColor = Color(46, 49, 54, 255)
    },
    Crate = {
        BG = function(s, w, h, itemtbl)
            draw.RoundedBox(0, 0, 0, w, h, Color(225, 245, 254, 255))
            draw.RoundedBox(0, 0, 0, w, 26, Color(46, 49, 54, 255))
            surface.SetDrawColor(0, 0, 0, 120)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(0, 0, w, h)
            draw.SimpleText(itemtbl.item.Name, "GModNotify", w / 2, 26, Color(46, 49, 54), TEXT_ALIGN_CENTER)
            m_DrawShadowedText(1, s.TitleText, "moat_ItemDesc", 13, 5, Color(255, 255, 255))
        end,
        Panel = function(s, w, h, crate_contents)
            draw.RoundedBox(0, 0, 0, w, h, Color(46, 49, 54))
            m_DrawShadowedText(1, "This crate contains one of the following " .. #crate_contents .. " items:", "moat_ItemDesc", 5, 2, Color(255, 255, 255))
        end,
        CloseB = {23, 3, 20, 20},
        CLOSE_PAINT = function(s, w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(26, 29, 34))

            if (s:IsHovered()) then
                draw.RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 2))
            end

            if (s:IsDown()) then
                draw.RoundedBox(10, 0, 0, w, h, Color(255, 0, 0, 6))
            end
        end,
        Open_Background = true
    }
}