D3A.Warns = D3A.Warns or {}

function D3A.DisplayWarns(w)
	w = w or D3A.Warns[1]
	if (not w) then return end

	local f = vgui.Create("DFrame")
    f:SetSize(ScrW(), ScrH())
    f:SetTitle("")
    f:MakePopup()
    f:SetKeyBoardInputEnabled(false)
    f:Center()
    f:ShowCloseButton(false)
    f:SetDraggable(false)
    f:RequestFocus()
    f:SetDrawOnTop(true)
    f:MoveToFront()
    f:SetAlpha(0)
    f.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0))
    end

	local p = Derma_Query("Warning from " .. w.staff_name .. " (" .. util.SteamIDFrom64(w.staff_steam_id) .. "), " .. D3A.FormatTimeNow(w.time) .. " ago:\n\n\n" .. w.reason .. "\n", "Heads up!", "I Understand.")
	p:MakePopup()

	p.OnRemove = function()
		f:Remove()
	end

	local c = p:GetChildren()
	if (c and c[6] and c[6]:GetChildren()[1]) then
		local btn = c[6]:GetChildren()[1]
		btn:SetDisabled(true)
		local t = 10
		btn:SetText("I understand. (" .. t .. ")")
		timer.Create("warning." .. w.id, 1, t, function()
			t = t - 1
			btn:SetText("I understand. (" .. t .. ")")

			if (t <= 0) then
				btn:SetText("I understand.")
			end
		end)
		timer.Simple(10, function() btn:SetDisabled(false) end)
	end
end

function D3A.Warnings()
	D3A.Warns = {}

	for i = 1, net.ReadUInt(8) do
		local n = net.ReadUInt(8)
		D3A.Warns[n] = {}
		D3A.Warns[n].id = net.ReadUInt(32)
		D3A.Warns[n].staff_steam_id = net.ReadString()
		D3A.Warns[n].staff_name = net.ReadString()
		D3A.Warns[n].time = tonumber(net.ReadString())
		D3A.Warns[n].reason = net.ReadString()
	end

	PrintTable(D3A.Warns)
end
net.Receive("D3A.Warn", D3A.Warnings)