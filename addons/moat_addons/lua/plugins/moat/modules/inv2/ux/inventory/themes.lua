
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
local moat_inv_cooldown = 0

local spooky_url = "https://i.moat.gg/servers/images/halloween/"
local spooks = {
    [1] = {"1left.png", 0, 0, 0},
    [2] = {"2left.png", 0, 0, 0},
    [3] = {"3left.png", 0, 0, 0},
    [4] = {"1right.png", 0, 0, 0},
    [5] = {"2right.png", 0, 0, 0},
    [6] = {"3right.png", 0, 0, 0}
}
local next_spook = CurTime()
local current_spook = 1
local currently_spook = false

local function DrawSpooky(s, w, h)
    draw.WebImage(spooky_url .. "halloween3.png", 0, 0, w, h, Color(255, 255, 255))

    if (next_spook <= CurTime()) then
        current_spook = math.random(1, 6)

        local da_spook = spooks[current_spook]
        if (da_spook[1]:EndsWith("right.png")) then
            da_spook[2] = -100
        else
            da_spook[2] = w + 100
        end

        da_spook[3] = math.random(100, h - 200)
        da_spook[4] = math.random(50, 100)

        currently_spook = true
        next_spook = CurTime() + 20
    elseif (currently_spook) then
        local da_spook = spooks[current_spook]

        draw.WebImage(spooky_url .. da_spook[1], da_spook[2], da_spook[3] - (math.sin(RealTime() * 3) * 25), da_spook[4], da_spook[4], Color(255, 255, 255))

        if (da_spook[1]:EndsWith("right.png")) then
            da_spook[2] = da_spook[2] + (FrameTime() * 120)

            if (da_spook[2] > w) then currently_spook = false end
        else
            da_spook[2] = da_spook[2] - (FrameTime() * 120)

            if (da_spook[2] < -100) then currently_spook = false end
        end
    end
end

local function createSpooky(pnl, x, y, w, h)
    if (true) then return end
    
    next_spook = CurTime() + 5
    pnl.spookypanel = vgui.Create("DPanel",pnl)
    pnl.spookypanel:SetSize(w,h)
    pnl.spookypanel:SetPos(x,y)
    pnl.spookypanel.Paint = function(s,w,h)
        DrawSpooky(s, w, h)
    end
end

local blur = Material("pp/blurscreen")
local mat_coins = Material("icon16/coins.png")
local mat_lock = Material("icon16/lock.png")
local mat_paint = Material("icon16/palette.png")

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

local light_gradient = Material("sprites/light_ignorez")
local circ_gradient = "https://i.moat.gg/8WkHz.png"

MOAT_THEME = MOAT_THEME or {}
MOAT_THEME.Cooldown = CurTime()
MOAT_THEME.FrameSize = {750, 550}
MOAT_THEME.Themes = MOAT_THEME.Themes or {}

MOAT_THEME.Themes["Original"] = {
    TextColor = Color(255, 255, 255),
    TextShadow = true,
    TradePlayerColor = {0, 200, 0},
    BG_PAINT = function(s, w, h)
        surface_SetDrawColor(62, 62, 64, 255)
        surface_DrawOutlinedRect(0, 0, w, h)
        draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface_SetDrawColor(0, 0, 0, 120)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(0, 0, 0, 150)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, 29)
        local line_x = MOAT_INV_BG:GetWide() - (350 + 14) - 4 - 5
        surface_SetDrawColor(100, 100, 100, 50)
        surface_DrawLine(0, 29, s:GetWide(), 29)
        surface_SetDrawColor(0, 0, 0, 100)
        surface_DrawLine(0, 30, s:GetWide(), 30)
        DisableClipping(true)
        m_DrawShadowedText(1, "Moat Inventory " .. MOAT_VERSION, "moat_ItemDesc", w, h, Color(200, 200, 200, 255), TEXT_ALIGN_RIGHT)
        DisableClipping(false)
    end,
    INV_PANEL_PAINT = function(s, w, h)
        --m_DrawShadowedText(1, "Inventory", "moat_Trebuchet", 2, 0, Color(200, 200, 200, 255))
        local m_DrawCredits = "Inventory Credits: " .. string.Comma(MOAT_INVENTORY_CREDITS)
        surface_SetFont("moat_ItemDesc")
        local cred_w, cred_h = surface_GetTextSize(m_DrawCredits)
        m_DrawShadowedText(1, m_DrawCredits, "moat_ItemDesc", w, 10, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
        surface_SetMaterial(mat_coins)
        surface_SetDrawColor(255, 255, 255)
        surface_DrawTexturedRect(w - cred_w - 5 - 16, 9, 16, 16)
    end,
    CloseB = {714, 3, 33, 19},
    CLOSE_PAINT = function(s, w, h)
        draw_RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface_SetDrawColor(137, 137, 137, 255)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        draw_SimpleTextOutlined("r", "marlett", 17, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 15))
            draw_SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 20))
            draw_SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end,
    CatSpacing = 2,
    CatInfo = {2, 85, 28},
    CAT_PAINT = function(s, w, h, cur_cat)
		if (s.CatLabel == "Store") then
			draw_RoundedBoxEx(8, 0, 0, w, h, Color(50, 50, 50, 100), true, true)
            draw_RoundedBoxEx(8, 1, 1, w - 2, h - 2, Color(s.hover_coloral, s.hover_coloral, s.hover_coloral, 150), true, true)
            surface_SetDrawColor(0, 0, 0, 100)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(1, 1, w - 2, h - 2)
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8, (h/2)-8, 16, 16, ux.ShiftColor(ux.p.mg.shop, ux.p.mg.shop2, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1))
	
            return
        end

        if (cur_cat == s.CAT_NUM) then
            draw_RoundedBoxEx(8, 0, 0, w, h, Color(50, 50, 50, 50), true, true)
            draw_RoundedBoxEx(8, 1, 1, w - 2, h - 2, Color(150, 150, 150, 150), true, true)
            surface_SetDrawColor(0, 0, 0, 50)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        else
            draw_RoundedBoxEx(8, 0, 0, w, h, Color(50, 50, 50, 100), true, true)
            draw_RoundedBoxEx(8, 1, 1, w - 2, h - 2, Color(s.hover_coloral, s.hover_coloral, s.hover_coloral, 150), true, true)
            surface_SetDrawColor(0, 0, 0, 100)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        end

        m_DrawShadowedText(1, s.CatLabel, "moat_Medium10", w / 2, h / 2, ux.ShiftColor(ux.p.mg.light, ux.p.white, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,
    VBAR_PAINT = {
        PAINT = function(s, w, h)
            draw_RoundedBox(0, 0, 4, 11, h - 8, Color(40, 40, 40))
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

            draw_RoundedBox(0, 0, 0, 11, h, draw_color)
            surface_SetDrawColor(50, 50, 50, 255)
            surface_SetMaterial(gradient_r)
            surface_DrawTexturedRect(0, 0, 11, h)
        end,
        UP = function(s, w, h)
            local draw_color = Color(84, 84, 84)

            if (s:IsHovered()) then
                draw_color = Color(150, 150, 150)
            end

            surface_SetDrawColor(draw_color)
            surface_DrawLine(1, 4 + 6, 6, 5)
            surface_DrawLine(9, 4 + 6, 4, 5)
            surface_DrawLine(2, 4 + 6, 6, 6)
            surface_DrawLine(8, 4 + 6, 4, 6)
        end,
        DOWN = function(s, w, h)
            local draw_color = Color(84, 84, 84)

            if (s:IsHovered()) then
                draw_color = Color(150, 150, 150)
            end

            surface_SetDrawColor(draw_color)
            surface_DrawLine(1, 4, 6, 4 + 5)
            surface_DrawLine(9, 4, 4, 4 + 5)
            surface_DrawLine(2, 4, 6, 4 + 4)
            surface_DrawLine(8, 4, 4, 4 + 4)
        end
    },
    CHAT = {
        CHAT_BG = function(s, w, h, mc, b)
            surface_SetDrawColor(62, 62, 64, 255 * mc.alpha)
            surface_DrawOutlinedRect(0, 0, w, h)
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250 * mc.alpha))
            surface_SetDrawColor(0, 0, 0, 120 * mc.alpha)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(1, 1, w - 2, h - 2)
            surface_SetDrawColor(0, 0, 0, 150 * mc.alpha)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(1, 1, w - 2, 20)
            draw.DrawText(mc.header, mc.font, 6, 2, Color(255, 255, 255, 255 * mc.alpha))
            local chat_str = "Say :"
            local chat_type = 1

            if (#mc.chattype > 1) then
                chat_str = "Say (TEAM) :"
                chat_type = 2
            end

            surface_SetDrawColor(62, 62, 64, 255 * mc.alpha)
            surface_DrawOutlinedRect(5, mc.config.h - 25, mc.sayvars[chat_type].w, 20)
            surface_SetDrawColor(0, 0, 0, 150 * mc.alpha)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(5, mc.config.h - 25, mc.sayvars[chat_type].w, 20)
            draw.DrawText(chat_str, mc.font, 10, mc.config.h - 24, Color(255, 255, 255, 255 * mc.alpha))
        end,
        CHAT_PANEL = function(s, w, h, mc)
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 15 * mc.alpha))
        end,
        CHAT_ENTRY = function(s, w, h, mc)
            surface_SetDrawColor(62, 62, 64, 255 * mc.alpha)
            surface_DrawOutlinedRect(0, 0, w, h)
            surface_SetDrawColor(0, 0, 0, 150 * mc.alpha)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(0, 0, w, h)
            s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))
        end,
        DefaultColor = Color(255, 255, 255)
    },
    TradeRequest = {
        BG = function(s, w, h)
            surface_SetDrawColor(62, 62, 64, 255)
            surface_DrawOutlinedRect(0, 0, w, h)
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
            surface_SetDrawColor(0, 0, 0, 120)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(1, 1, w - 2, h - 2)
            surface_SetDrawColor(0, 0, 0, 150)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(1, 1, w - 2, 25)
            local line_x = 350 - (350 + 14) - 4 - 5
            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawLine(line_x, 26, line_x, s:GetTall())
            surface_DrawLine(0, 25, s:GetWide(), 25)
            surface_SetDrawColor(0, 0, 0, 100)
            surface_DrawLine(line_x + 1, 26, line_x + 1, s:GetTall())
            surface_DrawLine(0, 26, s:GetWide(), 26)
            local other_cols = (200 / 30) * s.Timer
            m_DrawShadowedText(1, s.Timer, "moat_ItemDesc", w - 40, 6, Color(200, other_cols, other_cols, 255), TEXT_ALIGN_RIGHT)
            draw_SimpleText("has requested to trade with you.", "GModNotify", w / 2, 195, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER)
            local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
            draw_RoundedBox(0, 1, h - 4, w - 2, 3, Color(0, 0, 0, 100))
            draw_RoundedBox(0, 1, h - 4, timer_vis, 3, Color(255, 255, 255, 255))
        end,
        Close = true
    }
}

MOAT_THEME.Themes["Light"] = {
    Background = Color(225, 245, 254),
    Header = Color(46, 49, 54),
    TextColor = Color(66, 66, 66),
    TextShadow = false,
    TradePlayerColor = {0, 150, 150},
    BG_PAINT = function(s, w, h)
        draw_RoundedBox(0, 0, 0, w, h, s.Theme.Background)
        draw_RoundedBox(0, 0, 0, w, 30, s.Theme.Header)
        surface_SetDrawColor(0, 0, 0, 120)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(0, 0, w, h)
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
    CloseB = {727, 3, 20, 20},
    CLOSE_PAINT = function(s, w, h)
        draw_RoundedBox(10, 0, 0, w, h, Color(26, 29, 34))

        if (s:IsHovered()) then
            draw_RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 2))
        end

        if (s:IsDown()) then
            draw_RoundedBox(10, 0, 0, w, h, Color(255, 0, 0, 6))
        end
    end,
    CatSpacing = 0,
    CatInfo = {0, 90, 30},
    CAT_PAINT = function(s, w, h, cur_cat)
		if (s.CatLabel == "Store") then
			draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
			draw_RoundedBox(0, w - 1, 0, 1, h, Color(26, 29, 34, 255))
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8, (h/2)-8, 16, 16, ux.ShiftColor(ux.p.mg.shop, ux.p.mg.shop2, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1))
	
            return
        end

        if (cur_cat == s.CAT_NUM) then
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        else
            draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
        end

        draw_RoundedBox(0, w - 1, 0, 1, h, Color(26, 29, 34, 255))
        draw_SimpleText(s.CatLabel, "moat_Medium10", w / 2, h / 2, ux.ShiftColor(ux.p.mg.light, ux.p.white, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
        --draw_RoundedBox(6, 0, 4+9, 11, h - 8-18, Color(66, 69, 74))
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

            draw_RoundedBox(4, 2, 0, 7, h, draw_color)
        end,
        UP = function(s, w, h) end,
        DOWN = function(s, w, h) end
    },
    CHAT = {
        CHAT_BG = function(s, w, h, mc, b)
            draw_RoundedBox(0, 0, 0, w, h, Color(225, 245, 254, 255 * mc.alpha))
            draw_RoundedBox(0, 0, 0, w, 21, Color(46, 49, 54, 255 * mc.alpha))
            surface_SetDrawColor(0, 0, 0, 120 * mc.alpha)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(0, 0, w, h)
            draw_DrawText(mc.header, mc.font, 6, 2, Color(255, 255, 255, 255 * mc.alpha))
            local chat_str = "Say :"
            local chat_type = 1

            if (#mc.chattype > 1) then
                chat_str = "Say (TEAM) :"
                chat_type = 2
            end

            draw_DrawText(chat_str, mc.font, 10, mc.config.h - 24, Color(46, 49, 54, 255 * mc.alpha))
        end,
        CHAT_PANEL = function(s, w, h, mc) end,
        CHAT_ENTRY = function(s, w, h, mc)
            draw_RoundedBox(0, 0, 0, w, h, Color(46, 49, 54, 255 * mc.alpha))
            s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))
        end,
        DefaultColor = Color(255, 255, 255, 255)
    },
    TradeRequest = {
        BG = function(s, w, h)
            draw_RoundedBox(0, 0, 0, w, h, Color(225, 245, 254, 255))
            draw_RoundedBox(0, 0, 0, w, 26, Color(46, 49, 54, 255))
            surface_SetDrawColor(0, 0, 0, 120)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(0, 0, w, h)
            local other_cols = (200 / 30) * s.Timer
            draw_SimpleText("has requested to trade.", "GModNotify", w / 2, 195, Color(46, 49, 54, 255), TEXT_ALIGN_CENTER)
            local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
            draw_RoundedBox(0, 1, h - 4, w - 2, 3, Color(46, 49, 54, 255))
            draw_RoundedBox(0, 1, h - 4, timer_vis, 3, Color(255, 255, 255, 50))
        end,
        Close = false,
        Background = true,
        NameColor = Color(46, 49, 54, 255)
    },
    Crate = {
        BG = function(s, w, h, itemtbl)
            draw_RoundedBox(0, 0, 0, w, h, Color(225, 245, 254, 255))
            draw_RoundedBox(0, 0, 0, w, 26, Color(46, 49, 54, 255))
            surface_SetDrawColor(0, 0, 0, 120)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(0, 0, w, h)
            draw_SimpleText(itemtbl.item.Name, "GModNotify", w / 2, 26, Color(46, 49, 54), TEXT_ALIGN_CENTER)
            m_DrawShadowedText(1, s.TitleText, "moat_ItemDesc", 13, 5, Color(255, 255, 255))
        end,
        Panel = function(s, w, h, crate_contents)
            draw_RoundedBox(0, 0, 0, w, h, Color(46, 49, 54))
            m_DrawShadowedText(1, "This crate contains one of the following " .. #crate_contents .. " items:", "moat_ItemDesc", 5, 2, Color(255, 255, 255))
        end,
        CloseB = {23, 3, 20, 20},
        CLOSE_PAINT = function(s, w, h)
            draw_RoundedBox(10, 0, 0, w, h, Color(26, 29, 34))

            if (s:IsHovered()) then
                draw_RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 2))
            end

            if (s:IsDown()) then
                draw_RoundedBox(10, 0, 0, w, h, Color(255, 0, 0, 6))
            end
        end,
        Open_Background = true
    }
}

MOAT_THEME.Themes["Dark"] = {
    Background = Color(54, 57, 62),
    Header = Color(46, 49, 54),
    TextColor = Color(235, 235, 235),
    TextShadow = false,
    DisableScrollBtns = true,
    TradePlayerColor = {0, 200, 0},
    BG_PAINT = function(s, w, h)
        draw_RoundedBox(0, 0, 0, w, h, s.Theme.Background)
        draw_RoundedBox(0, 0, 0, w, 30, s.Theme.Header)
        surface_SetDrawColor(0, 0, 0, 120)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(0, 0, w, h)
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
    CloseB = {727, 3, 20, 20},
    CLOSE_PAINT = function(s, w, h)
        draw_RoundedBox(10, 0, 0, w, h, Color(26, 29, 34))

        if (s:IsHovered()) then
            draw_RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 2))
        end

        if (s:IsDown()) then
            draw_RoundedBox(10, 0, 0, w, h, Color(255, 0, 0, 6))
        end
    end,
    CatSpacing = 0,
    CatInfo = {0, 90, 30},
    CAT_PAINT = function(s, w, h, cur_cat)
		if (s.CatLabel == "Store") then
			draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
			draw_RoundedBox(0, w - 1, 0, 1, h, Color(26, 29, 34, 155))
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8, (h/2)-8, 16, 16, ux.ShiftColor(ux.p.mg.shop, ux.p.mg.shop2, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1))
	
            return
        end

        if (cur_cat == s.CAT_NUM) then
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        else
            draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
        end

        draw_RoundedBox(0, w - 1, 0, 1, h, Color(36, 39, 44, 255))
        draw_SimpleText(s.CatLabel, "moat_Medium10", w / 2, h / 2, ux.ShiftColor(ux.p.mg.light, ux.p.white, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,
    CATBAR_PAINT = function(s, w, h)
        if (s.cur_cat ~= s.new_cat) then
            s.cur_cat = Lerp(FrameTime() * 10, s.cur_cat, s.new_cat)
        end

        local ww = w / s.cat_num
        draw_RoundedBox(0, (ww * s.cur_cat) - ww - 1, h - 2, ww + 1, 2, HSVToColor(s.cur_cat * 65 % 360, 1, 1))
    end,
    VBAR_PAINT = {
        PAINT = function(s, w, h)
            draw_RoundedBox(6, 0, 2, 11, h - 4, Color(36, 39, 44))
            if (s.DisabledButtons) then return end
            s:SetHideButtons(true)
            s.DisabledButtons = true
        end,
        GRIP = function(s, w, h, sbar)
            local draw_color = Color(26, 29, 34)

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

            draw_RoundedBox(4, 2, 0, 7, h, draw_color)
        end,
        UP = function(s, w, h) end,
        DOWN = function(s, w, h) end
    },
    CHAT = {
        CHAT_BG = function(s, w, h, mc, b)
            draw_RoundedBox(0, 0, 0, w, h, Color(54, 57, 62, 255 * mc.alpha))
            draw_RoundedBox(0, 0, 0, w, 21, Color(46, 49, 54, 255 * mc.alpha))
            surface_SetDrawColor(0, 0, 0, 120 * mc.alpha)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(0, 0, w, h)
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
            draw_RoundedBox(0, 0, 0, w, h, Color(54, 57, 62, 255))
            draw_RoundedBox(0, 0, 0, w, 26, Color(46, 49, 54, 255))
            surface_SetDrawColor(0, 0, 0, 120)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(0, 0, w, h)
            local other_cols = (200 / 30) * s.Timer
            draw_SimpleText("has requested to trade.", "GModNotify", w / 2, 195, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
            draw_RoundedBox(0, 1, h - 4, w - 2, 3, Color(46, 49, 54, 255))
            draw_RoundedBox(0, 1, h - 4, timer_vis, 3, Color(255, 255, 255, 50))
        end,
        Close = false,
        Background = true
    },
    Crate = {
        BG = function(s, w, h, itemtbl)
            draw_RoundedBox(0, 0, 0, w, h, Color(54, 57, 62, 255))
            draw_RoundedBox(0, 0, 0, w, 26, Color(46, 49, 54, 255))
            surface_SetDrawColor(0, 0, 0, 120)
            surface_SetMaterial(gradient_d)
            surface_DrawTexturedRect(0, 0, w, h)
            m_DrawShadowedText(1, itemtbl.item.Name, "GModNotify", w / 2, 26, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            m_DrawShadowedText(1, s.TitleText, "moat_ItemDesc", 13, 5, Color(255, 255, 255))
        end,
        Panel = function(s, w, h, crate_contents)
            draw_RoundedBox(0, 0, 0, w, h, Color(46, 49, 54, 255))
            m_DrawShadowedText(1, "This crate contains one of the following " .. #crate_contents .. " items:", "moat_ItemDesc", 5, 2, Color(200, 200, 200))
        end,
        CloseB = {23, 3, 20, 20},
        CLOSE_PAINT = function(s, w, h)
            draw_RoundedBox(10, 0, 0, w, h, Color(26, 29, 34))

            if (s:IsHovered()) then
                draw_RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 2))
            end

            if (s:IsDown()) then
                draw_RoundedBox(10, 0, 0, w, h, Color(255, 0, 0, 6))
            end
        end,
        Open_Background = true
    }
}
MOAT_THEME.Themes["Clear"] = {
    Background = Color(0, 0, 0, 100),
    Header = Color(46, 49, 54),
    TextColor = Color(255, 255, 255),
    TextShadow = true,
    TradePlayerColor = {0, 200, 0},
    BG_PAINT = function(s, w, h) end,
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
    CloseB = {727, 3, 20, 20},
    CLOSE_PAINT = function(s, w, h)
        draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end,
    CatSpacing = 0,
    CatInfo = {0, 90, 30},
    CAT_PAINT = function(s, w, h, cur_cat)
		if (s.CatLabel == "Store") then
			draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8-2, (h/2)-8-2, 20, 20, Color(0, 0, 0, 25))
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8, (h/2)-8, 16, 16, ux.ShiftColor(ux.p.mg.shop, ux.p.mg.shop2, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1))
	
            return
        end

        if (cur_cat == s.CAT_NUM) then
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        else
            draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
        end

        draw_SimpleTextOutlined(s.CatLabel, "moat_Medium10", w / 2, h / 2, ux.ShiftColor(ux.p.mg.light, ux.p.white, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 25))
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
            local draw_color = Color(16, 19, 24, 150)

            if (not input.IsMouseDown(MOUSE_LEFT) and sbar.moving) then
                sbar.moving = false
            end

            if (s:IsHovered()) then
                draw_color = Color(50, 50, 50, 150)

                if (input.IsMouseDown(MOUSE_LEFT)) then
                    sbar.moving = true
                end

                s:SetCursor("hand")
            end

            if (sbar.moving) then
                s:SetCursor("hand")
                draw_color = Color(150, 150, 150, 100)
                sbar.LerpTarget = sbar:GetScroll()
            end

            draw_RoundedBox(0, 0, 0, 11, h, draw_color)
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
    CHAT = {
        CHAT_BG = function(s, w, h, mc, b)
            --b(s, 5)
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100 * mc.alpha))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 100 * mc.alpha))
            --surface_SetDrawColor(150, 150, 150, 50 * mc.alpha)
            --surface_DrawRect(0, 0, w, 21)
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
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 100))
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
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
            m_DrawShadowedText(1, itemtbl.item.Name, "GModNotify", w / 2, 26, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            m_DrawShadowedText(1, s.TitleText, "moat_ItemDesc", 13, 5, Color(255, 255, 255))
        end,
        Panel = function(s, w, h, crate_contents)
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50))
            m_DrawShadowedText(1, "This crate contains one of the following " .. #crate_contents .. " items:", "moat_ItemDesc", 5, 2, Color(200, 200, 200))
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

MOAT_THEME.Themes["Alpha"] = {
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
    CloseB = {728, 5,system.IsOSX() and 18 or 17, 17},
    CLOSE_PAINT = function(s, w, h)
        if (not s.LerpNum) then
            s.LerpNum = 0
        end

        if (s:IsHovered() or s:IsDown()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

		if (system.IsOSX()) then
			draw_RoundedBox(4, 0, 0, w, h, Color(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum)))
			draw_SimpleText("r", "marlett", 7, 8, Color(255 - (55 * s.LerpNum), 50 + (150 * s.LerpNum), 50 + (150 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_RoundedBox(4, 0, 0, w, h, Color(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum)))
        	draw_SimpleText("r", "marlett", 8 + 1, 8, Color(255 - (55 * s.LerpNum), 50 + (150 * s.LerpNum), 50 + (150 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
    end,
    CatSpacing = 0,
    CatInfo = {0, 90, 30},
    CAT_PAINT = function(s, w, h, cur_cat)
		if (s.CatLabel == "Store") then
			draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8-2, (h/2)-8-2, 20, 20, Color(0, 0, 0, 25))
			cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8, (h/2)-8, 16, 16, ux.ShiftColor(ux.p.mg.shop, ux.p.mg.shop2, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1))
	
            return
        end

        if (cur_cat == s.CAT_NUM) then
            draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        else
            draw_RoundedBox(0, 0, 0, w, h, Color(16, 19, 24, s.hover_coloral))
        end

        draw_SimpleTextOutlined(s.CatLabel, "moat_Medium10", w / 2, h / 2, ux.ShiftColor(ux.p.mg.light, ux.p.white, (cur_cat ~= s.CAT_NUM) and (s.hover_coloral > 0 and s.hover_coloral/155 or 0) or 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 25))
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
        local draw_x = 2
        local draw_y = 2
        local draw_w = w - 4
        local draw_h = h - 4
        local draw_y2 = 2 + ((h - 4) / 2)
        local draw_h2 = (h - 4) - ((h - 4) / 2)
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(0, 0, 0, 100))
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(150, 150, 150, lr))
        if (not item) then return end

        if (item.c) then
            draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(32, 34, 42))

            if (item.l and item.l == 1) then
                draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(255, 255, 255, 50))
            end

            surface_SetMaterial(fetch_asset(circ_gradient))
            surface_SetDrawColor(rarity_names[item.item.Rarity][2].r, rarity_names[item.item.Rarity][2].g, rarity_names[item.item.Rarity][2].b, 255)
            surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(0, 0, 0, 255)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(0, 0, 0, 175)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(0, 0, 0, lr)
            surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
            surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(rarity_names[item.item.Rarity][2].r, rarity_names[item.item.Rarity][2].g, rarity_names[item.item.Rarity][2].b, lr * 3)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
        end

        surface_SetDrawColor(83, 83, 83, 255)

        if (item.c) then
            surface_SetDrawColor(rarity_names[item.item.Rarity][2])
        end

        surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
        surface_SetDrawColor(83, 83, 83, 175)
        surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)

        if (item.c) then
            surface_SetDrawColor(rarity_names[item.item.Rarity][2].r, rarity_names[item.item.Rarity][2].g, rarity_names[item.item.Rarity][2].b, lr / 2)
        else
            surface_SetDrawColor(183, 183, 183, 0)
            surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(0, 0, 0, lr / 2)
            surface_SetMaterial(fetch_asset(circ_gradient))
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
        end
    end,
    LSLOT_PAINT = function(s, w, h, lr, item)
        local y2 = 10
        local draw_x = 2 + 3
        local draw_y = 2 + y2 + 3
        local draw_w = w - 4 - 6
        local draw_h = h - 4 - y2 - 6
        local draw_y2 = 2 + ((h - 4) / 2) + y2 + 3
        local draw_h2 = (h - 4) - ((h - 4) / 2) - y2 - 6
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(0, 0, 0, 100))
        draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(150, 150, 150, lr))
        if (not item) then return end

        if (item.c) then
            draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(32, 34, 42))

            if (item.l and item.l == 1) then
                draw_RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(255, 255, 255, 50))
            end

            surface_SetMaterial(fetch_asset(circ_gradient))
            surface_SetDrawColor(rarity_names[item.item.Rarity][2].r, rarity_names[item.item.Rarity][2].g, rarity_names[item.item.Rarity][2].b, 255)
            surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(0, 0, 0, 255)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(0, 0, 0, 175)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(0, 0, 0, lr)
            surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
            surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
            surface_SetDrawColor(rarity_names[item.item.Rarity][2].r, rarity_names[item.item.Rarity][2].g, rarity_names[item.item.Rarity][2].b, lr * 3)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
        end

        surface_SetDrawColor(83, 83, 83, 255)

        if (item.c) then
            surface_SetDrawColor(rarity_names[item.item.Rarity][2])
        end

        surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
        surface_SetDrawColor(83, 83, 83, 175)
        surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)

        if (item.c) then
            surface_SetDrawColor(rarity_names[item.item.Rarity][2].r, rarity_names[item.item.Rarity][2].g, rarity_names[item.item.Rarity][2].b, lr / 2)
        else
            surface_SetMaterial(fetch_asset(circ_gradient))
            surface_SetDrawColor(50, 50, 50, 25 - (lr / 2))
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
            surface_DrawTexturedRect(draw_x, draw_y, draw_w, draw_h)
        end
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