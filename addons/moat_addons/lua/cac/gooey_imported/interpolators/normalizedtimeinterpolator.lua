-- Generated from: gooey/lua/gooey/interpolators/normalizedtimeinterpolator.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/interpolators/normalizedtimeinterpolator.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.NormalizedTimeInterpolator = CAC.MakeConstructor (self, CAC.TimeInterpolator)

function self:ctor ()
end

function self:GetDuration ()
	return 1
end

function self:GetFinalValue ()
	return 1
end

function self:GetInitialValue ()
	return 0
end

function self:GetValue (t)
	return 0
end