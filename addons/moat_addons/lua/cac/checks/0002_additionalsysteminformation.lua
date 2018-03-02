local self, info = CAC.Checks:RegisterCheck ("AdditionalSystemInformation", CAC.SingleResponseCheck)

info:SetName ("Additional System Information")
info:SetDescription ("Retrieves additional player system information.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("AdditionalSystemInformationReporter")
end

function self:OnStarted ()
	-- Skip this check on non-windows machines
	local operatingSystemInformation = self:GetPlayerSession ():GetOperatingSystemInformation ()
	if operatingSystemInformation:GetOperatingSystem () ~= CAC.OperatingSystem.Windows then
		self:SetStatus ("Cannot retrieve additional system information on non-Windows machines.")
		self:Finish ()
		return
	end
	
	self:SetStatus ("Requesting additional system information...")
	self:SetStatus ("Waiting for additional system information...")
end

function self:OnResponse (inBuffer)
	local success = inBuffer:Boolean ()
	
	if success then
		self:SetStatus ("Received additional system information!")
		
		local operatingSystemInformation = CAC.OperatingSystemInformation ()
		local hardwareInformation        = CAC.HardwareInformation        ()
		
		operatingSystemInformation:Deserialize (inBuffer)
		hardwareInformation       :Deserialize (inBuffer)
		
		self:GetLivePlayerSession ():GetPlayerSession     ():GetOperatingSystemInformation ():Copy (operatingSystemInformation)
		self:GetLivePlayerSession ():GetPlayerInformation ():GetOperatingSystemInformation ():Copy (operatingSystemInformation)
		
		self:GetLivePlayerSession ():GetPlayerSession     ():GetHardwareInformation        ():Copy (hardwareInformation)
		self:GetLivePlayerSession ():GetPlayerInformation ():GetHardwareInformation        ():Copy (hardwareInformation)
	else
		self:SetStatus ("Unable to retrieve additional system information!")
	end
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for additional system information timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Additional system information did not arrive on time.")
end

function self:OnFinished ()
end