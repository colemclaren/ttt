local self = {}
CAC.PlayerSessionSender = CAC.MakeConstructor (self)

--[[
	Events:
		CreateOutBuffer ()
			Fired when an OutBuffer instance is needed.
		DispatchPacket (OutBuffer packet)
			Fired when a packet needs to be dispatched.
]]

function self:ctor (playerSession)
	self.PlayerSession = nil
	
	self.AccountInformationSender         = CAC.AccountInformationSender         ()
	self.GameInformationSender            = CAC.GameInformationSender            ()
	self.OperatingSystemInformationSender = CAC.OperatingSystemInformationSender ()
	self.LocationInformationSender        = CAC.LocationInformationSender        ()
	self.HardwareInformationSender        = CAC.HardwareInformationSender        ()
	
	self.AccountInformationSender        :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("AccountInformation"        ) return outBuffer end)
	self.GameInformationSender           :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("GameInformation"           ) return outBuffer end)
	self.OperatingSystemInformationSender:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("OperatingSystemInformation") return outBuffer end)
	self.LocationInformationSender       :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("LocationInformation"       ) return outBuffer end)
	self.HardwareInformationSender       :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("HardwareInformation"       ) return outBuffer end)
	
	self.AccountInformationSender        :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.GameInformationSender           :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.OperatingSystemInformationSender:AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.LocationInformationSender       :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.HardwareInformationSender       :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	
	CAC.EventProvider (self)
	
	self:SetPlayerSession (playerSession)
end

function self:dtor ()
	self:SetPlayerSession (nil)
end

function self:GetPlayerSession ()
	return self.PlayerSession
end

function self:SetPlayerSession (playerSession)
	if self.PlayerSession == playerSession then return self end
	
	self:UnhookPlayerSession (self.PlayerSession)
	
	self.PlayerSession = playerSession
	
	self.AccountInformationSender        :SetObject (self.PlayerSession and self.PlayerSession:GetAccountInformation         ())
	self.GameInformationSender           :SetObject (self.PlayerSession and self.PlayerSession:GetGameInformation            ())
	self.OperatingSystemInformationSender:SetObject (self.PlayerSession and self.PlayerSession:GetOperatingSystemInformation ())
	self.LocationInformationSender       :SetObject (self.PlayerSession and self.PlayerSession:GetLocationInformation        ())
	self.HardwareInformationSender       :SetObject (self.PlayerSession and self.PlayerSession:GetHardwareInformation        ())
	
	self:HookPlayerSession (self.PlayerSession)
	
	return self
end

function self:SendFullUpdate ()
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8  ("FullUpdate")
	self:SerializeFullUpdate (outBuffer, self:GetPlayerSession ())
	self:DispatchEvent  ("DispatchPacket", outBuffer)
end

function self:SerializeFullUpdate (outBuffer, playerSession)
	local subOutBuffer = CAC.StringOutBuffer ()
	playerSession:Serialize (subOutBuffer)
	
	local data           = subOutBuffer:GetString ()
	local compressedData = util.Compress (data)
	outBuffer:StringN16 (compressedData)
	
	return outBuffer
end

function self:HookPlayerSession (playerSession)
	if not playerSession then return end
	
	playerSession:AddEventListener ("StartTimeChanged", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, startTime)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("StartTimeChanged")
			outBuffer:UInt32    (startTime)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("EndTimeChanged", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, endTime)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("EndTimeChanged")
			outBuffer:UInt32    (endTime)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("FinishedChanged", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, finished)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("FinishedChanged")
			outBuffer:Boolean   (finished)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("IncidentIdChanged", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, incidentId)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("IncidentIdChanged")
			outBuffer:Boolean   (incidentId ~= 0)
			outBuffer:UInt32    (incidentId or 0)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("FlagAdded", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, flag)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("FlagAdded")
			outBuffer:StringN8  (flag)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("FlagsCleared", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("FlagsCleared")
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("FlagRemoved", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, flag)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("FlagRemoved")
			outBuffer:StringN8  (flag)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("DetectionAdded", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, detection)
			self:OnDetectionChanged (detection)
		end
	)
	
	playerSession:AddEventListener ("DetectionChanged", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, detection)
			self:OnDetectionChanged (detection)
		end
	)
	
	playerSession:AddEventListener ("DetectionsCleared", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("DetectionsCleared")
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	playerSession:AddEventListener ("DetectionRemoved", "CAC.PlayerSessionSender." .. self:GetHashCode (),
		function (_, detection)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("DetectionRemoved")
			outBuffer:StringN8  (detection:GetDetectionType ())
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
	
	playerSession:RemoveEventListener ("StartTimeChanged",  "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("EndTimeChanged",    "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("FinishedChanged",   "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("IncidentIdChanged", "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("FlagAdded",         "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("FlagsCleared",      "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("FlagRemoved",       "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionAdded",    "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionChanged",  "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionsCleared", "CAC.PlayerSessionSender." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionRemoved",  "CAC.PlayerSessionSender." .. self:GetHashCode ())
end

function self:OnDetectionChanged (detection)
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8  ("DetectionChanged")
	outBuffer:StringN8  (detection:GetDetectionType ())
	
	local subOutBuffer = CAC.StringOutBuffer ()
	detection:Serialize (subOutBuffer)
	
	local data           = subOutBuffer:GetString ()
	local compressedData = util.Compress (data)
	outBuffer:StringN16 (compressedData)
	
	self:DispatchEvent  ("DispatchPacket", outBuffer)
end