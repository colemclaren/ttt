local self = {}
CAC.LuaWhitelistStatus = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		LastUpdateTimeChanged (lastUpdateTime)
		LastUpdateDurationChanged (lastUpdateDuration)
		LastLiveUpdateTimeChanged (lastLiveUpdateTime)
		
		FileCountChanged (fileCount)
		FunctionCountChanged (functionCount)
		UniqueFunctionHashCountChanged (uniqueFunctionHashCount)
]]

CAC.LuaWhitelistStatus.Networking =
{
	Events =
	{
		LastUpdateTimeChanged          = { Handler = "SetLastUpdateTime",          Parameters = { "UInt32" } },
		LastUpdateDurationChanged      = { Handler = "SetLastUpdateDuration",      Parameters = { "Double" } },
		LastLiveUpdateTimeChanged      = { Handler = "SetLastLiveUpdateTime",      Parameters = { "UInt32" } },
		FileCountChanged               = { Handler = "SetFileCount",               Parameters = { "UInt32" } },
		FunctionCountChanged           = { Handler = "SetFunctionCount",           Parameters = { "UInt32" } },
		UniqueFunctionHashCountChanged = { Handler = "SetUniqueFunctionHashCount", Parameters = { "UInt32" } },
	}
}

CAC.LuaWhitelistStatusSender   = CAC.CreateObjectSenderFactory   (CAC.LuaWhitelistStatus)
CAC.LuaWhitelistStatusReceiver = CAC.CreateObjectReceiverFactory (CAC.LuaWhitelistStatus)

function self:ctor ()
	self.LastUpdateTime          = 0
	self.LastUpdateDuration      = 0
	
	self.LastLiveUpdateTime      = 0
	
	self.FileCount               = 0
	self.FunctionCount           = 0
	self.UniqueFunctionHashCount = 0
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32  (self.LastUpdateTime         )
	outBuffer:Double  (self.LastUpdateDuration     )
	
	outBuffer:UInt32  (self.LastLiveUpdateTime     )
	
	outBuffer:UInt32  (self.FileCount              )
	outBuffer:UInt32  (self.FunctionCount          )
	outBuffer:UInt32  (self.UniqueFunctionHashCount)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetLastUpdateTime          (inBuffer:UInt32  ())
	self:SetLastUpdateDuration      (inBuffer:Double  ())
	
	self:SetLastLiveUpdateTime      (inBuffer:UInt32  ())
	
	self:SetFileCount               (inBuffer:UInt32  ())
	self:SetFunctionCount           (inBuffer:UInt32  ())
	self:SetUniqueFunctionHashCount (inBuffer:UInt32  ())
	
	return self
end

-- LuaWhitelistStatus
function self:GetLastUpdateTime ()
	return self.LastUpdateTime
end

function self:GetLastUpdateDuration ()
	return self.LastUpdateDuration
end

function self:GetLastLiveUpdateTime ()
	return self.LastLiveUpdateTime
end

function self:IsUpdateNeeded ()
	return self.LastLiveUpdateTime > self.LastUpdateTime
end

function self:SetLastUpdateTime (lastUpdateTime)
	if self.LastUpdateTime == lastUpdateTime then return self end
	
	self.LastUpdateTime = lastUpdateTime
	
	self:DispatchEvent ("LastUpdateTimeChanged", self.LastUpdateTime)
	
	return self
end

function self:SetLastUpdateDuration (lastUpdateDuration)
	if self.LastUpdateDuration == lastUpdateDuration then return self end
	
	self.LastUpdateDuration = lastUpdateDuration
	
	self:DispatchEvent ("LastUpdateDurationChanged", self.LastUpdateDuration)
	
	return self
end

function self:SetLastLiveUpdateTime (lastLiveUpdateTime)
	if self.LastLiveUpdateTime == lastLiveUpdateTime then return self end
	
	self.LastLiveUpdateTime = lastLiveUpdateTime
	
	self:DispatchEvent ("LastLiveUpdateTimeChanged", self.LastLiveUpdateTime)
	
	return self
end

function self:GetFileCount ()
	return self.FileCount
end

function self:GetFunctionCount ()
	return self.FunctionCount
end

function self:GetUniqueFunctionHashCount ()
	return self.UniqueFunctionHashCount
end

function self:SetFileCount (fileCount)
	if self.FileCount == fileCount then return self end
	
	self.FileCount = fileCount
	
	self:DispatchEvent ("FileCountChanged", self.FileCount)
	
	return self
end

function self:SetFunctionCount (functionCount)
	if self.FunctionCount == functionCount then return self end
	
	self.FunctionCount = functionCount
	
	self:DispatchEvent ("FunctionCountChanged", self.FunctionCount)
	
	return self
end

function self:SetUniqueFunctionHashCount (uniqueFunctionHashCount)
	if self.UniqueFunctionHashCount == uniqueFunctionHashCount then return self end
	
	self.UniqueFunctionHashCount = uniqueFunctionHashCount
	
	self:DispatchEvent ("UniqueFunctionHashCountChanged", self.UniqueFunctionHashCount)
	
	return self
end
