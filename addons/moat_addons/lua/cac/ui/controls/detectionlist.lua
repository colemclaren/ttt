local self = {}

function self:Init ()
	self.PlayerSession               = nil
	
	self.CopyButton                  = nil
	self.CopyButtonNotificationLabel = nil
	
	self.Detections                  = {}
	self.DetectionsByType            = {}
	
	-- Bubble mouse events up
	self:AddEventListener ("MouseDown",
		function (_, mouseCode, x, y)
			self:GetParent ():OnMousePressed (mouseCode)
		end
	)
	
	self:AddEventListener ("MouseUp",
		function (_, mouseCode, x, y)
			self:GetParent ():OnMouseReleased (mouseCode)
		end
	)
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	-- Detections
	local x = 0
	local y = 0
	
	local maximumTextWidth = 0
	for i = 1, #self.Detections do
		self.Detections [i]:SetPos (x, y)
		
		local textWidth = self.Detections [i]:GetTextSize ()
		maximumTextWidth = math.max (maximumTextWidth, textWidth)
		
		y = y + self.Detections [i]:GetHeight ()
	end
	
	for i = 1, #self.Detections do
		self.Detections [i]:SetWidth (maximumTextWidth)
	end
	
	-- Copy button
	local detectionHeight = math.min (y, h)
	if self.CopyButton then
		self.CopyButton:SetVisible (#self.Detections > 0)
		
		self.CopyButton:SetPos (math.min (maximumTextWidth + 4, w - self.CopyButton:GetWidth ()), math.max (0, 0.5 * (detectionHeight - self.CopyButton:GetHeight ())))
		
		self.CopyButtonNotificationLabel:SizeToContents ()
		self.CopyButtonNotificationLabel:SetPos (self.CopyButton:GetX () + self.CopyButton:GetWidth () + 4, self.CopyButton:GetY () + 0.5 * (self.CopyButton:GetHeight () - self.CopyButtonNotificationLabel:GetHeight ()))
	end
end

function self:GetPlayerSession ()
	return self.PlayerSession
end

function self:SetPlayerSession (playerSession)
	if self.PlayerSession == playerSession then return self end
	
	self:UnhookPlayerSession (self.PlayerSession)
	self:ClearDetectionItems ()
	
	self.PlayerSession = playerSession
	
	if self.PlayerSession then
		self:HookPlayerSession (self.PlayerSession)
		for detection in self.PlayerSession:GetDetectionEnumerator () do
			self:CreateDetectionItem (detection)
		end
	end
	
	return self
end

-- Internal, do not call
function self:OnRemoved ()
	self:SetPlayerSession (nil)
end

function self:CreateCopyButton ()
	if self.CopyButton then return self.CopyButton end
	
	self.CopyButton = self:Create ("CACCopyButton")
	self.CopyButton:AddEventListener ("GetText",
		function (_)
			return self:GetPlayerSession ():GetDetectionListText ()
		end
	)
	self.CopyButton:SetToolTipText ("Copy detections")
	
	self.CopyButtonNotificationLabel = self:Create ("GLabel")
	self.CopyButtonNotificationLabel:SetFont (CAC.Font ("Roboto", 16))
	self.CopyButtonNotificationLabel:SetText ("Copied to clipboard!")
	self.CopyButtonNotificationLabel:SetTextColor (CAC.Colors.Firebrick)
	
	self.CopyButton:SetNotificationControl (self.CopyButtonNotificationLabel)
	
	return self.CopyButton
end

function self:ClearDetectionItems ()
	if #self.Detections == 0 then return end
	
	for i = 1, #self.Detections do
		self.Detections [i]:Remove ()
	end
	
	self.Detections     = {}
	self.DetectionsById = {}
end

function self:CreateDetectionItem (detection)
	self:CreateCopyButton ()
	
	local detectionType = detection:GetDetectionType ()
	if self.DetectionsByType [detectionType] then
		return self.DetectionsByType [detectionType]
	end
	
	local detectionItem = self:Create ("CACDetectionItem")
	detectionItem:SetDetection (detection)
	
	self.Detections [#self.Detections + 1] = detectionItem
	self.DetectionsByType [detectionType] = detectionItem
	
	self:InvalidateLayout ()
	
	return detectionItem
end

function self:DestroyDetectionItem (detection)
	local detectionType = detection:GetDetectionType ()
	if not self.DetectionsByType [detectionType] then return end
	
	local detectionItem = self.DetectionsByType [detectionType]
	detectionItem:Remove ()
	
	self.DetectionsByType [detectionType] = nil
	
	for i = 1, #self.Detections do
		if self.Detections [i] == detectionItem then
			table.remove (self.Detections, i)
			break
		end
	end
	
	self:InvalidateLayout ()
	
	return detectionItem
end

function self:HookPlayerSession (playerSession)
	if not playerSession then return end
	
	playerSession:AddEventListener ("DetectionAdded", "CAC.PlayerListBoxItem." .. self:GetHashCode (),
		function (_, detection)
			self:CreateDetectionItem (detection)
		end
	)
	
	playerSession:AddEventListener ("DetectionsCleared", "CAC.PlayerListBoxItem." .. self:GetHashCode (),
		function (_, detection)
			self:ClearDetectionItems ()
		end
	)
	
	playerSession:AddEventListener ("DetectionRemoved", "CAC.PlayerListBoxItem." .. self:GetHashCode (),
		function (_, detection)
			self:DestroyDetectionItem (detection)
		end
	)
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
	
	playerSession:RemoveEventListener ("DetectionAdded",    "CAC.PlayerListBoxItem." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionsCleared", "CAC.PlayerListBoxItem." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionRemoved",  "CAC.PlayerListBoxItem." .. self:GetHashCode ())
end

CAC.Register ("CACDetectionList", self, "CACPanel")