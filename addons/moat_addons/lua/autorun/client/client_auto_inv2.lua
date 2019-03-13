print "cl"

ii = ii or {}
icfg = icfg or {}

function ii.Reload()
	local scrw, scrh, t = ScrW(), ScrH(), {}

	-- Main MG Palette
	t.p = ux.p.mg

	-- Main Panel
	t.pnl = {
		w = 855,
		h = 575,
		x = ux.CenterX(855),
		y = ux.CenterY(575)
	}

	-- Top Header Bar
	t.head = 25
	t.header = 30

	-- Left Navigation Bar
	t.nav = {
		w = 250,
		h = t.pnl.h
	}

	-- Right Navigation Bar
	t.info = {
		w = 20,
		h = t.pnl.h
	}

	-- Main Padding
	t.pad = 5

	t.view = {
		w = t.pnl.w - (t.pad * 2),
		h = t.pnl.h - (t.pad * 2) - t.header,
		x = t.pad,
		y = t.pad + t.header,
		x2 = ((t.pnl.w - (t.pad * 3)) / 2) + (t.pad * 2),
		w2 = (t.pnl.w - (t.pad * 3)) / 2
	}

	t.icon = {
		s = t.view.w2 / 5,
		d = (t.view.w2 / 5) - 5
	}

	icfg = t
	return icfg
end

if (CLIENT) then
	ii.Reload()
	hook("moat", ii.Reload)
end

ii.Main = ii.Main or {}
ii.Main.Tabs = {Count = 0}

function ii.Main.Close()
	if (not IsValid(ii.bg)) then
		return
	end

	ii.bg:BounceOut(BOTTOM)
end

function ii.Main.Open()
	if (IsValid(ii.bg)) then
		ii.bg:Remove()
	end

	ii.bg = ux.Create("DFrame", function(s)
		s:Setup(icfg.pnl.x, -icfg.pnl.h, icfg.pnl.w, icfg.pnl.h)
		s:BounceIn()

		s:MakePopup()
		s:SetKeyboardInputEnabled(false)
		s:ShowCloseButton(false)
	end, {Paint = function(s, w, h)
		ux.Blur(s, 4)

		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)

		draw.WebImage("https://cdn.moat.gg/f/ZbiTBZ.png", 0, 0, 2048, 2048, Color(255, 255, 255, 250))
	end, Think = function(s) end})

	ii.RenderNav(ii.bg)

	/*
	local edge = cn.edge
	local pnlw, pnlh = (bgw/2) - edge - (edge/2), bgh - cn.nav - (edge * 2)
	local pnlx, pnly = (bgw/2) + (edge/2), cn.nav + edge

	--
	--  Inventory
	--

	ii.ip = ux.Create("DPanel", ii.bg, function(s)
		s:Setup(pnlx, pnly, pnlw, pnlh)
	end, {Paint = function(s) end})

	ii.isp = ux.Create("DScrollPanel", ii.ip, function(s)
		s:Setup(0, 0, pnlw, pnlh)

		local v = s:GetVBar()
		v:SetWide(0)

	end, {Paint = function(s) end})

	ii.ilp = ux.Create("DIconLayout", ii.isp, function(s)
		s:Setup(4, 4, pnlw, pnlh)
		s:SetSpaceX(4)
		s:SetSpaceY(4)

		for i = 1, 100 do
			ii.CreateIcon(s:Add("DButton"))
		end
	end, {Paint = function(s) end})

	--
	--  Loadout
	--

	ii.lp = ux.Create("DPanel", ii.bg, function(s)
		s:Setup(edge, pnly, pnlw, pnlh)
	end, {Paint = function(s) end})

	ii.llp1 = ux.Create("DIconLayout", ii.lp, function(s)
		s:Setup(4, 4, 106, pnlh)
		s:SetSpaceX(18)
		s:SetSpaceY(24)

		for i = 1, 5 do
			ii.CreateIcon(s:Add("DButton"))
		end
	end, {Paint = function(s) end})

	ii.llp2 = ux.Create("DIconLayout", ii.lp, function(s)
		s:Setup(pnlw - 88, 18, 106, pnlh)
		s:SetSpaceX(18)
		s:SetSpaceY(24)

		for i = 1, 5 do
			ii.CreateIcon(s:Add("DButton"), function(s)
				s.PaintOver = function(s, w, h)
					DisableClipping(true)
					draw.SimpleText("Loadout", "ux.14", w/2, 0, ux.p.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
					DisableClipping(false)
				end
			end)
		end
	end, {Paint = function(s) end})
	*/
end

function ii.RenderNav(bg)
	ii.header = ux.Create("DPanel", bg, function(s)
		s:Setup(0, 0, icfg.pnl.w, icfg.header)
	end, {Paint = function(s, w, h)
		surface.SetDrawColor(icfg.p.dark_darker)
		surface.DrawRect(0, 0, w, h)
	end})

	local tw, tx = icfg.pnl.w / ii.Main.Tabs.Count, 0
	ii.nav = ux.Create("DPanel", ii.header, function(s)
		s:Setup(0, 0, icfg.pnl.w, icfg.header)
	end, {Paint = function() end, PaintOver = function(s, w, h)
		s.BarPos = Lerp(RealFrameTime() * 15, s.BarPos or 0, tw * (ii.CurrentTab or 1) - tw)

		surface.SetDrawColor(ii.CurrentTab == 9 and icfg.p.yellow or icfg.p.blue)
		surface.DrawRect(s.BarPos, h - 3, tw, 3)
	end})

	for i = 1, ii.Main.Tabs.Count do
		ux.Create("DButton", ii.nav, function(s)
			s:Setup(tx, 0, tw, icfg.header)
			s:SetText ""
			s.Info = ii.Main.Tabs[i]
		end, {Think = function(s)
			ux.HoverThink(s, false, ii.CurrentTab == i)
		end, DoClick = function(s)
			ii.LoadTab(i)
		end, Paint = function(s, w, h)
				surface.SetDrawColor(ColorAlpha(icfg.p.dark_blue, 100 * s.hover))
				surface.DrawRect(0, 0, w, h)

				draw.SimpleText(s.Info.Title, "ux.16", w/2, h/2, i == 9 and icfg.p.yellow or ux.ShiftColor(
					icfg.p.text,
					icfg.p.white,
					s.hover
				), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end})

		tx = tx + tw
	end

	ii.LoadTab(2)
end

function ii.RenderView(tab)
	ii.CurrentView = ux.Create("DPanel", ii.bg, function(s)
		s:SetSize(tab.FullWidth and icfg.view.w or icfg.view.w2, icfg.view.h)
		s:FadeIn(icfg.view.x, icfg.view.y, 5)
		if (IsValid(ii.InventoryView) and not tab.FullWidth and not ii.InventoryView:IsVisible()) then
			ii.InventoryView:SetAlpha(0)
			ii.InventoryView:SetVisible(true)
			ii.InventoryView:SetPos(icfg.view.x2, icfg.view.y)
			ii.InventoryView:FadeIn(icfg.view.x2, icfg.view.y, 5)
		end
	end, {Paint = function(s, w, h)
		surface.SetDrawColor(icfg.p.dark_bluer)
		surface.DrawRect(0, 0, w, h)
	end})

	if (tab.OpenFunc) then
		tab.OpenFunc(ii.CurrentView)
	end
end

function ii.LoadTab(num)
	ii.CurrentTab = ii.CurrentTab or 0
	num = num or 1

	if (not ii.Main.Tabs[num]) then
		return
	end

	local new = ii.Main.Tabs[num]
	local cur = ii.Main.Tabs[ii.CurrentTab]

	if (new.FullWidth) then
		if (IsValid(ii.InventoryView)) then
			ii.InventoryView:FadeOut(function(p)
				if (IsValid(ii.InventoryView)) then ii.InventoryView:SetVisible(false) end
			end, 5)
		end
	elseif (not IsValid(ii.InventoryView)) then
		ii.RenderInventoryView()
		ii.RenderLoadoutView()
	end

	if (not cur or not IsValid(ii.CurrentView)) then
		ii.RenderView(new)
	else
		if (cur.CloseFunc) then
			cur.CloseFunc(ii.CurrentView)
		end

		ii.CurrentView:FadeOut(function(p)
			if (IsValid(ii.CurrentView)) then ii.CurrentView:Remove() end

			ii.RenderView(new)
		end, 5)
	end

	ii.CurrentTab = num

	hook.Run("inv.TabChange", new)
end

function ii.AddTab(order, title, full, open, close)
	if (order < 1) then
		return
	end

	ii.Main.Tabs.Count = ii.Main.Tabs.Count + 1
	ii.Main.Tabs[order] = {
		Enum = order,
		Title = title,
		FullWidth = full,
		OpenFunc = open,
		CloseFunc = close
	}
end

function ii.RenderInventoryView()
	if (IsValid(ii.InventoryView)) then
		return
	end

	ii.InventoryView = ux.Create("DPanel", ii.bg, function(s)
		s:SetSize(icfg.view.w2, icfg.view.h)
		s:SetPos(icfg.view.x2, icfg.view.y)
	end, {Paint = function(s, w, h) end})

	ii.InventoryViewScroll = ux.Create("DScrollPanel", ii.InventoryView, function(s)
		s:Setup(0, 0, icfg.view.w2, icfg.view.h)

		local v = s:GetVBar()
		v:SetHideButtons(true)
		v:SetWide(6)
		v:SetZPos(50)

		local btnX, btnY = 0, 0
		for i = 1, 300 do
			ux.Create("DPanel", s, function(p)
				ii.CreateIcon(p, btnX, btnY, (i <= 5) or (i >= (1200 - 5)))
			end)

			btnX = btnX + icfg.icon.s
			if (i % 5 == 0) then
				btnY = btnY + icfg.icon.s
				btnX = 0
			end
		end
	end, {Paint = function(s, w, h)
	end, Think = function(s)
		local cx, cy = s:CursorPos()

		if (cx < 0 or cy < 0 or cx > icfg.view.w2 or cy > icfg.view.h) then
			return
		end

		if (cy < 50) then
			s.Bounds = true
			s:GetVBar():AddScroll(((50 - cy) / 50) * -0.15)
		elseif (cy > (icfg.view.h - 50)) then
			s.Bounds = true
			s:GetVBar():AddScroll(((50 - (icfg.view.h - cy)) / 50) * 0.15)
		else
			s.Bounds = false
		end
	end})
end

function ii.RenderLoadoutView()
	if (IsValid(ii.LoadoutView)) then
		ii.LoadoutView:Remove()
	end

	ii.LoadoutView = ux.Create("DPanel", ii.bg, function(s)
		s:SetSize(icfg.view.w2, icfg.view.h)
		s:SetPos(icfg.view.x, icfg.view.y)
	end, {Paint = function(s) end})

	ii.LoadoutModel = ux.Create("DPanel", ii.LoadoutView, function(s)
		s:Setup(0, 0, icfg.view.w2, icfg.view.h)

		s.Player = vgui.Create("MOAT_PlayerPreview2", s)
		s.Player:SetSize(icfg.view.w2, icfg.view.h)
		s.Player:SetPos(0, 0)
		s.Player:SetText ""
		s.Player:SetModel "models/player/phoenix.mdl"
	end, {Paint = function(s) end})

	ii.LoadoutViewPanel = ux.Create("DPanel", ii.LoadoutView, function(s)
		s:Setup(0, 0, icfg.view.w2, icfg.view.h)
		local pad, head = 9, icfg.view.h
		head = head - ((icfg.icon.s / pad) * 5) - (icfg.icon.s * 5) + 5

		local btnX, btnY = icfg.view.w2 - icfg.icon.s - (icfg.icon.s / pad) + 4, head
		for i = 1, 5 do
			ux.Create("DPanel", s, function(p)
				ii.CreateIcon(p, btnX, btnY, false)
			end)

			btnY = btnY + icfg.icon.s + (icfg.icon.s / pad)
		end

		btnX, btnY = (icfg.icon.s / pad), head
		for i = 1, 5 do
			ux.Create("DPanel", s, function(p)
				ii.CreateIcon(p, btnX, btnY, false)
			end)

			btnY = btnY + icfg.icon.s + (icfg.icon.s / pad)
		end
	end, {Paint = function(s) end})

	/*
	M_INV_PMDL_PNL = vgui.Create("DPanel", M_LOADOUT_PNL)
    M_INV_PMDL_PNL:SetPos(93, 70)
    M_INV_PMDL_PNL:SetSize(192, 475)
    M_INV_PMDL_PNL.Paint = nil

    M_INV_PMDL = vgui.Create("MOAT_PlayerPreview", M_INV_PMDL_PNL)
    M_INV_PMDL:SetSize(350, 550)
    M_INV_PMDL:SetPos(-60, 0)
	M_INV_PMDL.ShowParticles = true
	--M_INV_PMDL.ParticleInventory = true
    M_INV_PMDL:SetText("")

	local set_model = false

    if (m_Loadout) then
        for i = 6, 10 do
            if (IsValid(M_INV_PMDL) and m_Loadout[i] and m_Loadout[i].c) then
                if (m_Loadout[i].item and m_Loadout[i].item.Kind and m_CosmeticSlots[m_Loadout[i].item.Kind]) then
                    M_INV_PMDL:AddModel(m_Loadout[i].u, m_Loadout[i])
                end

                if (m_Loadout[i].item and m_Loadout[i].item.Kind == "Model") then
                    M_INV_PMDL:SetModel(m_Loadout[i].u)
					set_model = true
                end
            end
        end
    end

	if (not set_model) then
		 M_INV_PMDL:SetModel(GetGlobalString("ttt_default_playermodel"))
	end
	
	ii.llp2 = ux.Create("DIconLayout", ii.lp, function(s)
		
		s:Setup(pnlw - 88, 18, 106, pnlh)
		s:SetSpaceX(18)
		s:SetSpaceY(24)

		for i = 1, 5 do`
			ii.CreateIcon(s:Add("DButton"), function(s)
				s.PaintOver = function(s, w, h)
					DisableClipping(true)
					draw.SimpleText("Loadout", "ux.14", w/2, 0, ux.p.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
					DisableClipping(false)
				end
			end)
		end
	end, {Paint = function(s) end})
	*/
end


ii.AddTab(1, "Home", true, function() end, function() end)
ii.AddTab(2, "Loadout", false, function(pnl)
	pnl.Paint = function(s, w, h)

	end
end, function(pnl)

end)

ii.AddTab(3, "Inventory", true, function() end, function() end)
ii.AddTab(4, "Trading", false, function() end, function() end)
ii.AddTab(5, "Shop", false, function() end, function() end)
ii.AddTab(6, "Gamble", true, function() end, function() end)
ii.AddTab(7, "Challenges", true, function() end, function() end)
ii.AddTab(8, "Settings", true, function() end, function() end)
ii.AddTab(9, "Donate", true, function() end, function() end)

function ii.CreateIcon(p, px, py, clip)
	p:SetPos(px, py)
	p:SetSize(icfg.icon.s, icfg.icon.s)
	p:SetText ""
	p.hover = 0
	p.Think = function(s)
		ux.HoverThink(s)

		if (s:IsHovered()) then
			s:SetZPos(52)
		elseif (s.hover > 0.2) then
			s:SetZPos(51)
		else
			s:SetZPos(50)
		end

		s:SetCursor "hand"
	end
	p.Paint = function(s, w, h)
		w, h = icfg.icon.d, icfg.icon.d

		surface.SetDrawColor(0, 0, 0, 25)
		surface.DrawRect(1, 1, w, h)
		surface.DrawRect(2, 2, w, h)

		surface.SetDrawColor(icfg.p.dark_darker)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(ColorAlpha(icfg.p.dark_blue, 100 * s.hover))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(icfg.p.dark_blue)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(ColorAlpha(icfg.p.blue, 100 * s.hover))
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		surface.DrawOutlinedRect(2, 2, w - 4, h - 4)
	end
end

if (IsValid(ii.bg)) then
	if (IsValid(ii.InventoryView)) then
		ii.InventoryView:Remove()
	end

	ii.CurrentTab = 0
	ii.bg:Remove()
	ii.Open()
end

ii.Cooldown = 0
ii.CooldownTime = 0.5

function ii.Open()
	ii.Main.Open()
	ii.Cooldown = CurTime() + 1
end

function ii.Close()
	ii.Main.Close()
	ii.Cooldown = CurTime() + 1
end

function ii.Toggle()
	if (not ii.Main or ii.Cooldown > CurTime()) then
		return
	end

	ii.Reload()

	if (IsValid(ii.bg)) then
		ii.Close()
	else
		ii.Open()
	end
end
/*
concommand.Add("inventory", ii.Toggle)
hook.Remove("PlayerButtonDown", "moat_InventoryKey")
hook.Add("PlayerButtonDown", "moat_InventoryKey", function(p, k)
	if (k == KEY_I) then
		ii.Toggle()
	end
end)
*/