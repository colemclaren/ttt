-- Generated from: gooey/lua/gooey/interpolators/livesmoothinginterpolator.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/interpolators/livesmoothinginterpolator.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.LiveSmoothingInterpolator = CAC.MakeConstructor (self, CAC.LiveAdditiveInterpolator)

function self:ctor ()
	self.DefaultDuration = 1
end

function self:GetDefaultDuration ()
	return self.DefaultDuration
end

function self:GetTargetValue ()
	return self:GetFinalValue ()
end

function self:SetDefaultDuration (defaultDuration)
	self.DefaultDuration = defaultDuration
end

function self:SetTargetValue (targetValue, duration)
	duration = duration or self:GetDefaultDuration ()
	
	local deltaValue = targetValue - self:GetTargetValue ()
	if deltaValue == 0 then return end
	
	self:AddInterpolator (
		CAC.ScaledTimeInterpolator (
			CAC.AccelerationDecelerationInterpolator (),
			duration,
			deltaValue
		)
	)
end