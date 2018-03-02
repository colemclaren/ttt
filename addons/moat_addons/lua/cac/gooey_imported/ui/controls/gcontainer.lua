-- Generated from: gooey/lua/gooey/ui/controls/gcontainer.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gcontainer.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

function PANEL:Init ()
end

function PANEL:Paint (w, h)
end

function PANEL:OnMouseDown (mouseCode, x, y)
	if not self:GetParent () then return end
	if not self:GetParent ():IsValid () then return end
	if not self:GetParent ().OnMousePressed then return end
	self:GetParent ():OnMousePressed (mouseCode)
end

function PANEL:OnMouseMove (mouseCode, x, y)
	if not self:GetParent () then return end
	if not self:GetParent ():IsValid () then return end
	if not self:GetParent ().OnCursorMoved then return end
	self:GetParent ():OnCursorMoved (self:GetParent ():CursorPos ())
end

function PANEL:OnMouseUp (mouseCode, x, y)
	if not self:GetParent () then return end
	if not self:GetParent ():IsValid () then return end
	if not self:GetParent ().OnMouseReleased then return end
	self:GetParent ():OnMouseReleased (mouseCode)
end

CAC.Register ("GContainer", PANEL, "GPanel")