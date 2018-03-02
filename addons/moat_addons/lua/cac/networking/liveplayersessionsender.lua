local self = {}
CAC.LivePlayerSessionSender = CAC.MakeConstructor (self)

--[[
	Events:
		CreateOutBuffer ()
			Fired when an OutBuffer instance is needed.
		DispatchPacket (OutBuffer packet)
			Fired when a packet needs to be dispatched.
]]

function self:ctor (livePlayerSession)
	self.LivePlayerSession = nil
	
	CAC.EventProvider (self)
	
	self:SetLivePlayerSession (livePlayerSession)
end

function self:dtor ()
	self:SetLivePlayerSession (nil)
end

function self:GetLivePlayerSession ()
	return self.LivePlayerSession
end

function self:SetLivePlayerSession (livePlayerSession)
	if self.LivePlayerSession == livePlayerSession then return self end
	
	self:UnhookLivePlayerSession (self.LivePlayerSession)
	
	self.LivePlayerSession = livePlayerSession
	
	self:HookLivePlayerSession (self.LivePlayerSession)
	
	return self
end

function self:SendFullUpdate ()
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8  ("FullUpdate")
	self.LivePlayerSession:Serialize (outBuffer)
	self:DispatchEvent  ("DispatchPacket", outBuffer)
end

function self:HookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	livePlayerSession:AddEventListener ("CheckAdded", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, check)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("CheckAdded")
			outBuffer:StringN8  (check:GetId ())
			check:Serialize     (outBuffer)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("CheckStarted", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, check)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("CheckStarted")
			outBuffer:StringN8  (check:GetId ())
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("CheckFinished", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, check)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("CheckFinished")
			outBuffer:StringN8  (check:GetId ())
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("CheckStatusChanged", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, check, status)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("CheckStatusChanged")
			outBuffer:StringN8  (check:GetId ())
			outBuffer:StringN16 (status)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("CheckTimeoutChanged", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, check, timeoutEntry)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("CheckTimeoutChanged")
			outBuffer:StringN8  (check:GetId ())
			outBuffer:UInt32    (timeoutEntry and timeoutEntry:GetId () or 0)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("TimeoutAdded", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, timeoutEntry)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("TimeoutAdded")
			outBuffer:UInt32    (timeoutEntry:GetId ())
			timeoutEntry:Serialize (outBuffer)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("TimeoutDescriptionChanged", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, timeoutEntry, description)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("TimeoutDescriptionChanged")
			outBuffer:UInt32    (timeoutEntry:GetId ())
			outBuffer:StringN16 (description)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("TimeoutDurationChanged", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, timeoutEntry, duration)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8 ("TimeoutDurationChanged")
			outBuffer:UInt32   (timeoutEntry:GetId ())
			outBuffer:Double   (duration)
			self:DispatchEvent ("DispatchPacket", outBuffer)
		end
	)
	
	livePlayerSession:AddEventListener ("TimeoutRemoved", "CAC.LivePlayerSessionSender." .. self:GetHashCode (),
		function (_, timeoutEntry)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("TimeoutRemoved")
			outBuffer:UInt32    (timeoutEntry:GetId ())
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
end

function self:UnhookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	livePlayerSession:RemoveEventListener ("CheckAdded",                "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
	livePlayerSession:RemoveEventListener ("CheckStarted",              "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
	livePlayerSession:RemoveEventListener ("CheckFinished",             "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
	livePlayerSession:RemoveEventListener ("CheckStatusChanged",        "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
	livePlayerSession:RemoveEventListener ("CheckTimeoutChanged",       "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
	livePlayerSession:RemoveEventListener ("TimeoutAdded",              "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
	livePlayerSession:RemoveEventListener ("TimeoutDescriptionChanged", "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
	livePlayerSession:RemoveEventListener ("TimeoutRemoved",            "CAC.LivePlayerSessionSender." .. self:GetHashCode ())
end
