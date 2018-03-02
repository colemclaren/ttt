-- Generated from: gooey/lua/gooey/ui/controls/gverticallayout.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gverticallayout.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

function PANEL:Init ()
	-- Items
	self.Items = CAC.Containers.OrderedSet ()
	
	-- Item IDs
	self.ItemIds   = {}
	self.ItemsById = {}
	
	-- Item layout
	self.ItemSpacing = 0
	
	-- Layout
	self.VerticalItemLayoutValid = true
	
	-- Scrolling
	self.ItemView   = vgui.Create ("GContainer", self)
	self.ItemCanvas = vgui.Create ("GContainer", self.ItemView)
	
	self.VScroll = self.VScrollBarFactory (self)
	self.VScroll:SetZPos (20)
	self.VScroll:SetSmallIncrement (20)
	self.HScroll = self.HScrollBarFactory (self)
	self.HScroll:SetZPos (20)
	self.HScroll:SetSmallIncrement (20)
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
	
	self:AddEventListener ("SizeChanged",
		function (_, w, h)
			self.ScrollableViewController:SetViewSize (self:GetContentSizeWithoutScrollbars ())
			self.ScrollableViewController:SetViewSizeWithScrollBars (self:GetContentSizeWithScrollbars ())
		end
	)
	
	self:AddEventListener ("WidthChanged",
		function (_, w)
			self.ItemCanvas:SetWidth (self:GetContentWidth ())
		end
	)
	
	self.ItemCanvas:AddEventListener ("WidthChanged",
		function (_, w)
			self:InvalidateItemWidths ()
		end
	)
end

-- Factories
PANEL.VScrollBarClassName         = "GVScrollBar"
PANEL.HScrollBarClassName         = "GHScrollBar"
PANEL.ScrollBarCornerClassName    = "GScrollBarCorner"

function PANEL.VScrollBarFactory (self)
	return self:Create (self.VScrollBarClassName)
end

function PANEL.HScrollBarFactory (self)
	return self:Create (self.HScrollBarClassName)
end

function PANEL.ScrollBarCornerFactory (self)
	return self:Create (self.ScrollBarCornerClassName)
end

function PANEL:Paint (w, h)
end

function PANEL:PerformLayout (w, h)
	local x1, y1, x2, y2 = self:GetContentBounds ()
	self.ItemView:SetPos (x1, y1)
	self.ItemView:SetSize (x2 - x1, y2 - y1)
	
	self:LayoutScrollbars (w, h)
	
	if not self.VerticalItemLayoutValid then
		self:LayoutItems (w, h)
	end
	
	if not self.ItemWidthsValid then
		self:LayoutItemWidths (w, h)
	end
end

function PANEL:LayoutItems (w, h)
	if self.VerticalItemLayoutValid then return end
	
	self.VerticalItemLayoutValid = true
	
	-- Item positioning
	local y = 0
	for control in self:GetItemEnumerator () do
		control:SetPos (0, y)
		
		if control:IsVisible () then
			y = y + control:GetHeight () + self.ItemSpacing
		end
	end
	
	local contentHeight = y - self.ItemSpacing
	self.ScrollableViewController:SetContentHeight (contentHeight)
	self.ItemCanvas:SetHeight (contentHeight)
end

function PANEL:LayoutScrollbars (w, h)
	self.VScroll:SetPos (w - self.VScroll:GetWidth (), 0)
	self.VScroll:SetHeight (h - (self.HScroll:IsVisible () and self.HScroll:GetHeight () or 0))
	self.HScroll:SetPos (0, h - self.HScroll:GetHeight ())
	self.HScroll:SetWidth (w - (self.VScroll:IsVisible () and self.VScroll:GetWidth () or 0))
	self.ScrollBarCorner:SetPos (w - self.ScrollBarCorner:GetWidth (), h - self.ScrollBarCorner:GetHeight ())
	self.ScrollBarCorner:SetVisible (self.VScroll:IsVisible () and self.HScroll:IsVisible ())
end

function PANEL:LayoutItemWidths (w, h)
	if self.ItemWidthsValid then return end
	
	self.ItemWidthsValid = true
	
	local contentWidth = self:GetContentWidth ()
	for control in self:GetItemEnumerator () do
		control:SetWidth (contentWidth)
	end
end

-- Items
function PANEL:AddItem (control, id)
	if self.Items:Contains (control) then return end
	
	self.Items:Add (control)
	control:SetParent (self.ItemCanvas)
	
	if id then
		if self.ItemsById [id] then
			self.ItemIds [self.ItemsById [id]] = nil
			self.ItemsById [id] = nil
		end
		
		self.ItemsById [id] = control
		self.ItemIds [control] = id
	end
	
	self:HookControl (control)
	
	self:InvalidateVerticalItemLayout ()
	self:InvalidateItemWidths ()
end

function PANEL:Clear ()
	for control in self:GetItemEnumerator () do
		self:UnhookControl (control)
	end
	
	self.Items:Clear ()
	
	self.ItemIds   = {}
	self.ItemsById = {}
	
	self:InvalidateVerticalItemLayout ()
end

function PANEL:ContainsItem (control)
	return self.Items:Contains (control)
end

function PANEL:GetItem (index)
	return self.Items:Get (index)
end

function PANEL:GetItemById (id)
	return self.ItemsById [id]
end

function PANEL:GetItemCount ()
	return self.Items:GetCount ()
end

function PANEL:GetItemEnumerator ()
	return self.Items:GetEnumerator ()
end

function PANEL:IsEmpty ()
	return self.Items:IsEmpty ()
end

function PANEL:RemoveItem (control)
	if not self.Items:Contains (control) then return end
	
	self.Items:Remove (control)
	
	if self.ItemIds [control] then
		self.ItemsById [self.ItemIds [control]] = nil
		self.ItemIds [control] = nil
	end
	
	self:UnhookControl (control)
	
	self:InvalidateVerticalItemLayout ()
end

function PANEL:EnsureVisible (control)
	if not control then return end
	if self:IsItemVisible (control) then return end
	
	local left, top, right, bottom = self:GetContentBounds ()
	local y = control:GetY ()
	local h = control:GetHeight ()
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

--- Returns whether the specified Control will lie fully within the visible part of the VerticalLayout after the current animation has ended
-- @return A boolean indicating whether the specified Control will lie fully within the visible part of the VerticalLayout after the current animation has ended
function PANEL:IsItemVisible (control)
	if not control then return false end
	
	local y = control:GetY ()
	local h = control:GetHeight ()
	local viewY      = self.ScrollableViewController:GetViewY ()
	local viewHeight = self.ScrollableViewController:GetViewHeight ()
	return y >= viewY and y + h <= viewY + viewHeight
end

-- Item layout
function PANEL:GetItemSpacing ()
	return self.ItemSpacing
end

function PANEL:SetItemSpacing (itemSpacing)
	if self.ItemSpacing == itemSpacing then return self end
	
	self.ItemSpacing = itemSpacing
	
	self:InvalidateVerticalItemLayout ()
	
	self:DispatchEvent ("ItemSpacingChanged", self.ItemSpacing)
	
	return self
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
function PANEL:OnMouseWheel (delta)
	if self.VScroll:IsVisible () then
		self.VScroll:OnMouseWheeled (delta)
	else
		self.HScroll:OnMouseWheeled (delta)
	end
	return true
end

-- Internal, do not call
function PANEL:HookControl (control)
	if not control then return end
	
	control:AddEventListener ("HeightChanged", "CAC.VerticalLayout." .. self:GetHashCode (),
		function (_, _)
			self:InvalidateVerticalItemLayout ()
		end
	)
end

function PANEL:UnhookControl (control)
	if not control then return end
	
	control:RemoveEventListener ("HeightChanged", "CAC.VerticalLayout." .. self:GetHashCode ())
end

function PANEL:InvalidateItemWidths ()
	self.ItemWidthsValid = false
	self:InvalidateLayout ()
end

function PANEL:InvalidateVerticalItemLayout ()
	self.VerticalItemLayoutValid = false
	self:InvalidateLayout ()
end

CAC.Register ("GVerticalLayout", PANEL, "GPanel")