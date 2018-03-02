local self = {}

function self:Init ()
	self:SetFont (CAC.Font ("Roboto", 20))
	self:SetTextColor (CAC.Colors.Black)
	
	self:SetCursor ("arrow")
end

CAC.Register ("CACCheckbox", self, "GCheckbox")