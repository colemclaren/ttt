-- Generated from: gooey/lua/gooey/interpolators/accelerationdecelerationinterpolator.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/interpolators/accelerationdecelerationinterpolator.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.AccelerationDecelerationInterpolator = CAC.MakeConstructor (self, CAC.NormalizedTimeInterpolator)

function self:ctor ()
end

function self:GetValue (t)
	if t < 0 then return self:GetInitialValue () end
	if t > 1 then return self:GetFinalValue () end
	return t - math.sin (2 * math.pi * t) / (2 * math.pi)
end