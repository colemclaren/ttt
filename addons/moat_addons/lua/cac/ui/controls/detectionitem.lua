local self = {}

function self:Init ()
	self.Detection = nil
	
	self:SetFont (CAC.Font ("Roboto", 13))
	self:SetHeight (12)
	
	self:AddEventListener ("MouseDown",
		function (_, mouseCode, x, y)
			self:GetParent ():OnMousePressed (mouseCode)
			
			self:SetToolTipText (nil)
		end
	)
	
	self:AddEventListener ("MouseEnter",
		function (_)
			self:SetToolTipText (self.Detection and self.Detection.GetReasonString and self.Detection:GetReasonString () or nil)
		end
	)
	
	self:AddEventListener ("MouseUp",
		function (_, mouseCode, x, y)
			self:GetParent ():OnMouseReleased (mouseCode)
			
			self:SetToolTipText (self.Detection and self.Detection.GetReasonString and self.Detection:GetReasonString () or nil)
		end
	)
end

function self:GetTextSize ()
	surface.SetFont (self:GetFont ())
	return surface.GetTextSize (self.Detection:GetInformation ():GetName ())
end

function self:Think ()
end

function self:Paint (w, h)
	if not self.Detection then return end
	
	surface.SetFont (self:GetFont ())
	surface.SetTextColor (CAC.Colors.Firebrick)
	
	surface.SetTextPos (0, 0)
	surface.DrawText (self.Detection:GetInformation ():GetName ())
end

function self:GetDetection ()
	return self.Detection
end

function self:SetDetection (detection)
	if self.Detection == detection then return self end
	
	self:UnhookDetection (self.Detection)
	self:SetToolTipText (nil)
	
	self.Detection = detection
	
	if self.Detection then
		self:HookDetection (self.Detection)
		self:SetToolTipText (self.Detection.GetReasonString and self.Detection:GetReasonString () or nil)
	end
	
	return self
end

-- Internal, do not call
function self:OnRemoved ()
	self:SetDetection (nil)
end

function self:HookDetection (detection)
	if not detection then return end
	
	detection:AddEventListener ("Changed", "CAC.DetectionItem." .. self:GetHashCode (),
		function (_)
			self:SetToolTipText (detection.GetReasonString and detection:GetReasonString () or nil)
		end
	)
end

function self:UnhookDetection (detection)
	if not detection then return end
	
	detection:RemoveEventListener ("Changed", "CAC.DetectionItem." .. self:GetHashCode ())
end

CAC.Register ("CACDetectionItem", self, "CACPanel")