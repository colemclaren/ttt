local self = {}
CAC.SampleSet = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function CAC.SampleSet.FromArray (array)
	local sampleSet = CAC.SampleSet ()
	sampleSet:AddSamples (array)
	return sampleSet
end

function CAC.SampleSet.FromEnumerable (enumerable)
	local sampleSet = CAC.SampleSet ()
	sampleSet:AddSamples (enumerable)
	return sampleSet
end

function self:ctor (enumerable)
	self.Samples = {}
	
	self.μ       = nil
	self.μValid  = false
	
	self.σ²      = nil
	self.σ²Valid = false
	
	self.σ       = nil
	self.σValid  = false
	
	if enumerable then
		self:AddSamples (enumerable)
	end
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32 (#self.Samples)
	
	for i = 1, #self.Samples do
		outBuffer:Double (self.Samples [i])
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local n = inBuffer:UInt32 ()
	
	self.Samples = {}
	for i = 1, n do
		self.Samples [i] = inBuffer:Double ()
	end
	
	self:InvalidateStatistics ()
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:Clear ()
	self:AddSamples (source)
	
	return self
end

-- SampleSet
function self:AddSample (x)
	self.Samples [#self.Samples + 1] = x
	
	self:InvalidateStatistics ()
end

function self:AddSamples (enumerable)
	if enumerable.GetEnumerator then
		for x in enumerable:GetEnumerator () do
			self.Samples [#self.Samples + 1] = x
		end
	else
		for _, x in ipairs (enumerable) do
			self.Samples [#self.Samples + 1] = x
		end
	end
	
	self:InvalidateStatistics ()
end

function self:Clear ()
	self.Samples = {}
	self:InvalidateStatistics ()
end

function self:GetEnumerator ()
	return CAC.Enumerator.ArrayEnumerator (self.Samples)
end

function self:GetSample (i)
	return self.Samples [i]
end

function self:GetSampleCount ()
	return #self.Samples
end

function self:GetSamples ()
	return self.Samples
end

function self:GetMean ()
	if not self.μValid then
		self.μValid = true
		
		local Σx = 0
		for i = 1, #self.Samples do
			Σx = Σx + self.Samples [i]
		end
		
		self.μ = Σx / #self.Samples
	end
	
	return self.μ
end

function self:GetStandardDeviation ()
	if not self.σValid then
		self.σValid = true
		
		self.σ = math.sqrt (self:GetVariance ())
	end
	
	return self.σ
end

function self:GetVariance ()
	if not self.σ²Valid then
		self.σ²Valid = true
		
		local Σx² = 0
		for i = 1, #self.Samples do
			Σx² = Σx² + self.Samples [i] ^ 2
		end
		
		self.σ² = Σx² / #self.Samples - self:GetMean () ^ 2
	end
	
	return self.σ²
end

-- Internal, do not call
function self:InvalidateStatistics ()
	self.μValid  = false
	self.σ²Valid = false
	self.σValid  = false
end