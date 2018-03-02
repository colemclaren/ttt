local self = {}
CAC.CheckRegistry = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor (logger)
	self.Logger = logger or CAC.Logger
	
	self.Checks = {}
	
	-- Sequencing
	self.NextChecks     = {}
	self.PreviousChecks = {}
end

-- ISerializable
function self:Serialize (outBuffer)
	for checkId, checkInformation in pairs (self.Checks) do
		outBuffer:StringN8 (checkId)
		checkInformation:Serialize (outBuffer)
	end
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Checks = {}
	
	local checkId = inBuffer:StringN8 ()
	while checkId ~= "" do
		local checkInformation = CAC.CheckInformation (checkId)
		self.Checks [checkId] = checkInformation
		
		checkInformation:Deserialize (inBuffer)
		checkInformation:SetConstructor (CAC.Check)
		
		checkId = inBuffer:StringN8 ()
	end
	
	return self
end

-- CheckRegistry
function self:CreateCheck (checkId, ...)
	if not self.Checks [checkId] then
		CAC.Error ("CAC.CheckRegistry:CreateCheck : Check " .. checkId .. " does not exist!")
		return nil
	end
	
	return self.Checks [checkId]:Create (...)
end

function self:GetCheck (checkId)
	return self.Checks [checkId]
end

function self:RegisterCheck (checkId, baseClass)
	local checkInformation = CAC.CheckInformation (checkId)
	self.Checks [checkId] = checkInformation
	
	local check = {}
	checkInformation:SetConstructor (CAC.MakeConstructor (check, baseClass or CAC.Check))
	
	self.Logger:Message ("Registered check \"" .. checkId .. "\".")
	
	return check, checkInformation
end

function self:UnregisterCheck (checkId)
	self.Checks [checkId] = nil
end

-- Sequencing
function self:AddNextCheck (checkId, nextCheckId)
	self.NextChecks [checkId] = self.NextChecks [checkId] or {}
	self.NextChecks [checkId] [nextCheckId] = true
	
	self.PreviousChecks [nextCheckId] = self.PreviousChecks [nextCheckId] or {}
	self.PreviousChecks [nextCheckId] [checkId] = true
end

function self:AddPreviousCheck (checkId, previousCheckId)
	self:AddNextCheck (previousCheckId, checkId)
end

function self:ClearCheckSequences ()
	self.NextChecks     = {}
	self.PreviousChecks = {}
end

function self:ClearNextChecks (checkId)
	if not self.NextChecks [checkId] then return end
	
	for nextCheckId, _ in pairs (self.NextChecks [checkId]) do
		self:RemoveNextCheck (checkId, nextCheckId)
	end
end

function self:ClearPreviousChecks (checkId)
	if not self.PreviousChecks [checkId] then return end
	
	for previousCheckId, _ in pairs (self.PreviousChecks [checkId]) do
		self:RemovePreviousCheck (checkId, previousCheckId)
	end
end

function self:RemoveNextCheck (checkId, nextCheckId)
	if not self.NextChecks [checkId] then return end
	
	self.NextChecks [checkId] [nextCheckId] = nil
	self.PreviousChecks [nextCheckId] [checkId] = nil
end

function self:RemovePreviousCheck (checkId, previousCheckId)
	self:RemoveNextCheck (previousCheckId, checkId)
end

function self:GetNextCheckEnumerator (checkId)
	if not self.NextChecks [checkId] then return CAC.NullEnumerator () end
	
	return CAC.KeyEnumerator (self.NextChecks [checkId])
end

function self:GetPreviousCheckEnumerator (checkId)
	if not self.PreviousChecks [checkId] then return CAC.NullEnumerator () end
	
	return CAC.KeyEnumerator (self.PreviousChecks [checkId])
end

CAC.Checks = CAC.CheckRegistry ()