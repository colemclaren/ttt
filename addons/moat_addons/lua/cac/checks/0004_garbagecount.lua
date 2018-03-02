local self, info = CAC.Checks:RegisterCheck ("GarbageCount", CAC.SingleResponseCheck)

info:SetName ("Startup Garbage Count")
info:SetDescription ("Checks the amount of startup lua garbage.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("GarbageCountReporter")
end

function self:OnStarted ()
	self:SetStatus ("Requesting lua garbage count...")
	self:SetStatus ("Waiting for lua garbage count...")
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received lua garbage count!")
	
	local startupGarbageCount                   = inBuffer:UInt32 ()
	
	-- TODO: Do something magical with startupGarbageCount
	self:AppendLogLine ("\tStartup garbage count: " .. CAC.FormatFileSize (startupGarbageCount))
	
	self:GetLivePlayerSession ():GetData ().StartupGarbageCount = startupGarbageCount
	
	local detectionAdded = false
	local emptyTableAllocationDetectionAdded = false
	local noAllocationDetectionAdded         = false
	local summary = {}
	
	for i = 1, 5 do
		local allocated         = inBuffer:Boolean ()
		local preGarbageCount   = inBuffer:UInt32 ()
		local postGarbageCount  = inBuffer:UInt32 ()
		local deltaGarbageCount = postGarbageCount - preGarbageCount
		
		if allocated then
			summary [#summary + 1] = "+" .. CAC.FormatFileSize (deltaGarbageCount)
			if deltaGarbageCount ~= 32 and
			   not emptyTableAllocationDetectionAdded then
				emptyTableAllocationDetectionAdded = true
				
				self:SetStatus ("Unexpected empty table garbage count, rekking player...")
				self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Reported garbage due to empty table allocation ({}) was not 32 B (got " .. CAC.FormatFileSize (deltaGarbageCount) .. " instead)!")
				detectionAdded = true
			end
		else
			summary [#summary + 1] = "=" .. CAC.FormatFileSize (deltaGarbageCount)
			if deltaGarbageCount ~= 0 and
			   not noAllocationDetectionAdded then
				noAllocationDetectionAdded = true
				
				self:SetStatus ("Unexpected identity garbage count, rekking player...")
				self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Reported garbage due to no allocation was not 0 B (got " .. CAC.FormatFileSize (deltaGarbageCount) .. " instead)!")
				detectionAdded = true
			end
		end
	end
	
	if detectionAdded then
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "\tGarbage count report: " .. table.concat (summary, ", "))
	end
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for lua garbage count timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Lua garbage count did not arrive on time.")
end

function self:OnFinished ()
end