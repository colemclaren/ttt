local self = {}
CAC.ExponentialDecayResponseFilter = CAC.MakeConstructor (self)

function self:ctor (k)
	k = k or 5
	
	self.Constant    = k
	self.ImpulseTime = 0
end

function self:GetConstant ()
	return self.Constant
end

function self:SetConstant (k)
	self.Constant = k
	return self
end

function self:SetImpulseTime (t)
	self.ImpulseTime = t
	return self
end

function self:Evaluate (t)
	t = t or SysTime ()
	
	t = t - self.ImpulseTime
	t = math.max (t, 0)
	
	return math.exp (-self.Constant * t)
end

function self:Impulse (t)
	t = t or SysTime ()
	self:SetImpulseTime (t)
end

function self:__call (t)
	return self:Evaluate (t)
end