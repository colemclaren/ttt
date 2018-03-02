local self = {}
CAC.BullshitDistribution = CAC.MakeConstructor (self, CAC.ProbabilityDensityFunction)

local CAC_StandardNormalDistribution_Evaluate = CAC.StandardNormalDistribution.Evaluate

function self:ctor (enumerable)
	self.SampleSet = CAC.SampleSet (enumerable)
end

function self:GetSampleSet ()
	return self.SampleSet
end

function self:Evaluate (x)
	local n = self.SampleSet:GetSampleCount ()
	local standardDeviation = self.SampleSet:GetStandardDeviation ()
	
	local oneOverStandardDeviation  = 1 / standardDeviation
	local oneOverNStandardDeviation = 1 / n * oneOverStandardDeviation
	
	local total = 0
	for x1 in self.SampleSet:GetEnumerator () do
		total = total + oneOverNStandardDeviation * CAC_StandardNormalDistribution_Evaluate (oneOverStandardDeviation * (x - x1))
	end
	
	return total
end

function self:EvaluateBulk (array, out)
	out = out or {}
	
	local n = self.SampleSet:GetSampleCount ()
	local standardDeviation = self.SampleSet:GetStandardDeviation ()
	
	local oneOverStandardDeviation  = 1 / standardDeviation
	local oneOverNStandardDeviation = 1 / n * oneOverStandardDeviation
	
	for i = 1, #array do
		local x = array [i]
		local total = 0
		for x1 in self.SampleSet:GetEnumerator () do
			total = total + oneOverNStandardDeviation * CAC_StandardNormalDistribution_Evaluate (oneOverStandardDeviation * (x - x1))
		end
		
		out [i] = total
	end
	
	return out
end