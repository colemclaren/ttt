local math              = math
local table             = table
local draw              = draw
local team              = team
local IsValid           = IsValid
local CurTime           = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
local draw_DrawText = draw.DrawText
local surface_SetFont = surface.SetFont
local surface_SetTextColor = surface.SetTextColor
local surface_SetTextPos = surface.SetTextPos
local surface_DrawText = surface.DrawText
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_GetTextSize = surface.GetTextSize
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawPoly = surface.DrawPoly
local surface_DrawCircle = surface.DrawCircle
local gradient_u = Material("vgui/gradient-u")
local gradient_d = Material("vgui/gradient-d")
local gradient_r = Material("vgui/gradient-r")
local blur = Material("pp/blurscreen")
local mat_coins = Material("icon16/coins.png")
local circ_gradient = "https://i.moat.gg/8WkHz.png"
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

local no_item = "https://i.moat.gg/jAQ10.png"
MOAT_THEME.Themes["2.0"] = {
    Background = Color(0, 0, 0, 100),
    Header = Color(46, 49, 54),
    TextColor = Color(255, 255, 255),
    TextShadow = true,
    TradePlayerColor = {0, 200, 0},
    BG_PAINT = function(s, w, h)
        DisableClipping(true)
        surface_SetDrawColor(180, 180, 180, 200)
        surface_DrawLine(0, -3, w, -3)
        surface_DrawLine(0, h + 3, w, h + 3)
        DisableClipping(false)
        surface_SetDrawColor(0, 0, 0, 100)
        surface_DrawRect(0, 0, w, h)
        DrawBlur(s, 3)
        draw.WebImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 225))
    end,
    INV_PANEL_PAINT = function(s, w, h)
        --draw_SimpleTextOutlined("Inventory", "moat_Trebuchet", 2, 0, s.Theme.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 25))
        local m_DrawCredits = "Inventory Credits: " .. string.Comma(MOAT_INVENTORY_CREDITS)
        surface_SetFont("moat_ItemDesc")
        local cred_w, cred_h = surface_GetTextSize(m_DrawCredits)
        draw_SimpleTextOutlined(m_DrawCredits, "moat_ItemDesc", w, 10, s.Theme.TextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 25))
        surface_SetMaterial(mat_coins)
        surface_SetDrawColor(255, 255, 255)
        surface_DrawTexturedRect(w - cred_w - 5 - 16, 9, 16, 16)
    end,
    CloseB = {728, 5, 17, 17},
    CLOSE_PAINT = function(s, w, h)
        if (not s.LerpNum) then
            s.LerpNum = 0
        end

        if (s:IsHovered() or s:IsDown()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        draw_RoundedBox(4, 0, 0, w, h, Color(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum)))
        draw_SimpleText("r", "marlett", 8 + 1, 8, Color(255 - (55 * s.LerpNum), 50 + (150 * s.LerpNum), 50 + (150 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,
    CatSpacing = 0,
    CatInfo = {0, 90, 26},
    CAT_PAINT = function(s, w, h, cur_cat)
        if (cur_cat == s.CAT_NUM) then
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        else
            draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
        end

        draw_SimpleTextOutlined(s.CatLabel, "moat_Medium4", w / 2, h / 2, s.CatLabel == "Donate" and Color(255, 205, 0) or Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 25))
    end,
    CATBAR_PAINT = function(s, w, h)
        if (s.cur_cat ~= s.new_cat) then
            s.cur_cat = Lerp(FrameTime() * 10, s.cur_cat, s.new_cat)
        end

        local ww = w / s.cat_num
        draw_RoundedBox(0, (ww * s.cur_cat) - ww, h - 2, ww, 2, HSVToColor(s.cur_cat * 65 % 360, 1, 1))
    end,
    VBAR_PAINT = {
        PAINT = function(s, w, h) 
            if (s.DisabledButtons) then return end
            s:SetHideButtons(true)
            s.DisabledButtons = true
        end,
        --draw_RoundedBox(0, 0, 4, 11, h - 8, Color(0, 0, 0, 100))
        GRIP = function(s, w, h, sbar)
            local draw_color = Color(255, 255, 255, 30)

            if (not input.IsMouseDown(MOUSE_LEFT) and sbar.moving) then
                sbar.moving = false
            end

            if (s:IsHovered()) then
                draw_color = Color(255, 255, 255, 100)

                if (input.IsMouseDown(MOUSE_LEFT)) then
                    sbar.moving = true
                end

                s:SetCursor("hand")
            end

            if (sbar.moving) then
                s:SetCursor("hand")
                draw_color = Color(255, 255, 255, 100)
                sbar.LerpTarget = sbar:GetScroll()
            end

            surface_SetDrawColor(draw_color)
            surface_DrawRect(0, 0, 11, h)
        end,
        UP = function(s, w, h)
            local draw_color = Color(150, 150, 150)

            if (s:IsHovered()) then
                draw_color = Color(255, 255, 255)
            end

            surface_SetDrawColor(draw_color)
            surface_DrawLine(1, 4 + 6, 6, 5)
            surface_DrawLine(9, 4 + 6, 4, 5)
            surface_DrawLine(2, 4 + 6, 6, 6)
            surface_DrawLine(8, 4 + 6, 4, 6)
        end,
        DOWN = function(s, w, h)
            local draw_color = Color(150, 150, 150)

            if (s:IsHovered()) then
                draw_color = Color(255, 255, 255)
            end

            surface_SetDrawColor(draw_color)
            surface_DrawLine(1, 4, 6, 4 + 5)
            surface_DrawLine(9, 4, 4, 4 + 5)
            surface_DrawLine(2, 4, 6, 4 + 4)
            surface_DrawLine(8, 4, 4, 4 + 4)
        end
    },
    SLOT_PAINT = function(s, w, h, lr, item)
        if (not item) then return end
        local draw_x = 2
        local draw_y = 2
        local draw_w = w - 4
        local draw_h = h - 4
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(0, 0, 0, 100))
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(150, 150, 150, lr))

        local raritymat = item.c and fetch_asset(rarity_names[item.item.Rarity][4]) or fetch_asset(no_item)
        surface_SetMaterial(raritymat)
        surface_SetDrawColor(255, 255, 255)
        surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
    end,
    LSLOT_PAINT = function(s, w, h, lr, item)
        if (not item) then return end
        local y2 = 10
        local draw_x = 2 + 3
        local draw_y = 2 + y2 + 3
        local draw_w = w - 4 - 6
        local draw_h = h - 4 - y2 - 6
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(0, 0, 0, 100))
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(150, 150, 150, lr))

        local raritymat = item.c and fetch_asset(rarity_names[item.item.Rarity][4]) or fetch_asset(no_item)
        surface_SetMaterial(raritymat)
        surface_SetDrawColor(255, 255, 255)
        surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
    end,
    CHAT = {
        CHAT_BG = function(s, w, h, mc, b)
            b(s, 5)
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50 * mc.alpha))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50 * mc.alpha))
            surface_SetDrawColor(150, 150, 150, 50 * mc.alpha)
            surface_DrawRect(0, 0, w, 21)
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
            surface_SetDrawColor(150, 150, 150, 50 * mc.alpha)
            surface_DrawRect(0, 0, w, h)
            s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))
        end,
        DefaultColor = Color(255, 255, 255, 255)
    },
    TradeRequest = {
        BG = function(s, w, h)
            DrawBlur(s, 5)
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
            local other_cols = (200 / 30) * s.Timer
            draw_SimpleText("has requested to trade.", "GModNotify", w / 2, 195, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER)
            local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
            draw_RoundedBox(0, 1, h - 4, w - 2, 3, Color(0, 0, 0, 100))
            draw_RoundedBox(0, 1, h - 4, timer_vis, 3, Color(255, 255, 255, 255))
        end,
        Close = false,
        Background = true
    },
    Crate = {
        BG = function(s, w, h, itemtbl)
            DrawBlur(s, 5)
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
            m_DrawShadowedText(1, itemtbl.item.Name, "GModNotify", w / 2, 26, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            m_DrawShadowedText(1, s.TitleText, "moat_ItemDesc", 13, 5, Color(255, 255, 255))
        end,
        Panel = function(s, w, h, crate_contents)
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
        end,
        CloseB = {23, 3, 20, 20},
        CLOSE_PAINT = function(s, w, h)
            draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

            if (s:IsHovered()) then
                draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
            end

            if (s:IsDown()) then
                draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
            end
        end,
        Open_Background = true
    }
}