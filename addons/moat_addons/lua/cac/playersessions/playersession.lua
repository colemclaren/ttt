local self = {}
CAC.PlayerSession = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		StartTimeChanged (startTime)
			Fired when this PlayerSession's start time has changed.
		EndTimeChanged (endTime)
			Fired when this PlayerSession's end time has changed.
		FinishedChanged (finished)
			Fired when this PlayerSession's finished state has changed.
		IncidentIdChanged (incidentId)
			Fired when this PlayerSession's incident ID has changed.
		FlagAdded (flag)
			Fired when a flag has been added.
		FlagsCleared ()
			Fired when the flags have been cleared.
		FlagRemoved (flag)
			Fired when a flag has been removed.
		DetectionAdded (Detection detection)
			Fired when a detection has been added.
		DetectionChanged (Detection detection)
			Fired when a detection has changed.
		DetectionsCleared ()
			Fired when the detections have been cleared.
		DetectionReasonAdded (Detection detection, reason)
			Fired when a detection reason has been added.
		DetectionRemoved (Detection detection)
			Fired when a detection has been removed.
]]

CAC.SerializerRegistry:RegisterSerializable ("PlayerSession", 2)

function CAC.PlayerSession.FileNameFromSessionId (sessionId)
	return "session_" .. string.format ("%08x", sessionId) .. "_" .. os.date ("%Y%m%d-%H%M%S", sessionId) .. ".txt"
end

function CAC.PlayerSession.LogFileNameFromSessionId (sessionId)
	return "session_" .. string.format ("%08x", sessionId) .. "_" .. os.date ("%Y%m%d-%H%M%S", sessionId) .. "_log.txt"
end

function CAC.PlayerSession.SessionIdFromFileName (fileName)
	local timestamp = string.match (fileName, "session_([a-fA-F0-9]+)_[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]%.txt")
	if not timestamp then return nil end
	
	return tonumber (timestamp, 16)
end

function self:ctor (playerInformation, sessionId)
	self.PlayerInformation          = playerInformation
	self.SessionId                  = sessionId
	
	-- Serialization
	self.SessionFilePath            = self.PlayerInformation:GetPlayerDirectory () .. "/" .. CAC.PlayerSession.FileNameFromSessionId (self.SessionId)
	self.SaveNeeded                 = false
	
	-- Identity
	self.AccountInformation         = CAC.AccountInformation ()
	self.AccountInformation:Copy (self.PlayerInformation:GetAccountInformation ())
	
	-- Timespan
	self.StartTime                  = sessionId
	self.EndTime                    = sessionId
	self.Finished                   = false
	
	-- Incident
	self.IncidentId                 = nil
	
	-- Information
	self.GameInformation            = CAC.GameInformation ()
	self.OperatingSystemInformation = CAC.OperatingSystemInformation ()
	self.LocationInformation        = CAC.LocationInformation ()
	self.HardwareInformation        = CAC.HardwareInformation ()
	
	-- Anticheat state
	self.Flags                      = {}
	self.Detections                 = {}
	
	self.AccountInformation        :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.GameInformation           :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.OperatingSystemInformation:AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.LocationInformation       :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.HardwareInformation       :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	
	-- Log
	self.Log                        = CAC.PlayerSessionLog ()
	self.Log:SetPath (self.PlayerInformation:GetPlayerDirectory () .. "/" .. CAC.PlayerSession.LogFileNameFromSessionId (self:GetSessionId ()))
	self.SaveLog                    = false
	
	self.Log:AddEventListener ("Text",
		function (_, text)
			self:DispatchEvent ("LogText", text)
			
			if self:ShouldSaveLog () then
				self:MarkUnsaved ()
			end
		end
	)
	
	CAC.EventProvider (self)
end

function self:GetPlayerInformation ()
	return self.PlayerInformation
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32  (self:GetStartTime ())
	outBuffer:UInt32  (self:GetEndTime   ())
	outBuffer:Boolean (self:IsFinished   ())
	
	outBuffer:Boolean (self:HasIncident  ())
	outBuffer:UInt32  (self:GetIncidentId () or 0)
	
	self:GetAccountInformation         ():Serialize (outBuffer)
	self:GetGameInformation            ():Serialize (outBuffer)
	self:GetOperatingSystemInformation ():Serialize (outBuffer)
	self:GetLocationInformation        ():Serialize (outBuffer)
	self:GetHardwareInformation        ():Serialize (outBuffer)
	
	-- Flags
	for flag in self:GetFlagEnumerator () do
		outBuffer:StringN8 (flag)
	end
	outBuffer:StringN8 ("")
	
	-- Detections
	for detection in self:GetDetectionEnumerator () do
		outBuffer:StringN8 (detection:GetDetectionType ())
		detection:Serialize (outBuffer)
	end
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer, version)
	self:SetStartTime (inBuffer:UInt32 ())
	self:SetEndTime   (inBuffer:UInt32 ())
	self:SetFinished  (inBuffer:Boolean ())
	
	if inBuffer:Boolean () then
		self:SetIncidentId (inBuffer:UInt32 ())
	else
		inBuffer:UInt32 ()
		self:SetIncidentId (nil)
	end
	
	self:GetAccountInformation         ():Deserialize (inBuffer)
	self:GetGameInformation            ():Deserialize (inBuffer)
	self:GetOperatingSystemInformation ():Deserialize (inBuffer)
	self:GetLocationInformation        ():Deserialize (inBuffer)
	self:GetHardwareInformation        ():Deserialize (inBuffer)
	
	-- Flags
	local flag = inBuffer:StringN8 ()
	while flag ~= "" do
		self:AddFlag (flag)
		flag = inBuffer:StringN8 ()
	end
	
	-- Detections
	local detectionType = inBuffer:StringN8 ()
	while detectionType ~= "" do
		local detection = self:AddDetection (detectionType)
		detection:Deserialize (inBuffer)
		detectionType = inBuffer:StringN8 ()
	end
	
	return self
end

-- Serialization
function self:GetSessionFilePath ()
	return self.SessionFilePath
end

function self:Load ()
	if file.Exists (self.SessionFilePath, "DATA") then
		local data = file.Read (self.SessionFilePath, "DATA")
		
		local inBuffer = CAC.StringInBuffer (data)
		
		local version = inBuffer:UInt32 ()
		local playerSessionDeserializer = CAC.SerializerRegistry:GetDeserializer ("PlayerSession", version)
		if not playerSessionDeserializer then
			CAC.Logger:Message ("PlayerSession:Load : Cannot load version " .. version .. " files. Current version is " .. CAC.SerializerRegistry:GetLatestDeserializerVersion ("PlayerSession") .. ".")
			return
		end
		
		playerSessionDeserializer (self, inBuffer)
		self.SaveNeeded = false
	end
	
	self:GetLog ():Load ()
end

function self:Save ()
	if self.SaveNeeded then
		file.CreateDir (self.PlayerInformation:GetPlayerDirectory ())
		
		local outBuffer = CAC.StringOutBuffer ()
		
		local version    = CAC.SerializerRegistry:GetLatestSerializerVersion ("PlayerSession")
		local playerSessionSerializer = CAC.SerializerRegistry:GetSerializer ("PlayerSession", version)
		outBuffer:UInt32 (version)
		
		playerSessionSerializer (self, outBuffer)
		
		file.Write (self.SessionFilePath, outBuffer:GetString ())
		
		self.SaveNeeded = false
	end
	
	if self:ShouldSaveLog () then
		self:GetLog ():Save ()
	end
end

function self:MarkUnsaved ()
	self.SaveNeeded = true
end

-- Identity
function self:GetSteamId ()
	return self.AccountInformation:GetSteamId ()
end

function self:GetSessionId ()
	return self.SessionId
end

function self:GetAccountInformation ()
	return self.AccountInformation
end

-- Timespan
function self:GetStartTime ()
	return self.StartTime
end

function self:GetEndTime ()
	return self.EndTime
end

function self:IsFinished ()
	return self.Finished
end

function self:SetStartTime (startTime)
	if self.StartTime == startTime then return self end
	
	self.StartTime = startTime
	
	self:MarkUnsaved ()
	self:DispatchEvent ("StartTimeChanged", self.StartTime)
	
	return self
end

function self:SetEndTime (endTime)
	if self.EndTime == endTime then return self end
	
	self.EndTime = endTime
	
	self:MarkUnsaved ()
	self:DispatchEvent ("EndTimeChanged", self.EndTime)
	
	return self
end

function self:SetFinished (finished)
	if self.Finished == finished then return self end
	
	self.Finished = finished
	
	self:MarkUnsaved ()
	self:DispatchEvent ("Finished", self.Finished)
	
	return self
end

-- Incident
function self:GetIncident ()
	return CAC.Incidents:GetIncident (self.IncidentId)
end

function self:GetIncidentId ()
	return self.IncidentId
end

function self:HasIncident ()
	return self.IncidentId ~= nil
end

function self:SetIncidentId (incidentId)
	if self.IncidentId == incidentId then return self end
	
	self.IncidentId = incidentId
	
	self:MarkUnsaved ()
	self:DispatchEvent ("IncidentIdChanged", self.IncidentId)
	
	return self
end

-- Information
function self:GetGameInformation ()
	return self.GameInformation
end

function self:GetOperatingSystemInformation ()
	return self.OperatingSystemInformation
end

function self:GetLocationInformation ()
	return self.LocationInformation
end

function self:GetHardwareInformation ()
	return self.HardwareInformation
end

-- Anticheat state
-- Flags
function self:AddFlag (flag)
	if self.Flags [flag] then return end
	
	self.Flags [flag] = true
	
	self:MarkUnsaved ()
	self:DispatchEvent ("FlagAdded", flag)
end

function self:ClearFlags ()
	self.Flags = {}
	
	self:MarkUnsaved ()
	self:DispatchEvent ("FlagsCleared", flag)
end

function self:GetFlagEnumerator ()
	return CAC.KeyEnumerator (self.Flags)
end

function self:HasFlag (flag)
	return self.Flags [flag] ~= nil
end

function self:RemoveFlag (flag)
	if not self.Flags [flag] then return end
	
	self.Flags [flag] = nil
	
	self:MarkUnsaved ()
	self:DispatchEvent ("FlagRemoved", flag)
end

-- Detections
function self:AddDetection (detectionType)
	if self.Detections [detectionType] then
		return self.Detections [detectionType]
	end
	
	local detection = CAC.Detections:CreateDetection (detectionType)
	self.Detections [detectionType] = detection
	self:HookDetection (self.Detections [detectionType])
	
	self:MarkUnsaved ()
	self:DispatchEvent ("DetectionAdded", detection)
	
	return self.Detections [detectionType]
end

function self:AddDetectionReason (detectionType, reason)
	self:AddDetection (detectionType):AddReason (reason)
end

function self:AddDetectionReasonFiltered (detectionType, reason)
	if CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):GetUserWhitelist ():GetUserWhitelistStatus (self:GetSteamId ()) >= CAC.WhitelistStatus.SuppressDetections then
		return
	end
	
	self:AddDetectionReason (detectionType, reason)
end

function self:ClearDetections ()
	for detection in self:GetDetectionEnumerator () do
		self:UnhookDetection (detection)
		self:DispatchEvent ("DetectionRemoved", detection)
	end
	
	self.Detections = {}
	
	self:MarkUnsaved ()
	self:DispatchEvent ("DetectionsCleared", detection)
end

function self:GetDetectionEnumerator ()
	return CAC.ValueEnumerator (self.Detections)
end

function self:GetDetectionListText ()
	local detectionLines = {}
	detectionLines [#detectionLines + 1] = "Warning: It's a bad idea to show this detection list to cheaters, since it may give them enough information to make their cheats undetected."
	detectionLines [#detectionLines + 1] = "Detection list for " .. self:GetSteamId () .. " / https://steamcommunity.com/profiles/" .. self:GetAccountInformation ():GetCommunityId ()
	
	for detection in self:GetDetectionEnumerator () do
		detectionLines [#detectionLines + 1] = detection:GetDescription ()
	end
	
	return table.concat (detectionLines, "\n")
end

function self:HasDetection (detectionType)
	return self.Detections [detectionType] ~= nil
end

function self:HasDetections ()
	return next (self.Detections) ~= nil
end

function self:RemoveDetection (detectionType)
	if not self.Detections [detectionType] then return end
	
	self:UnhookDetection (self.Detections [detectionType])
	self.Detections [detectionType] = nil
	
	self:MarkUnsaved ()
	self:DispatchEvent ("DetectionRemoved", detection)
end

-- Log
function self:GetLog ()
	return self.Log
end

function self:ShouldSaveLog ()
	return self.SaveLog
end

function self:SetSaveLog (saveLog)
	if self.SaveLog == saveLog then return self end
	
	self.SaveLog = saveLog
	
	if self.SaveLog then
		self.Log:Save ()
	end
	
	return self
end

-- Internal, do not call
function self:HookDetection (detection)
	if not detection then return end
	
	detection:AddEventListener ("Changed", "CAC.PlayerSession." .. self:GetHashCode (),
		function (_)
			self:MarkUnsaved ()
			self:DispatchEvent ("DetectionChanged", detection)
		end
	)
	
	detection:AddEventListener ("ReasonAdded", "CAC.PlayerSession." .. self:GetHashCode (),
		function (_, reason)
			self:MarkUnsaved ()
			self:DispatchEvent ("DetectionReasonAdded", detection, reason)
		end
	)
end

function self:UnhookDetection (detection)
	if not detection then return end
	
	detection:RemoveEventListener ("Changed",     "CAC.PlayerSession." .. self:GetHashCode ())
	detection:RemoveEventListener ("ReasonAdded", "CAC.PlayerSession." .. self:GetHashCode ())
end
