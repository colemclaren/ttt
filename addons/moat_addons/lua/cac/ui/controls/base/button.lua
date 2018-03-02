local self = {}

local backgroundColor = Color (128, 128, 128, 32)

function self:Init ()
	self.HoverAlphaFilter = CAC.ExponentialDecayResponseFilter (5)
	
	self:SetFont ("DermaLarge")
	self:SetText ("Button")
	self:SetTextColor (CAC.Colors.Black)
	self:SetHeight (30)
	
	self:SetBackgroundColor (backgroundColor)
end

local color
function self:Paint (w, h)
	-- Background
	surface.SetDrawColor (self:GetBackgroundColor ())
	surface.DrawRect (0, 0, w, h)
	
	if self:IsEnabled () then
		if self:IsHoveredRecursive () then
			self.HoverAlphaFilter:Impulse ()
		end
		
		-- Highlight
		local alpha = 128 * self.HoverAlphaFilter:Evaluate ()
		if self:IsPressed () then
			alpha = 160
		end
		
		color = CAC.Color.FromColor (CAC.Colors.LightSkyBlue, alpha, color)
		surface.SetDrawColor (color)
		surface.DrawRect (0, 0, w, h)
	end
	
	-- Text
	self:PaintContent (w, h)
end

function self:PaintContent (w, h)
	-- Text
	surface.SetFont (self:GetFont ())
	local textWidth, textHeight = surface.GetTextSize (self:GetText ())
	surface.SetTextPos (0.5 * (w - textWidth), 0.5 * (h - textHeight))
	surface.SetTextColor (self:GetTextColor ())
	surface.DrawText (self:GetText ())
end

CAC.Register ("CACButton", self, "CACPanel")