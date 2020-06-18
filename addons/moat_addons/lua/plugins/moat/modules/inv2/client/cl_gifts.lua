MOAT_GIFTS = MOAT_GIFTS or {}
MOAT_GIFTS.FrameW = 550
MOAT_GIFTS.FrameH = 320
MOAT_GIFTS.PlayerInfo = nil
MOAT_GIFTS.SteamIDEntered = nil

function MOAT_GIFTS.IsSteamID(s)
	if (s:match("%a") and not s:StartWith("STEAM_")) then return false end
	
	if (s:StartWith("7656") and #s <= 20) then return true end
	if (s:StartWith("STEAM_")) then
		if (s:match("STEAM_0:[0-9]:[0-9]+")) then return true end
	end
	return false
end

function MOAT_GIFTS.LoadPlayerData(t)
	if (not IsValid(MOAT_GIFTS.Frame) or not IsValid(MOAT_GIFTS.Frame.p)) then return end
	local h = MOAT_GIFTS.PlayerInfo

	local p = MOAT_GIFTS.Frame.p
	local a = vgui.Create("AvatarImage", p)
	a:SetPos(10, 10)
	a:SetSize(128, 128)
	a:SetSteamID(h.sid, 128)


	local l = vgui.Create("DLabel", p)
	l:SetFont("moat_ItemDesc")
	l:SetText("Name: " .. h.name)
	l:DockMargin(156, 18, 0, 0)
	l:Dock(TOP)
	l:SizeToContents()

	local l = vgui.Create("DLabel", p)
	l:SetFont("moat_ItemDesc")
	l:SetText("Rank: " .. h.rank)
	l:DockMargin(156, 10, 0, 0)
	l:Dock(TOP)
	l:SizeToContents()

	local l = vgui.Create("DLabel", p)
	l:SetFont("moat_ItemDesc")
	l:SetText("Level: " .. h.lvl)
	l:DockMargin(156, 10, 0, 0)
	l:Dock(TOP)
	l:SizeToContents()

	local l = vgui.Create("DLabel", p)
	l:SetFont("moat_ItemDesc")
	l:SetText("Playtime: " .. D3A.FormatTimeSingle(h.playtime))
	l:DockMargin(156, 10, 0, 0)
	l:Dock(TOP)
	l:SizeToContents()

	local l = vgui.Create("DLabel", p)
	l:SetFont("moat_ItemDesc")
	l:SetText("Last Online: " .. D3A.FormatTimeSingle(h.last_online) .. " ago")
	l:DockMargin(156, 10, 0, 0)
	l:Dock(TOP)
	l:SizeToContents()

	if (MOAT_GIFTS.SteamIDEntered == LocalPlayer():SteamID64() or MOAT_GIFTS.SteamIDEntered == LocalPlayer():SteamID()) then return end
	MOAT_GIFTS.Frame.s:SetDisabled(false)
end

net.Receive("MOAT_GET_PLAYER_INFO", function()
	if (not IsValid(MOAT_GIFTS.Frame) or not IsValid(MOAT_GIFTS.Frame.p)) then return end
	local t = net.ReadTable()

	if (t.sid == MOAT_GIFTS.SteamIDEntered) then
		MOAT_GIFTS.PlayerInfo = t
		MOAT_GIFTS.LoadPlayerData()
	end
end)

net.Receive("MOAT_GET_PLAYER_INFO_FAILED", function()
	if (not IsValid(MOAT_GIFTS.Frame) or not IsValid(MOAT_GIFTS.Frame.p)) then return end
	MOAT_GIFTS.Failed = true
end)

function MOAT_GIFTS.AddPanel(f, t)
	f:DockPadding(0, 45, 0, 0)
	if (f.p) then f.p:Remove() end
	
	f.p = vgui.Create("DPanel", f)
	f.p:Dock(TOP)
	f.p:SetTall(148)
	f.p:DockMargin(50, 10, 50, 0)
	f.p.PaintOver = function(s, w, h)
		if (MOAT_GIFTS.PlayerInfo) then return end
		if (MOAT_GIFTS.Failed) then draw.SimpleText("Failed to load Player with that SteamID... Do they exist?", "moat_ItemDesc", w/2, h/2, Color(255, 50, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) return end
		draw.SimpleText("Loading Player...", "moat_ItemDesc", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("(if this takes forever, the player doesn't exist)", "moat_ItemDesc", w/2, h/2 + 20, Color(255, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	MOAT_GIFTS.SteamIDEntered = (t:StartWith("7656") and t or util.SteamIDTo64(t))

	net.Start("MOAT_GET_PLAYER_INFO")
	net.WriteString(t:StartWith("7656") and t or util.SteamIDTo64(t))
	net.SendToServer()
end

function MOAT_GIFTS.SendGift(item, slot)
	MOAT_GIFTS.PlayerInfo = nil
	MOAT_GIFTS.SteamIDEntered = nil
	MOAT_GIFTS.Failed = false

	local scrw, scrh = ScrW(), ScrH()
	local fx, fy = (scrw/2) - (MOAT_GIFTS.FrameW/2), (scrh/2) - (MOAT_GIFTS.FrameH/2)

	local f = vgui.Create("DFrame")
	f:SetTitle("Send Gift Package")
	f:SetPos(fx, scrh)
	f:SetSize(MOAT_GIFTS.FrameW, MOAT_GIFTS.FrameH)
	f:MakePopup()
	f:SetBackgroundBlur(true)
	f:DoModal(true)
	f.Think = function() end
	f:DockPadding(0, 125, 0, 0)
	f:MoveTo(fx, fy - 10, 0.3, 0, -1, function(a, p)
		p:MoveTo(fx, fy, 0.1, 0, -1)
	end)


	local l = vgui.Create("DLabel", f)
	l:SetFont("moat_ItemDesc")
	l:SetText("Enter the SteamID of the Player:")
	l:Dock(TOP)
	l:SetContentAlignment(5)
	l:SizeToContents()

	local t = vgui.Create("DTextEntry", f)
	t:SetFont("moat_ItemDesc")
	t:SetUpdateOnType(true)
	t:Dock(TOP)
	t:DockMargin(50, 8, 50, 0)
	t:SetContentAlignment(5)
	t.OnLoseFocus = function(s) s:OnEnter() end
	t.OnEnter = function(s)
		local p = s:GetText()
		if (not IsValid(t.w)) then end
		MOAT_GIFTS.Frame.s:SetDisabled(true)

		if (MOAT_GIFTS.IsSteamID(p)) then
			MOAT_GIFTS.Failed = false
			t.w.Appear = CurTime() - 10
			MOAT_GIFTS.AddPanel(f, s:GetText())
		else
			f:DockPadding(0, 45, 0, 0)
			if (f.p) then f.p:Remove() end
			t.w.Appear = CurTime()
		end
	end

	t.w = vgui.Create("DLabel", f)
	local w = t.w
	w:SetFont("moat_ItemDesc")
	w:SetText("That's not a valid SteamID!")
	w:Dock(TOP)
	w:SetContentAlignment(5)
	w:SizeToContents()
	w:SetTextColor(Color(255, 50, 50))
	w:DockMargin(0, 5, 0, 0)
	w.Think = function(s, w, h)
		if (s.Appear and s.Appear > (CurTime() - 5)) then
			s:SetTall(14)
		else
			s:SetTall(0)
		end
	end

	local b = vgui.Create("DButton", f)
	b:SetPos(5, f:GetTall() - 35)
	b:SetSize(140, 30)
	b:SetFont("moat_ItemDesc")
	b:SetText("Cancel")
	b.DoClick = function() f:Remove() end
	b.Red = true

	f.s = vgui.Create("DButton", f)
	f.s:SetPos(f:GetWide() - 145, f:GetTall() - 35)
	f.s:SetSize(140, 30)
	f.s:SetFont("moat_ItemDesc")
	f.s:SetText("Send Gift")
	f.s:SetDisabled(true)
	f.s.Green = true
	f.s.DoClick = function(s)
		f:Remove()

		net.Start("MOAT_SEND_GIFT")
		net.WriteLong(tonumber(item.c))
		net.WriteString(slot)
		net.WriteString(MOAT_GIFTS.SteamIDEntered)
		net.SendToServer()
	end

	/*f.sa = vgui.Create("DButton", f)
	f.sa:SetPos(150, f:GetTall() - 35)
	f.sa:SetSize(140, 30)
	f.sa:SetFont("moat_ItemDesc")
	f.sa:SetText("Send Anonymously")
	f.sa:SetDisabled(true)
	f.sa.Orange = true
	f.sa.DoClick = function(s)
		f:Remove()

		net.Start("MOAT_SEND_GIFT")
		net.WriteLong(item.c)
		net.WriteString(slot)
		net.WriteString(MOAT_GIFTS.SteamIDEntered)
		net.WriteBool(true)
		net.SendToServer()
	end*/

	MOAT_GIFTS.Frame = f
end