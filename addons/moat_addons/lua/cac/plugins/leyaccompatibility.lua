local self = CAC.Plugins:CreatePlugin ("LeyACCompatibility")

function self:ctor ()
	self.LogTimedOut = true
end

-- Plugin
function self:CanEnable ()
	return self:IsLeyACPresent ()
end

function self:OnEnable ()
	-- Disable, since we are going to stomp over LeyAC's loader.
	self.LogTimedOut = LeyAC.logtimedout
	LeyAC.logtimedout = false
end

function self:OnDisable ()
	LeyAC.logtimedout = self.LogTimedOut
end

-- LeyACCompatibility
function self:IsLeyACPresent ()
	return LeyAC ~= nil
end