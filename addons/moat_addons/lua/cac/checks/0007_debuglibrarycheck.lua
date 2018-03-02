local self, info = CAC.Checks:RegisterCheck ("DebugLibraryCheck", CAC.SingleResponseCheck)

info:SetName ("Debug Library Verification")
info:SetDescription ("Verifies the integrity of the debug library.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("DebugLibraryCheck")
end

function self:OnStarted ()
	self:SetStatus ("Sending debug library integrity check...")
	self:SetStatus ("Waiting for debug library integrity check...")
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received debug library information!")
	
	local clientDllImageSize    = inBuffer:UInt32 ()
	local luaSharedDllImageSize = inBuffer:UInt32 ()
	
	-- Check for improbable image sizes
	if clientDllImageSize > 128 * 1024 * 1024 then
		self:SetStatus ("Reported client.dll size is > 128 MiB, restructuring player's rectum...")
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "client.dll's reported size was improbably big (" .. CAC.FormatFileSize (clientDllImageSize) .. ").")
		
		clientDllImageSize = 8 * 1024 * 1024
	end
	if luaSharedDllImageSize > 128 * 1024 * 1024 then
		self:SetStatus ("Reported lua_shared.dll size is > 128 MiB, restructuring player's rectum...")
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "lua_shared.dll's reported size was improbably big (" .. CAC.FormatFileSize (luaSharedDllImageSize) .. ").")
		
		luaSharedDllImageSize = 8 * 1024 * 1024
	end
	
	-- Default to sensible sizes if it failed for some reason.
	if clientDllImageSize    == 0 then clientDllImageSize    = 8 * 1024 * 1024 end
	if luaSharedDllImageSize == 0 then luaSharedDllImageSize = 1 * 1024 * 1024 end
	
	self:GetLivePlayerSession ():GetData ().ClientDllImageSize    = clientDllImageSize
	self:GetLivePlayerSession ():GetData ().LuaSharedDllImageSize = luaSharedDllImageSize
	
	-- Operating system
	local operatingSystem = self:GetLivePlayerSession ():GetPlayerSession ():GetOperatingSystemInformation ():GetOperatingSystem ()
	local operatingSystemString = CAC.OperatingSystem.ToString (operatingSystem)
	
	-- Calculate client.dll image base address
	local systemBatteryPowerAddr = inBuffer:UInt32 ()
	local clientDllImageBase, clientDllImageBaseCertain = CAC.Modules.GetClientDllBaseAddress (systemBatteryPowerAddr, operatingSystemString, self:GetLivePlayerSession ():GetPlayerSession ():GetGameInformation ():GetVersion ())
	self:GetLivePlayerSession ():GetData ().ClientDllImageBase        = clientDllImageBase
	self:GetLivePlayerSession ():GetData ().ClientDllImageBaseCertain = clientDllImageBaseCertain
	
	-- Read luajit addresses
	local ircalladdresses = {}
	for i = 0, 72 do
		ircalladdresses [i] = tonumber (inBuffer:StringN8 ())
	end
	
	-- Check for lazy override of jit.util.ircalladdr
	if ircalladdresses [20] ~= 0 then
		self:SetStatus ("Anomaly in debug library detected, restructuring player's rectum...")
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Debug library integrity check #1 failed.")
	elseif ircalladdresses [72] ~= nil then
		self:SetStatus ("Anomaly in debug library detected, restructuring player's rectum...")
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Debug library integrity check #2 failed.")
	end
	
	-- Calculate lua_shared.dll base address
	local luaSharedDllImageBase, luaSharedDllImageBaseCertain = CAC.Modules.GetLuaSharedDllBaseAddress (ircalladdresses [0] or 0, operatingSystemString, self:GetLivePlayerSession ():GetPlayerSession ():GetGameInformation ():GetVersion ())
	self:GetLivePlayerSession ():GetData ().LuaSharedDllImageBase        = luaSharedDllImageBase
	self:GetLivePlayerSession ():GetData ().LuaSharedDllImageBaseCertain = luaSharedDllImageBaseCertain
	
	local functionNames =
	{
		"debug.getfenv",
		"debug.gethook",
		"debug.getinfo",
		"debug.getlocal",
		"debug.getmetatable",
		"debug.getregistry",
		"debug.getupvalue",
		"debug.setfenv",
		"debug.sethook",
		"debug.setmetatable",
		"string.dump",
		"jit.attach",
		"jit.util.funcbc",
		"jit.util.funcinfo",
		"jit.util.funck",
		"jit.util.funcuvname",
		"jit.util.ircalladdr"
	}
	
	local debugGetInfoFunctionInformation    = CAC.DebugGetInfoFunctionInformation    ()
	local jitUtilFuncInfoFunctionInformation = CAC.JitUtilFuncInfoFunctionInformation ()
	
	local isWindows = operatingSystem == CAC.OperatingSystem.Windows
	
	for i = 1, #functionNames do
		debugGetInfoFunctionInformation   :Deserialize (inBuffer)
		jitUtilFuncInfoFunctionInformation:Deserialize (inBuffer)
		
		local hasLocals    = inBuffer:Boolean ()
		local hasUpvalues  = inBuffer:Boolean ()
		local hasBytecode1 = inBuffer:Boolean ()
		local hasBytecode2 = inBuffer:Boolean ()
		local hasConstants = inBuffer:Boolean ()
		local hasUpvalues3 = inBuffer:Boolean ()
		
		-- Ensure that the function is native
		local functionAddress = jitUtilFuncInfoFunctionInformation:GetAddress ()
		if not functionAddress then
			if not CAC.Plugins:GetPlugin ("LeyACCompatibility") or
			   not CAC.Plugins:GetPlugin ("LeyACCompatibility"):IsLeyACPresent () then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't (check #1 failed).")
			end
			
		-- Ensure that the function lies within lua_shared.dll
		elseif isWindows and
		       not self:GetLivePlayerSession ():IsLuaSharedDllAddress (functionAddress) then
			if self:GetLivePlayerSession ():IsLuaSharedDllAddressRangeCertain () then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Debug library integrity check #3 failed for " .. functionNames [i] .. " (" .. string.format ("0x%08x", functionAddress) .. " not in " .. self:GetLivePlayerSession ():GetFormattedLuaSharedDllAddressRange () .. ").")
			end
		else
			-- Ensure that the function isn't pretending to be native, badly
			if hasLocals then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't (check #2 failed).")
			elseif hasUpvalues then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't (check #3 failed).")
			elseif hasBytecode1 then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't (check #4 failed).")
			elseif hasBytecode2 then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't (check #5 failed).")
			elseif hasConstants then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't (check #6 failed).")
			elseif hasUpvalues3 then
				self:SetStatus ("Anomaly in debug library detected...")
				self:AddDetectionReasonFiltered ("ClientsideLuaExecution", functionNames [i] .. " is supposed to be native, but isn't (check #7 failed).")
			end
		end
	end
	
	local boolean1 = inBuffer:Boolean ()
	local uint320  = inBuffer:UInt32  ()
	local boolean2 = inBuffer:Boolean ()
	local boolean3 = inBuffer:Boolean ()
	local uint321  = inBuffer:UInt32  ()
	
	if not boolean1 then
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Debug library integrity check #4 failed.")
	end
	
	if uint320 ~= 65474 then
		self:AddDetectionReasonFiltered ("ClientsideLuaExecution", "Debug library integrity check #5 failed (" .. uint320 .. ").")
	end

	if boolean2 then
		self:AddDetectionReasonFiltered ("ClientsideLuaExecution", "Debug library integrity check #6 failed.")
	end
	
	if not boolean3 then
		self:AddDetectionReasonFiltered ("ClientsideLuaExecution", "Debug library integrity check #7 failed.")
	end
	
	if uint321 ~= 65541 then
		self:AddDetectionReasonFiltered ("ClientsideLuaExecution", "Debug library integrity check #8 failed (" .. uint321 .. ").")
	end
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for debug library check timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Debug library integrity check results did not arrive on time.")
end

function self:OnFinished ()
end