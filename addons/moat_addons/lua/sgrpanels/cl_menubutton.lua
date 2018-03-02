/*---------------------------------------------------------
  START MenuButtonPanel
---------------------------------------------------------*/
local MenuButtonPanel = {}

function MenuButtonPanel:Init()
	self:SetDrawBackground(false)
	self:SetDrawBorder(false)
	//self:SetStretchToFit(false)
	self:SetSize(250, REWARDS.ControlHeight)
	
	self.CurrentWidth = 250
	self.BackColor = REWARDS.Theme.ButtonColor
	self.TextColor = Color(255, 255, 255, 250 )
	self.HoverColor = REWARDS.Theme.ButtonHoverColor
	self.HoverTextColor = Color(255, 255, 255, 250)
	self.Hovering = false
	
	self.HeaderLbl = vgui.Create("DLabel", self)
	self.HeaderLbl:SetFont(REWARDS.Theme.Font)
	self.HeaderLbl:SetColor(self.TextColor)

end

function MenuButtonPanel:SetNoActionEnbaled()
	self.NoAction = true
	self.HoverColor = Color(0, 0, 0, 155 )
	self.HeaderLbl:SetColor(Color(153, 153, 153, 90 ))
end

function MenuButtonPanel:SetColor(color)
	if not type(color) == "color" then return end
	self.NoAction = true
	self.HoverColor = color
	self.HoverTextColor = color
end

function MenuButtonPanel:SetText(text)
	self.HeaderLbl:SetText(text)
	self.HeaderLbl:SizeToContents()
	self.CurrentWidth = self.HeaderLbl:GetWide() + 10
end
function MenuButtonPanel:PerformLayout()
	
	self.HeaderLbl:SetPos(3, 3)

	self:SetWide( self.CurrentWidth )
 end

function MenuButtonPanel:Paint()
	if not self.Hovering and not self.CurrentSelection then surface.SetDrawColor(self.BackColor)
	else surface.SetDrawColor(self.HoverColor) end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall())
end

function MenuButtonPanel:OnCursorEntered()
	self.Hovering = true
	if not self.NoAction and not self.CurrentSelection then
	self.HeaderLbl:SetColor(self.HoverTextColor)
	end
end

function MenuButtonPanel:OnCursorExited()
	self.Hovering = false
	if not self.NoAction and not self.CurrentSelection then
	self.HeaderLbl:SetColor(self.TextColor)
	end
end

derma.DefineControl("ModernRewardsButton", "Modern RewardsButton", MenuButtonPanel, "DImageButton")

/*---------------------------------------------------------
  End MenuButtonPanel
---------------------------------------------------------*/