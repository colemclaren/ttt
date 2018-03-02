local self = {}

function self:Init ()
	-- Ugly hack
	self.Grip:Remove ()
	self.UpButton:Remove ()
	self.DownButton:Remove ()
	
	self.Grip = self.ScrollBarGripFactory (self)
	self.Grip:SetScrollBar (self)
	
	self.UpButton = self.ScrollBarButtonFactory (self)
	self.UpButton:SetScrollBar (self)
	self.UpButton:SetScrollIncrement (-self:GetSmallIncrement ())
	self.UpButton:SetDirection ("Up")
	
	self.DownButton = self.ScrollBarButtonFactory (self)
	self.DownButton:SetScrollBar (self)
	self.DownButton:SetScrollIncrement (self:GetSmallIncrement ())
	self.DownButton:SetDirection ("Down")
	
	self.Grip:AddEventListener ("TargetPositionChanged",
		function (_, x, y)
			local scrollFraction = (y - self:GetThickness ()) / self:GetScrollableTrackSize ()
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

CAC.Register ("CACVScrollBar", self, "GVScrollBar")