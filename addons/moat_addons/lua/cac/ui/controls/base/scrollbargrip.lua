local self = {}

local backgroundColor = CAC.Colors.Gainsboro

function self:Init ()
	self.HoverAlphaFilter = CAC.ExponentialDecayResponseFilter (5)
	
	self:SetBackgroundColor (backgroundColor)
end

local color
function self:Paint (w, h)
	if self:IsHoveredRecursive () then
		self.HoverAlphaFilter:Impulse ()
	end
	
	local x = 0
	local y = 0
	
	if self:GetParent ():GetOrientation () == CAC.Orientation.Horizontal then
		x = x + 2
		w = w - 4
	elseif self:GetParent ():GetOrientation () == CAC.Orientation.Vertical then
		y = y + 2
		h = h - 4
	end
	
	-- Background
	surface.SetDrawColor (self:GetBackgroundColor ())
	surface.DrawRect (x, y, w, h)
	
	-- Highlight
	local alpha = 128 * self.HoverAlphaFilter:Evaluate ()
	if self:IsPressed () then
		alpha = 160
	end
	
	color = CAC.Color.FromColor (CAC.Colors.LightSteelBlue, alpha, color)
	surface.SetDrawColor (color)
	surface.DrawRect (x, y, w, h)
end

CAC.Register ("CACScrollBarGrip", self, "GScrollBarGrip")