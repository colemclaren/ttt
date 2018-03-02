local self = {}

function self:Init ()
	-- Ugly hack
	self.Grip:Remove ()
	self.LeftButton:Remove ()
	self.RightButton:Remove ()
	
	self.Grip = self.ScrollBarGripFactory (self)
	self.Grip:SetScrollBar (self)
	
	self.LeftButton = self.ScrollBarButtonFactory (self)
	self.LeftButton:SetScrollBar (self)
	self.LeftButton:SetScrollIncrement (-self:GetSmallIncrement ())
	self.LeftButton:SetDirection ("Left")
	
	self.RightButton = self.ScrollBarButtonFactory (self)
	self.RightButton:SetScrollBar (self)
	self.RightButton:SetScrollIncrement (self:GetSmallIncrement ())
	self.RightButton:SetDirection ("Right")
	
	self.Grip:AddEventListener ("TargetPositionChanged",
		function (_, x, y)
			local scrollFraction = (x - self:GetThickness ()) / self:GetScrollableTrackSize ()
			if scrollFraction < 0 then scrollFraction = 0 end
			if scrollFraction > 1 then scrollFraction = 1 end
			local viewOffset = scrollFraction * (self.ContentSize - self.ViewSize)
			self:SetViewOffset (viewOffset)
		end
	)
	-- End of ugly hack
end

-- Factories
self.ScrollBarButtonClassName = "CACScrollBarButton"
self.ScrollBarGripClassName   = "CACScrollBarGrip"

function self:Paint (w, h)
end

CAC.Register ("CACHScrollBar", self, "GHScrollBar")