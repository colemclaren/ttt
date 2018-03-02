local self = {}
CAC.UserBlacklistStatus = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
		LastUpdateTimeChanged (lastUpdateTime)
		LastUpdateCheckTimeChanged (lastUpdateCheckTime)
]]

CAC.UserBlacklistStatus.Networking =
{
	Events =
	{
		LastUpdateTimeChanged      = { Handler = "SetLastUpdateTime",      Parameters = { "UInt32" } },
		LastUpdateCheckTimeChanged = { Handler = "SetLastUpdateCheckTime", Parameters = { "UInt32" } },
	}
}

CAC.UserBlacklistStatusSender   = CAC.CreateObjectSenderFactory   (CAC.UserBlacklistStatus)
CAC.UserBlacklistStatusReceiver = CAC.CreateObjectReceiverFactory (CAC.UserBlacklistStatus)

CAC.SerializerRegistry:RegisterSerializable ("UserBlacklistStatus", 1)

function self:ctor ()
	self.LastUpdateTime      = 0
	self.LastUpdateCheckTime = 0
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32 (self:GetLastUpdateTime      ())
	outBuffer:UInt32 (self:GetLastUpdateCheckTime ())
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetLastUpdateTime      (inBuffer:UInt32 ())
	self:SetLastUpdateCheckTime (inBuffer:UInt32 ())
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetLastUpdateTime      (source:GetLastUpdateTime      ())
	self:SetLastUpdateCheckTime (source:GetLastUpdateCheckTime ())
	
	return self
end

function self:GetLastUpdateTime ()
	return self.LastUpdateTime
end

function self:GetLastUpdateCheckTime ()
	return self.LastUpdateCheckTime
end

function self:SetLastUpdateTime (lastUpdateTime)
	if self.LastUpdateTime == lastUpdateTime then return self end
	
	self.LastUpdateTime = lastUpdateTime
	
	self:DispatchEvent ("LastUpdateTimeChanged", self.LastUpdateTime)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetLastUpdateCheckTime (lastUpdateCheckTime)
	if self.LastUpdateCheckTime == lastUpdateCheckTime then return self end
	
	self.LastUpdateCheckTime = lastUpdateCheckTime
	
	self:DispatchEvent ("LastUpdateCheckTimeChanged", self.LastUpdateCheckTime)
	self:DispatchEvent ("Changed")
	
	return self
end