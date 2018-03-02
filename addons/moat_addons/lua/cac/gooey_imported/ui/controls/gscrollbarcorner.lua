-- Generated from: gooey/lua/gooey/ui/controls/gscrollbarcorner.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gscrollbarcorner.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

function PANEL:Init ()
	self:SetSize (15, 15)
end

function PANEL:Paint (w, h)
	surface.SetDrawColor (CAC.Colors.Silver)
	surface.DrawRect (0, 0, w, h)
end

CAC.Register ("GScrollBarCorner", PANEL, "GPanel")