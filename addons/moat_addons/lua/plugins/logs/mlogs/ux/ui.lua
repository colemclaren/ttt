if (true) then
	return
end

mui = mui or {}

function mlogs.Reload()
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

	mui = t
	return mui
end

if (CLIENT) then
	mlogs.Reload()
end

mlogs.Main = mlogs.Main or {}
mlogs.Main.Tabs = {Count = 0}

function mlogs.Main.Close()
	if (not IsValid(mlogs.bg)) then
		return
	end

	mlogs.bg:BounceOut(BOTTOM)
end

function mlogs.Main.Open()
	if (IsValid(mlogs.bg)) then
		mlogs.bg:Remove()
	end

	mlogs.bg = ux.Create("DFrame", function(s)
		s:Setup(mui.pnl.x, -mui.pnl.h, mui.pnl.w, mui.pnl.h)
		s:BounceIn()

		s:MakePopup()
		s:SetKeyboardInputEnabled(false)
		s:ShowCloseButton(false)
	end, {Paint = function(s, w, h)
		ux.Blur(s, 4)

		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)

		draw.WebImage("https://ttt.dev/R9fuW.png", 0, 0, 2048, 2048, Color(255, 255, 255, 250))
	end, Think = function(s) end})

	mlogs.RenderNav(mlogs.bg)

	/*
	local edge = cn.edge
	local pnlw, pnlh = (bgw/2) - edge - (edge/2), bgh - cn.nav - (edge * 2)
	local pnlx, pnly = (bgw/2) + (edge/2), cn.nav + edge

	--
	--  Inventory
	--

	mlogs.ip = ux.Create("DPanel", mlogs.bg, function(s)
		s:Setup(pnlx, pnly, pnlw, pnlh)
	end, {Paint = function(s) end})

	mlogs.isp = ux.Create("DScrollPanel", mlogs.ip, function(s)
		s:Setup(0, 0, pnlw, pnlh)

		local v = s:GetVBar()
		v:SetWide(0)

	end, {Paint = function(s) end})

	mlogs.ilp = ux.Create("DIconLayout", mlogs.isp, function(s)
		s:Setup(4, 4, pnlw, pnlh)
		s:SetSpaceX(4)
		s:SetSpaceY(4)

		for i = 1, 100 do
			mlogs.CreateIcon(s:Add("DButton"))
		end
	end, {Paint = function(s) end})

	--
	--  Loadout
	--

	mlogs.lp = ux.Create("DPanel", mlogs.bg, function(s)
		s:Setup(edge, pnly, pnlw, pnlh)
	end, {Paint = function(s) end})

	mlogs.llp1 = ux.Create("DIconLayout", mlogs.lp, function(s)
		s:Setup(4, 4, 106, pnlh)
		s:SetSpaceX(18)
		s:SetSpaceY(24)

		for i = 1, 5 do
			mlogs.CreateIcon(s:Add("DButton"))
		end
	end, {Paint = function(s) end})

	mlogs.llp2 = ux.Create("DIconLayout", mlogs.lp, function(s)
		s:Setup(pnlw - 88, 18, 106, pnlh)
		s:SetSpaceX(18)
		s:SetSpaceY(24)

		for i = 1, 5 do
			mlogs.CreateIcon(s:Add("DButton"), function(s)
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

function mlogs.RenderNav(bg)
	mlogs.header = ux.Create("DPanel", bg, function(s)
		s:Setup(0, 0, mui.pnl.w, mui.header)
	end, {Paint = function(s, w, h)
		surface.SetDrawColor(mui.p.dark_darker)
		surface.DrawRect(0, 0, w, h)
	end})

	local tw, tx = mui.pnl.w / mlogs.Main.Tabs.Count, 0
	mlogs.nav = ux.Create("DPanel", mlogs.header, function(s)
		s:Setup(0, 0, mui.pnl.w, mui.header)
	end, {Paint = function() end, PaintOver = function(s, w, h)
		s.BarPos = Lerp(RealFrameTime() * 15, s.BarPos or 0, tw * (mlogs.CurrentTab or 1) - tw)

		surface.SetDrawColor(mlogs.CurrentTab == 9 and mui.p.yellow or mui.p.blue)
		surface.DrawRect(s.BarPos, h - 3, tw, 3)
	end})

	for i = 1, mlogs.Main.Tabs.Count do
		ux.Create("DButton", mlogs.nav, function(s)
			s:Setup(tx, 0, tw, mui.header)
			s:SetText ""
			s.Info = mlogs.Main.Tabs[i]
		end, {Think = function(s)
			ux.HoverThink(s, false, mlogs.CurrentTab == i)
		end, DoClick = function(s)
			mlogs.LoadTab(i)
		end, Paint = function(s, w, h)
				surface.SetDrawColor(ColorAlpha(mui.p.dark_blue, 100 * s.hover))
				surface.DrawRect(0, 0, w, h)

				draw.SimpleText(s.Info.Title, "ux.16", w/2, h/2, i == 9 and mui.p.yellow or ux.ShiftColor(
					mui.p.text,
					mui.p.white,
					s.hover
				), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end})

		tx = tx + tw
	end

	mlogs.LoadTab(2)
end

function mlogs.RenderView(tab)
	mlogs.CurrentView = ux.Create("DPanel", mlogs.bg, function(s)
		s:SetSize(tab.FullWidth and mui.view.w or mui.view.w2, mui.view.h)
		s:FadeIn(mui.view.x, mui.view.y, 5)
		if (IsValid(mlogs.LogsView) and not tab.FullWidth and not mlogs.LogsView:IsVisible()) then
			mlogs.LogsView:SetAlpha(0)
			mlogs.LogsView:SetVisible(true)
			mlogs.LogsView:SetPos(mui.view.x2, mui.view.y)
			mlogs.LogsView:FadeIn(mui.view.x2, mui.view.y, 5)
		end
	end, {Paint = function(s, w, h)
		surface.SetDrawColor(mui.p.dark_bluer)
		surface.DrawRect(0, 0, w, h)
	end})

	if (tab.OpenFunc) then
		tab.OpenFunc(mlogs.CurrentView)
	end
end

function mlogs.LoadTab(num)
	mlogs.CurrentTab = mlogs.CurrentTab or 0
	num = num or 1

	if (not mlogs.Main.Tabs[num]) then
		return
	end

	local new = mlogs.Main.Tabs[num]
	local cur = mlogs.Main.Tabs[mlogs.CurrentTab]

	if (new.FullWidth) then
		if (IsValid(mlogs.LogsView)) then
			mlogs.LogsView:FadeOut(function(p)
				if (IsValid(mlogs.LogsView)) then mlogs.LogsView:SetVisible(false) end
			end, 5)
		end
	elseif (not IsValid(mlogs.LogsView)) then
		mlogs.RenderLogsView()
	end

	if (not cur or not IsValid(mlogs.CurrentView)) then
		mlogs.RenderView(new)
	else
		if (cur.CloseFunc) then
			cur.CloseFunc(mlogs.CurrentView)
		end

		mlogs.CurrentView:FadeOut(function(p)
			if (IsValid(mlogs.CurrentView)) then mlogs.CurrentView:Remove() end

			mlogs.RenderView(new)
		end, 5)
	end

	mlogs.CurrentTab = num

	hook.Run("inv.TabChange", new)
end

function mlogs.AddTab(order, title, full, open, close)
	if (order < 1) then
		return
	end

	mlogs.Main.Tabs.Count = mlogs.Main.Tabs.Count + 1
	mlogs.Main.Tabs[order] = {
		Enum = order,
		Title = title,
		FullWidth = full,
		OpenFunc = open,
		CloseFunc = close
	}
end

function mlogs.RenderLogsView()
	if (IsValid(mlogs.LogsView)) then
		return
	end

	print "p"
	
	mlogs.LogsView = ux.Create("DPanel", mlogs.bg, function(s)
		s:SetSize(mui.view.w2, mui.view.h)
		s:SetPos(mui.view.x2, mui.view.y)
	end, {Paint = function(s, w, h) end})

	mlogs.LogsViewScroll = ux.Create("DScrollPanel", mlogs.LogsView, function(s)
		s:Setup(0, 0, mui.view.w2, mui.view.h)

		local v = s:GetVBar()
		v:SetHideButtons(true)
		v:SetWide(6)
		v:SetZPos(50)
		/*
		function sbar.btnGrip:Think()
            if (not input.IsMouseDown(MOUSE_LEFT) and sbar.moving) then
                sbar.moving = false
            end

            if (s:IsHovered()) then
                if (input.IsMouseDown(MOUSE_LEFT)) then
                    sbar.moving = true
                end

				self:SetCursor("hand")
            end

            if (sbar.moving) then
                self:SetCursor("hand")
            end
		end
		*/
		local btnX, btnY = 0, 0
		for i = 1, 300 do
			ux.Create("DPanel", s, function(p)
				mlogs.CreateIcon(p, btnX, btnY, (i <= 6) or (i >= (1200 - 6)))
			end)

			btnX = btnX + (68 + 1)
			if (i % 6 == 0) then
				btnY = btnY + (68 + 1)
				btnX = 0
			end
		end
	end, {Paint = function(s, w, h)
	end, Think = function(s)
		local cx, cy = s:CursorPos()

		if (cx < 0 or cy < 0 or cx > mui.view.w2 or cy > mui.view.h) then
			return
		end

		if (cy < 50) then
			s.Bounds = true
			s:GetVBar():AddScroll(((50 - cy) / 50) * -0.15)
		elseif (cy > (mui.view.h - 50)) then
			s.Bounds = true
			s:GetVBar():AddScroll(((50 - (mui.view.h - cy)) / 50) * 0.15)
		else
			s.Bounds = false
		end
	end})
end


mlogs.AddTab(1, "Home", true, function() end, function() end)
mlogs.AddTab(2, "Loadout", false, function(pnl)
	pnl.Paint = function(s, w, h)
	end

end, function(pnl)

end)


mlogs.AddTab(3, "Inventory", true, function() end, function() end)
mlogs.AddTab(4, "Trading", false, function() end, function() end)
mlogs.AddTab(5, "Shop", false, function() end, function() end)
mlogs.AddTab(6, "Gamble", true, function() end, function() end)
mlogs.AddTab(7, "Challenges", true, function() end, function() end)
mlogs.AddTab(8, "Settings", true, function() end, function() end)
mlogs.AddTab(9, "Donate", true, function() end, function() end)

function mlogs.CreateIcon(p, px, py, clip)
	local box = 64

	p:SetPos(px, py)
	p:SetSize(66, 66)
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
		w, h = 64, 64

		surface.SetDrawColor(0, 0, 0, 25)
		surface.DrawRect(1, 1, w, h)
		surface.DrawRect(2, 2, w, h)

		surface.SetDrawColor(mui.p.dark_darker)
		surface.DrawRect(0, 0, w, h)
		
		surface.SetDrawColor(ColorAlpha(mui.p.dark_blue, 100 * s.hover))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(mui.p.dark_blue)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(ColorAlpha(mui.p.blue, 100 * s.hover))
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		surface.DrawOutlinedRect(2, 2, w - 4, h - 4)
	end
end

if (IsValid(mlogs.bg)) then
	if (IsValid(mlogs.LogsView)) then
		mlogs.LogsView:Remove()
	end

	mlogs.CurrentTab = 0
	mlogs.bg:Remove()
	mlogs.Open()
end

mlogs.Cooldown = 0
mlogs.CooldownTime = 0.5

function mlogs.Toggle()
	if (not mlogs.Main or mlogs.Cooldown > CurTime()) then
		return
	end

	mlogs.Reload()

	if (IsValid(mlogs.bg)) then mlogs.Close() return end
	if (not ux.Active()) then mlogs.Open() return end
end

function mlogs.Open()
	mlogs.Main.Open()
	mlogs.Cooldown = CurTime() + mlogs.CooldownTime
end

function mlogs.Close()
	mlogs.Main.Close()
	mlogs.Cooldown = CurTime() + mlogs.CooldownTime
end

concommand.Add("mlogs", mlogs.Toggle)
hook("PlayerButtonDown", function(p, k)
	if (k == KEY_L) then mlogs.Toggle() end
end)