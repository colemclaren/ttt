local self = {}

function self:Init ()
	self:SetBackgroundColor (CAC.Colors.Gainsboro)
	
	self:AddEventListener ("MenuOpening",
		function (_, menu)
			for menuItem in menu.Control:GetEnumerator () do
				menuItem:SetFont (self:GetFont ())
			end
		end
	)
end

function self:Paint (w, h)
	if not self:GetBackgroundColor () then return end
	
	surface.SetDrawColor (self:GetBackgroundColor ())
	surface.DrawRect (0, 0, w, h)
end

CAC.Register ("CACComboBox", self, "GComboBox")