local PANEL = {}
local color_halfwhite = Color(255, 255, 255, 50)

function PANEL:Init()
	self:SetPos(4,4)
	self:SetSize(self:GetWide() - 8, 24)
	self:SetBackgroundColor(Color(139, 174, 179, 255))
	self.icon = vgui.Create("DImage", self)
	self.icon:SetImage("icon16/comment.png")
	self.icon:SizeToContents()
	self.label = vgui.Create("DLabel", self)
	self.label:SetText("")
	self.label:SetTextColor(color_white)
	self.label:SetExpensiveShadow(1, Color(0, 0, 0, 150))
end

function PANEL:PerformLayout(w, h)
	self.icon:SetPos(4, 4)
	self.label:SetPos((w/2) - (self.label:GetWide()/2),( h/2) - (self.label:GetTall()/2))
	derma.SkinHook("Layout", "Panel", self)
end

function PANEL:Paint(w, h)
	local color = self:GetBackgroundColor()
	if (not color) then return end

	local x, y = 0, 0
	if (self:IsDepressed()) then
		x, y, w, h = x + 2, y + 2, w - 4, h - 4
	end

	if (self:IsButton() and self:IsHovered()) then
		color = color_halfwhite
	end

	draw.RoundedBox(4, x, y, w, h, Color(color.r, color.g, color.b, color.a * 0.75))
end

function PANEL:SetText(text)
	self.label:SetText(text)
	self.label:SizeToContents()
end

function PANEL:SetButton(isButton)
	self.isButton = isButton
end

function PANEL:IsButton()
	return self.isButton
end

function PANEL:SetDepressed(isDepressed)
	self.isDepressed = isDepressed
end

function PANEL:IsDepressed()
	return self.isDepressed
end

function PANEL:SetHovered(isHovered)
	self.isHovered = isHovered
end

function PANEL:IsHovered()
	return self.isHovered
end

function PANEL:SetTextColor(color)
	self.label:SetTextColor(color)
end

function PANEL:OnMousePressed(mouseCode)
	if (self:IsButton()) then
		self:SetDepressed(true)
		self:MouseCapture(true)
	end
end

function PANEL:OnCursorEntered()
	self:SetHovered(true)
end

function PANEL:OnCursorExited()
	self:SetHovered(false)
end

function PANEL:SetShowIcon(showIcon)
	self.icon:SetVisible(showIcon)
end

function PANEL:SetIcon(icon)
	self.icon:SetImage(icon)
	self.icon:SizeToContents()
	self.icon:SetVisible(true)
end

function PANEL:SetInfoColor(color)
	if (color == "red") then
		self:SetBackgroundColor(Color(179, 46, 49, 255))
		self:SetIcon("icon16/exclamation.png")
	elseif (color == "orange") then
		self:SetBackgroundColor(Color(223, 154, 72, 255))
		self:SetIcon("icon16/error.png")
	elseif (color == "green") then
		self:SetBackgroundColor(Color(139, 215, 113, 255))
		self:SetIcon("icon16/tick.png")
	elseif (color == "blue") then
		self:SetBackgroundColor(Color(139, 174, 179, 255))
		self:SetIcon("icon16/information.png")
	else
		self:SetShowIcon(false)
		self:SetBackgroundColor(color)
	end
end

vgui.Register("dlogs_InfoLabel", PANEL, "DPanel")