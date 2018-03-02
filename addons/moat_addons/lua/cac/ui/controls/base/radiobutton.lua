local self = {}

--[[
	Events:
		RadioButtonGroupChanged (lastRadioButtonGroup, radioButtonGroup)
			Fired when this radio button's group has changed.
		SelectedChanged (selected)
			Fired when this radio button has been selected or unselected.
]]

function self:Init ()
	self.HoverAlphaFilter = CAC.ExponentialDecayResponseFilter (5)
	
	self.RadioButtonGroup = nil
	
	self.Selected         = false
	
	self:SetFont (CAC.Font ("Roboto", 20))
	self:SetTextColor (CAC.Colors.Black)
	self:SetHeight (16)
end

local darkGray = Color (72, 72, 72, 255)
local color
function self:Paint (w, h)
	local x = 4
	if self:IsEnabled () then
		if self:IsHoveredRecursive () then
			self.HoverAlphaFilter:Impulse ()
		end
		
		-- Highlight
		local alpha = 128 * self.HoverAlphaFilter:Evaluate ()
		if self:IsPressed () then
			alpha = 160
		end
		
		local radius = 8
		local dr = 2
		draw.RoundedBox	(radius,      x,      h * 0.5 - radius,       radius       * 2,  radius       * 2, darkGray)
		draw.RoundedBox	(radius - dr, x + dr, h * 0.5 - radius + dr, (radius - dr) * 2, (radius - dr) * 2, CAC.Colors.White)
		
		color = CAC.Color.FromColor (CAC.Colors.LightSkyBlue, alpha, color)
		draw.RoundedBox	(radius - dr, x + dr, h * 0.5 - radius + dr, (radius - dr) * 2, (radius - dr) * 2, color)
		
		if self:IsSelected () then
			draw.RoundedBox (radius - 4, x + 4, h * 0.5 - radius + 4, (radius - 4) * 2, (radius - 4) * 2, darkGray)
		end
		
		x = x + radius * 2
		x = x + 4
	end
	
	-- Text
	surface.SetFont (self:GetFont ())
	surface.SetTextColor (self:GetTextColor ())
	
	local textWidth, textHeight = surface.GetTextSize (self:GetText ())
	surface.SetTextPos (x + 4, 0.5 * (h - textHeight))
	surface.DrawText (self:GetText ())
end

function self:PerformLayout (w, h)
end

function self:GetRadioButtonGroup ()
	return self.RadioButtonGroup
end

function self:IsSelected ()
	return self.Selected
end

function self:SetRadioButtonGroup (radioButtonGroup)
	if self.RadioButtonGroup == radioButtonGroup then return self end
	
	local lastRadioButtonGroup = self.RadioButtonGroup
	self.RadioButtonGroup = radioButtonGroup
	
	self:DispatchEvent ("RadioButtonGroupChanged", lastRadioButtonGroup, self.RadioButtonGroup)
	
	return self
end

function self:SetSelected (selected)
	if self.RadioButtonGroup == selected then return self end
	
	self.Selected = selected
	
	if self.Selected then
		for _, control in ipairs (self:GetParent ():GetChildren ()) do
			if control ~= self and
			   isfunction (control.GetRadioButtonGroup) and
			   control:GetRadioButtonGroup () == self:GetRadioButtonGroup () then
				control:SetSelected (false)
			end
		end
	end
	
	self:DispatchEvent ("SelectedChanged", self.Selected)
	
	return self
end

function self:OnMouseDown (mouseCode, x, y)
	self:SetSelected (true)
end

CAC.Register ("CACRadioButton", self, "CACPanel")