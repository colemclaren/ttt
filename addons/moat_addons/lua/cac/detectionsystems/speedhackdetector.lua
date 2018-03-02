local self = {}
CAC.SpeedhackDetector = CAC.MakeConstructor (self)

local engineTickInterval = engine.TickInterval ()

function self:ctor (timeFunction, timeScaleFunction)
	self.TimeFunction      = timeFunction
	self.TimeScaleFunction = timeScaleFunction
	
	self.LastUserCmdTime   = nil
	
	-- Buffer 1
	self.Buffer1 = {}
	self.Buffer1.Duration                                     = 3 -- seconds
	self.Buffer1.StartIndex                                   = 1
	self.Buffer1.UserCmdCount                                 = 0
	self.Buffer1.ReferenceSimulationTime                      = 0
	self.Buffer1.LastReferenceSimulationTimeRecalculationTime = 0
	
	-- Buffer 2
	self.Buffer2 = {}
	self.Buffer2.UserCmdCount                                 = 0
	self.Buffer2.ReferenceSimulationTime                      = 0
	self.Buffer2.SimulationTime                               = 0
	
	-- Speedhack
	self.InSpeedhack        = false
	self.SpeedhackStartTime = nil
end

function self:Impulse (t)
	t = t or self.TimeFunction ()
	
	if not self.LastUserCmdTime then
		self.LastUserCmdTime = t
		return
	end
	
	-- Recalculate Buffer1 reference simulation time if over a minute elapsed
	-- since last recalcuation
	if t - self.Buffer1.LastReferenceSimulationTimeRecalculationTime > 60 then
		local referenceSimulationTime = 0
		for i = self.Buffer1.StartIndex, self.Buffer1.StartIndex + self.Buffer1.UserCmdCount - 1 do
			referenceSimulationTime = referenceSimulationTime + self.Buffer1 [i]
		end
		self.Buffer1.ReferenceSimulationTime = referenceSimulationTime
		
		self.Buffer1.LastReferenceSimulationTimeRecalculationTime = t
	end
	
	-- Add to Buffer1
	local dt = (t - self.LastUserCmdTime) * self.TimeScaleFunction ()
	self.LastUserCmdTime = t
	
	self.Buffer1 [self.Buffer1.StartIndex + self.Buffer1.UserCmdCount] = dt
	self.Buffer1.UserCmdCount = self.Buffer1.UserCmdCount + 1
	self.Buffer1.ReferenceSimulationTime = self.Buffer1.ReferenceSimulationTime + dt
	
	-- Cull Buffer1, move to Buffer2
	local referenceSimulationTime = self:GetBuffer1ReferenceSimulationTime ()
	while referenceSimulationTime > self.Buffer1.Duration do
		referenceSimulationTime = referenceSimulationTime - self.Buffer1 [self.Buffer1.StartIndex]
		self:AddToBuffer2 (self.Buffer1 [self.Buffer1.StartIndex])
		
		self.Buffer1.ReferenceSimulationTime = self.Buffer1.ReferenceSimulationTime - self.Buffer1 [self.Buffer1.StartIndex]
		self.Buffer1 [self.Buffer1.StartIndex] = nil
		self.Buffer1.StartIndex   = self.Buffer1.StartIndex   + 1
		self.Buffer1.UserCmdCount = self.Buffer1.UserCmdCount - 1
	end
	
	-- Clamp Buffer2 lag
	local dt2 = self:GetBuffer2TimeAhead ()
	if dt2 < -10 then
		self.Buffer2.SimulationTime = self.Buffer2.ReferenceSimulationTime - 10
	end
	
	-- Analyze Buffer1
	local dt1 = self:GetBuffer1TimeAhead ()
	local dt2 = self:GetBuffer2TimeAhead ()
	
	-- 15:06 - !𝖼𝖺𝗄𝖾: guys give me a random number between 0 and 10
	-- 15:06 - #: [Jvs] 4
	-- 15:06 - Author: 6
	-- 15:07 - #: [tfgo] 8
	-- 15:07 - !𝖼𝖺𝗄𝖾: thanks, that's now my new speedhack detector threshold
	-- 15:07 - !𝖼𝖺𝗄𝖾: jvs wins, sorry
	-- 2015-03-21 : Speedhack detector threshold raised, sorry Jvs.
	if dt1 > 1.0 * self.Buffer1.Duration and dt2 > 8 then
		if not self.InSpeedhack then
			self.InSpeedhack        = true
			self.SpeedhackStartTime = t
		end
	else
		self.InSpeedhack = false
	end
end

function self:GetSpeedhackStartTime ()
	return self.SpeedhackStartTime
end

function self:GetSpeedhackTime ()
	return self.LastUserCmdTime - self.SpeedhackStartTime
end

function self:IsInSpeedhack ()
	return self.InSpeedhack
end

function self:AddToBuffer2 (referenceSimulationTime)
	self.Buffer2.UserCmdCount            = self.Buffer2.UserCmdCount            + 1
	self.Buffer2.ReferenceSimulationTime = self.Buffer2.ReferenceSimulationTime + referenceSimulationTime
	self.Buffer2.SimulationTime          = self.Buffer2.SimulationTime          + engineTickInterval
end

function self:GetBuffer1TimeAhead ()
	return self:GetBuffer1SimulationTime () - self:GetBuffer1ReferenceSimulationTime ()
end

function self:GetBuffer1Duration ()
	return self.Buffer1.Duration
end

function self:GetBuffer1ReferenceSimulationTime ()
	return self.Buffer1.ReferenceSimulationTime
end

function self:GetBuffer1SimulationTime ()
	return self.Buffer1.UserCmdCount * engineTickInterval
end

function self:GetBuffer2TimeAhead ()
	return self:GetBuffer2SimulationTime () - self:GetBuffer2ReferenceSimulationTime ()
end

function self:GetBuffer2ReferenceSimulationTime ()
	return self.Buffer2.ReferenceSimulationTime
end

function self:GetBuffer2SimulationTime ()
	return self.Buffer2.SimulationTime
end