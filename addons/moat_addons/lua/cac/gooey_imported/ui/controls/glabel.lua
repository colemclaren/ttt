-- Generated from: gooey/lua/gooey/ui/controls/glabel.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/glabel.lua
-- Timestamp:      2016-04-28 19:58:52
local PANEL = {}

function PANEL:Init ()
end

function PANEL:ApplySchemeSettings ()
	self:UpdateColours (self:GetSkin ())
	
	self:SetFGColor (self.m_colText or self.m_colTextStyle)
end

function PANEL:GetLineHeight ()
	surface.SetFont (self:GetFont ())
	local _, lineHeight = surface.GetTextSize ("W")
	return lineHeight
end

function PANEL:UpdateColours (skin)
	if self.TextColor then return end
	
	local ret = DLabel.UpdateColours (self, skin)
	self:SetTextColor (self:GetTextStyleColor ())
	return ret
end

CAC.Register ("GLabel", PANEL, "DLabel")