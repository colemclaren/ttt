local self, info = CAC.Checks:RegisterCheck ("SysTime", CAC.SingleResponseCheck)

info:SetName ("SysTime")
info:SetDescription ("Does nothing.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("SysTimeCheck")
end

function self:OnStarted ()
	self:SetStatus ("Sending SysTime integrity check...")
	self:SetStatus ("Waiting for SysTime integrity check...")
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received SysTime information!")
	
	local sampleCount = inBuffer:UInt32 ()
	if sampleCount ~= 32 then
		self:SetStatus ("Unexpected SysTime sample count, rekking player...")
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "SysTime check returned " .. sampleCount .. " samples (expected 32 instead)!")
	end
	
	sampleCount = math.min (sampleCount, 32)
	
	local sampleSet = CAC.SampleSet ()
	for i = 1, sampleCount do
		sampleSet:AddSample (inBuffer:Double ())
	end
	
	if sampleSet:GetVariance () == 0 then
		self:SetStatus ("SysTime is broken, rekking player...")
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "SysTime is broken.")
	end
	
	-- print ("mean: " .. sampleSet:GetMean () .. ", variance: " .. sampleSet:GetVariance () .. ", stddev: " .. sampleSet:GetStandardDeviation ())
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for SysTime integrity check timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "SysTime integrity check results did not arrive on time.")
end

function self:OnFinished ()
end