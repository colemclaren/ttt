local self = {}
CAC.PlayerSessionReceiver = CAC.MakeConstructor (self)

function self:ctor (playerSession)
	self.PlayerSession = nil
	
	self.AccountInformationReceiver         = CAC.AccountInformationReceiver         ()
	self.GameInformationReceiver            = CAC.GameInformationReceiver            ()
	self.OperatingSystemInformationReceiver = CAC.OperatingSystemInformationReceiver ()
	self.LocationInformationReceiver        = CAC.LocationInformationReceiver        ()
	self.HardwareInformationReceiver        = CAC.HardwareInformationReceiver        ()
	
	self:SetPlayerSession (playerSession)
end

function self:dtor ()
	self:SetPlayerSession (nil)
end

function self:GetPlayerSession ()
	return self.PlayerSession
end

function self:SetPlayerSession (playerSession)
	self.PlayerSession = playerSession
	
	self.AccountInformationReceiver        :SetObject (self.PlayerSession and self.PlayerSession:GetAccountInformation         ())
	self.GameInformationReceiver           :SetObject (self.PlayerSession and self.PlayerSession:GetGameInformation            ())
	self.OperatingSystemInformationReceiver:SetObject (self.PlayerSession and self.PlayerSession:GetOperatingSystemInformation ())
	self.LocationInformationReceiver       :SetObject (self.PlayerSession and self.PlayerSession:GetLocationInformation        ())
	self.HardwareInformationReceiver       :SetObject (self.PlayerSession and self.PlayerSession:GetHardwareInformation        ())
	
	return self
end

function self:HandlePacket (inBuffer, playerSession)
	playerSession = playerSession or self:GetPlayerSession ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if not self [handlerMethodName] then
		CAC.Error ("CAC.PlayerSessionReceiver:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName))
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, playerSession)
end

function self:HandleFullUpdate (inBuffer, playerSession)
	local compressedData = inBuffer:StringN16 ()
	local data           = util.Decompress (compressedData)
	
	local subInBuffer = CAC.StringInBuffer (data)
	playerSession:Deserialize (subInBuffer)
end

function self:HandleAccountInformation (inBuffer, playerSession)
	self.AccountInformationReceiver:HandlePacket (inBuffer, playerSession:GetAccountInformation ())
end

function self:HandleGameInformation (inBuffer, playerSession)
	self.GameInformationReceiver:HandlePacket (inBuffer, playerSession:GetGameInformation ())
end

function self:HandleOperatingSystemInformation (inBuffer, playerSession)
	self.OperatingSystemInformationReceiver:HandlePacket (inBuffer, playerSession:GetOperatingSystemInformation ())
end

function self:HandleLocationInformation (inBuffer, playerSession)
	self.LocationInformationReceiver:HandlePacket (inBuffer, playerSession:GetLocationInformation ())
end

function self:HandleHardwareInformation (inBuffer, playerSession)
	self.HardwareInformationReceiver:HandlePacket (inBuffer, playerSession:GetHardwareInformation ())
end

function self:HandleStartTimeChanged (inBuffer, playerSession)
	playerSession:SetStartTime (inBuffer:UInt32  ())
end

function self:HandleEndTimeChanged (inBuffer, playerSession)
	playerSession:SetEndTime (inBuffer:UInt32  ())
end

function self:HandleFinishedChanged (inBuffer, playerSession)
	playerSession:SetFinished (inBuffer:Boolean ())
end

function self:HandleIncidentIdChanged (inBuffer, playerSession)
	if inBuffer:Boolean () then
		playerSession:SetIncidentId (inBuffer:UInt32())
	else
		inBuffer:UInt32 ()
		playerSession:SetIncidentId (nil)
	end
end

function self:HandleFlagAdded (inBuffer, playerSession)
	playerSession:AddFlag (inBuffer:StringN8 ())
end

function self:HandleFlagsCleared (inBuffer, playerSession)
	playerSession:ClearFlags ()
end

function self:HandleFlagRemoved (inBuffer, playerSession)
	playerSession:RemoveFlag (inBuffer:StringN8 ())
end

function self:HandleDetectionAdded (inBuffer, playerSession)
	return self:HandleDetectionChanged (inBuffer, playerSession)
end

function self:HandleDetectionChanged (inBuffer, playerSession)
	local detection = playerSession:AddDetection (inBuffer:StringN8 ())
	
	local compressedData = inBuffer:StringN16 ()
	local data           = util.Decompress (compressedData)
	
	local subInBuffer = CAC.StringInBuffer (data)
	detection:Deserialize (subInBuffer)
end

function self:HandleDetectionsCleared (inBuffer, playerSession)
	playerSession:ClearDetections ()
end

function self:HandleDetectionRemoved (inBuffer, playerSession)
	playerSession:RemoveDetection (inBuffer:StringN8 ())
end

function self:__call (...)
	return self.__ictor (...)
end

CAC.PlayerSessionReceiver = CAC.PlayerSessionReceiver ()