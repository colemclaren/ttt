local self, info = CAC.Checks:RegisterCheck ("Aimbot", CAC.Check)

info:SetName ("Aimbot")
info:SetDescription ("Detects when a client has an aimbot.")

function self:ctor (livePlayerSession)
end

function self:OnStarted ()
	self:SetStatus ("Sending aimbot detector...")
	
	self:SendPayload ("AimbotDetector",
		function (inBuffer)
			return self:DispatchCall ("OnResponse", inBuffer)
		end
	)
	
	self:Finish ()
end

function self:OnResponse (inBuffer)
	local fieldCount = inBuffer:UInt8 ()
	local fieldNameSet = {}
	
	for i = 1, fieldCount do
		local fieldName = inBuffer:StringN8 ()
		fieldName = CAC.InverseIdentifiers [fieldName] or fieldName
		fieldNameSet [fieldName] = true
	end
	
	local sessionData = self:GetLivePlayerSession ():GetData ()
	if fieldNameSet ["CommandNumber"] then
		fieldNameSet ["CommandNumber"] = nil
		if not sessionData.LastSeedManipulationDetectionTime or SysTime () - sessionData.LastSeedManipulationDetectionTime > 10 then
			self:AddDetectionReasonFiltered ("SeedManipulation", "Seed manipulation detected!")
			
			sessionData.LastSeedManipulationDetectionTime = SysTime ()
		end
	end
	
	if not next (fieldNameSet) then return true end
	
	if not sessionData.LastAimbotDetectionTime or SysTime () - sessionData.LastAimbotDetectionTime > 10 then
		local fieldNames = ""
		for fieldName, _ in pairs (fieldNameSet) do
			if fieldNames ~= "" then fieldNames = fieldNames .. ", " end
			fieldNames = fieldNames .. CAC.String.EscapeNonprintable (fieldName)
		end
		
		self:AddDetectionReasonFiltered ("Aimbot", "Automated movement detected (" .. fieldNames .. ")")
		
		sessionData.LastAimbotDetectionTime = SysTime ()
	end
	
	return true
end

function self:OnTimedOut ()
end

function self:OnFinished ()
end
