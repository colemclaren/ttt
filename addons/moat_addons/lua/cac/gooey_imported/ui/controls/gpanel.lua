-- Generated from: gooey/lua/gooey/ui/controls/gpanel.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gpanel.lua
-- Timestamp:      2016-04-28 19:58:52
local PANEL = {}

function PANEL:Init ()
end

function PANEL:Paint (w, h)
	draw.RoundedBox (4, 0, 0, w, h, self:GetBackgroundColor ())
end

-- Event handlers
CAC.CreateMouseEvents (PANEL)

function PANEL:OnKeyCodePressed (keyCode)
	return self:DispatchKeyboardAction (keyCode)
end
PANEL.OnKeyCodeTyped = PANEL.OnKeyCodePressed

CAC.Register ("GPanel", PANEL, "DPanel")