local cookie_prefix = "moatbeta_pos"

MOAT_MODEL_POS_EDITS = MOAT_MODEL_POS_EDITS or {}
MOAT_MODEL_POS_EDITS_DEFAULTS = {
	0,
	0,
	1,
	0,
	0,
	0
}

local rotate_labels = {"Tilt", "Rotate", "Custom Size"}
local pos_labels = {"Back | Front", "Left | Right", "Down | Up"}
local gradient_d = Material("vgui/gradient-d")
function moat_InitializeEditPanel(item_enum, bg, bg_w, bg_h)
	local item = m_GetCosmeticItemFromEnum(item_enum)

	bg:SetSize(bg_w, bg_h + 80)
	bg:Center()

	MOAT_ITEM_EDIT_BG = vgui.Create("DPanel", bg)
	MOAT_ITEM_EDIT_BG:SetPos(5, bg_h)
	MOAT_ITEM_EDIT_BG:SetSize(bg_w-10, 75)
	MOAT_ITEM_EDIT_BG.Paint = function(s, w, h)

		for i = 1, 3 do
			m_DrawShadowedText(1, rotate_labels[i] .. "", "moat_ChatFont", 2+125, (i * 25) - 20, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		for i = 1, 3 do
			m_DrawShadowedText(1, "" .. pos_labels[i] .. "", "moat_ChatFont", 258+125, (i * 25) - 20, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	local slider_moving = false
	local cur_edits = MOAT_MODEL_POS_EDITS[item_enum]
	local edit_sliders = {}

	for i = 1, 3 do
		local POS_SLIDER = vgui.Create("DButton", MOAT_ITEM_EDIT_BG)
    	POS_SLIDER:SetPos(2, 13 + (25 * i) - 25)
    	POS_SLIDER:SetSize(250, 10)
    	POS_SLIDER:SetText("")
    	POS_SLIDER.Value = 0.5

		if (cur_edits and cur_edits[i]) then
			if (i == 1 and MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_enum]) then
				POS_SLIDER.Value = 0
				rotate_labels[i] = "Tilt is not available for this item."
			elseif (i == 3) then
				POS_SLIDER.Value = (cur_edits[i] - 0.8)/0.4
			else
				POS_SLIDER.Value = ((cur_edits[i]/180)/2) + 0.5
			end
		end

    	POS_SLIDER.HoverVal = 0
    	POS_SLIDER.Paint = function(s, w, h)
        	draw.RoundedBox(0, 0, 0, w, h, Color(255 - (255 * s.Value), 255 * s.Value, 0, 25 + (25 * s.HoverVal)))
        	draw.RoundedBox(0, 0, 0, math.Clamp(w*s.Value, 0, 250), h, Color(255 - (255 * s.Value), 255 * s.Value, 0, 200))
    	end
   		POS_SLIDER.Think = function(s)
			if (i == 1 and MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_enum]) then
				s.HoverVal = 0

				return
			end

   			if (s:IsHovered() or s.Moving) then
   				s.HoverVal = Lerp(FrameTime() * 10, s.HoverVal, 1)
   			else
   				s.HoverVal = Lerp(FrameTime() * 10, s.HoverVal, 0)
   			end

        	if (s.Moving) then
            	local x, y = s:CursorPos()
            	s.Value = math.Clamp(x/250, 0, 1)
            	if (not MOAT_MODEL_POS_EDITS[item_enum]) then
            		MOAT_MODEL_POS_EDITS[item_enum] = {}
            	end

            	if (i == 3) then
            		MOAT_MODEL_POS_EDITS[item_enum][3] = 0.8 + (s.Value * 0.4)
            	else
            		MOAT_MODEL_POS_EDITS[item_enum][i] = (s.Value - 0.5) * 360
				end
        	end

        	if (input.IsMouseDown(MOUSE_LEFT) and s:IsHovered() and not slider_moving) then
        		slider_moving = true
            	s.Moving = true
        	elseif (input.IsMouseDown(MOUSE_LEFT) and s.Moving) then
        		return
        	elseif (s.Moving) then
				moat_SaveItemPosition(item_enum, i)
            	s.Moving = false
            	slider_moving = false
        	end
    	end
    	table.insert(edit_sliders, POS_SLIDER)
	end

	for i = 1, 3 do
		local POS_SLIDER = vgui.Create("DButton", MOAT_ITEM_EDIT_BG)
    	POS_SLIDER:SetPos(258, 13 + (25 * i) - 25)
    	POS_SLIDER:SetSize(250, 10)
    	POS_SLIDER:SetText("")
    	POS_SLIDER.HoverVal = 0
    	POS_SLIDER.Value = 0.5
		
		
		if (cur_edits and cur_edits[i + 3]) then
			POS_SLIDER.Value = ((cur_edits[i + 3]/2.5)/2) + 0.5
        end

    	POS_SLIDER.Paint = function(s, w, h)
        	draw.RoundedBox(0, 0, 0, w, h, Color(255 - (255 * s.Value), 255 * s.Value, 0, 25 + (25 * s.HoverVal)))
        	draw.RoundedBox(0, 0, 0, math.Clamp(w*s.Value, 0, 250), h, Color(255 - (255 * s.Value), 255 * s.Value, 0, 200))
    	end
   		POS_SLIDER.Think = function(s)
   			if (s:IsHovered() or s.Moving) then
   				s.HoverVal = Lerp(FrameTime() * 10, s.HoverVal, 1)
   			else
   				s.HoverVal = Lerp(FrameTime() * 10, s.HoverVal, 0)
   			end

        	if (s.Moving) then
            	local x, y = s:CursorPos()
            	s.Value = math.Clamp(x/250, 0, 1)
            	if (not MOAT_MODEL_POS_EDITS[item_enum]) then
            		MOAT_MODEL_POS_EDITS[item_enum] = {}
            	end
				
				MOAT_MODEL_POS_EDITS[item_enum][i + 3] = (s.Value - 0.5) * 5
        	end

        	if (input.IsMouseDown(MOUSE_LEFT) and s:IsHovered() and not slider_moving) then
        		slider_moving = true
            	s.Moving = true
        	elseif (input.IsMouseDown(MOUSE_LEFT) and s.Moving) then
        		return
        	elseif (s.Moving) then
				moat_SaveItemPosition(item_enum, i + 3)
            	s.Moving = false
            	slider_moving = false
        	end
    	end
    	table.insert(edit_sliders, POS_SLIDER)
	end

	local hover_coloral2 = 0
	local btn_hovered2 = 1
    local btn_color_a2 = false

    local EDIT_RESET = vgui.Create("DButton", MOAT_ITEM_EDIT_BG)
    EDIT_RESET:SetSize(227, 29)
    EDIT_RESET:SetPos(513, 75-63)
    EDIT_RESET:SetText("")
    EDIT_RESET.Paint = function(s, w, h)
        surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(200, 0, 0, 20 + hover_coloral2 / 5)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(255, 0, 0, 20 + hover_coloral2 / 5)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Reset Changes", "Trebuchet24", w / 2, h / 2, Color(200, 100, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    EDIT_RESET.Think = function(s)
        if (not s:IsHovered()) then
            btn_hovered2 = 0
            btn_color_a2 = false

            if (hover_coloral2 > 0) then
                hover_coloral2 = Lerp(2 * FrameTime(), hover_coloral2, 0)
            end
        else
            if (hover_coloral2 < 154 and btn_hovered == 0) then
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
                    if (hover_coloral2 <= 50) then
                        btn_color_a2 = true
                    else
                        hover_coloral2 = hover_coloral2 - (100 * FrameTime())
                    end
                end
            end
        end
    end
    EDIT_RESET.DoClick = function(s)
    	for i = 1, #edit_sliders do
			if (i == 1 and MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_enum]) then
				edit_sliders[i].Value = 0
			else
				edit_sliders[i].Value = 0.5
			end
    	end

    	MOAT_MODEL_POS_EDITS[item_enum] = table.Copy(MOAT_MODEL_POS_EDITS_DEFAULTS)
		moat_UpdateItemPositions(item_enum)

		surface.PlaySound("UI/buttonclick.wav")
    end

	local hover_coloral = 0
	local btn_hovered = 1
    local btn_color_a = false

    local EDIT_SAVE = vgui.Create("DButton", MOAT_ITEM_EDIT_BG)
    EDIT_SAVE:SetSize(227, 29)
    EDIT_SAVE:SetPos(513, 75-29)
    EDIT_SAVE:SetText("")
    EDIT_SAVE.Paint = function(s, w, h)
        surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 200, 0, 20 + hover_coloral / 5)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 255, 0, 20 + hover_coloral / 5)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Done", "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    EDIT_SAVE.Think = function(s)
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
	EDIT_SAVE.DoClick = function(s)
		moat_UpdateItemPositions(item_enum)
		moat_RemoveEditPositionPanel()
		if (IsValid(M_INV_PMDL)) then
			M_INV_PMDL:ResetZoom()
		end

		surface.PlaySound("UI/buttonclick.wav")
	end
end

function moat_SaveItemPosition(item_enum, slider_id)
	local val = MOAT_MODEL_POS_EDITS_DEFAULTS[slider_id]
	if (MOAT_MODEL_POS_EDITS[item_enum] and MOAT_MODEL_POS_EDITS[item_enum][slider_id]) then
		val = MOAT_MODEL_POS_EDITS[item_enum][slider_id]
	end

	if (MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_enum]) then
		val = 0
	end

	local cookie_name = cookie_prefix .. item_enum .. slider_id
	cookie.Set(cookie_name, val)

	net.Start("MOAT_UPDATE_MODEL_POS_SINGLE")
    net.WriteUInt(item_enum, 16)
	net.WriteUInt(slider_id, 8)
	net.WriteDouble(val)
	net.SendToServer()

	moat_UpdateItemPositions(item_enum)
end

function moat_UpdateItemPositions(enum)
	local beginning = cookie_prefix .. enum

	net.Start("MOAT_UPDATE_MODEL_POS")
    net.WriteUInt(enum, 16)
	for i = 1, 6 do
		local val = MOAT_MODEL_POS_EDITS_DEFAULTS[i]
		if (MOAT_MODEL_POS_EDITS[enum] and MOAT_MODEL_POS_EDITS[enum][i]) then
			val = MOAT_MODEL_POS_EDITS[enum][i]
		end

		if (i == 1 and MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_enum]) then
			val = 0
		end


		net.WriteDouble(val)
		cookie.Set(beginning .. i, val)
	end
    net.SendToServer()
end

function moat_RemoveEditPositionPanel()
	if (IsValid(MOAT_ITEM_EDIT_BG)) then
		MOAT_ITEM_EDIT_BG:Remove()
		MOAT_INV_BG:SetSize(MOAT_INV_BG_W, MOAT_INV_BG_H)
		MOAT_INV_BG:Center()
	end
end