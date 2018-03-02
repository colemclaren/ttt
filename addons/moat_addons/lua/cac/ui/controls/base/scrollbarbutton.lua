local self = {}

local backgroundColor = CAC.Colors.Gainsboro

local upPoly =
{
	{ x =  8, y = 5 },
	{ x = 12, y = 9 },
	{ x =  4, y = 9 }
}

local downPoly =
{
	{ x =  8, y = 9 },
	{ x =  4, y = 5 },
	{ x = 12, y = 5 }
}

function self:Init ()
	self.HoverAlphaFilter = CAC.ExponentialDecayResponseFilter (5)
	
	self:SetBackgroundColor (backgroundColor)
end

local color
function self:Paint (w, h)
	if self:IsHoveredRecursive () then
		self.HoverAlphaFilter:Impulse ()
	end
	
	-- Background
	surface.SetDrawColor (self:GetBackgroundColor ())
	surface.DrawRect (0, 0, w, h)
	
	-- Highlight
	local alpha = 128 * self.HoverAlphaFilter:Evaluate ()
	if self:IsPressed () then
		alpha = 160
	end
	
	color = CAC.Color.FromColor (CAC.Colors.LightSteelBlue, alpha, color)
	surface.SetDrawColor (color)
	surface.DrawRect (0, 0, w, h)
	
	-- Arrows
	surface.SetDrawColor (CAC.Colors.Black)
	draw.NoTexture ()
	local direction = self:GetDirection ()
	if direction == "Up" then
		surface.DrawPoly (upPoly)
	elseif direction == "Down" then
		surface.DrawPoly (downPoly)
	end
end

CAC.Register ("CACScrollBarButton", self, "GScrollBarButton")