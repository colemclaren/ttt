-- Generated from: gooey/lua/gooey/ui/controls/gcomboboxitem.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gcomboboxitem.lua
-- Timestamp:      2016-04-28 19:58:53
local self = {}
CAC.ComboBoxItem = CAC.MakeConstructor (self)

--[[
	Events:
		Deselected ()
			Fired when this item has been deselected.
		EnabledChanged (enabled)
			Fired when this item has been enabled or disabled.
		IconChanged (string icon)
			Fired when this item's icon has changed.
		Selected ()
			Fired when this item has been selected.
		TextChanged (string text)
			Fired when this item's text has changed.
		VisibleChanged (bool visible)
			Fired when this item's visibility has changed.
]]

function self:ctor (comboBox, id, text)
	-- Identity
	self.ComboBox = comboBox
	self.Id       = id
	
	-- Appearance
	self.Enabled  = true
	self.Visible  = true
	self.Text     = text
	self.Icon     = nil
	
	-- Menu item
	self.MenuItem = nil
	
	CAC.EventProvider (self)
	
	self:AddEventListener ("Deselected",
		function ()
			if not self.MenuItem then return end
			
			self.MenuItem:SetChecked (false)
		end
	)
	
	self:AddEventListener ("Selected",
		function ()
			if not self.MenuItem then return end
			
			self.MenuItem:SetChecked (true)
		end
	)
end

-- Identity
function self:GetComboBox ()
	return self.ComboBox
end

function self:GetId ()
	return self.Id or self:GetHashCode ()
end

function self:SetId (id)
	self.Id = id
end

-- Appearance
function self:GetIcon ()
	return self.Icon
end

function self:GetText ()
	return self.Text
end

function self:IsEnabled ()
	return self.Enabled
end

function self:IsVisible ()
	return self.Visible
end

function self:SetIcon (icon)
	if self.Icon == icon then return self end
	
	self.Icon = icon
	if self.MenuItem then
		self.MenuItem:SetIcon (self.Icon)
	end
	
	self:DispatchEvent ("IconChanged", self.Icon)
	
	return self
end

function self:SetText (text)
	if self.Text == text then return self end
	
	self.Text = text
	if self.MenuItem then
		self.MenuItem:SetText (self.Text)
	end
	
	self:DispatchEvent ("TextChanged", text)
	
	return self
end

function self:SetEnabled (enabled)
	if self.Enabled == enabled then return self end
	
	self.Enabled = enabled
	if self.MenuItem then
		self.MenuItem:SetEnabled (self.Enabled)
	end
	
	self:DispatchEvent ("EnabledChanged", enabled)
	
	return self
end

function self:SetVisible (visible)
	if self.Visible == visible then return self end
	
	self.Visible = visible
	if self.MenuItem then
		self.MenuItem:SetVisible (self.Visible)
	end
	
	self:DispatchEvent ("VisibleChanged", visible)
	
	return self
end

-- State
function self:IsSelected ()
	return self == self.ComboBox:GetSelectedItem ()
end

function self:Select ()
	self.ComboBox:SetSelectedItem (self)
end

-- Menu item
function self:GetMenuItem ()
	return self.MenuItem
end

function self:SetMenuItem (menuItem)
	if self.MenuItem == menuItem then return self end
	
	self:UnhookMenuItem (self.MenuItem)
	self.MenuItem = menuItem
	self:HookMenuItem (self.MenuItem)
	
	if self.MenuItem then
		self.MenuItem:SetEnabled (self:IsEnabled  ())
		self.MenuItem:SetVisible (self:IsVisible  ())
		
		self.MenuItem:SetText    (self:GetText    ())
		self.MenuItem:SetChecked (self:IsSelected ())
	end
	
	return self
end

-- Internal, do not call
function self:HookMenuItem (menuItem)
	if not menuItem then return end
	
	menuItem:AddEventListener ("Click", "CAC.ComboBoxItem." .. self:GetHashCode (),
		function ()
			self:Select ()
		end
	)
end

function self:UnhookMenuItem (menuItem)
	if not menuItem then return end
	
	menuItem:RemoveEventListener ("Click", "CAC.ComboBoxItem." .. self:GetHashCode ())
end