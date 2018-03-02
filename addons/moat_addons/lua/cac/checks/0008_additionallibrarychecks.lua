local self, info = CAC.Checks:RegisterCheck ("AdditionalLibraryChecks", CAC.SingleResponseCheck)

info:SetName ("Additional Library Verification")
info:SetDescription ("Verifies the integrity of other libraries.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("AdditionalLibraryChecks")
end

function self:OnStarted ()
	self:SetStatus ("Sending additional library integrity checks...")
	self:SetStatus ("Waiting for additional library integrity checks...")
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received additional library information!")
	
	local isWindows = self:GetLivePlayerSession ():GetPlayerSession ():GetOperatingSystemInformation ():GetOperatingSystem () == CAC.OperatingSystem.Windows
	
	local jitUtilFuncInfoFunctionInformation = CAC.JitUtilFuncInfoFunctionInformation ()
	
	local functionNames =
	{
		"collectgarbage",
		"math.random"
	}
	
	for i = 1, #functionNames do
		jitUtilFuncInfoFunctionInformation:Deserialize (inBuffer)
	
		-- Ensure that the function is native
		local functionAddress = jitUtilFuncInfoFunctionInformation:GetAddress ()
		if not functionAddress then
			self:SetStatus ("Anomaly in " .. functionNames [i] .. " detected.")
			self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't.")
		
		-- Ensure that the function lies within lua_shared.dll
		elseif isWindows and
			   not self:GetLivePlayerSession():IsLuaSharedDllAddress (functionAddress) then
			if self:GetLivePlayerSession ():IsLuaSharedDllAddressRangeCertain () then
				self:SetStatus ("Anomaly in " .. functionNames [i] .. " detected.")
				self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", functionNames [i] .. " has been overridden (" .. string.format ("0x%08x", functionAddress) .. " not in " .. self:GetLivePlayerSession ():GetFormattedLuaSharedDllAddressRange () .. ").")
			end
		end
	end
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for additional library checks timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Additional library integrity check results did not arrive on time.")
end

function self:OnFinished ()
end