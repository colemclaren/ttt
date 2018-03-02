local self = {}
CAC.TimeoutEntry = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		DescriptionChanged (description)
			Fired when this TimeoutEntry's description has changed.
		DurationChanged (duration)
			Fired when this TimeoutEntry's duration has changed.
		TimedOut ()
			Fired when this TimeoutEntry has timed out.
]]

function self:ctor (id, description)
	self.Id             = id
	
	self.LastUpdateTime = 0
	
	self.Duration       = 120 -- seconds
	self.TimeoutCounter = 0
	
	self.Description    = description or "Timeout"
	
	self.Callback = nil
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Double    (self.Duration      )
	outBuffer:Double    (self.TimeoutCounter)
	outBuffer:StringN16 (self.Description   )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Duration       = inBuffer:Double ()
	self.TimeoutCounter = inBuffer:Double ()
	self:SetDescription (inBuffer:StringN16 ())
	
	self.LastUpdateTime   = SysTime ()
	
	return self
end

-- TimeoutEntry
function self:GetId ()
	return self.Id
end

function self:Credit (t)
	local timedOut = self:HasTimedOut ()
	self.TimeoutCounter = self.TimeoutCounter + t
	self.LastUpdateTime = SysTime ()
	
	if not timedOut and self:HasTimedOut () then
		self:DispatchEvent ("TimedOut")
	end
end

function self:GetCallback ()
	return self.Callback
end

function self:GetDescription ()
	return self.Description
end

function self:GetTimeRemaining ()
	return math.max (0, self.Duration - self.TimeoutCounter)
end

function self:GetProjectedTimeRemaining ()
	return math.max (0, self.Duration - self.TimeoutCounter - SysTime () + self.LastUpdateTime)
end

function self:HasTimedOut ()
	return self.TimeoutCounter >= self.Duration
end

function self:SetCallback (callback)
	if self.Callback == callback then return self end
	
	self.Callback = callback
	
	return self
end

function self:SetDescription (description)
	if self.Description == description then return self end
	
	self.Description = description
	
	self:DispatchEvent ("DescriptionChanged", self.Description)
	
	return self
end

function self:SetDuration (duration)
	if self.Duration == duration then return self end
	
	self.Duration = duration
	
	self:DispatchEvent ("DurationChanged", self.Duration)
	
	return self
end