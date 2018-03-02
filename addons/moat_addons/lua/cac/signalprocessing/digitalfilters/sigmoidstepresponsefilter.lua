function CAC.SigmoidStepResponseFilter (duration, samplePeriod)
	local samplingTimes = {}
	
	for t = 0, duration, samplePeriod do
		samplingTimes [#samplingTimes + 1] = t
	end
	
	local gaussian = CAC.NormalDistribution (duration * 0.5, duration * 0.01)
	local impulseResponse = gaussian:EvaluateBulk (samplingTimes, samplingTimes)
	
	-- Ensure unit DC gain
	local sum = 0
	for i = 1, #impulseResponse do
		sum = sum + impulseResponse [i]
	end
	
	for i = 1, #impulseResponse do
		impulseResponse [i] = impulseResponse [i] / sum
	end
	
	return CAC.RealFIRFilter.FromImpulseResponse (impulseResponse)
end