local self = {}
CAC.NormalDistribution = CAC.MakeConstructor (self, CAC.ProbabilityDensityFunction)

local math_exp  = math.exp
local math_pi   = math.pi
local math_sqrt = math.sqrt

--        1         (    1  (  x - μ  )2 )
-- ------------ exp ( - --- ( ------- )  )
--      /-----      (    2  (    σ    )  )
--  σ ,/  2 π

local oneOverRootTwoPi = 1 / math_sqrt (2 * math_pi)

function CAC.NormalDistribution.Evaluate (mean, variance, x)
	local oneOverStandardDeviation = 1 / math_sqrt (variance)
	x = (x - mean) * oneOverStandardDeviation
	return oneOverStandardDeviation * oneOverRootTwoPi * math_exp (-0.5 * x * x)
end

function self:ctor (mean, variance)
	self.Mean = mean
	self.StandardDeviation = math_sqrt (variance)
	self.OneOverStandardDeviation = 1 / self.StandardDeviation
end

function self:Evaluate (x)
	x = (x - self.Mean) * self.OneOverStandardDeviation
	return self.OneOverStandardDeviation * oneOverRootTwoPi * math_exp (-0.5 * x * x)
end

function self:EvaluateBulk (array, out)
	out = out or {}
	
	local μ = self.Mean
	local oneOverStandardDeviation = self.OneOverStandardDeviation
	
	for i = 1, #array do
		local x = array [i]
		x = (x - μ) * oneOverStandardDeviation
		out [i] = oneOverStandardDeviation * oneOverRootTwoPi * math_exp (-0.5 * x * x)
	end
	
	return out
end