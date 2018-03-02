-- Generated from: gooey/lua/gooey/ui/controls/menu/gmenuseparator.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/menu/gmenuseparator.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

function PANEL:Init ()
	self.Id = nil
	self.ContainingMenu = nil
	
	self.Item = nil
	
	self:SetTall (1)
end

function PANEL:GetContainingMenu ()
	return self.ContainingMenu
end

function PANEL:GetId ()
	return self.Id
end

function PANEL:GetItem ()
	return self.Item
end

function PANEL:GetMinimumContentWidth ()
	return 0
end

function PANEL:IsItem ()
	return false
end

function PANEL:IsSeparator ()
	return true
end

function PANEL:Paint (w, h)
	surface.SetDrawColor (Color (0, 0, 0, 100))
	surface.DrawRect (0, 0, w, h)
end

function PANEL:SetContainingMenu (menu)
	self.ContainingMenu = menu
end

function PANEL:SetId (id)
	self.Id = id
end

function PANEL:SetItem (menuItem)
	self.Item = menuItem
end

-- Event handlers
function PANEL:OnCursorEntered ()
	if not self:GetContainingMenu () then return end
	self:GetContainingMenu ():SetHoveredItem (self)
end

function PANEL:OnCursorExited ()
	if not self:GetContainingMenu () then return end
	if self:GetContainingMenu ():GetHoveredItem () == self then
		self:GetContainingMenu ():SetHoveredItem (nil)
	end
end

CAC.Register ("GMenuSeparator", PANEL, "DPanel")