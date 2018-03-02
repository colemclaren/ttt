-- Generated from: gooey/lua/gooey/ui/controls/listbox/listboxitem.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/listbox/listboxitem.lua
-- Timestamp:      2016-04-28 19:58:53
local self = {}
CAC.ListBox.ListBoxItem = CAC.MakeConstructor (self)

--[[
	Events:
		EnabledChanged (enabled)
			Fired when this ListBoxItem's has been enabled or disabled.
		HeightChanged (lastHeight, height)
			Fired when this ListBoxItem's height has been changed.
		IndentChanged (indent)
			Fired when this ListBoxItem's content indent has changed.
		ListBoxChanged (ListBox listBox)
			Fired when this ListBoxItem's parent has changed.
		ParentChanged (ListBox listBox)
			Fired when this ListBoxItem's parent has changed.
		PositionChanged (x, y)
			Fired when this ListBoxItem's position has changed.
		SizeChanged (width, height)
			Fired when this ListBoxItem's size has changed.
		TextChanged (text)
			Fired when this ListBoxItems' text has changed.
		ToolTipTextChanged (toolTipText)
			Fired when this ListBoxItem's tooltip text has changed.
		VisibleChanged (visible)
			Fired when this ListBoxItem's visibility has changed.
]]

function self:ctor (listBox)
	self.ListBox         = listBox
	self.Parent          = listBox
	
	self.Id              = nil
	
	self.Control         = nil
	
	self.Enabled         = true
	self.Visible         = true
	
	-- Size
	self.Height          = 20
	
	-- Content
	self.Indent          = 0
	self.Icon            = nil
	
	self.BackgroundColor = nil
	
	-- Text
	self.Font            = "DermaDefault"
	self.Text            = "ListBoxItem"
	self.TextColor       = CAC.Colors.Black
	
	self.ToolTipText     = nil
	
	-- Selection
	self.Selectable      = true
	
	CAC.EventProvider (self)
end

function self:dtor ()
	self:Remove ()
end

-- ListBox
function self:GetListBox ()
	return self.ListBox
end

function self:GetParent ()
	return self.Parent
end

function self:SetListBox (listBox)
	if self.ListBox == listBox then return self end
	
	self.ListBox = listBox
	
	self:DispatchEvent ("ListBoxChanged", self.ListBox)
	return self
end

function self:SetParent (parent)
	if self.Parent == parent then return self end
	
	self.Parent = parent
	
	self:DispatchEvent ("ParentChanged", self.Parent)
	return self
end

function self:GetIndex ()
	return self.ListBox:GetItems ():IndexOf (self)
end

function self:GetSortedIndex ()
	return self.ListBox:GetItems ():SortedIndexOf (self)
end

-- Control
function self:GetControl ()
	return self.Control
end

function self:SetControl (control)
	if self.Control == control then return self end
	
	if self.Control then
		self.Control:SetListBoxItem (nil)
	end
	
	self.Control = control
	
	if self.Control then
		self.Control:SetListBoxItem (self)
	end
	
	return self
end

function self:LocalToScreen (x, y)
	return self.Control:LocalToScreen (x, y)
end

function self:GetSize ()
	return self.Control:GetSize ()
end

-- Identity
function self:GetId ()
	return self.Id
end

function self:SetId (id)
	if self.Id == id then return self end
	
	self.Id = id
	
	return self
end

-- Appearance
function self:IsEnabled ()
	return self.Enabled
end

function self:IsVisible ()
	return self.Visible
end

function self:SetEnabled (enabled)
	if self.Enabled == enabled then return self end
	
	self.Enabled = enabled
	
	self:DispatchEvent ("EnabledChanged", self.Enabled)
	return self
end

function self:SetVisible (visible)
	if self.Visible == visible then return self end
	
	self.Visible = visible
	
	self:DispatchEvent ("VisibleChanged", self.Visible)
	return self
end

-- Size
function self:GetHeight ()
	return self.Height
end

function self:SetHeight (height)
	if self.Height == height then return self end
	
	local lastHeight = self.Height
	self.Height = height
	self:DispatchEvent ("HeightChanged", lastHeight, self.Height)
	
	return self
end

function self:GetBackgroundColor ()
	return self.BackgroundColor
end

function self:SetBackgroundColor (backgroundColor)
	if self.BackgroundColor == backgroundColor then return self end
	
	self.BackgroundColor = backgroundColor
	
	self:DispatchEvent ("BackgroundColorChanged", self.BackgroundColor)
	
	return self
end

-- Content
function self:GetIndent ()
	return self.Indent
end

function self:GetIcon ()
	return self.Icon
end

function self:SetIndent (indent)
	if self.Indent == indent then return self end
	
	self.Indent = indent
	
	self:DispatchEvent ("IndentChanged", self.Indent)
	
	return self
end

function self:SetIcon (icon)
	if self.Icon == icon then return self end
	
	self.Icon = icon
	
	self:DispatchEvent ("IconChanged", self.Icon)
	
	return self
end

-- Text
function self:GetFont ()
	return self.Font
end

function self:GetText ()
	return self.Text
end

function self:GetTextColor ()
	return self.TextColor
end

function self:SetFont (font)
	if self.Font == font then return self end
	
	self.Font = font
	
	self:DispatchEvent ("FontChanged", self.Font)
	
	return self
end

function self:SetText (text)
	if self.Text == text then return self end
	
	self.Text = text
	
	self:DispatchEvent ("TextChanged", self.Text)
	
	return self
end

function self:SetTextColor (textColor)
	if self.TextColor == textColor then return self end
	
	self.TextColor = textColor
	
	self:DispatchEvent ("TextColorChanged", self.TextColor)
	
	return self
end

-- Tooltip
function self:GetToolTipText ()
	return self.ToolTipText
end

function self:SetToolTipText (toolTipText)
	if self.ToolTipText == toolTipText then return self end
	
	self.ToolTipText = toolTipText
	
	self:DispatchEvent ("ToolTipTextChanged", self.ToolTipText)
	
	return self
end

-- Selection
function self:CanSelect ()
	return self.Selectable
end

function self:EnsureVisible ()
	if not self.ListBox then return end
	self.ListBox:EnsureVisible (self)
end

function self:Select ()
	self.ListBox.SelectionController:ClearSelection ()
	self.ListBox.SelectionController:AddToSelection (self)
end

function self:SetCanSelect (canSelect)
	self.Selectable = canSelect
end

-- ListBoxItem
function self:Remove ()
	if not self.ListBox then return end
	
	self.ListBox:GetItems ():RemoveItem (self)
	self:SetListBox (nil)
	
	self:DispatchEvent ("Removed")
end