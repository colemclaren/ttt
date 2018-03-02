-- Generated from: gooey/lua/gooey/ui/controls/menu/menuitem.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/menu/menuitem.lua
-- Timestamp:      2016-04-28 19:58:53
local self = {}
CAC.MenuItem = CAC.MakeConstructor (self, CAC.BaseMenuItem)

--[[
	Events:
		ActionChanged (actionName)
			Fired when this menu item's action has changed.
		Checked (checked)
			Fired when this menu item's check state has changed.
		Click (targetItem)
			Fired when this item has been clicked.
		IconChanged (icon)
			Fired when this menu item's icon has changed.
		MouseEnter ()
			Fired when the mouse has entered this menu item.
		MouseLeave ()
			Fired when the mouse has left this menu item.
		SubMenuChanged (oldSubMenu, newSubMenu)
			Fired when this menu item's submenu has changed.
		TextChanged (text)
			Fired when this menu item's text has changed.
]]

function self:ctor ()
	self.Text = ""
	self.Checked = false
	self.Icon = nil
	
	self.SubMenu = nil
	
	-- Actions
	self.Action = nil
end

function self:dtor ()
	if self.SubMenu then
		self.SubMenu:dtor ()
	end
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	-- BaseMenuItem
	self:SetId      (source:GetId     ())
	self:SetEnabled (source:IsEnabled ())
	self:SetVisible (source:IsVisible ())
	
	-- MenuItem
	self:SetText    (source:GetText   ())
	self:SetChecked (source:IsChecked ())
	self:SetIcon    (source:GetIcon   ())
	
	self:SetSubMenu (source:GetSubMenu () and source:GetSubMenu ():Clone () or nil)
	
	-- Events
	self:GetEventProvider ():Copy (source)
	
	self:SetAction  (source:GetAction ())
	
	return self
end

function self:CreateSubMenu ()
	if not self.SubMenu then
		self:SetSubMenu (CAC.Menu ())
	end
	return self.SubMenu
end

function self:GetAction ()
	return self.Action
end

function self:GetIcon ()
	return self.Icon
end

function self:GetSubMenu ()
	return self.SubMenu
end

function self:GetText ()
	return self.Text
end

function self:HasSubMenu ()
	return self.SubMenu ~= nil
end

function self:IsChecked ()
	return self.Checked
end

function self:IsParent ()
	return self.ChildMenu ~= nil
end

function self:IsItem ()
	return true
end

function self:IsValid ()
	return true
end

function self:SetAction (action)
	if self.Action == action then return self end
	
	self.Action = action
	self:DispatchEvent ("ActionChanged", self.Action)
	
	return self
end

function self:SetChecked (checked)
	if self.Checked == checked then return self end
	
	self.Checked = checked
	self:DispatchEvent ("CheckedChanged", self.Checked)
	
	return self
end

function self:SetIcon (icon)
	if self.Icon == icon then return self end
	
	self.Icon = icon
	self:DispatchEvent ("IconChanged", self.Icon)
	
	return self
end

function self:SetSubMenu (subMenu)
	if self.SubMenu == subMenu then return self end
	
	local oldSubMenu = self.SubMenu
	self.SubMenu = subMenu
	self:DispatchEvent ("SubMenuChanged", oldSubMenu, self.SubMenu)
	
	return self
end

function self:SetText (text)
	if self.Text == text then return self end
	
	self.Text = text
	self:DispatchEvent ("TextChanged", self.Text)
	
	return self
end