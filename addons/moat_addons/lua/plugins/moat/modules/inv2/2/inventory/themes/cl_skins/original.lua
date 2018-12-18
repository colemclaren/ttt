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

MOAT_THEME.Themes["Original"] = {
    TextColor = Color(255, 255, 255),
    TextShadow = true,
    TradePlayerColor = {0, 200, 0},
    BG_PAINT = function(s, w, h)
        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        local line_x = MOAT_INV_BG:GetWide() - (350 + 14) - 4 - 5
        surface.SetDrawColor(100, 100, 100, 50)
        surface.DrawLine(0, 25, s:GetWide(), 25)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawLine(0, 26, s:GetWide(), 26)
        DisableClipping(true)
        m_DrawShadowedText(1, "Moat Inventory " .. MOAT_VERSION .. " - http://moat.gg/", "moat_ItemDesc", w, h, Color(200, 200, 200, 255), TEXT_ALIGN_RIGHT)
        DisableClipping(false)
    end,
    INV_PANEL_PAINT = function(s, w, h)
        --m_DrawShadowedText(1, "Inventory", "moat_Trebuchet", 2, 0, Color(200, 200, 200, 255))
        local m_DrawCredits = "Inventory Credits: " .. string.Comma(MOAT_INVENTORY_CREDITS)
        surface.SetFont("moat_ItemDesc")
        local cred_w, cred_h = surface.GetTextSize(m_DrawCredits)
        m_DrawShadowedText(1, m_DrawCredits, "moat_ItemDesc", w, 10, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
        surface.SetMaterial(mat_coins)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(w - cred_w - 5 - 16, 9, 16, 16)
    end,
    CloseB = {714, 3, 33, 19},
    CLOSE_PAINT = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(137, 137, 137, 255)
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
    end,
    CatSpacing = 2,
    CatInfo = {2, 85, 24},
    CAT_PAINT = function(s, w, h, cur_cat)
        if (cur_cat == s.CAT_NUM) then
            draw.RoundedBoxEx(8, 0, 0, w, h, Color(50, 50, 50, 50), true, true)
            draw.RoundedBoxEx(8, 1, 1, w - 2, h - 2, Color(150, 150, 150, 150), true, true)
            surface.SetDrawColor(0, 0, 0, 50)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        else
            draw.RoundedBoxEx(8, 0, 0, w, h, Color(50, 50, 50, 100), true, true)
            draw.RoundedBoxEx(8, 1, 1, w - 2, h - 2, Color(s.hover_coloral, s.hover_coloral, s.hover_coloral, 150), true, true)
            surface.SetDrawColor(0, 0, 0, 100)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        end

        m_DrawShadowedText(1, s.CatLabel, "moat_Medium4", w / 2, h / 2, s.CatLabel == "Donate" and Color(255, 205, 0) or Color(255, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,
    VBAR_PAINT = {
        PAINT = function(s, w, h)
            draw.RoundedBox(0, 0, 4, 11, h - 8, Color(40, 40, 40))
        end,
        GRIP = function(s, w, h, sbar)
            local draw_color = Color(64, 64, 64)

            if (not input.IsMouseDown(MOUSE_LEFT) and sbar.moving) then
                sbar.moving = false
            end

            if (s:IsHovered()) then
                draw_color = Color(72, 72, 72)

                if (input.IsMouseDown(MOUSE_LEFT)) then
                    sbar.moving = true
                end

                s:SetCursor("hand")
            end

            if (sbar.moving) then
                s:SetCursor("hand")
                draw_color = Color(64, 64, 100)
                sbar.LerpTarget = sbar:GetScroll()
            end

            draw.RoundedBox(0, 0, 0, 11, h, draw_color)
            surface.SetDrawColor(50, 50, 50, 255)
            surface.SetMaterial(gradient_r)
            surface.DrawTexturedRect(0, 0, 11, h)
        end,
        UP = function(s, w, h)
            local draw_color = Color(84, 84, 84)

            if (s:IsHovered()) then
                draw_color = Color(150, 150, 150)
            end

            surface.SetDrawColor(draw_color)
            surface.DrawLine(1, 4 + 6, 6, 5)
            surface.DrawLine(9, 4 + 6, 4, 5)
            surface.DrawLine(2, 4 + 6, 6, 6)
            surface.DrawLine(8, 4 + 6, 4, 6)
        end,
        DOWN = function(s, w, h)
            local draw_color = Color(84, 84, 84)

            if (s:IsHovered()) then
                draw_color = Color(150, 150, 150)
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
            surface.SetDrawColor(62, 62, 64, 255 * mc.alpha)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250 * mc.alpha))
            surface.SetDrawColor(0, 0, 0, 120 * mc.alpha)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(1, 1, w - 2, h - 2)
            surface.SetDrawColor(0, 0, 0, 150 * mc.alpha)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(1, 1, w - 2, 20)
            draw.DrawText(mc.header, mc.font, 6, 2, Color(255, 255, 255, 255 * mc.alpha))
            local chat_str = "Say :"
            local chat_type = 1

            if (#mc.chattype > 1) then
                chat_str = "Say (TEAM) :"
                chat_type = 2
            end

            surface.SetDrawColor(62, 62, 64, 255 * mc.alpha)
            surface.DrawOutlinedRect(5, mc.config.h - 25, mc.sayvars[chat_type].w, 20)
            surface.SetDrawColor(0, 0, 0, 150 * mc.alpha)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(5, mc.config.h - 25, mc.sayvars[chat_type].w, 20)
            draw.DrawText(chat_str, mc.font, 10, mc.config.h - 24, Color(255, 255, 255, 255 * mc.alpha))
        end,
        CHAT_PANEL = function(s, w, h, mc)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 15 * mc.alpha))
        end,
        CHAT_ENTRY = function(s, w, h, mc)
            surface.SetDrawColor(62, 62, 64, 255 * mc.alpha)
            surface.DrawOutlinedRect(0, 0, w, h)
            surface.SetDrawColor(0, 0, 0, 150 * mc.alpha)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(0, 0, w, h)
            s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))
        end,
        DefaultColor = Color(255, 255, 255)
    },
    TradeRequest = {
        BG = function(s, w, h)
            surface.SetDrawColor(62, 62, 64, 255)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
            surface.SetDrawColor(0, 0, 0, 120)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(1, 1, w - 2, h - 2)
            surface.SetDrawColor(0, 0, 0, 150)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(1, 1, w - 2, 25)
            local line_x = 350 - (350 + 14) - 4 - 5
            surface.SetDrawColor(100, 100, 100, 50)
            surface.DrawLine(line_x, 26, line_x, s:GetTall())
            surface.DrawLine(0, 25, s:GetWide(), 25)
            surface.SetDrawColor(0, 0, 0, 100)
            surface.DrawLine(line_x + 1, 26, line_x + 1, s:GetTall())
            surface.DrawLine(0, 26, s:GetWide(), 26)
            local other_cols = (200 / 30) * s.Timer
            m_DrawShadowedText(1, s.Timer, "moat_ItemDesc", w - 40, 6, Color(200, other_cols, other_cols, 255), TEXT_ALIGN_RIGHT)
            draw.SimpleText("has requested to trade with you.", "GModNotify", w / 2, 195, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER)
            local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
            draw.RoundedBox(0, 1, h - 4, w - 2, 3, Color(0, 0, 0, 100))
            draw.RoundedBox(0, 1, h - 4, timer_vis, 3, Color(255, 255, 255, 255))
        end,
        Close = true
    }
}