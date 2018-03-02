local Menu = Prometheus.Menu.Base
local DrawCursorText = false
local ShowAdminTab = false
local FetchedInitMessages = false

function Prometheus.Menu.Open()
	if IsValid(Menu.Frame) then return end

	surface.CreateFont("PrometheusTextSmall", {
		font = "verdana",
		size = ScreenScale(6),
		weight = 600
	})

	net.Start("Cl_PrometheusRequest")
		net.WriteUInt(0, 2)
	net.SendToServer()


	FetchedInitMessages = false

	local W, H = ScrW(), ScrH()
	Menu.Packages = {}
	Menu.Messages = {}

	Menu.Frame = vgui.Create("DFrame")
		Menu.Frame:SetSize(W / 3, H / 1.7)
		Menu.Frame:SetPos(W / 2 - W / 6,  H / 4.6)
		Menu.Frame:SetTitle("")
		Menu.Frame:ShowCloseButton(false)
		Menu.Frame:MakePopup()

			Menu.Frame.Paint = function() end


	Menu.MainPanel = vgui.Create("DPanel", Menu.Frame)
		Menu.MainPanel:SetPos(0, 0)
		Menu.MainPanel:SetPaintBackground(false)
		Menu.MainPanel:SetSize(Menu.Frame:GetSize() )

			Menu.MainPanel.PaintOver = function(self)
				surface.SetDrawColor(Prometheus.Menu.TitleBGColor)
				surface.DrawRect(0, 50, self:GetWide(), 40)
				draw.DrawText(Prometheus.Menu.Header or "PROMETHEUS", "PrometheusTitle", self:GetWide() / 2, 57, Prometheus.Menu.TitleColor, TEXT_ALIGN_CENTER)
			end

			Menu.MainPanel.Paint = function(self)
				surface.SetDrawColor(Prometheus.Menu.BGColor)
				surface.DrawRect(0, 60, self:GetWide(), self:GetTall() - 60)
			end

		Menu.BtnPackage = vgui.Create("DButton", Menu.MainPanel)
			Menu.BtnPackage:SetPos(0, 0)
			Menu.BtnPackage:SetSize(80, 50)
			Menu.BtnPackage:SetText("")
			Menu.BtnPackage.Selected = true
			Menu.BtnPackage:SetEnabled(false)

			Menu.BtnPackage.Paint = function(self)
				if self.Selected then
					surface.SetDrawColor(Prometheus.Menu.TabColorSelected)
				else
					surface.SetDrawColor(Prometheus.Menu.TabColor)
				end
				surface.DrawRect(0, 0, self:GetSize() )
				draw.SimpleText(Prometheus.Lang.Packages, "PrometheusText", self:GetWide() / 2, 20, Prometheus.Menu.TabTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			Menu.BtnPackage.DoClick = function()
				Prometheus.Menu.SwitchTab(0)
			end

			Menu.BtnPackage.OnCursorEntered = function(self)
				if !self.Selected then
					local X = self:GetPos()
					self:MoveTo(X, 5, 0.2)
				else
					self:SetCursor("arrow")
				end
			end

			Menu.BtnPackage.OnCursorExited = function(self)
				if !self.Selected then
					local X = self:GetPos()
					self:MoveTo(X, 10, 0.2)
				else
					self:SetCursor("hand")
				end
			end


		Menu.BtnDonate = vgui.Create("DButton", Menu.MainPanel)
			Menu.BtnDonate:SetPos(83, 10)
			Menu.BtnDonate:SetSize(80, 50)
			Menu.BtnDonate:SetText("")
			Menu.BtnDonate.Color = Prometheus.Menu.TabColor

			Menu.BtnDonate.Paint = function(self)
				surface.SetDrawColor(self.Color)
				surface.DrawRect(0, 0, self:GetSize() )
				draw.SimpleText(Prometheus.Lang.Donate, "PrometheusText", self:GetWide() / 2, 20, Prometheus.Menu.TabTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			Menu.BtnDonate.DoClick = function()
				gui.OpenURL(Prometheus.WebsiteUrl or "http://TellTheServerOwnerToChangeTheURLInConfig")
			end

			Menu.BtnDonate.OnCursorEntered = function(self)
				local X = self:GetPos()
				self:MoveTo(X, 5, 0.2)
			end

			Menu.BtnDonate.OnCursorExited = function(self)
				local X = self:GetPos()
				self:MoveTo(X, 10, 0.2)
			end

		Menu.BtnAdmin = vgui.Create("DButton", Menu.MainPanel)
			Menu.BtnAdmin:SetPos(166, 10)
			Menu.BtnAdmin:SetSize(80, 50)
			Menu.BtnAdmin:SetText("")
			Menu.BtnAdmin.Selected = false
			if !ShowAdminTab then
				Menu.BtnAdmin:SetVisible(false)
			end
			Menu.BtnAdmin.Paint = function(self)
				if self.Selected then
					surface.SetDrawColor(Prometheus.Menu.TabColorSelected)
				else
					surface.SetDrawColor(Prometheus.Menu.TabColor)
				end
				surface.DrawRect(0, 0, self:GetSize() )
				draw.SimpleText(Prometheus.Lang.Admin, "PrometheusText", self:GetWide() / 2, 20, Prometheus.Menu.TabTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			Menu.BtnAdmin.DoClick = function()
				Prometheus.Menu.SwitchTab(1)
			end

			Menu.BtnAdmin.OnCursorEntered = function(self)
				if !self.Selected then
					local X = self:GetPos()
					self:MoveTo(X, 5, 0.2)
				else
					self:SetCursor("arrow")
				end
			end

			Menu.BtnAdmin.OnCursorExited = function(self)
				if !self.Selected then
					local X = self:GetPos()
					self:MoveTo(X, 10, 0.2)
				else
					self:SetCursor("hand")
				end
			end

	Menu.PackagePanel = vgui.Create("DPanel", Menu.MainPanel)
		Menu.PackagePanel:SetPos(0, 50)
		Menu.PackagePanel:SetPaintBackground(false)
		Menu.PackagePanel:SetSize(Menu.MainPanel:GetWide(), Menu.MainPanel:GetTall() - 50)

		Menu.PackagePanel.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.PackageTitleBGColor)
			surface.DrawRect(0, 0, self:GetWide(), 40)

			draw.SimpleText(Prometheus.Lang.Package, "PrometheusTextSmall", Menu.PackageScroll.WidePart * 6, 60, Prometheus.Menu.PackageTitleTextColor, 1, 1)

			draw.SimpleText(Prometheus.Lang.ExpireDate, "PrometheusTextSmall", Menu.PackageScroll.WidePart * 13.7, 60, Prometheus.Menu.PackageTitleTextColor, 1, 1)

			draw.SimpleText(Prometheus.Lang.State, "PrometheusTextSmall", Menu.PackageScroll.WidePart * 18, 60, Prometheus.Menu.PackageTitleTextColor, 1, 1)

			surface.SetDrawColor(Prometheus.Menu.PackageBGColor)
			surface.DrawRect(0, 80, self:GetWide(), self:GetTall() - 120)
		end

	Menu.PackageScroll = vgui.Create("DScrollPanel", Menu.PackagePanel)
		Menu.PackageScroll:SetSize(Menu.PackagePanel:GetWide(), Menu.PackagePanel:GetTall() - 120)
		Menu.PackageScroll:SetPos(0, 80)
		Menu.PackageScroll.ChildHeight = 40

		Menu.PackageScroll.WidePart = Menu.PackageScroll:GetWide() / 20

		Menu.PackageScroll.VBar.btnUp:SetSize(0, 0)
		Menu.PackageScroll.VBar.btnDown:SetSize(0, 0)

		local OCanvasPL = Menu.PackageScroll.pnlCanvas.PerformLayout

		Menu.PackageScroll.pnlCanvas.PerformLayout = function(self)
			OCanvasPL()
			for n, j in ipairs(Menu.Packages) do
				j.Panel:PerformLayout()
			end
			Menu.PackageScroll.WidePart = Menu.PackageScroll.pnlCanvas:GetWide() / 20
		end

		Menu.PackageScroll.VBar.Paint = function(self)
		surface.SetDrawColor(Prometheus.Menu.ScrollBGColor)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
	end

		Menu.PackageScroll.VBar.btnUp.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.ScrollUpColor)
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
		end

		Menu.PackageScroll.VBar.btnDown.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.ScrollDownColor)
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
		end

		Menu.PackageScroll.VBar.btnGrip.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.ScrollGripColor)
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
		end

	Menu.AdminPanel = vgui.Create("DPanel", Menu.MainPanel)
		Menu.AdminPanel:SetPos(0, 50)
		Menu.AdminPanel:SetPaintBackground(false)
		Menu.AdminPanel:SetSize(Menu.MainPanel:GetWide(), Menu.MainPanel:GetTall() - 50)
		Menu.AdminPanel:SetVisible(false)

		Menu.AdminPanel.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.AdminTitleBGColor)
			surface.DrawRect(0, 0, self:GetWide(), 40)

			draw.SimpleText(Prometheus.Lang.Text, "PrometheusTextSmall", Menu.AdminScroll.WidePart * 7.5, 60, Prometheus.Menu.AdminTitleTextColor, 1, 1)

			draw.SimpleText(Prometheus.Lang.Time, "PrometheusTextSmall", Menu.AdminScroll.WidePart * 17.2, 60, Prometheus.Menu.AdminTitleTextColor, 1, 1)

			surface.SetDrawColor(Prometheus.Menu.AdminBGColor)
			surface.DrawRect(0, 80, self:GetWide(), self:GetTall() - 120)
		end

	Menu.AdminScroll = vgui.Create("DScrollPanel", Menu.AdminPanel)
		Menu.AdminScroll:SetSize(Menu.AdminPanel:GetWide(), Menu.AdminPanel:GetTall() - 120)
		Menu.AdminScroll:SetPos(0, 80)
		Menu.AdminScroll.ChildHeight = 40

		Menu.AdminScroll.WidePart = Menu.AdminScroll:GetWide() / 20

		Menu.AdminScroll.VBar.btnUp:SetSize(0, 0)
		Menu.AdminScroll.VBar.btnDown:SetSize(0, 0)

		local OCanvasPL = Menu.AdminScroll.pnlCanvas.PerformLayout

		Menu.AdminScroll.pnlCanvas.PerformLayout = function(self)
			OCanvasPL()
			for n, j in ipairs(Menu.Messages) do
				j.Panel:PerformLayout()
			end
			Menu.AdminScroll.WidePart = Menu.AdminScroll.pnlCanvas:GetWide() / 20
		end

		Menu.AdminScroll.VBar.Paint = function(self)
		surface.SetDrawColor(Prometheus.Menu.ScrollBGColor)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
	end

		Menu.AdminScroll.VBar.btnUp.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.ScrollUpColor)
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
		end

		Menu.AdminScroll.VBar.btnDown.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.ScrollDownColor)
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
		end

		Menu.AdminScroll.VBar.btnGrip.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.ScrollGripColor)
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall() )
		end


	Menu.Close = vgui.Create("DButton", Menu.MainPanel)
		Menu.Close:SetPos(0, Menu.MainPanel:GetTall() - 40)
		Menu.Close:SetSize(Menu.MainPanel:GetWide(), 40)
		Menu.Close:SetText("")
		Menu.Close.Color = Prometheus.Menu.CloseColor

		Menu.Close.Paint = function(self)
			surface.SetDrawColor(self.Color)
			surface.DrawRect(0, 0, self:GetSize() )
			draw.SimpleText("Close", "PrometheusTitle", self:GetWide() / 2, 20, Prometheus.Menu.CloseTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		Menu.Close.SetColor = function(self, Col)
			self.Color = Col
		end

		Menu.Close.GetColor = function(self)
			return self.Color
		end

		Menu.Close.DoClick = function()
			Prometheus.Menu.Close()
		end

		Menu.Close.OnCursorEntered = function(self)
			self:ColorTo(Prometheus.Menu.CloseHoverColor, 0.3, 0)
		end

		Menu.Close.OnCursorExited = function(self)
			self:ColorTo(Prometheus.Menu.CloseColor, 0.3, 0)
		end

end

function Prometheus.Menu.SwitchTab(ID)
	if !IsValid(Menu.Frame) then return end

	local AdminX, _, AdminW, _ = Menu.BtnAdmin:GetBounds()
	local PackX, _, PackW, _ = Menu.BtnPackage:GetBounds()

	if ID == 0 then
		Menu.BtnAdmin:MoveTo(AdminX, 10, 0.4)
		Menu.BtnPackage:MoveTo(PackX, 0, 0.2)
		Menu.BtnAdmin.Selected = false
		Menu.BtnAdmin:SetEnabled(true)
		Menu.BtnPackage.Selected = true
		Menu.BtnPackage:SetEnabled(false)
		Menu.PackagePanel:SetVisible(true)
		Menu.AdminPanel:SetVisible(false)
	else
		Menu.BtnPackage:MoveTo(PackX, 10, 0.4)
		Menu.BtnAdmin:MoveTo(AdminX, 0, 0.2)
		Menu.BtnAdmin.Selected = true
		Menu.BtnAdmin:SetEnabled(false)
		Menu.BtnPackage.Selected = false
		Menu.BtnPackage:SetEnabled(true)
		Menu.PackagePanel:SetVisible(false)
		Menu.AdminPanel:SetVisible(true)
		if !FetchedInitMessages then
			net.Start("Cl_PrometheusRequest")
				net.WriteUInt(1, 2)
				net.WriteUInt(1, 10)
			net.SendToServer()

			if !timer.Exists("PrometheusRefreshMessages") then
				timer.Create("PrometheusRefreshMessages", 5, 0, function()
					if Menu.Frame == nil then timer.Remove("PrometheusRefreshMessages") return end
					net.Start("Cl_PrometheusRequest")
						net.WriteUInt(1, 2)
						net.WriteUInt(#Menu.Messages + 1, 10)
					net.SendToServer()
				end)
			end

			FetchedInitMessages = true
		end
	end

end

function Prometheus.DrawCursorText()
	if DrawCursorText then
		local PosX, PosY = input.GetCursorPos()
		surface.SetFont("PrometheusTextSmall")
		surface.SetDrawColor(Prometheus.Menu.HoverTextBGColor)
		local TextX, TextY = surface.GetTextSize(DrawCursorText)
		surface.DrawRect(PosX - TextX / 2 - 5, PosY - TextY * 2, TextX + 10, TextY + 10)
		draw.SimpleText(DrawCursorText, "PrometheusTextSmall", PosX, PosY - TextY - 2, Prometheus.Menu.HoverTextColor, 1, 1)
	end
end

hook.Add("DrawOverlay", "PrometheusDrawOverlayHook", Prometheus.DrawCursorText)

function Prometheus.Menu.Close()
	if timer.Exists("PrometheusRefreshMessages") then
		timer.Remove("PrometheusRefreshMessages")
	end
	if IsValid(Menu.Frame) then
		Menu.Frame:Close()
		Menu = {}
	end
end

local function CharWrap(Text, Width)
	local Total = 0
	Text = Text:gsub(".", function(Char)
		Total = Total + surface.GetTextSize(Char)
		if Total >= Width then
			Total = 0
			return "\n" .. Char
		end
		return Char
	end)

	return Text, Total
end

function Prometheus.Menu.CutText(Text, Length, Font, Type)
	surface.SetFont(Font)
	local Total = 0

	if Type == 0 then
		local ExtraLen = surface.GetTextSize("...") + surface.GetTextSize("1000-01-01") + Menu.PackageScroll.WidePart

		local Done = false
		Text = Text:gsub(".", function(Char)
			if Done then return "" end
			Total = Total + surface.GetTextSize(Char)
			if Total + ExtraLen >= Length then
				Done = true
				return "..."
			end
			return Char
		end)

		return Text
	elseif Type == 1 then

		local SpaceSize = surface.GetTextSize(" ")
		Text = Text:gsub("(%s?[%S]+)", function(Word)
			local Char = string.sub(Word, 1, 1)
			if Char == "\n" or Char == "\t" then
				Total = 0
			end

			local WordLen = surface.GetTextSize(Word)
			Total = Total + WordLen

			if WordLen >= Length then
				local SplitWord, SplitPoint = CharWrap(Word, Length)
				Total = SplitPoint
				return splitWord
			elseif Total < Length then
				return Word
			end

			if Char == " " then
				Total = WordLen - SpaceSize
				return "\n" .. string.sub(Word, 2)
			end

			Total = WordLen
			return "\n" .. Word
		end)

		return Text
	end
end

function Prometheus.Menu.AddPackage(Title, ExpireTime, Active)
	if IsValid(Menu.PackageScroll) then
		local Line = {}

		Line.Num = #Menu.Packages

		Line.Title = Title
		Line.DrawTitle = Prometheus.Menu.CutText(Title, Menu.PackageScroll.WidePart * 15, "PrometheusTextSmall", 0)

		if Line.Title == Line.DrawTitle then
			Line.Cut = false
		else
			Line.Cut = true
		end

		if ExpireTime == "1000-01-01" then
			Line.ExpireTime = Prometheus.Lang.ExpiresNever
		else
			Line.ExpireTime = ExpireTime
		end

		Line.Panel = vgui.Create("DPanel", Menu.PackageScroll.pnlCanvas)
			Line.Panel:SetPos(0, (Line.Num * Menu.PackageScroll.ChildHeight) )
			if Line.Num % 2 == 0 then
				Line.Panel.Color = Prometheus.Menu.PackageLineBGColor1
			else
				Line.Panel.Color = Prometheus.Menu.PackageLineBGColor2
			end

			local ActiveText = Either(Active, Prometheus.Lang.StateActive, Prometheus.Lang.StateInactive)

			Line.Panel.Paint = function(self)
				surface.SetDrawColor(self.Color)
				surface.DrawRect(0, 0, self:GetSize() )
				if Active then
					surface.SetDrawColor(Color(92, 184, 92) )
				else
					surface.SetDrawColor(Color(19, 21, 21) )
				end

				surface.DrawRect(Menu.PackageScroll.WidePart * 16 + self:GetTall() * 0.2, self:GetTall() * 0.2, Menu.PackageScroll.WidePart * 4 - self:GetTall() * 0.4 , self:GetTall() * 0.6)

				draw.SimpleText(Line.DrawTitle, "PrometheusTextSmall", Menu.PackageScroll.WidePart * 0.5, self:GetTall() / 2, Prometheus.Menu.PackageLineTextColor, 0, 1)

				draw.SimpleText(Line.ExpireTime, "PrometheusTextSmall", Menu.PackageScroll.WidePart * 13.7, self:GetTall() / 2, Prometheus.Menu.PackageLineTextColor, 1, 1)

				draw.SimpleText(ActiveText, "PrometheusTextSmall", Menu.PackageScroll.WidePart * 18, self:GetTall() / 2, Prometheus.Menu.PackageLineTextColor, 1, 1)

			end

			Line.TitlePanel = vgui.Create("DPanel", Line.Panel)
			Line.TitlePanel:SetPos(0, 0)
			Line.TitlePanel.Paint = function() end

			Line.TitlePanel.OnMousePressed = function()
				if Line.Cut then
					DrawCursorText = Line.Title
				end
			end

			Line.TitlePanel.OnCursorExited = function()
				DrawCursorText = false
			end

		Line.Panel.PerformLayout = function()
			Line.TitlePanel:SetSize(Menu.PackageScroll.WidePart * 11.5, Menu.PackageScroll.ChildHeight)
			Line.Panel:SetSize(Menu.PackageScroll.pnlCanvas:GetWide(), Menu.PackageScroll.ChildHeight)
		end

		table.insert(Menu.Packages, Line)
	end
end


function Prometheus.Menu.AddMessage(Text, Time, Type)
	if IsValid(Menu.AdminScroll) then
		local Line = {}

		Line.Num = #Menu.Messages

		Line.Text = Text
		Line.DrawText = Prometheus.Menu.CutText(Text, Menu.AdminScroll.WidePart * 17, "PrometheusTextSmall", 0)

		if Line.Text == Line.DrawText then
			Line.Cut = false
		else
			Line.Cut = true
		end

		Line.Time = os.date("%X - %d/%m", Time)

		if Line.Num == 0 then
			Line.AddSpace = 0
		else
			Line.AddSpace = 1
		end

		Line.Panel = vgui.Create("DPanel", Menu.AdminScroll.pnlCanvas)
			Line.Panel:SetPos(0, (Line.Num * (Menu.AdminScroll.ChildHeight + Line.AddSpace) ) )
			if Type == 0 then
				Line.Panel.Color = Prometheus.Menu.AdminLineBGColorError
			else
				Line.Panel.Color = Prometheus.Menu.AdminLineBGColorInfo
			end

			Line.Panel.Paint = function(self)
				surface.SetDrawColor(self.Color)
				surface.DrawRect(0, 0, self:GetSize() )

				draw.SimpleText(Line.DrawText, "PrometheusTextSmall", Menu.AdminScroll.WidePart * 0.5, self:GetTall() / 2, Prometheus.Menu.AdminLineTextColor, 0, 1)

				draw.SimpleText(Line.Time, "PrometheusTextSmall", Menu.AdminScroll.WidePart * 17.2, self:GetTall() / 2, Prometheus.Menu.AdminLineTextColor, 1, 1)

			end

			Line.TextPanel = vgui.Create("DPanel", Line.Panel)
			Line.TextPanel:SetPos(0, 0)
			Line.TextPanel.Paint = function() end

			Line.TextPanel.OnMousePressed = function()
				if Line.Cut then
					DrawCursorText = Line.Text
				end
			end

			Line.TextPanel.OnCursorExited = function()
				DrawCursorText = false
			end

		Line.Panel.PerformLayout = function()
			Line.TextPanel:SetSize(Menu.AdminScroll.WidePart * 14, Menu.AdminScroll.ChildHeight)
			Line.Panel:SetSize(Menu.AdminScroll.pnlCanvas:GetWide(), Menu.AdminScroll.ChildHeight)
		end

		table.insert(Menu.Messages, Line)
	end
end


function Prometheus.Menu.AddInfo(Text)
	if IsValid(Menu.PackageScroll) then
		local Line = {}

		Line.Num = #Menu.Packages

		Line.DrawText = Prometheus.Menu.CutText(Text, Menu.PackageScroll.WidePart * 19, "PrometheusTextSmall", 1)

		Line.Panel = vgui.Create("DPanel", Menu.PackageScroll.pnlCanvas)
		Line.Panel:SetPos(0, (#Menu.Packages * Menu.PackageScroll.ChildHeight * 4) )

		Line.Panel.Paint = function(self)
			surface.SetDrawColor(Prometheus.Menu.PackageLineBGColor2)
			surface.DrawRect(0, 0, self:GetSize() )
			draw.DrawText(Line.DrawText, "PrometheusTextSmall", Menu.PackageScroll.WidePart * 10, 10, Prometheus.Menu.PackageTextColor, 1)
		end

		Line.Panel.PerformLayout = function()
			Line.Panel:SetSize(Menu.PackageScroll.pnlCanvas:GetWide(), Menu.PackageScroll.ChildHeight * 4)
		end

		table.insert(Menu.Packages, Line)
	end
end

local function SetAdminMenuAccess(Bool)
	ShowAdminTab = Bool
	if IsValid(Menu.Frame) then
		Menu.BtnAdmin:SetVisible(Bool)
	end
end

net.Receive("PrometheusPackages", function()
	SetAdminMenuAccess(net.ReadUInt(1) == 1)

	local ExtraID = net.ReadUInt(2)

	if ExtraID == 1 then
		Prometheus.Menu.AddInfo(Prometheus.Lang.OnCooldown)
		return
	elseif ExtraID == 2 then
		Prometheus.Menu.AddInfo(Prometheus.Lang.DBFailed)
		return
	end

	local Count = net.ReadUInt(10)

	for n = 1, Count do
		local Title = net.ReadString()
		local ExpireTime = net.ReadString()
		local Active = net.ReadUInt(1) == 1
		Prometheus.Menu.AddPackage(Title, ExpireTime, Active)
	end
end)

net.Receive("PrometheusMessages", function()

	local Count = net.ReadUInt(10)

	for n = 1, Count do
		local Type = net.ReadUInt(1)
		local Time = net.ReadUInt(32)
		local Text = net.ReadString()
		Prometheus.Menu.AddMessage(Text, Time, Type)
	end
end)

concommand.Add("Prometheus", Prometheus.Menu.Open)

concommand.Add("PrometheusSite", function() gui.OpenURL(Prometheus.WebsiteUrl or "http://TellTheServerOwnerToSetTheURLInConfig") end)