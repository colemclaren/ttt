local self = {}

function self:Init ()
	self:SetBackgroundColor (CAC.Colors.Gainsboro)
end

function self:Paint (w, h)
	if not self:GetBackgroundColor () then return end
	
	surface.SetDrawColor (self:GetBackgroundColor ())
	surface.DrawRect (0, 0, w, h)
end

CAC.Register ("CACPanel", self, "GPanel")