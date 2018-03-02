local self = {}
CAC.PlayerInformationReceiver = CAC.MakeConstructor (self)

function self:ctor (playerInformation)
	self.PlayerInformation = nil
	
	self.AccountInformationReceiver         = CAC.AccountInformationReceiver         ()
	self.GameInformationReceiver            = CAC.GameInformationReceiver            ()
	self.OperatingSystemInformationReceiver = CAC.OperatingSystemInformationReceiver ()
	self.LocationInformationReceiver        = CAC.LocationInformationReceiver        ()
	self.HardwareInformationReceiver        = CAC.HardwareInformationReceiver        ()
	
	self:SetPlayerInformation (playerInformation)
end

function self:dtor ()
	self:SetPlayerInformation (nil)
end

function self:GetPlayerInformation ()
	return self.PlayerInformation
end

function self:SetPlayerInformation (playerInformation)
	self.PlayerInformation = playerInformation
	
	self.AccountInformationReceiver        :SetObject (self.PlayerInformation and self.PlayerInformation:GetAccountInformation         ())
	self.GameInformationReceiver           :SetObject (self.PlayerInformation and self.PlayerInformation:GetGameInformation            ())
	self.OperatingSystemInformationReceiver:SetObject (self.PlayerInformation and self.PlayerInformation:GetOperatingSystemInformation ())
	self.LocationInformationReceiver       :SetObject (self.PlayerInformation and self.PlayerInformation:GetLocationInformation        ())
	self.HardwareInformationReceiver       :SetObject (self.PlayerInformation and self.PlayerInformation:GetHardwareInformation        ())
	
	return self
end

function self:HandlePacket (inBuffer, playerInformation)
	playerInformation = playerInformation or self:GetPlayerInformation ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if not self [handlerMethodName] then
		CAC.Error ("CAC.PlayerInformationReceiver:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName))
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, playerInformation)
end

function self:HandleFullUpdate (inBuffer, playerInformation)
	playerInformation:Deserialize (inBuffer)
end

function self:HandleAccountInformation (inBuffer, playerInformation)
	self.AccountInformationReceiver:HandlePacket (inBuffer, playerInformation:GetAccountInformation ())
end

function self:HandleGameInformation (inBuffer, playerInformation)
	self.GameInformationReceiver:HandlePacket (inBuffer, playerInformation:GetGameInformation ())
end

function self:HandleOperatingSystemInformation (inBuffer, playerInformation)
	self.OperatingSystemInformationReceiver:HandlePacket (inBuffer, playerInformation:GetOperatingSystemInformation ())
end

function self:HandleLocationInformation (inBuffer, playerInformation)
	self.LocationInformationReceiver:HandlePacket (inBuffer, playerInformation:GetLocationInformation ())
end

function self:HandleHardwareInformation (inBuffer, playerInformation)
	self.HardwareInformationReceiver:HandlePacket (inBuffer, playerInformation:GetHardwareInformation ())
end

function self:__call (...)
	return self.__ictor (...)
end

CAC.PlayerInformationReceiver = CAC.PlayerInformationReceiver ()