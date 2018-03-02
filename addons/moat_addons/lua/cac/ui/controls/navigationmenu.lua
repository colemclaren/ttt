local self = {}

--[[
	Events:
		SelectedItemChanged (NavigationMenuItem lastSelectedItem, NavigationMenuItem selectedItem)
			Fired when the selected item has changed.
]]
local backgroundColor = Color (  0,   0,   0,   0)

function self:Init ()
	self.Items        = {}
	self.ItemsById    = {}
	
	-- Selection
	self.SelectedItem = nil
	self.SelectionBackgroundYInterpolator = CAC.SigmoidStepResponseInterpolator ()
end

function self:Paint (w, h)
	if self:GetSelectedItem () then
		surface.SetDrawColor (CAC.Colors.CornflowerBlue)
		surface.DrawRect (0, self.SelectionBackgroundYInterpolator:Run (), w, self:GetSelectedItem ():GetHeight ())
	end
end

function self:PerformLayout (w, h)
	local y = 0
	for navigationMenuItem in self:GetEnumerator () do
		navigationMenuItem:SetPos (0, y)
		navigationMenuItem:SetWidth (w)
		y = y + navigationMenuItem:GetHeight () + 8
	end
	
	if self:GetSelectedItem () then
		self.SelectionBackgroundYInterpolator:SetTargetValue (self:GetSelectedItem ():GetY ())
	end
end

-- Items
function self:AddItem (id, text)
	text = text or id
	text = text or "Button"
	
	local item = self:Create ("CACNavigationMenuItem")
	item:SetNavigationMenu (self)
	item:SetId (id)
	item:SetText (text)
	
	self.Items [#self.Items + 1] = item
	if item:GetId () then
		self.ItemsById [item:GetId ()] = item
	end
	
	-- Selection
	if not self:GetSelectedItem () then
		self:SetSelectedItem (item)
	end
	
	return item
end

function self:GetEnumerator ()
	return CAC.ArrayEnumerator (self.Items)
end

function self:GetItemById (id)
	return self.ItemsById [id]
end

function self:IndexOf (navigationMenuItem)
	for k, v in ipairs (self.Items) do
		if v == navigationMenuItem then
			return k
		end
	end
	
	return nil
end

-- Selection
function self:GetSelectedItem ()
	return self.SelectedItem
end

function self:SetSelectedItem (selectedItem)
	if isstring (selectedItem) then selectedItem = self:GetItemById (selectedItem) end
	
	if self.SelectedItem == selectedItem then return self end
	
	local lastSelectedItem = self.SelectedItem
	self.SelectedItem = selectedItem
	
	if self:GetSelectedItem () then
		self.SelectionBackgroundYInterpolator:SetTargetValue (self:GetSelectedItem ():GetY ())
	end
	
	self:DispatchEvent ("SelectedItemChanged", lastSelectedItem, self.SelectedItem)
	
	return self
end

CAC.Register ("CACNavigationMenu", self, "CACPanel")