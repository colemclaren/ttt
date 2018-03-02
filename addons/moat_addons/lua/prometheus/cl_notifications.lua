local function charWrap(text, pxWidth)
	local total = 0
	text = text:gsub(".", function(char)
		total = total + surface.GetTextSize(char)
		if total >= pxWidth then
			total = 0
			return "\n" .. char
		end
		return char
	end)

	return text, total
end

local function CutText(text, pxWidth, Font)
	local total = 0

	surface.SetFont(Font)

	local spaceSize = surface.GetTextSize(" ")
	text = text:gsub("(%s?[%S]+)", function(word)
		local char = string.sub(word, 1, 1)
		if char == "\n" or char == "\t" then
			total = 0
		end

		local wordlen = surface.GetTextSize(word)
		total = total + wordlen

		if wordlen >= pxWidth then
			local splitWord, splitPoint = charWrap(word, pxWidth)
			total = splitPoint
			return splitWord
		elseif total < pxWidth then
			return word
		end

		if char == " " then
			total = wordlen - spaceSize
			return "\n" .. string.sub(word, 2)
		end

		total = wordlen
		return "\n" .. word
	end)

	return text
end


function Prometheus.ShowNotification(Text)

	local NotifyPos = 0
	for i=1,10 do
		if !istable(Prometheus.Notifications[i]) then
			NotifyPos = i
			break
		end
	end

	local Notify = {}
	Prometheus.Notifications[NotifyPos] = Notify

	Text = CutText(Text, 230, "PrometheusText")
	surface.SetFont( "PrometheusText" )
	local TextW, TextH = surface.GetTextSize(Text)

	Notify.Height = 80 + TextH + 12
	Notify.HPos = 140
	for n, j in ipairs(Prometheus.Notifications) do
		if j == Notify then
			break
		end
		if j != nil then
			Notify.HPos = Notify.HPos + j.Height + 5
		end
	end

	Notify.Frame = vgui.Create("DFrame")
		Notify.Frame:SetSize(250, 80 + TextH + 12)
		Notify.Frame:SetPos(ScrW(), Notify.HPos)
		Notify.Frame:SetTitle("")
		Notify.Frame:ShowCloseButton(false)
		Notify.Frame:SetKeyBoardInputEnabled(false)
			Notify.Frame.Paint = function() end


	Notify.Panel = vgui.Create("DPanel", Notify.Frame)
		Notify.Panel:SetPos(0, 0)
		Notify.Panel:SetPaintBackground(false)
		Notify.Panel:SetSize(Notify.Frame:GetSize() )
		Notify.Panel:SetBackgroundColor(Color(120,120,120,0) )

			Notify.Panel.Paint = function(self)
				surface.SetDrawColor(Prometheus.Notify.BGColor)
				surface.DrawRect(0, 0, self:GetSize() )
				surface.SetDrawColor(Prometheus.Notify.TitleBGColor)
				surface.DrawRect(0, 0, 250, 40)
				draw.DrawText(Prometheus.Notify.Header or "PROMETHEUS", "PrometheusTitle", self:GetWide() / 2, 7, Prometheus.Notify.TitleColor , TEXT_ALIGN_CENTER)
				draw.DrawText(Text, "PrometheusText", self:GetWide() / 2, 45, Prometheus.Notify.TextColor , TEXT_ALIGN_CENTER)
			end

	Notify.Close = vgui.Create("DButton", Notify.Panel)
		Notify.Close:SetPos(0, Notify.Panel:GetTall() - 40)
		Notify.Close:SetSize(250, 40)
		Notify.Close:SetText("")
		Notify.Close.HoverOver = 255
		Notify.Close.Color = Prometheus.Notify.CloseColor


		Notify.Close.Paint = function(self)
			if self.Color.a > self.HoverOver then
				self.Color.a = self.Color.a - 3
			elseif self.Color.a < self.HoverOver then
				self.Color.a = self.Color.a + 3
			end
			surface.SetDrawColor( self.Color )
			surface.DrawRect( 0, 0, self:GetSize() )
			draw.SimpleText("Close", "PrometheusTitle", 125, 20, Prometheus.Notify.CloseTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		Notify.Close.DoClick = function()
			Prometheus.CloseNotification(NotifyPos, 0)
		end

		Notify.Close.OnCursorEntered = function(self)
			self.HoverOver = 120
		end

		Notify.Close.OnCursorExited = function(self)
			self.HoverOver = 255
		end

		Notify.Frame:MoveTo(ScrW() - 250, Notify.HPos, 1, 0, -1, function() Prometheus.CloseNotification(NotifyPos, Prometheus.Notify.ShowTime) end)
end


function Prometheus.CloseNotification(NotifyPos, Delay)
	if !IsValid(Prometheus.Notifications[NotifyPos].Frame) then return end

	Prometheus.Notifications[NotifyPos].Frame:MoveTo( ScrW(), Prometheus.Notifications[NotifyPos].HPos, 1, Delay, -1, function()
		if Prometheus.Notifications[NotifyPos] && IsValid(Prometheus.Notifications[NotifyPos].Frame) then
			Prometheus.Notifications[NotifyPos].Frame:Close()
		end
		Prometheus.Notifications[NotifyPos] = nil
	end)
end

net.Receive("PrometheusNotification", function()
	Prometheus.ShowNotification(net.ReadString() )
end)