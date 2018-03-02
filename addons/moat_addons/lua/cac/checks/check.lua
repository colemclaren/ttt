local self = {}
CAC.Check = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Started ()
			Fired when this check has started.
		Finished ()
			Fired when this check has finished.
		StatusChanged (status)
			Fired when this check's status has changed.
		TimeoutChanged (TimeoutEntry timeout)
			Fired when this check's timeout has changed.
]]

function self:ctor (checkId, livePlayerSession)
	self.Id                = checkId
	self.LivePlayerSession = livePlayerSession
	
	self.Started           = false
	self.Finished          = false
	
	self.Status            = nil
	self.Timeout           = nil
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Boolean   (self.Started     )
	outBuffer:Boolean   (self.Finished    )
	outBuffer:StringN16 (self.Status or "")
	outBuffer:UInt32    (self.Timeout and self.Timeout:GetId () or 0)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetStarted  (inBuffer:Boolean ())
	self:SetFinished (inBuffer:Boolean ())
	local status = inBuffer:StringN16 ()
	if status == "" then status = nil end
	self:SetStatus (status)
	
	local timeoutId = inBuffer:UInt32 ()
	self:SetTimeout (self.LivePlayerSession:GetTimeout (timeoutId))
	
	return self
end

-- Check
function self:GetId ()
	return self.Id
end

function self:GetName ()
	return self:GetCheckInformation ():GetName ()
end

function self:GetCheckInformation ()
	return CAC.Checks:GetCheck (self:GetId ())
end

function self:GetLivePlayerSession ()
	return self.LivePlayerSession
end

function self:GetPlayerSession ()
	return self.LivePlayerSession:GetPlayerSession ()
end

-- State machine
function self:IsStarted ()
	return self.Started
end

function self:IsFinished ()
	return self.Finished
end

function self:Start ()
	if self:IsStarted () then return end
	
	self.Started = true
	
	self:DispatchEvent ("Started")
	
	self:DispatchCall ("OnStarted")
end

function self:Finish ()
	if self:IsFinished () then return end
	
	self.Started  = true
	self.Finished = true
	
	self:DispatchEvent ("Finished")
	self:DispatchCall ("OnFinished")
end

function self:SetStarted (started)
	if self.Started == started then return self end
	
	self.Started = started
	
	if self.Started then
		self:DispatchEvent ("Started")
	end
	
	return self
end

function self:SetFinished (finished)
	if self.Finished == finished then return self end
	
	self.Finished = finished
	
	if self.Finished then
		self:DispatchEvent ("Finished")
	end
	
	return self
end

-- Status
function self:GetStatus ()
	return self.Status
end

function self:SetStatus (status)
	if self.Status == status then return self end
	
	self.Status = status
	
	self:DispatchEvent ("StatusChanged", self.Status)
	
	return self
end

-- Payload
function self:SendPayload (payloadId, replyCallback, timeoutCallback)
	if Profiler then
		replyCallback = replyCallback and Profiler:Wrap (replyCallback, debug.getinfo (replyCallback).source)
	end
	
	if timeoutCallback then
		self:CreateTimeout (timeoutCallback)
		
		self:GetLivePlayerSession ():SendPayload (payloadId,
			function (inBuffer)
				self:DestroyTimeout ()
				return replyCallback (inBuffer)
			end
		)
	else
		self:GetLivePlayerSession ():SendPayload (payloadId, replyCallback)
	end
end

if Profiler then
	self.SendPayload = Profiler:Wrap (self.SendPayload, "Check:SendPayload")
end

-- Timeouts
function self:CreateTimeout (callback)
	local timeoutEntry = self.LivePlayerSession:AddTimeout (callback)
	self:SetTimeout (timeoutEntry)
	return timeoutEntry
end

function self:DestroyTimeout ()
	self.LivePlayerSession:RemoveTimeout (self.Timeout)
	self:SetTimeout (nil)
end

function self:GetTimeout ()
	return self.Timeout
end

function self:SetTimeout (timeoutEntry)
	if self.Timeout == timeoutEntry then return self end
	
	self.Timeout = timeoutEntry
	
	self:DispatchEvent ("TimeoutChanged", self.Timeout)
	
	return self
end

-- Detections
function self:AddDetection (detectionType)
	return self.LivePlayerSession:GetPlayerSession ():AddDetection (detectionType)
end

function self:AddDetectionReason (detectionType, reason)
	return self.LivePlayerSession:GetPlayerSession ():AddDetectionReason (detectionType, reason)
end

function self:AddDetectionReasonFiltered (detectionType, reason)
	return self.LivePlayerSession:GetPlayerSession ():AddDetectionReasonFiltered (detectionType, reason)
end

-- Logging
function self:AppendLogLine (line)
	self.LivePlayerSession:GetPlayerSession ():GetLog ():AppendLine (self:GetName () .. ": " .. line)
end

-- Internal, do not call
function self:DispatchCall (methodName, ...)
	local method = self [methodName]
	
	if Profiler then
		method = Profiler:Wrap (method, methodName .. " : " .. debug.getinfo (method).source)
	end
	
	local success, r1, r2, r3, r4 = xpcall (method,
		function (message)
			self:AppendLogLine (message)
			self:AppendLogLine (debug.traceback ())
			
			if GLib and GLib.Error then
				GLib.Error (message)
			else
				ErrorNoHalt (message)
				ErrorNoHalt (debug.traceback ())
			end
		end,
		self,
		...
	)
	
	if success then
		return r1, r2, r3, r4
	end
end

function self:OnStarted ()
end

function self:OnFinished ()
end