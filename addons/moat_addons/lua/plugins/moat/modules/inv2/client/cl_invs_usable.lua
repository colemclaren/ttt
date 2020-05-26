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
local draw_NoTexture = draw.NoTexture
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
local mat_lock = Material("icon16/lock.png")
local mat_paint = Material("icon16/palette.png")

function m_DrawItemSlot(num, itemtbl, pnl, da_x, da_y)
    local item_cache = itemtbl
    local m_WClass = {}
	local m_ItemExists = false

	if (item_cache.c) then
		m_ItemExists = true
	end

	local m_WClass = {}

	if (m_ItemExists) then
		if (item_cache.item.Image) then
			m_WClass.WorldModel = item_cache.item.Image
		elseif (item_cache.item.Model) then
			m_WClass.WorldModel = item_cache.item.Model
			m_WClass.ModelSkin = item_cache.item.Skin
		else
			m_WClass = weapons.Get(item_cache.w)
		end
	end

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end

    local hover_coloral = 0
	
    local m_DPanel = vgui.Create("DPanel", pnl)
    m_DPanel:SetSize(68, 68)
    m_DPanel:SetPos(da_x, da_y)
    m_DPanel.Paint = function(s, w, h)
        if (MT[CurTheme].SLOT_PAINT) then
            MT[CurTheme].SLOT_PAINT(s, w, h, hover_coloral, item_cache)

            return
        end

        local draw_x = 2
		local draw_y = 2
		local draw_w = w - 4
		local draw_h = h - 4
		local draw_y2 = 2 + ((h - 4) / 2)
		local draw_h2 = (h - 4) - ((h - 4) / 2)
		surface_SetDrawColor(0, 0, 0, 100)
		surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
		surface_SetDrawColor(50, 50, 50, hover_coloral)
		surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
		if (not item_cache) then return end

		if (item_cache.c and item_cache.item and item_cache.item.Rarity) then
			surface_SetDrawColor(150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 100)
			surface_DrawRect(draw_x, draw_y, draw_w, draw_h)

			if (item_cache.l and item_cache.l == 1) then
				surface_SetDrawColor(240, 245, 253, 50)
				surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
			end

			surface_SetDrawColor(rarity_names[item_cache.item.Rarity][2].r, rarity_names[item_cache.item.Rarity][2].g, rarity_names[item_cache.item.Rarity][2].b, 100 + hover_coloral)
			surface_SetMaterial(gradient_d)
			surface_DrawTexturedRect(draw_x, draw_y2 - (hover_coloral / 7), draw_w, draw_h2 + (hover_coloral / 7) + 1)
		end

		surface_SetDrawColor(62, 62, 64, 255)

		if (item_cache.c and item_cache.item and item_cache.item.Rarity) then
			surface_SetDrawColor(rarity_names[item_cache.item.Rarity][2])
		end

		surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
		surface_SetDrawColor(62, 62, 64, hover_coloral / 2)
    end

        --  surface_DrawPoly( triangle )
    local m_DPanelIcon = {}
    m_DPanelIcon.SIcon = vgui.Create("MoatModelIcon", m_DPanel)
    m_DPanelIcon.SIcon:SetPos(2, 2)
    m_DPanelIcon.SIcon:SetSize(64, 64)
    m_DPanelIcon.SIcon:SetTooltip(nil)

    m_DPanelIcon.SIcon.Think = function(s)
        s:SetTooltip(nil)
    end

	m_DPanelIcon.SIcon:SetVisible(false)

	if (m_ItemExists and m_WClass) then
		m_DPanelIcon.SIcon:SetModel(m_WClass.WorldModel, m_WClass.ModelSkin)
		m_DPanelIcon.SIcon:SetVisible(true)
	end

	m_DPanelIcon.WModel = nil
	m_DPanelIcon.Item = nil
	m_DPanelIcon.MSkin = nil

	if (m_ItemExists and m_WClass) then
		if (not string.EndsWith(m_WClass.WorldModel, ".mdl")) then
			if (not IsValid(m_DPanelIcon.SIcon.Icon)) then m_DPanelIcon.SIcon:CreateIcon(n) end
			m_DPanelIcon.SIcon.Icon:SetAlpha(0)
		end

		m_DPanelIcon.WModel = m_WClass.WorldModel
		m_DPanelIcon.Item = item_cache
		if (m_WClass.ModelSkin) then
			m_DPanelIcon.MSkin = m_WClass.ModelSkin
		end
	end
	
	m_DPanelIcon.SIcon.PaintOver = function(self, w, h)
		if (not item_cache) then
			return
		end

		if (item_cache and item_cache.item) then
			local icon = item_cache.item.Image
			if (not icon and item_cache.w) then
				icon = util.GetWeaponModel(item_cache.w)
			elseif (not icon and item_cache.item.Model) then
				icon = item_cache.item.Model
			end

			if (icon and not string.EndsWith(icon, ".mdl")) then
				-- s.Icon:SetAlpha(0)
				if (item_cache.item and item_cache.item.Clr) then
					cdn.DrawImage(icon, 0, 0, w, h, {r = item_cache.item.Clr[1], g = item_cache.item.Clr[2], b = item_cache.item.Clr[3], a = 255})
				elseif (icon:StartWith("https")) then
					cdn.DrawImage(icon, 1, 1, w, h, {r = 255, g = 255, b = 255, a = 100})
					cdn.DrawImage(icon, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 255})
				else
					surface_SetDrawColor(240, 245, 253, 100)
					surface_SetMaterial(Material(icon))
					surface_DrawTexturedRect(1, 1, w, h)
					surface_SetDrawColor(240, 245, 253, 255)
					surface_DrawTexturedRect(0, 0, w, h)
				end
			else
				-- s.Icon:SetAlpha(255)
			end

			local locked = false

			if (item_cache.l and item_cache.l == 1) then
				locked = true
				surface_SetDrawColor(240, 245, 253)
				surface_SetMaterial(mat_lock)
				surface_DrawTexturedRect(1, 1, 16, 16)
			end

			if (item_cache.p or item_cache.p2 or item_cache.p3) then
				surface_SetDrawColor(240, 245, 253)
				surface_SetMaterial(mat_paint)
				surface_DrawTexturedRect(locked and 18 or 1, 1, 16, 16)
			end
		end
	end

    local m_DPanelBTN = vgui.Create("DButton", m_DPanel)
	m_DPanelBTN:SetText("")
	m_DPanelBTN:SetSize(68, 68)
	m_DPanelBTN.Paint = function(s, w, h) end
	local btn_hovered = 1
	local btn_color_a = false

	m_DPanelBTN.Think = function(s)
		if (not s:IsHovered()) then
			btn_hovered = 0
			btn_color_a = false

			if (hover_coloral > 0) then
				hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
			end

			if (m_HoveredSlot == (num .. "u")) then
				HoveringSlot = false
			end
		else
			if (IsValid(M_INV_MENU)) then
				if (M_INV_MENU.Hovered) then
					btn_hovered = 0
					btn_color_a = false

					if (hover_coloral > 0) then
						hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
					end

					return
				end
			end

			-- m_HoveredSlot = num .. "u"

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

	m_DPanelBTN.OnCursorEntered = function(s)
		m_HoveredSlot = num .. "u"
		HoveringSlot = true

		if (IsValid(MOAT_INV_S)) then
            MOAT_INV_S.AnimVal = 1
			MOAT_INV_S:SetVisible(true)
            MOAT_INV_S:SetAlpha(255)
            MOAT_INV_S:Think()
		end

		if (item_cache and item_cache.c) then
			sfx.Hover()
		end
	end

	m_DPanelBTN.OnCursorExited = function(s)
		HoveringSlot = false
	end

	sfx.ClickSound(m_DPanelBTN)

    return m_DPanel, m_DPanelBTN
end

local non_char_cap = {
    ["1"] = "!",
    ["2"] = "@",
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
    ["7"] = "&",
    ["8"] = "*",
    ["9"] = "(",
    ["0"] = ")",
    ["-"] = "_",
    ["="] = "+",
    ["["] = "{",
    ["]"] = "}",
    ["\\"] = "|",
    [";"] = ":",
    ["/"] = "?",
    ["`"] = "~"
}

function m_IniateUsableItem(num, itemtbl)
	if (not IsValid(MOAT_INV_BG)) then
		net.Start "MOAT_END_USABLE"
        net.SendToServer()
		return
	end

    m_ChangeInventoryPanel(-2, false)

	if (IsValid(M_USABLE_PNL_BG)) then M_USABLE_PNL_BG:Remove() end
    INV_SELECTED_ITEM = nil
    local sel_itm = nil

    M_USABLE_PNL_BG = vgui.Create("DPanel", M_USABLE_PNL)
    M_USABLE_PNL_BG:SetSize(385 - (5 * 2) - 7, MOAT_INV_BG:GetTall() - 30 - 5)
    M_USABLE_PNL_BG:SetPos(5, 30)
    M_USABLE_PNL_BG.ErrorMessage = nil
    M_USABLE_PNL_BG.Paint = function(s, w, h)
        surface_SetDrawColor(62, 62, 64, 255)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(0, 0, 0, 100)
        surface_DrawRect(1, 1, w - 2, h - 2)

        surface_SetDrawColor(62, 62, 64, 255)
        surface_DrawOutlinedRect(0, 0, w, h)

        draw.SimpleText("Select the item you wish to affect.", "GModNotify", w/2, 10, Color(255, 255, 255, 150), TEXT_ALIGN_CENTER)

        surface_SetDrawColor(62, 62, 64, 25)
        surface_DrawRect(35, 35, w - 70, h/2 - 55)

        surface_SetDrawColor(62, 62, 64, 200)
        --surface_DrawLine(35, 35, w - 35, 35)
        --surface_DrawLine(35, h/2 - 25, w - 35, h/2 - 25)
        surface_DrawOutlinedRect(35, 35, w - 70, h/2 - 55)

        draw.SimpleText("You're Using", "GModNotify", w/2, 85, Color(255, 255, 255), TEXT_ALIGN_CENTER)

        surface_SetDrawColor(rarity_names[itemtbl.item.Rarity][2])
        surface_DrawOutlinedRect((w/2) - 34, 115, 68, 68)
        surface_SetDrawColor(rarity_names[itemtbl.item.Rarity][2].r, rarity_names[itemtbl.item.Rarity][2].g, rarity_names[itemtbl.item.Rarity][2].b, 75)
        surface_DrawOutlinedRect((w/2) - 35, 114, 70, 70)
        surface_SetDrawColor(rarity_names[itemtbl.item.Rarity][2].r, rarity_names[itemtbl.item.Rarity][2].g, rarity_names[itemtbl.item.Rarity][2].b, 25)
        surface_DrawOutlinedRect((w/2) - 36, 113, 72, 72)

        --draw.SimpleText(itemtbl.item.Name, "GModNotify", w/2, 175, itemtbl.item.NameColor or rarity_names[itemtbl.item.Rarity][2], TEXT_ALIGN_CENTER)

        draw.SimpleText("You've Selected", "GModNotify", w/2, 275, Color(255, 255, 255), TEXT_ALIGN_CENTER)

        if (INV_SELECTED_ITEM == nil) then
            draw.SimpleText("nothing, click to select", "GModNotify", w/2, 305, Color(255, 255, 255, 50), TEXT_ALIGN_CENTER)
        elseif (s.ErrorMessage) then
            draw.SimpleText("You cannot use this item for selection!", "GModNotify", w/2, 385, Color(200, 0, 0, 255), TEXT_ALIGN_CENTER)
            draw.SimpleText(s.ErrorMessage, "GModNotify", w/2, 405, Color(200, 0, 0, 255), TEXT_ALIGN_CENTER)

            surface_SetDrawColor(255, 0, 0)
            surface_DrawOutlinedRect((w/2) - 34, 305, 68, 68)
            surface_DrawOutlinedRect((w/2) - 35, 304, 70, 70)
            surface_DrawOutlinedRect((w/2) - 36, 303, 72, 72)
        elseif (sel_itm and sel_itm.item) then
            surface_SetDrawColor(rarity_names[sel_itm.item.Rarity][2])
            surface_DrawOutlinedRect((w/2) - 34, 305, 68, 68)
            surface_SetDrawColor(rarity_names[sel_itm.item.Rarity][2].r, rarity_names[sel_itm.item.Rarity][2].g, rarity_names[sel_itm.item.Rarity][2].b, 75)
            surface_DrawOutlinedRect((w/2) - 35, 304, 70, 70)
            surface_SetDrawColor(rarity_names[sel_itm.item.Rarity][2].r, rarity_names[sel_itm.item.Rarity][2].g, rarity_names[sel_itm.item.Rarity][2].b, 25)
            surface_DrawOutlinedRect((w/2) - 36, 303, 72, 72)

            if (itemtbl.u == 4001) then
                surface_SetDrawColor(62, 62, 64, 255)
                surface_DrawOutlinedRect(5, h - 115, w - 10, 30)
                surface_SetDrawColor(62, 62, 64, 25)
                surface_DrawRect(5, h - 115, w - 10, 30)

                draw_SimpleText("Racist or Harassing names will result in punishment. Please be nice :)", "DermaDefault", w/2, h - 120, Color(200, 200, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

                --draw_SimpleText("WWWWWWWWWWWWWWWWWWWW", "GModNotify", w/2, h - 109, Color(200, 200, 200, 100), TEXT_ALIGN_CENTER)
            elseif (ItemPaints(itemtbl.u)) then
                draw_SimpleText("Click the icon above to preview.", "DermaDefault", w/2, h - 120, Color(200, 200, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
            end
        end
    end
    M_USABLE_PNL_BG.OnRemove = function()
        net.Start("MOAT_END_USABLE")
        net.SendToServer()
    end

    local M_REQ_A = vgui.Create("DButton", M_USABLE_PNL_BG)
    M_REQ_A:SetDisabled(true)

    M_REQ_A.DoClick = function()
        net.Start("MOAT_USE_USABLE")
        net.WriteDouble(num)
        net.WriteDouble(itemtbl.c)
        net.WriteDouble(INV_SELECTED_ITEM)
        net.WriteDouble(sel_itm.c)
        net.SendToServer()
        return
    end

    if (itemtbl.u == 4001) then
        local ne = vgui.Create("DTextEntry", M_USABLE_PNL_BG)
        ne:SetPos(5, M_USABLE_PNL_BG:GetTall() - 115)
        ne:SetSize(M_USABLE_PNL_BG:GetWide() - 10, 30)
        ne:SetFont("GModNotify")
        ne.MaxChars = 30
        ne.ed = false
        ne.txt = ""
        ne.Paint = function(s, w, h)
            if (not sel_itm or M_USABLE_PNL_BG.ErrorMessage) then return end
            if (#s:GetText() < 1 and not s.ed) then draw_SimpleText("Enter your item's new name..", "GModNotify", 2, 6, Color(200, 200, 200, 100), TEXT_ALIGN_LEFT) end

            local tw = draw_SimpleText(s.txt, "GModNotify", 2, 6, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT)

			s:DrawTextEntryText(Color(200, 200, 200, 255), s:GetHighlightColor(), s:GetCursorColor())

            -- if (s.ed and math.Round(CurTime() * 2) % 2 == 0) then draw_SimpleText("|", "GModNotify", (w/2) + (tw/2), 4, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT) end
        end
        ne.Think = function(s)
            if (INV_SELECTED_ITEM == nil or M_USABLE_PNL_BG.ErrorMessage) then
                M_REQ_A:SetDisabled(true)
                return
            end

            if (#s:GetText() < 3 or #s:GetText() > 30) then M_REQ_A:SetDisabled(true) elseif (#s:GetText() > 2) then M_REQ_A:SetDisabled(false) end

			if (s:IsHovered()) then
				s.h = true
			else
				s.h = false
			end

            if (input.IsMouseDown(MOUSE_LEFT)) then
                if (s.h) then
                    s.ed = true
                    MOAT_INV_BG:SetKeyboardInputEnabled(true)
					M_USABLE_PNL:SetKeyboardInputEnabled(true)
					M_USABLE_PNL_BG:SetKeyboardInputEnabled(true)
                else
                    s.ed = false
                    MOAT_INV_BG:SetKeyboardInputEnabled(false)
                end
            end
        end

        ne.OnTextChanged = function(s)
            local txt = s:GetValue()
            local amt = string.len(txt)

            if (amt > s.MaxChars) then
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

        ne.AddLetter = function(s, b, l, c)
            if (b) then s.txt = s.txt:sub(1, #s.txt - 1) return end
            if (c) then l = non_char_cap[l] or l:upper() end

            if (s.CheckUpdate(s, l)) then
                s.txt = s.txt .. l
            end
        end
        ne.CheckUpdate = function(s, l)
            if (l == " " and #s.txt < 1) then return false end
            if (l == "#" and #s.txt < 1) then return false end
            if (#s.txt >= s.MaxChars) then return false end

            return true
        end

        -- local caps = false
        -- local shift = false

        -- MOAT_INV_BG.OnKeyCodePressed = function(s, n)
        --     if (not IsValid(ne)) then return end
        --     -- if (not ne.ed) then return end
            
        --     local k = input.GetKeyName(n)

        --     --if (k == "'") then return end
        --     if (k == "SHIFT") then shift = true end
        --     if (k == "CAPSLOCKTOGGLE") then caps = not caps end
        --     if (k == "BACKSPACE") then ne.AddLetter(ne, true) return end
        --     if (k == "SPACE") then ne.AddLetter(ne, false, " ", false) end
        --     local c = ((caps and not shift) or (shift and not caps))

        --     if (#k == 1) then
        --         ne.AddLetter(ne, false, k, c)
        --     end
        --     if (k == "SEMICOLON") then ne.AddLetter(ne, false, ";", c) end
        -- end

        -- MOAT_INV_BG.OnKeyCodeReleased = function(s, k)
        --     if (not IsValid(ne)) then return end
        --     -- if (not ne.ed) then return end

        --     k = input.GetKeyName(k)

        --     if (k == "SHIFT") then shift = false end
        -- end

        M_REQ_A.DoClick = function()
            net.Start("MOAT_USE_NAME_MUTATOR")
            net.WriteDouble(num)
            net.WriteDouble(itemtbl.c)
            net.WriteDouble(INV_SELECTED_ITEM)
            net.WriteDouble(sel_itm.c)
            net.WriteString(ne:GetText())
            net.SendToServer()
            return
        end
    end

    local selected_pnl = nil
    local selected_pnl_btn = nil
    local selected_cache = {}

    M_USABLE_PNL_BG.Think = function(s)
        if (INV_SELECTED_ITEM == nil) then return end

        if (selected_cache ~= INV_SELECTED_ITEM) then
			selected_cache = INV_SELECTED_ITEM

            s.ErrorMessage = nil
            M_REQ_A:SetDisabled(false)

            if (IsValid(selected_pnl)) then selected_pnl:Remove() end
            sel_itm = m_Inventory[INV_SELECTED_ITEM]

            selected_pnl, selected_pnl_btn = m_DrawItemSlot(INV_SELECTED_ITEM, sel_itm, M_USABLE_PNL_BG, (M_USABLE_PNL_BG:GetWide()/2) - 34, 305)

            if (not MOAT_ITEM_CHECK[itemtbl.item.ItemCheck or 1][1](sel_itm)) then
                s.ErrorMessage = MOAT_ITEM_CHECK[itemtbl.item.ItemCheck or 1][2]
                M_REQ_A:SetDisabled(true)
            end

            if (not ItemPaints(itemtbl.u)) then return end

            selected_pnl_btn.DoClick = function()
                local tint, paint, texture = nil, nil, nil

                if (ItemIsTint(itemtbl.u)) then
                    tint = itemtbl.u
                elseif (ItemIsPaint(itemtbl.u)) then
                    paint = itemtbl.u
                elseif (ItemIsSkin(itemtbl.u)) then
                    texture = itemtbl.u
                end

				if (not tint and not paint and not texture) then
					return
				end

                if (sel_itm and sel_itm.item and sel_itm.item.Model) then
                    moat_view_paint_preview(sel_itm.item.Model, true, tint, paint, texture)
                elseif (sel_itm and sel_itm.w) then
                    local m = weapons.Get(sel_itm.w).ViewModel
                    moat_view_paint_preview(m, false, tint, paint, texture)
                end
            end
        end
    end

    m_DrawItemSlot(num, itemtbl, M_USABLE_PNL_BG, (M_USABLE_PNL_BG:GetWide()/2) - 34, 115)

    local hover_coloral = 0
    M_REQ_A:SetSize(125, 30)
    M_REQ_A:SetPos(35, M_USABLE_PNL_BG:GetTall() - 65)
    M_REQ_A:SetText("")

    M_REQ_A.Paint = function(s, w, h)
        local green_col = 200

        if (s:GetDisabled()) then
            green_col = 50
        end

        surface_SetDrawColor(0, 0, 0, 255)
        surface_DrawRect(0, 0, w, h)

        surface_SetDrawColor(50, 50, 50, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(0, green_col, 0, 20 + hover_coloral / 5)
        surface_DrawRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(0, green_col + 55, 0, 20 + hover_coloral / 5)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Apply", "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local btn_hovered = 1
    local btn_color_a = false

    M_REQ_A.Think = function(s)
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

    local hover_coloral2 = 0
    local M_REQ_D = vgui.Create("DButton", M_USABLE_PNL_BG)
    M_REQ_D:SetSize(125, 30)
    M_REQ_D:SetPos(M_USABLE_PNL_BG:GetWide() - 35 - 125, M_USABLE_PNL_BG:GetTall() - 65)
    M_REQ_D:SetText("")

    M_REQ_D.Paint = function(s, w, h)
        surface_SetDrawColor(0, 0, 0, 255)
        surface_DrawRect(0, 0, w, h)

        surface_SetDrawColor(50, 50, 50, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(255, 0, 0, 20 + hover_coloral2 / 5)
        surface_DrawRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(255, 0, 0, 20 + hover_coloral2 / 5)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Cancel", "Trebuchet24", w / 2, h / 2, Color(200, 100, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local btn_hovered2 = 1
    local btn_color_a2 = false

    M_REQ_D.Think = function(s)
        if (not s:IsHovered()) then
            btn_hovered2 = 0
            btn_color_a2 = false

            if (hover_coloral2 > 0) then
                hover_coloral2 = Lerp(2 * FrameTime(), hover_coloral2, 0)
            end
        else
            if (hover_coloral2 < 154 and btn_hovered2 == 0) then
                hover_coloral2 = Lerp(5 * FrameTime(), hover_coloral2, 155)
            else
                btn_hovered2 = 1
            end

            if (btn_hovered2 == 1) then
                if (btn_color_a2) then
                    if (hover_coloral2 >= 154) then
                        btn_color_a2 = false
                    else
                        hover_coloral2 = hover_coloral2 + (100 * FrameTime())
                    end
                else
                    if (hover_coloral <= 50) then
                        btn_color_a2 = true
                    else
                        hover_coloral2 = hover_coloral2 - (100 * FrameTime())
                    end
                end
            end
        end
    end

    M_REQ_D.DoClick = function()
        m_ChangeInventoryPanel(MOAT_INV_CAT)
        return
    end


    /*
    net.Start("MOAT_USE_USABLE")
    net.WriteDouble(num)
    net.WriteDouble(item.c)
    net.SendToServer()*/
end

net.Receive("MOAT_END_USABLE", function()
    m_ChangeInventoryPanel(MOAT_INV_CAT)
end)