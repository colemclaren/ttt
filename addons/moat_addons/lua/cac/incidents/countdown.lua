local self = {}
CAC.Countdown = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the countdown has changed.
]]

function self:ctor ()
	self.Running   = false
	self.Duration  = 0
	self.StartTime = 0
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Boolean (self:IsRunning ())
	outBuffer:Double  (self:GetTimeRemaining ())
	
	return outBuffer
end

function self:Deserialize (outBuffer)
	self.Running   = outBuffer:Boolean ()
	self.Duration  = outBuffer:Double  ()
	self.StartTime = SysTime ()
	
	return self
end

-- Countdown
function self:IsFinished ()
	return self:GetTimeRemaining () == 0
end

function self:IsRunning ()
	return self.Running
end

function self:SetDuration (duration)
	if self.Duration == duration then return self end
	
	self.Duration = duration
	
	self:DispatchEvent ("Changed")
	
	return self
end

function self:GetTimeRemaining ()
	if self.Running then
		return math.max (0, self.Duration - SysTime () + self.StartTime)
	else
		return self.Duration
	end
end

function self:Stop ()
	if not self.Running then return end
	
	self.Duration = self:GetTimeRemaining ()
	self.Running = false
	
	self:DispatchEvent ("Changed")
end

function self:Start ()
	if self.Running then return end
	
	self.Running   = true
	self.StartTime = SysTime ()
	
	self:DispatchEvent ("Changed")
end