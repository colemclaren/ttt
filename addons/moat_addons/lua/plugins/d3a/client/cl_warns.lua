D3A.WarnsCache = D3A.WarnsCache or {}
D3A.Warns = D3A.Warns or {}

local WarnActive = false
function D3A.DisplayWarns(int)
	int = int or 1

	local warn = D3A.Warns[int]
	if (not warn) then
		return
	end

	if (WarnActive or warn.ok) then
		return
	end

	WarnActive = true
	D3A.WARN = vgui.Create("DFrame")
	D3A.WARN:SetTitle("New Message!")
	D3A.WARN:SetDraggable(false)
	D3A.WARN:ShowCloseButton(false)
	D3A.WARN:SetBackgroundBlur(true)
	D3A.WARN:SetDrawOnTop(true)

	D3A.WARN.P = vgui.Create("DPanel", D3A.WARN)
	D3A.WARN.P:SetPaintBackground(false)

	D3A.WARN.T = vgui.Create("DLabel", D3A.WARN.P)
	D3A.WARN.T:SetText(warn.reason)
	D3A.WARN.T:SizeToContents()
	D3A.WARN.T:SetContentAlignment(5)
	D3A.WARN.T:SetTextColor(Color(255, 255, 255))

	D3A.WARN.T2 = vgui.Create("DLabel", D3A.WARN.P)
	D3A.WARN.T2:SetText("Sent by " .. warn.staff_name .. " (".. (D3A.FormatTimeNow(warn.time)) .. " ago)")
	D3A.WARN.T2:SizeToContents()
	D3A.WARN.T2:SetContentAlignment(5)
	D3A.WARN.T2:SetTextColor(Color(255, 255, 255))

	D3A.WARN.BP = vgui.Create("DPanel", D3A.WARN)
	D3A.WARN.BP:SetTall(30)
	D3A.WARN.BP:SetPaintBackground(false)

	local x = 5
	D3A.WARN.B = vgui.Create("DButton", D3A.WARN.BP)
	D3A.WARN.B:SetText("Back to Game")
	D3A.WARN.B:SizeToContents()
	D3A.WARN.B:SetTall(20)
	D3A.WARN.B:SetWide(D3A.WARN.B:GetWide() + 20)
	D3A.WARN.B.DoClick = function()
		if (IsValid(D3A.WARN)) then
			D3A.WARN:Remove()
		end

		net.Start "D3A.Warn"
			net.WriteUInt(warn.id, 32)
		net.SendToServer()

		D3A.WarnsCache[warn.id] = true
		WarnActive = false

		D3A.DisplayWarns(int + 1)
	end
	D3A.WARN.B:SetPos(x, 5)

	x = x + D3A.WARN.B:GetWide() + 5
	D3A.WARN.BP:SetWide(x)

	local w1, h1 = D3A.WARN.T:GetSize()
	local w2, h2 = D3A.WARN.T2:GetSize()

	local w = w1 + w2 + D3A.WARN.BP:GetWide()
	local h = h1 + h2 + 15

	D3A.WARN:SetSize(w + 50, h + 25 + 45 + 15)
	D3A.WARN:Center()

	D3A.WARN.P:StretchToParent(5, 25, 5, 45)

	D3A.WARN.T:DockMargin(5, 10, 5, 5)
	D3A.WARN.T:Dock(TOP)

	D3A.WARN.T2:DockMargin(5, 5, 5, 5)
	D3A.WARN.T2:Dock(TOP)

	D3A.WARN.BP:CenterHorizontal()
	D3A.WARN.BP:AlignBottom(8)

	D3A.WARN:MakePopup()
	D3A.WARN:DoModal()
end

function D3A.Warnings()
	D3A.Warns = D3A.Warns or {}

	local int = net.ReadUInt(8)
	net.ReadArray(int, function(i)
		local ID = net.ReadUInt(32)
		if (not D3A.WarnsCache[ID]) then
			D3A.Warns[i] = {}
			D3A.Warns[i].id = ID
			D3A.Warns[i].staff_steam_id = net.ReadString()
			D3A.Warns[i].staff_name = net.ReadString()
			D3A.Warns[i].time = tonumber(net.ReadString())
			D3A.Warns[i].reason = net.ReadString()
		end
	end)

	D3A.DisplayWarns()
end
net.Receive("D3A.Warn", D3A.Warnings)