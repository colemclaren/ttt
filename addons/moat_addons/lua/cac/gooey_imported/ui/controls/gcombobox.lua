-- Generated from: gooey/lua/gooey/ui/controls/gcombobox.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gcombobox.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

--[[
	GComboBox
	
	Events:
		MenuOpening (Menu menu)
			Fired when the menu is opening.
		SelectedItemChanged (ComboBoxItem lastSelectedItem, ComboBoxItem selectedItem)
			Fired when the selected item has changed.
]]

function PANEL:Init ()
	self.DropButton = vgui.Create ("GPanel", self)
	self.DropButton.Paint = function (panel, w, h)
		derma.SkinHook ("Paint", "ComboDownArrow", panel, w, h)
	end
	self.DropButton:SetMouseInputEnabled (false)
	self.DropButton.ComboBox = self
	
	self:SetHeight (22)
	
	self:SetContentAlignment (4)
	self:SetTextInset (8, 0)
	self.Icon = nil
	
	-- Items
	self.Items = {}
	self.ItemsById = {}
	self.SelectedItem = nil
	
	-- Menu
	self.Menu = CAC.Menu ()
	self.MenuDownwards = true
	self.MenuOpen = false
	self.MenuCloseTime = 0
	
	self.Menu:AddEventListener ("MenuOpening",
		function ()
			self:DispatchEvent ("MenuOpening", self.Menu)
		end
	)
	
	self.Menu:AddEventListener ("MenuClosed",
		function ()
			self.MenuOpen = false
			self.MenuCloseTime = CurTime ()
		end
	)
	
	self:AddEventListener ("MouseDown",
		function (_, mouseCode)
			if mouseCode == MOUSE_LEFT then
				if self.MenuCloseTime ~= CurTime () then
					if not self.Menu then return end
					self.MenuOpen = true
					
					local x, y = self:LocalToScreen (0, 1)
					local menu = self.Menu:Show (self, x, y, self:GetWide (), self:GetTall () - 2, CAC.Orientation.Vertical)
					self.MenuDownwards = menu:GetAnchorVerticalAlignment () == CAC.VerticalAlignment.Top
				end
			end
		end
	)
	
	self:AddEventListener ("WidthChanged",
		function (_)
			self:UpdateTooltip ()
		end
	)
	
	self:AddEventListener ("TextChanged",
		function (_)
			self:UpdateTooltip ()
		end
	)
end

function PANEL:AddItem (text, id)
	-- Auto-assign an id if possible
	id = id or text
	if self:GetItemById (id) then
		-- Id already taken
		id = nil
	end
	
	local comboBoxItem = CAC.ComboBoxItem (self, id)
	comboBoxItem:SetText (text)
	
	self.Items [#self.Items + 1] = comboBoxItem
	self.ItemsById [comboBoxItem:GetId ()] = comboBoxItem
	
	local menuItem = self.Menu:AddItem (comboBoxItem:GetText ())
	comboBoxItem:SetMenuItem (menuItem)
	
	self:HookComboBoxItem (comboBoxItem)
	
	if not self:GetSelectedItem () then
		self:SetSelectedItem (comboBoxItem)
	end
	
	return comboBoxItem
end

function PANEL:Clear ()
	for comboBoxItem in self:GetItemEnumerator () do
		self:UnhookComboBoxItem (comboBoxItem)
	end
	
	self.Items = {}
	self.ItemsById = {}
	
	self.Menu:Clear ()
	
	self:SetSelectedItem (nil)
end

function PANEL:GetItemById (id)
	return self.ItemsById [id]
end

function PANEL:GetItemCount ()
	return #self.Items
end

function PANEL:GetItemEnumerator ()
	return CAC.ArrayEnumerator (self.Items)
end

function PANEL:GetMenu ()
	return self.Menu
end

function PANEL:GetSelectedItem ()
	return self.SelectedItem
end

function PANEL:IsMenuOpen ()
	return self.MenuOpen
end

function PANEL:SetSelectedItem (comboBoxItem)
	if isnumber (comboBoxItem) or
	   isstring (comboBoxItem) then
		comboBoxItem = self:GetItemById (comboBoxItem)
	end
	
	if self.SelectedItem == comboBoxItem then return self end
	
	local lastSelectedItem = self.SelectedItem
	
	if self.SelectedItem then
		self:UnhookSelectedComboBoxItem (self.SelectedItem)
		self.SelectedItem:DispatchEvent ("Deselected")
	end
	
	self.SelectedItem = comboBoxItem
	self:SetIcon (comboBoxItem and comboBoxItem:GetIcon ())
	self:SetText (comboBoxItem and comboBoxItem:GetText () or "")
	
	if self.SelectedItem then
		self:HookSelectedComboBoxItem (self.SelectedItem)
		self.SelectedItem:DispatchEvent ("Selected")
	end
	
	self:DispatchEvent ("SelectedItemChanged", lastSelectedItem, self.SelectedItem)
	
	return self
end

-- Events
function PANEL:DoClick ()
end

function PANEL:OnRemoved ()
	self.Menu:dtor ()
end

function PANEL:OnSelect (index, text, comboBoxItem)
	self:SetSelectedItem (comboBoxItem)
end

function PANEL:Paint (w, h)
	derma.SkinHook ("Paint", "ComboBox", self, w, h)
end

-- Layout
function PANEL:CalculateTextInset ()
	if self.Icon then
		return self.Icon:GetPos () + self.Icon:GetWidth () + 3
	else
		return 8
	end
end

function PANEL:GetTextAreaWidth ()
	return self:GetWidth () - self:CalculateTextInset ()
end

function PANEL:PerformLayout ()
	if self.Icon then
		local iconInset = (self:GetHeight () - self.Icon:GetHeight ()) / 2
		self.Icon:SetSize (16, 16)
		self.Icon:SetPos (iconInset, iconInset)
	end
	
	self:SetTextInset (self:CalculateTextInset (), 0)
	
	self.DropButton:SetSize (15, 15)
	self.DropButton:AlignRight (4)
	self.DropButton:CenterVertical ()
	
	self.Menu:SetWidth (self:GetWidth ())
end

-- Internal, do not call
function PANEL:GetIcon ()
	if not self.Icon then return nil end
	return self.Icon:GetImage ()
end

function PANEL:SetIcon (icon)
	if self:GetIcon () == icon then return self end
	
	if not icon then
		self.Icon:Remove ()
		self.Icon = nil
		self:InvalidateLayout ()
		self:UpdateTooltip ()
	else
		if not self.Icon then
			self.Icon = vgui.Create ("GImage", self)
			self:InvalidateLayout ()
			self:UpdateTooltip ()
		end
		
		self.Icon:SetImage (icon)
	end
	
	return self
end

function PANEL:UpdateTooltip ()
	local textAreaWidth = self:GetTextAreaWidth ()
	
	surface.SetFont (self:GetFont ())
	local textWidth = surface.GetTextSize (self:GetText ())
	
	self:SetToolTipText (textWidth > textAreaWidth and self:GetText () or nil)
end

-- Hooks
function PANEL:HookComboBoxItem (comboBoxItem)
	if not comboBoxItem then return end
end

function PANEL:HookSelectedComboBoxItem (comboBoxItem)
	if not comboBoxItem then return end
	
	comboBoxItem:AddEventListener ("IconChanged", "CAC.ComboBox." .. self:GetHashCode (),
		function (_, icon)
			self:SetIcon (icon)
		end
	)
	
	comboBoxItem:AddEventListener ("TextChanged", "CAC.ComboBox." .. self:GetHashCode (),
		function (_, text)
			self:SetText (text)
		end
	)
end

function PANEL:UnhookComboBoxItem (comboBoxItem)
	if not comboBoxItem then return end
end

function PANEL:UnhookSelectedComboBoxItem (comboBoxItem)
	if not comboBoxItem then return end
	
	comboBoxItem:RemoveEventListener ("IconChanged", "CAC.ComboBox." .. self:GetHashCode ())
	comboBoxItem:RemoveEventListener ("TextChanged", "CAC.ComboBox." .. self:GetHashCode ())
end

CAC.Register ("GComboBox", PANEL, "GButton")