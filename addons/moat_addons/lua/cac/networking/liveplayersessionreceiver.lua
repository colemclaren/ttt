local self = {}
CAC.LivePlayerSessionReceiver = CAC.MakeConstructor (self)

function self:ctor (livePlayerSession)
	self.LivePlayerSession = nil
	
	self:SetLivePlayerSession (livePlayerSession)
end

function self:dtor ()
	self:SetLivePlayerSession (nil)
end

function self:GetLivePlayerSession ()
	return self.LivePlayerSession
end

function self:SetLivePlayerSession (livePlayerSession)
	self.LivePlayerSession = livePlayerSession
	
	return self
end

function self:HandlePacket (inBuffer, livePlayerSession)
	livePlayerSession = livePlayerSession or self:GetLivePlayerSession ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if not self [handlerMethodName] then
		CAC.Error ("CAC.LivePlayerSessionReceiver:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName))
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, livePlayerSession)
end

function self:HandleFullUpdate (inBuffer, livePlayerSession)
	livePlayerSession:Deserialize (inBuffer)
end

function self:HandleCheckAdded (inBuffer, livePlayerSession)
	local checkId = inBuffer:StringN8 ()
	local check = livePlayerSession:AddCheck (checkId)
	check:Deserialize (inBuffer)
end

function self:HandleCheckStarted (inBuffer, livePlayerSession)
	local checkId = inBuffer:StringN8 ()
	local check = livePlayerSession:GetCheck (checkId)
	if not check then return end
	
	check:SetStarted (true)
end

function self:HandleCheckFinished (inBuffer, livePlayerSession)
	local checkId = inBuffer:StringN8 ()
	local check = livePlayerSession:GetCheck (checkId)
	if not check then return end
	
	check:SetFinished (true)
end

function self:HandleCheckStatusChanged (inBuffer, livePlayerSession)
	local checkId = inBuffer:StringN8 ()
	local check = livePlayerSession:GetCheck (checkId)
	if not check then return end
	
	local status = inBuffer:StringN16 ()
	if status == "" then status = nil end
	check:SetStatus (status)
end

function self:HandleCheckTimeoutChanged (inBuffer, livePlayerSession)
	local checkId = inBuffer:StringN8 ()
	local check = livePlayerSession:GetCheck (checkId)
	if not check then return end
	
	local timeoutId = inBuffer:UInt32 ()
	check:SetTimeout (livePlayerSession:GetTimeout (timeoutId))
end

function self:HandleTimeoutAdded (inBuffer, livePlayerSession)
	local timeoutId = inBuffer:UInt32 ()
	local timeout = livePlayerSession:GetTimeout (timeoutId) or livePlayerSession:AddTimeout (nil, timeoutId)
	timeout:Deserialize (inBuffer)
end

function self:HandleTimeoutDescriptionChanged (inBuffer, livePlayerSession)
	local timeoutId = inBuffer:UInt32 ()
	local timeout = livePlayerSession:GetTimeout (timeoutId)
	timeout:SetDescription (inBuffer:StringN16 ())
end

function self:HandleTimeoutDurationChanged (inBuffer, livePlayerSession)
	local timeoutId = inBuffer:UInt32 ()
	local timeout = livePlayerSession:GetTimeout (timeoutId)
	timeout:SetDuration (inBuffer:Double ())
end

function self:HandleTimeoutRemoved (inBuffer, livePlayerSession)
	local timeoutId = inBuffer:UInt32 ()
	livePlayerSession:RemoveTimeout (timeoutId)
end

function self:__call (...)
	return self.__ictor (...)
end

CAC.LivePlayerSessionReceiver = CAC.LivePlayerSessionReceiver ()