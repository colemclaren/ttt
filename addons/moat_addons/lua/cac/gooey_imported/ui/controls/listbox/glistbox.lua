-- Generated from: gooey/lua/gooey/ui/controls/listbox/glistbox.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/listbox/glistbox.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

--[[
	Events:
		Click (ListBoxItem item)
			Fired when an item has been clicked.
		DoubleClick (ListBoxItem item)
			Fired when an item has been double clicked.
		FilterChanged (f)
			Fired when the filter has changed.
		ItemHeightChanged (itemHeight)
			Fired when the item height has changed.
		ItemSpacingChanged (itemSpacing)
			Fired when the spacing between ListBoxItems has changed.
		RightClick (ListBoxItem item)
			Fired when an item has been right clicked.
		SelectionChanged (ListBoxItem item)
			Fired when the selected item has changed.
		SelectionCleared ()
			Fired when the selection has been cleared.
]]

function PANEL:Init ()
	self.LastClickTime = 0

	self.Menu = nil
	
	-- Items
	self.Items = CAC.ListBox.ItemCollection (self)
	self.ItemControls = {}
	
	-- Item filtering
	self.FilterFunction = nil
	
	-- Item layout
	self.ItemHeight  = 0
	self.ItemSpacing = 0
	
	self.Items:AddEventListener ("ItemAdded",
		function (_, listBoxItem)
			self:HookListBoxItem (listBoxItem)
			
			local listBoxItemControl = self.ListBoxItemControlFactory (self)
			listBoxItemControl:SetParent (self.ItemCanvas)
			listBoxItemControl:SetListBox (self)
			listBoxItemControl:SetListBoxItem (listBoxItem)
			listBoxItemControl:SetWidth (self:GetContentWidth ())
			
			listBoxItem:SetControl (listBoxItemControl)
			
			self.ItemControls [listBoxItem] = listBoxItemControl
			
			self:InvalidateVerticalItemLayout ()
		end
	)
	
	self.Items:AddEventListener ("ItemRemoved",
		function (_, listBoxItem)
			self:UnhookListBoxItem (listBoxItem)
			
			self.ItemControls [listBoxItem]:Remove ()
			self.ItemControls [listBoxItem] = nil
			
			self.SelectionController:RemoveFromSelection (listBoxItem)
			
			self:InvalidateVerticalItemLayout ()
		end
	)
	
	-- Keyboard
	self.FocusedItem = nil
	
	-- Selection
	self.SelectionController = CAC.SelectionController (self)
	
	self.SelectionController:AddEventListener ("SelectionChanged",
		function (_, listBoxItem)
			self:DispatchEvent ("SelectionChanged", listBoxItem)
		end
	)
	
	self.SelectionController:AddEventListener ("SelectionCleared",
		function (_, listBoxItem)
			self:DispatchEvent ("SelectionCleared", listBoxItem)
		end
	)
	
	-- Layout
	self.ItemWidthsValid         = true
	self.VerticalItemLayoutValid = true
	
	-- Scrolling
	self.ItemView   = vgui.Create ("GContainer", self)
	self.ItemCanvas = vgui.Create ("GContainer", self.ItemView)
	
	self.VScroll = self.VScrollBarFactory (self)
	self.VScroll:SetZPos (20)
	self.HScroll = self.HScrollBarFactory (self)
	self.HScroll:SetZPos (20)
	self.ScrollBarCorner = self.ScrollBarCornerFactory (self)
	self.ScrollableViewController = CAC.ScrollableViewController ()
	self.ScrollableViewController:SetHorizontalScrollBar (self.HScroll)
	self.ScrollableViewController:SetVerticalScrollBar (self.VScroll)
	self.ScrollableViewController:SetScrollBarCorner (self.ScrollBarCorner)
	self.ScrollableViewController:SetViewSize (self:GetSize ())
	
	self.ScrollableViewController:AddEventListener ("InterpolatedViewPositionChanged",
		function (_, viewX, viewY)
			self.ItemCanvas:SetPos (-viewX, -viewY)
		end
	)
	
	self.ScrollableViewController:AddEventListener ("InterpolatedViewXChanged",
		function (_, interpolatedViewX)
		end
	)
	
	self.ScrollableViewController:AddEventListener ("InterpolatedViewYChanged",
		function (_, interpolatedViewY)
		end
	)
	
	-- Sorting
	self.Comparator = nil
	
	self.SortOrder = CAC.SortOrder.None
	
	self:AddEventListener ("EnabledChanged",
		function (_, enabled)
			for listBoxItem in self:GetItemEnumerator () do
				listBoxItem:SetEnabled (enabled)
			end
		end
	)
	
	self:AddEventListener ("ItemHeightChanged",
		function (_, itemHeight)
			if itemHeight then
				self.HScroll:SetSmallIncrement (itemHeight)
				self.VScroll:SetSmallIncrement (itemHeight)
			end
		end
	)
	
	self:AddEventListener ("SizeChanged",
		function (_, w, h)
			self.ScrollableViewController:SetViewSize (self:GetContentSizeWithoutScrollbars ())
			self.ScrollableViewController:SetViewSizeWithScrollBars (self:GetContentSizeWithScrollbars ())
		end
	)
	
	self:AddEventListener ("SizeChanged",
		function (_, w)
			-- Need to update when height changes too, since vertical scrollbar visibility can change,
			-- affecting view width
			self.ItemCanvas:SetWidth (self:GetContentWidth ())
		end
	)
	
	self.ItemCanvas:AddEventListener ("WidthChanged",
		function (_, w)
			self:InvalidateItemWidths ()
		end
	)
	
	self:SetItemHeight (20)
	self:SetKeyboardMap (CAC.ListBox.KeyboardMap)
	self:SetCanFocus (true)
end

-- Factories
PANEL.VScrollBarClassName         = "GVScrollBar"
PANEL.HScrollBarClassName         = "GHScrollBar"
PANEL.ScrollBarCornerClassName    = "GScrollBarCorner"
PANEL.ListBoxItemControlClassName = "GListBoxItem"

function PANEL.VScrollBarFactory (self)
	return self:Create (self.VScrollBarClassName)
end

function PANEL.HScrollBarFactory (self)
	return self:Create (self.HScrollBarClassName)
end

function PANEL.ScrollBarCornerFactory (self)
	return self:Create (self.ScrollBarCornerClassName)
end

function PANEL.ListBoxItemControlFactory (self)
	return self:Create (self.ListBoxItemControlClassName)
end

function PANEL.ListBoxItemFactory (self, ...)
	return CAC.ListBox.ListBoxItem (self, ...)
end

function PANEL:Paint (w, h)
	return derma.SkinHook ("Paint", "ListBox", self, w, h)
end

function PANEL:PaintOver ()
	self.SelectionController:PaintOver (self)
end

function PANEL:PerformLayout (w, h)
	self:LayoutScrollbars (w, h)
	
	if not self.VerticalItemLayoutValid then
		self:LayoutItems (w, h)
	end
	
	if not self.ItemWidthsValid then
		self:LayoutItemWidths (w, h)
	end
	
	-- Do this last, since item layout can change the content height
	-- which can change scrollbar visibility,
	-- which changes view size
	local x1, y1, x2, y2 = self:GetContentBounds ()
	self.ItemView:SetPos (x1, y1)
	self.ItemView:SetSize (x2 - x1, y2 - y1)
end

function PANEL:LayoutScrollbars (w, h)
	self.VScroll:SetPos (w - self.VScroll:GetWidth (), 0)
	self.VScroll:SetHeight (h - (self.HScroll:IsVisible () and self.HScroll:GetHeight () or 0))
	self.HScroll:SetPos (0, h - self.HScroll:GetHeight ())
	self.HScroll:SetWidth (w - (self.VScroll:IsVisible () and self.VScroll:GetWidth () or 0))
	self.ScrollBarCorner:SetPos (w - self.ScrollBarCorner:GetWidth (), h - self.ScrollBarCorner:GetHeight ())
	self.ScrollBarCorner:SetVisible (self.VScroll:IsVisible () and self.HScroll:IsVisible ())
end

function PANEL:LayoutItems (w, h)
	if self.VerticalItemLayoutValid then return end
	
	self.VerticalItemLayoutValid = true
	
	-- Apply filtering
	local filterFunction = self.FilterFunction or function () return true end
	for listBoxItem in self:GetItemEnumerator () do
		local listBoxItemControl = self.ItemControls [listBoxItem]
		listBoxItemControl:SetVisible (listBoxItem:IsVisible () and filterFunction (listBoxItem))
	end
	
	-- Item positioning
	local y = 0
	for listBoxItem in self:GetItemEnumerator () do
		local listBoxItemControl = self.ItemControls [listBoxItem]
		listBoxItemControl:SetPos (0, y)
		if self:GetItemHeight () then
			listBoxItemControl:SetHeight (self:GetItemHeight ())
		end
		
		if listBoxItemControl:IsVisible () then
			y = y + listBoxItemControl:GetHeight () + self.ItemSpacing
		end
	end
	
	local contentHeight = y - self.ItemSpacing
	self.ScrollableViewController:SetContentHeight (contentHeight)
	self.ItemCanvas:SetHeight (contentHeight)
end

function PANEL:LayoutItemWidths (w, h)
	if self.ItemWidthsValid then return end
	
	self.ItemWidthsValid = true
	
	local contentWidth = self:GetContentWidth ()
	for listBoxItem in self:GetItemEnumerator () do
		local listBoxItemControl = self.ItemControls [listBoxItem]
		listBoxItemControl:SetWidth (contentWidth)
	end
end

-- Control
function PANEL:GetMenu ()
	return self.Menu
end

function PANEL:SetMenu (menu)
	if self.Menu == menu then return self end
	
	self.Menu = menu
	return self
end

-- Items
function PANEL:AddItem (...)
	return self.Items:AddItem (...)
end

function PANEL:Clear ()
	self.Items:Clear ()
end

function PANEL:EnsureVisible (listBoxItem)
	if not listBoxItem then return end
	if self:IsItemVisible (listBoxItem) then return end
	
	local listBoxItemControl = self.ItemControls [listBoxItem]
	if not listBoxItemControl then return false end
	
	local left, top, right, bottom = self:GetContentBounds ()
	local y = listBoxItemControl:GetY ()
	local h = listBoxItemControl:GetHeight ()
	local viewY      = self.ScrollableViewController:GetViewY ()
	local viewHeight = self.ScrollableViewController:GetViewHeight ()
	if y < self.ScrollableViewController:GetViewY () then
		-- Scroll up
		self.ScrollableViewController:SetViewY (y)
	elseif y + h > viewY + viewHeight then
		-- Scroll down
		self.ScrollableViewController:SetViewY (y + h - viewHeight)
	end
end

function PANEL:FindItem (text)
	for listBoxItem in self:GetItemEnumerator () do
		if listBoxItem:GetText () == text then
			return listBoxItem
		end
	end
	return nil
end

-- Returns the ListBoxItem at the sorted index
function PANEL:GetItem (index)
	return self.Items:GetItem (index)
end

function PANEL:GetItemById (id)
	return self.Items:GetItemById (id)
end

function PANEL:GetItemBySortedIndex (sortedIndex)
	return self.Items:GetItemBySortedIndex (sortedIndex)
end

function PANEL:GetItemCount ()
	return self.Items:GetItemCount ()
end

function PANEL:GetItemEnumerator ()
	return self.Items:GetEnumerator ()
end

function PANEL:GetItems ()
	return self.Items
end

function PANEL:IsEmpty ()
	return self.Items:IsEmpty ()
end

function PANEL:RemoveItem (listBoxItem)
	return self.Items:RemoveItem (listBoxItem)
end

-- Item filtering
function PANEL:GetFilter ()
	return self.FilterFunction
end

function PANEL:SetFilter (filterFunction)
	if self.FilterFunction == filterFunction then return self end
	
	self.FilterFunction = filterFunction
	
	self:InvalidateVerticalItemLayout ()
	self:DispatchEvent ("FilterChanged", self.FilterFunction)
	
	return self
end

-- Item layout
function PANEL:GetItemHeight ()
	return self.ItemHeight
end

function PANEL:GetItemSpacing ()
	return self.ItemSpacing
end

function PANEL:SetItemHeight (itemHeight)
	if self.ItemHeight == itemHeight then return self end
	
	self.ItemHeight = itemHeight
	
	if self.ItemHeight ~= nil then
		for listBoxItem in self:GetItemEnumerator () do
			listBoxItem:SetHeight (self.ItemHeight)
		end
	end
	
	self:InvalidateVerticalItemLayout ()
	
	self:DispatchEvent ("ItemHeightChanged", self.ItemHeight)
	
	return self
end

function PANEL:SetItemSpacing (itemSpacing)
	if self.ItemSpacing == itemSpacing then return self end
	
	self.ItemSpacing = itemSpacing
	
	self:InvalidateVerticalItemLayout ()
	
	self:DispatchEvent ("ItemSpacingChanged", self.ItemSpacing)
	
	return self
end

--- Returns whether the specified ListBoxItem will lie fully within the visible part of the ListBox after the current animation has ended
-- @return A boolean indicating whether the specified ListBoxItem will lie fully within the visible part of the ListBox after the current animation has ended
function PANEL:IsItemVisible (listBoxItem)
	if not listBoxItem then return false end
	
	local listBoxItemControl = self.ItemControls [listBoxItem]
	if not listBoxItemControl then return false end
	
	local y = listBoxItemControl:GetY ()
	local h = listBoxItemControl:GetHeight ()
	local viewY      = self.ScrollableViewController:GetViewY ()
	local viewHeight = self.ScrollableViewController:GetViewHeight ()
	return y >= viewY and y + h <= viewY + viewHeight
end

-- Spatial queries
function PANEL:ItemFromPoint (x, y)
	local left, top, right, bottom = self:GetContentBounds ()
	if x < left    then return nil end
	if x >= right  then return nil end
	if y < top     then return nil end
	if y >= bottom then return nil end
	
	-- Convert to content coordinates
	local dx, dy = self.ItemView:GetPos ()
	x, y = x - dx, y - dy
	dx, dy = self.ItemCanvas:GetPos ()
	x, y = x - dx, y - dy
	
	local success, index, listBoxItem = self.Items:BinarySearch (
		function (listBoxItem)
			local listBoxItemControl = listBoxItem:GetControl ()
			
			local listBoxItemY = listBoxItemControl:GetY ()
			if y < listBoxItemY then return -1 end
			if y >= listBoxItemY + listBoxItemControl:GetHeight () then return 1 end
			return listBoxItemControl:IsVisible () and 0 or 1
		end
	)
	
	if not success then return nil end
	
	return listBoxItem
end

function PANEL:ItemsIntersectingAABB (x1, y1, x2, y2, out)
	-- Convert to content coordinates
	local dx, dy = self.ItemView:GetPos ()
	x1, y1 = x1 - dx, y1 - dy
	x2, y2 = x2 - dx, y2 - dy
	dx, dy = self.ItemCanvas:GetPos ()
	x1, y1 = x1 - dx, y1 - dy
	x2, y2 = x2 - dx, y2 - dy
	
	return self:ItemsIntersectingContentAABB (x1, y1, x2, y2, out)
end

function PANEL:ItemsIntersectingContentAABB (x1, y1, x2, y2, out)
	out = out or {}
	
	local firstItemSuccess, firstItemIndex, listBoxItem = self.Items:BinarySearch (
		function (listBoxItem)
			local listBoxItemControl = listBoxItem:GetControl ()
			
			local listBoxItemY = listBoxItemControl:GetY ()
			if y1 <  listBoxItemY then return -1 end
			if y1 >= listBoxItemY + listBoxItemControl:GetHeight () then return 1 end
			return listBoxItemControl:IsVisible () and 0 or 1
		end
	)
	local lastItemSuccess, lastItemIndex, listBoxItem = self.Items:BinarySearch (
		function (listBoxItem)
			local listBoxItemControl = listBoxItem:GetControl ()
			
			local listBoxItemY = listBoxItemControl:GetY ()
			if y2 <= listBoxItemY then return -1 end
			if y2 >= listBoxItemY + listBoxItemControl:GetHeight () then return 1 end
			return listBoxItemControl:IsVisible () and 0 or 1
		end
	)
	
	if not firstItemSuccess then
		firstItemIndex = firstItemIndex + 1
	end
	
	for i = firstItemIndex, lastItemIndex do
		local listBoxItem = self.Items:GetItem (i)
		local listBoxItemControl = listBoxItem:GetControl ()
		if listBoxItemControl:IsVisible () then
			out [#out + 1] = listBoxItem
		end
	end
	
	return out
end

-- Keyboard
function PANEL:GetFocusedItem ()
	return self.FocusedItem
end

function PANEL:SetFocusedItem (listBoxItem)
	self.FocusedItem = listBoxItem
	return self
end

-- Selection
function PANEL:ClearSelection ()
	self.SelectionController:ClearSelection ()
end

function PANEL:GetSelectedItems ()
	return self.SelectionController:GetSelectedItems ()
end

function PANEL:GetSelectedItem ()
	return self.SelectionController:GetSelectedItem ()
end

function PANEL:GetSelectionEnumerator ()
	return self.SelectionController:GetSelectionEnumerator ()
end

function PANEL:GetSelectionMode ()
	return self.SelectionController:GetSelectionMode ()
end

function PANEL:SetSelectedItem (listBoxItem)
	self.SelectionController:ClearSelection ()
	self.SelectionController:AddToSelection (listBoxItem)
end

function PANEL:SetSelectionMode (selectionMode)
	self.SelectionController:SetSelectionMode (selectionMode)
end

-- Layout
function PANEL:GetContentBounds ()
	local x1,  y1,  x2,  y2  = self:GetContentBoundsWithoutScrollbars ()
	local sx1, sy1, sx2, sy2 = self:GetContentBoundsWithScrollbars ()
	
	if self.VScroll and self.VScroll:IsVisible () then
		x1, x2 = sx1, sx2
	end
	if self.HScroll and self.HScroll:IsVisible () then
		y1, y2 = sy1, sy2
	end
	
	return x1, y1, x2, y2
end

function PANEL:GetContentWidth ()
	local x1, y1, x2, y2
	if self.VScroll and self.VScroll:IsVisible () then
		x1, y1, x2, y2 = self:GetContentBoundsWithScrollbars ()
	else
		x1, y1, x2, y2 = self:GetContentBoundsWithoutScrollbars ()
	end
	return x2 - x1
end

function PANEL:GetContentSizeWithoutScrollbars ()
	local x1, y1, x2, y2 = self:GetContentBoundsWithoutScrollbars ()
	return x2 - x1, y2 - y1
end

function PANEL:GetContentSizeWithScrollbars ()
	local x1, y1, x2, y2 = self:GetContentBoundsWithScrollbars ()
	return x2 - x1, y2 - y1
end

function PANEL:GetContentBoundsWithoutScrollbars ()
	return 1, 1, self:GetWidth () - 1, self:GetHeight () - 1
end

function PANEL:GetContentBoundsWithScrollbars ()
	local scrollBarWidth  = 1
	local scrollBarHeight = 1
	if self.VScroll then
		scrollBarWidth  = self.VScroll:GetWidth ()
	end
	if self.HScroll then
		scrollBarHeight = self.HScroll:GetHeight ()
	end
	return 1, 1, self:GetWidth () - scrollBarWidth, self:GetHeight () - scrollBarHeight
end

-- Sorting
function PANEL.DefaultComparator (a, b)
	return a:GetText () < b:GetText ()
end

function PANEL:GetComparator ()
	return self.Comparator or self.DefaultComparator
end

function PANEL:GetSortOrder ()
	return self.SortOrder
end

function PANEL:SetComparator (comparator)
	self.Comparator = comparator
end

function PANEL:Sort (comparator)
	self.Items:Sort (comparator or self:GetComparator ())
	self.SortOrder = CAC.SortOrder.Ascending
	
	self:InvalidateVerticalItemLayout ()
end

-- Event handlers
function PANEL:DoClick ()
	if SysTime () - self.LastClickTime < 0.3 then
		self:DoDoubleClick ()
		self.LastClickTime = 0
	else
		local listBoxItem = self:ItemFromPoint (self:CursorPos ())
		self:DispatchEvent ("Click", listBoxItem)
		
		if listBoxItem then
			listBoxItem:DispatchEvent ("Click")
		end
		
		self.LastClickTime = SysTime ()
	end
end

function PANEL:DoDoubleClick ()
	local listBoxItem = self:ItemFromPoint (self:CursorPos ())
	self:DispatchEvent ("DoubleClick", listBoxItem)
	
	if listBoxItem then
		listBoxItem:DispatchEvent ("DoubleClick")
	end
end

function PANEL:DoRightClick ()
	self:DispatchEvent ("RightClick", self:ItemFromPoint (self:CursorPos ()))
end

function PANEL:OnCursorMoved (x, y)
	self:DispatchEvent ("MouseMove", 0, x, y)
end

function PANEL:OnMousePressed (mouseCode)
	self:DispatchEvent ("MouseDown", mouseCode, self:CursorPos ())
	if self.OnMouseDown then self:OnMouseDown (mouseCode, self:CursorPos ()) end
	
	if self:CanFocus () and
	   not self:IsFocused () and
	   not vgui.FocusedHasParent (self) then
		self:Focus ()
	end
end

function PANEL:OnMouseReleased (mouseCode)
	self:DispatchEvent ("MouseUp", mouseCode, self:CursorPos ())
	if mouseCode == MOUSE_LEFT then
		self:DoClick ()
	elseif mouseCode == MOUSE_RIGHT then
		self:DoRightClick ()
		if self:GetSelectionMode () == CAC.SelectionMode.Multiple then
			if self.Menu then
				self.Menu:Show (self, self:GetSelectedItems ())
			end
		else
			if self.Menu then
				self.Menu:Show (self, self:GetSelectedItem ())
			end
		end
	end
end

function PANEL:OnMouseWheel (delta)
	if self.VScroll:IsVisible () then
		self.VScroll:OnMouseWheeled (delta)
		return true
	elseif self.HScroll:IsVisible () then
		self.HScroll:OnMouseWheeled (delta)
		return true
	end
end

function PANEL:OnRemoved ()
	if self.Menu then self.Menu:dtor () end
	if self.HeaderMenu then self.HeaderMenu:dtor () end
end

-- Internal, do not call
function PANEL:InvalidateItemWidths ()
	self.ItemWidthsValid = false
	self:InvalidateLayout ()
end

function PANEL:InvalidateVerticalItemLayout ()
	self.VerticalItemLayoutValid = false
	self:InvalidateLayout ()
end

function PANEL:HookListBoxItem (listBoxItem)
	if not listBoxItem then return end
	
	listBoxItem:AddEventListener ("HeightChanged", "CAC.ListBox." .. self:GetHashCode (),
		function (_)
			self:InvalidateVerticalItemLayout ()
		end
	)
	listBoxItem:AddEventListener ("VisibleChanged", "CAC.ListBox." .. self:GetHashCode (),
		function (_)
			self:InvalidateVerticalItemLayout ()
		end
	)
end

function PANEL:UnhookListBoxItem (listBoxItem)
	if not listBoxItem then return end
	
	listBoxItem:RemoveEventListener ("HeightChanged",  "CAC.ListBox." .. self:GetHashCode ())
	listBoxItem:RemoveEventListener ("VisibleChanged", "CAC.ListBox." .. self:GetHashCode ())
end

CAC.Register ("GListBox", PANEL, "GPanel")