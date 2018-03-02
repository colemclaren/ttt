-- Generated from: gooey/lua/gooey/ui/controls/listbox/glistboxitem.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/listbox/glistboxitem.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

--[[
	Events:
		ListBoxItemChanged (ListBoxItem lastListBoxItem, ListBoxItem listBoxItem)
			Fired when this GListBoxItem's underlying ListBoxItem has changed.
]]

function PANEL:Init ()
	-- ListBox
	self.ListBox     = nil
	self.ListBoxItem = nil
	
	self.TextLabel   = self:Create ("GLabel")
	
	self:AddEventListener ("Click", "CAC.ListBoxItem." .. self:GetHashCode (),
		function (_)
			if not self.ListBoxItem then return self end
			
			self.ListBoxItem:DispatchEvent ("Click")
		end
	)
	self:AddEventListener ("PositionChanged", "CAC.ListBoxItem." .. self:GetHashCode (),
		function (_, x, y)
			if not self.ListBoxItem then return self end
			
			self.ListBoxItem:DispatchEvent ("PositionChanged", x, y)
		end
	)
	self:AddEventListener ("SizeChanged", "CAC.ListBoxItem." .. self:GetHashCode (),
		function (_, x, y)
			if not self.ListBoxItem then return self end
			
			self.ListBoxItem:DispatchEvent ("SizeChanged", x, y)
		end
	)
end

-- ListBox
function PANEL:GetListBox ()
	return self.ListBox
end

function PANEL:SetListBox (listBox)
	self.ListBox = listBox
end

-- ListBoxItem
function PANEL:GetListBoxItem ()
	return self.ListBoxItem
end

function PANEL:SetListBoxItem (listBoxItem)
	if self.ListBoxItem == listBoxItem then return self end
	
	if self.ListBoxItem then
		CAC.UnbindProperty (self,           self.ListBoxItem, "BackgroundColor", "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.UnbindProperty (self,           self.ListBoxItem, "Height",          "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.UnbindProperty (self,           self.ListBoxItem, "ToolTipText",     "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.UnbindProperty (self.TextLabel, self.ListBoxItem, "Font",            "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.UnbindProperty (self.TextLabel, self.ListBoxItem, "Text",            "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.UnbindProperty (self.TextLabel, self.ListBoxItem, "TextColor",       "CAC.ListBoxItem." .. self:GetHashCode ())
		
		self.ListBoxItem:RemoveEventListener ("IconChanged",   "CAC.ListBoxItem." .. self:GetHashCode ())
		self.ListBoxItem:RemoveEventListener ("IndentChanged", "CAC.ListBoxItem." .. self:GetHashCode ())
	end
	
	local lastListBoxItem = self.ListBoxItem
	self.ListBoxItem = listBoxItem
	
	if self.ListBoxItem then
		CAC.BindProperty (self,           self.ListBoxItem, "BackgroundColor", "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.BindProperty (self,           self.ListBoxItem, "Height",          "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.BindProperty (self,           self.ListBoxItem, "ToolTipText",     "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.BindProperty (self.TextLabel, self.ListBoxItem, "Font",            "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.BindProperty (self.TextLabel, self.ListBoxItem, "Text",            "CAC.ListBoxItem." .. self:GetHashCode ())
		CAC.BindProperty (self.TextLabel, self.ListBoxItem, "TextColor",       "CAC.ListBoxItem." .. self:GetHashCode ())
		
		self.ListBoxItem:AddEventListener ("IconChanged", "CAC.ListBoxItem." .. self:GetHashCode (),
			function (_)
				self:InvalidateLayout ()
			end
		)
		self.ListBoxItem:AddEventListener ("IndentChanged", "CAC.ListBoxItem." .. self:GetHashCode (),
			function (_)
				self:InvalidateLayout ()
			end
		)
	end
	
	self:OnListBoxItemChanged (lastListBoxItem, listBoxItem)
	self:DispatchEvent ("ListBoxItemChanged", lastListBoxItem, listBoxItem)
	
	return self
end

-- Control
function PANEL:Paint (w, h)
	if not self.ListBoxItem then return end
	
	-- Background
	if self.BackgroundColor then
		surface.SetDrawColor (self.BackgroundColor)
		self:DrawFilledRect ()
	end
	
	local col = self:GetSkin ().combobox_selected
	if self:IsSelected () then
		if not self:GetListBox ():IsFocused () then
			col = CAC.Colors.Silver
		end
		surface.SetDrawColor (col)
		self:DrawFilledRect ()
	elseif self:IsHoveredRecursive () then
		surface.SetDrawColor (col.r, col.g, col.b, col.a * 0.25)
		self:DrawFilledRect ()
	end
	
	-- Icon
	if self.ListBoxItem:GetIcon () then
		local image = CAC.ImageCache:GetImage (self.ListBoxItem:GetIcon ())
		local spacing = (self:GetHeight () - image:GetHeight ()) * 0.5
		image:Draw (CAC.RenderContext, self.ListBoxItem:GetIndent () + 1 + spacing, spacing)
	end
end

function PANEL:PerformLayout (w, h)
	if not self.ListBoxItem then return end
	
	local x = self.ListBoxItem:GetIndent () + 5
	if self.ListBoxItem:GetIcon () then
		x = x + 19
	end
	
	self.TextLabel:SetPos (x, 0)
	self.TextLabel:SetSize (w - x, h)
end

function PANEL:IsSelected ()
	return self.ListBox.SelectionController:IsSelected (self.ListBoxItem)
end

-- Event handlers
function PANEL:DoClick ()
	self.ListBox:DoClick (self)
end

function PANEL:DoRightClick ()
	self.ListBox:DoRightClick (self)
end

function PANEL:OnMousePressed (mouseCode)
	self.ListBox:OnMousePressed (mouseCode)
end

function PANEL:OnMouseReleased (mouseCode)
	self.ListBox:OnMouseReleased (mouseCode)
end

function PANEL:OnRemoved ()
	self:SetListBox (nil)
	self:SetListBoxItem (nil)
end

function PANEL:OnListBoxItemChanged (lastListBoxItem, listBoxItem)
end

-- Internal, do not call

CAC.Register ("GListBoxItem", PANEL, "GPanel")