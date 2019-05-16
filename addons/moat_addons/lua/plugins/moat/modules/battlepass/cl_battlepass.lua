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

function m_CreateBattlePanel(pnl_x, pnl_y, pnl_w, pnl_h)
    if IsValid(M_BATTLE_PNL) then return end
    M_BATTLE_PNL = vgui.Create("DFrame")
    M_BATTLE_PNL:SetSize(pnl_w, pnl_h)
    M_BATTLE_PNL:SetPos(pnl_x, pnl_y)
    M_BATTLE_PNL:MakePopup()
    M_BATTLE_PNL:SetKeyboardInputEnabled(false)
    M_BATTLE_PNL:SetDraggable(false)
    M_BATTLE_PNL:ShowCloseButton(false)
    M_BATTLE_PNL:SetTitle("")
    M_BATTLE_PNL:SetAlpha(0)
    M_BATTLE_PNL.Think = function(s)
    	if (not IsValid(MOAT_INV_BG)) then
    		s:Remove()
    	else
			local x, y = MOAT_INV_BG:GetPos()
            s:SetPos(x + 5, y + 30)
    	end
    	if ((input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT)) and not s:IsHovered()) then
    		s:MakePopup()
    	end
    end
    M_BATTLE_PNL.Paint = function(s, w, h)
        local degrees = (CurTime() * 10) % 360
        local r = HSVToColor(degrees, 1, 1)
        surface.SetDrawColor(21, 28, 35, 150)
        surface.DrawRect(0, 0, w, h)
        DrawBlur(s, 3)
        cdn.DrawImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 225))
    	draw.DrawText('Coming Soon', "moat_JackBig", w/2, h/2 - 40 - 30, r, TEXT_ALIGN_CENTER)
        draw.DrawText('-Velkon <3', "moat_JackBig", w/2, h/2 - 40 + 30, r, TEXT_ALIGN_CENTER)
    end
    M_BATTLE_PNL:AlphaTo(255, 0.15, 0.15)
end

function m_RemoveBattlePanel()
    if (not IsValid(M_BATTLE_PNL)) then return end

	M_BATTLE_PNL:AlphaTo(0, 0.15, 0, function()
		M_BATTLE_PNL:Remove()
	end)
end