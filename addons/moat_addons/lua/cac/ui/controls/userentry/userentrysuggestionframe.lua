local self = {}

--[[
	Events:
		ItemChosen (ActorReference actorReference)
			Fired when the user has double clicked an item.
]]

function self:Init ()
	self.Control = nil
	
	self.ListBox = self:Create ("CACListBox", self)
	self.ListBox:SetKeyboardInputEnabled (false)
	self.ListBox:SetSelectionMode (CAC.SelectionMode.One)
	self.ListBox.ListBoxItemControlClassName = "CACUserEntrySuggestionListBoxItem"
	
	self.ListBox:AddEventListener ("Click",
		function (_, item)
			if not self:GetSelectedItem () then return end
			
			self:DispatchEvent ("ItemChosen", self:GetSelectedItem ())
		end
	)
	
	self.ListBox:AddEventListener ("SelectionChanged",
		function (_, listBoxItem)
			self:EnsureVisible (listBoxItem)
		end
	)
	
	self.ActorReferenceSet = {}
	
	self.LastShowTime = CurTime ()
	
	self:SetVisible (false)
	
	self:AddEventListener ("VisibleChanged",
		function (_, visible)
			if visible then
				self:MakePopup ()
				self:MoveToFront ()
				self:SetKeyboardInputEnabled (false)
				self.LastShowTime = CurTime ()
			end
		end
	)
end

local backgroundColor = Color (255, 255, 255, 128)
function self:Paint (w, h)
	surface.SetDrawColor (backgroundColor)
	surface.DrawRect (0, 0, w, h)
end

function self:PerformLayout (w, h)
	self.ListBox:SetPos (self:GetBorderThickness (), self:GetBorderThickness ())
	self.ListBox:SetSize (w - self:GetBorderThickness () * 2, h - self:GetBorderThickness () * 2)
	self.ListBox:InvalidateLayout ()
end

function self:OnMouseWheel (delta)
	return true
end

function self:GetControl ()
	return self.Control
end

function self:SetControl (control)
	self.Control = control
end

function self:GetBorderThickness ()
	return 4
end

-- Items
function self:AddActorReference (actorReference)
	if not actorReference then return end
	
	if self.ActorReferenceSet [actorReference:ToString ()] then return end
	
	self.ActorReferenceSet [actorReference:ToString ()] = true
	
	local listBoxItem = self.ListBox:AddItem (actorReference:ToString ())
	listBoxItem:GetControl ():SetActorReference (actorReference)
	listBoxItem:GetControl ():SetHighlightText (string.Trim (self:GetControl ():GetText ()))
	return listBoxItem
end

function self:Clear ()
	self.ActorReferenceSet = {}
	self.ListBox:Clear ()
end

function self:EnsureVisible (listBoxItem)
	self.ListBox:EnsureVisible (listBoxItem)
end

function self:GetItem (index)
	return self.ListBox:GetItem (1)
end

function self:GetItemCount ()
	return self.ListBox:GetItemCount ()
end

function self:GetSelectedItem ()
	local listBoxItem = self.ListBox:GetSelectedItem ()
	if not listBoxItem then return nil end
	return listBoxItem:GetControl ():GetActorReference ()
end

function self:IsEmpty ()
	return self.ListBox:IsEmpty ()
end

function self:Sort ()
	self.ListBox:Sort (
		function (a, b)
			return a:GetText ():lower () < b:GetText ():lower ()
		end
	)
end

-- Selection
function self:SelectByIndex (index)
	local listBoxItem = self.ListBox:GetItem (index)
	if not listBoxItem then return end
	listBoxItem:Select ()
end

function self:SelectActorReference (actorReference)
	local listBoxItem = self.ListBox:GetItem (actorReference:ToString ())
	if not listBoxItem then return end
	listBoxItem:Select ()
end

function self:SelectItem (listBoxItem)
	if not listBoxItem then return end
	self.ListBox:SetSelectedItem (listBoxItem)
end

function self:SelectPrevious ()
	local selectedItem = self.ListBox:GetSelectedItem ()
	local selectedSortedIndex = 0
	if selectedItem then
		selectedSortedIndex = selectedItem:GetSortedIndex () - 1
	end
	if selectedSortedIndex < 1 then
		selectedSortedIndex = self.ListBox:GetItemCount ()
	end
	self.ListBox:SetSelectedItem (self.ListBox:GetItemBySortedIndex (selectedSortedIndex))
end

function self:SelectNext ()
	local selectedItem = self.ListBox:GetSelectedItem ()
	local selectedSortedIndex = 1
	if selectedItem then
		selectedSortedIndex = selectedItem:GetSortedIndex () + 1
	end
	if selectedSortedIndex > self.ListBox:GetItemCount () then
		selectedSortedIndex = 1
	end
	self.ListBox:SetSelectedItem (self.ListBox:GetItemBySortedIndex (selectedSortedIndex))
end

function self:SetSelectedItem (listBoxItem)
	self.ListBox:SetSelectedItem (listBoxItem)
end

-- Visibility
function self:ShouldHide (lastShowTime)
	local x, y = self:CursorPos ()
	local containsMouse = x >= 0 and x < self:GetWidth () and
	                      y >= 0 and y < self:GetHeight ()
	
	if self.Control:IsVisible () and
	   not self.Control:IsFocused () and
	   not self.Control:HasHierarchicalFocus () and
	   not self:IsFocused () and
	   not self:HasHierarchicalFocus () and
	   not containsMouse and
	   CurTime () > lastShowTime then
		
		return true
	end
	
	return false
end

function self:Think ()
	if not self.Control then return end
	
	if self:ShouldHide (self.LastShowTime) then
		self:SetVisible (false)
	else
		self:MoveToFront ()
		
		-- Massive hack to fix text entry losing focus when anything in this frame is clicked
		if self.Control and
		   self.Control:IsValid () then
			local x, y = self:CursorPos ()
			local containsMouse = x >= 0 and x < self:GetWidth () and
			                      y >= 0 and y < self:GetHeight ()
			if containsMouse then
				self.Control:Focus ()
			end
		end
	end
end

CAC.Register ("CACUserEntrySuggestionFrame", self, "EditablePanel")