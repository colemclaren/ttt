local self = {}
CAC.StandardNormalDistribution = CAC.MakeConstructor (self, CAC.ProbabilityDensityFunction)

local math_exp  = math.exp
local math_pi   = math.pi
local math_sqrt = math.sqrt

--      1         (    1   2 )
-- ---------- exp ( - --- x  )
--    /-----      (    2     )
--  ,/  2 π

local oneOverRootTwoPi = 1 / math_sqrt (2 * math_pi)

function CAC.StandardNormalDistribution.Evaluate (x)
	return oneOverRootTwoPi * math_exp (-0.5 * x * x)
end

function CAC.StandardNormalDistribution.EvaluateBulk (array, out)
	out = out or {}
	
	for i = 1, #array do
		local x = array [i]
		out [i] = oneOverRootTwoPi * math_exp (-0.5 * x * x)
	end
end

function self:ctor ()
end

function self:Evaluate (x)
	return oneOverRootTwoPi * math_exp (-0.5 * x * x)
end

function self:EvaluateBulk (array, out)
	out = out or {}
	
	for i = 1, #array do
		local x = array [i]
		out [i] = oneOverRootTwoPi * math_exp (-0.5 * x * x)
	end
	
	return out
end