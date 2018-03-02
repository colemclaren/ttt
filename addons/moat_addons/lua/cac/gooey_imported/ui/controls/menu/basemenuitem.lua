-- Generated from: gooey/lua/gooey/ui/controls/menu/basemenuitem.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/menu/basemenuitem.lua
-- Timestamp:      2016-04-28 19:58:53
local self = {}
CAC.BaseMenuItem = CAC.MakeConstructor (self)

--[[
	Events:
		Click ()
			Fired when this item has been clicked.
		EnabledChanged (enabled)
			Fired when this item has been enabled or disabled.
		ParentChanged (Menu parent)
			Fired when this item's parent has been changed.
		Removed ()
			Fired when this item has been removed.
		Select ()
			Fired when the user has hovered over this item.
		ToolTipTextChanged (tooltipText)
			Fired when this item's tooltip text has changed.
		VisibleChanged (visible)
			Fired when this item's visibility has changed.
]]

function self:ctor ()
	self.Parent = nil
	
	self.Id = nil
	
	self.Enabled = true
	self.Visible = true
	
	self.ToolTipText = nil
	
	CAC.EventProvider (self)
end

function self:dtor ()
	self:DispatchEvent ("Removed")
end

function self:GetId ()
	return self.Id
end

function self:GetParent ()
	return self.Parent
end

function self:GetToolTipText ()
	return self.ToolTipText
end

function self:IsEnabled ()
	return self.Enabled
end

function self:IsItem ()
	return false
end

function self:IsSeparator ()
	return false
end

function self:IsVisible ()
	return self.Visible
end

function self:Remove ()
	self:dtor ()
end

function self:SetEnabled (enabled)
	if self.Enabled == enabled then return self end
	
	self.Enabled = enabled
	
	self:DispatchEvent ("EnabledChanged", self.Enabled)
	return self
end

function self:SetId (id)
	if self.Id == id then return self end
	
	self.Id = id
	
	return self
end

function self:SetParent (parent)
	if self.Parent == parent then return self end
	
	self.Parent = parent
	
	self:DispatchEvent ("ParentChanged", self.Parent)
	return self
end

function self:SetToolTipText (toolTipText)
	if self.ToolTipText == toolTipText then return self end
	
	self.ToolTipText = toolTipText
	self:DispatchEvent ("ToolTipTextChanged", self.ToolTipText)
	
	return self
end

function self:SetVisible (visible)
	if self.Visible == visible then return self end
	
	self.Visible = visible
	
	self:DispatchEvent ("VisibleChanged", self.Visible)
	return self
end