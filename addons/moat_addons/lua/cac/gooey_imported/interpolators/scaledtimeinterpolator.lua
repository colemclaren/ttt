-- Generated from: gooey/lua/gooey/interpolators/scaledtimeinterpolator.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/interpolators/scaledtimeinterpolator.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.ScaledTimeInterpolator = CAC.MakeConstructor (self, CAC.TimeInterpolator)

function self:ctor (timeInterpolator, duration, scale)
	self.TimeInterpolator = timeInterpolator
	self.Duration = duration or 1
	self.Scale = scale or 1
end

function self:GetDuration ()
	return self.Duration
end

function self:GetFinalValue ()
	return self.TimeInterpolator:GetFinalValue () * self.Scale
end

function self:GetInitialValue ()
	return self.TimeInterpolator:GetInitialValue () * self.Scale
end

function self:GetValue (t)
	return self.TimeInterpolator:GetValue (t / self.Duration) * self.Scale
end