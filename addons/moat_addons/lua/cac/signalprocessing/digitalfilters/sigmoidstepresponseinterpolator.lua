local self = {}
CAC.SigmoidStepResponseInterpolator = CAC.MakeConstructor (self)

function self:ctor (duration)
	duration = duration or 0.5
	
	self.SamplingPeriod = 1 / 60
	self.Time = SysTime ()
	
	self.Filter = CAC.SigmoidStepResponseFilter (duration, self.SamplingPeriod)
	self.CompiledFilter = self.Filter:CreateCompiledFilter ()
	self.TargetValue = 0
	self.Value = 0
end

function self:GetError ()
	return self.TargetValue - self.Value
end

function self:GetTime ()
	return self.Time
end

function self:GetTargetValue ()
	return self.TargetValue
end

function self:GetValue ()
	return self.Value
end

function self:SetTime (t)
	self.Time = t
	return self
end

function self:SetValue (value)
	self:Flush (value)
	return self
end

function self:SetTargetValue (targetValue)
	self.TargetValue = targetValue
	return self
end

function self:Flush (value)
	value = value or self.TargetValue
	
	local order = self.Filter:GetOrder ()
	for i = 1, order + 1 do
		self.Value = self.CompiledFilter (value)
	end
	
	self.Time = SysTime ()
end

function self:Initialize (value)
	self:SetTargetValue (value)
	self:Flush ()
end

function self:Run (finalTime)
	finalTime = finalTime or SysTime ()
	
	-- Don't bother keeping up if there's too much to do
	if finalTime - self.Time > 1 then
		self.Time = finalTime
	end
	
	while self.Time + self.SamplingPeriod <= finalTime do
		self.Value = self.CompiledFilter (self.TargetValue)
		self.Time = self.Time + self.SamplingPeriod
	end
	
	return self.Value
end

function self:Skip (t)
	t = t or SysTime ()
	self.Time = t
end