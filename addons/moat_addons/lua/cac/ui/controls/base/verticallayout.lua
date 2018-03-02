local self = {}

function self:Init ()
	-- Ugly hack
	self.VScroll:Remove ()
	self.HScroll:Remove ()
	self.ScrollBarCorner:Remove ()
	
	self.VScroll = self.VScrollBarFactory (self)
	self.VScroll:SetZPos (20)
	self.HScroll = self.HScrollBarFactory (self)
	self.HScroll:SetZPos (20)
	self.ScrollBarCorner = self.ScrollBarCornerFactory (self)
	
	self.ScrollableViewController:SetHorizontalScrollBar (self.HScroll)
	self.ScrollableViewController:SetVerticalScrollBar (self.VScroll)
	self.ScrollableViewController:SetScrollBarCorner (self.ScrollBarCorner)
	
	self.HScroll:SetSmallIncrement (20)
	self.VScroll:SetSmallIncrement (20)
	-- End of ugly hack
	
	self:SetItemSpacing (4)
end

-- Factories
self.VScrollBarClassName         = "CACVScrollBar"
self.HScrollBarClassName         = "CACHScrollBar"
self.ScrollBarCornerClassName    = "CACScrollBarCorner"

-- Layout
function self:GetContentBoundsWithoutScrollbars ()
	return 0, 0, self:GetWidth (), self:GetHeight ()
end

function self:GetContentBoundsWithScrollbars ()
	local scrollBarWidth  = 0
	local scrollBarHeight = 0
	if self.VScroll then
		scrollBarWidth  = self.VScroll:GetWidth  () + 4
	end
	if self.HScroll then
		scrollBarHeight = self.HScroll:GetHeight () + 4
	end
	return 0, 0, self:GetWidth () - scrollBarWidth, self:GetHeight () - scrollBarHeight
end

CAC.Register ("CACVerticalLayout", self, "GVerticalLayout")