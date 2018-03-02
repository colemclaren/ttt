local self = {}

function self:Init ()
	self:SetFont (CAC.Font ("Roboto", 20))
	self:SetTextColor (CAC.Colors.Black)
end

CAC.Register ("CACLabel", self, "GLabel")