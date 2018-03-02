local self = {}
CAC.MovingWindowSampleSet = CAC.MakeConstructor (self, CAC.SampleSet)

function CAC.MovingWindowSampleSet.FromArray (array)
	local sampleSet = CAC.MovingWindowSampleSet ()
	sampleSet:AddSamples (array)
	return sampleSet
end

function CAC.MovingWindowSampleSet.FromEnumerable (enumerable)
	local sampleSet = CAC.MovingWindowSampleSet ()
	sampleSet:AddSamples (enumerable)
	return sampleSet
end

function self:ctor (enumerable)
	self.NextIndex  = 1
	self.WindowSize = 10
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:Clear ()
	self:SetWindowSize (source:GetWindowSize())
	self:AddSamples (source)
	
	return self
end

-- SampleSet
function self:AddSample (x)
	self.Samples [self.NextIndex] = x
	self.NextIndex = self.NextIndex % self.WindowSize + 1
	
	self:InvalidateStatistics ()
end

function self:AddSamples (enumerable)
	if enumerable.GetEnumerator then
		for x in enumerable:GetEnumerator () do
			self.Samples [self.NextIndex] = x
			self.NextIndex = self.NextIndex % self.WindowSize + 1
		end
	else
		for _, x in ipairs (enumerable) do
			self.Samples [self.NextIndex] = x
			self.NextIndex = self.NextIndex % self.WindowSize + 1
		end
	end
	
	self:InvalidateStatistics ()
end

function self:GetWindowSize ()
	return self.WindowSize
end

function self:SetWindowSize (windowSize)
	if self.WindowSize == windowSize then return self end
	
	self.WindowSize = windowSize
	
	return self
end