local self = {}

function self:Init ()
	self:SetHeight (24)
end

function self:Paint (w, h)
	surface.SetDrawColor (self:GetBackgroundColor ())
	surface.DrawRect (0, 0, w, h)
	
	-- Help text
	if self:GetText () == "" then
		self:PaintHelpText (w, h)
	end
	
	-- Text
	self:DrawTextEntryText (self:GetTextColor (), self:GetHighlightColor (), self:GetCursorColor ())
end

CAC.Register ("CACTextEntry", self, "GTextEntry")
