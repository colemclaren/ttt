local self = {}
CAC.LuaWhitelistController = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor (logger)
	self.Logger                        = logger or CAC.Logger
	
	self.LuaWhitelistStatus            = CAC.LuaWhitelistStatus ()
	
	self.ServerWorkshopInformationFile = "cac/serverworkshopinformation.txt"
	self.WorkshopAddonUpdateTimes      = {}
	
	self.ServerLuaInformationFile      = "cac/serverluainformation.txt"
	self.StaticLuaInformation          = CAC.ServerLuaInformation (self.Logger)
	self.DynamicLuaInformation         = CAC.LuaInformation (self.Logger)
	
	self.LastCreationCheckTimes        = {}
	self.LastFailedUpdateTimes         = {}
	
	self.Version                       = 13
	
	CAC.EventProvider (self)
	
	self:Initialize ()
end

function self:dtor ()
	hook.Remove ("Initialize", "CAC.LuaWhitelistController." .. self:GetHashCode ())
end

function self:Initialize ()
	self:LoadWorkshopInformation ()
	
	local workshopInformationChanged = self:UpdateWorkshopInformation ()
	if workshopInformationChanged then
		self.Logger:Message ("Saving new workshop addon information...")
		self:SaveWorkshopInformation ()
	end
	
	local luaInformationLoaded       = false
	local shouldUpdateLuaInformation = false
	
	if workshopInformationChanged then
		self.Logger:Message ("Rebuilding lua information due to workshop addon changes.")
	else
		luaInformationLoaded = self:LoadLuaInformation ()
	end
	
	shouldUpdateLuaInformation = shouldUpdateLuaInformation or not luaInformationLoaded
	
	if not shouldUpdateLuaInformation then
		local path = "lua/includes/extensions/client/vehicle.lua"
		path = self.StaticLuaInformation:NormalizeSourceId (path)
		local sourceInformation = self.StaticLuaInformation:GetSourceInformation (path)
		if sourceInformation then
			shouldUpdateLuaInformation = shouldUpdateLuaInformation or sourceInformation:IsOutdated ()
		end
	end
	
	shouldUpdateLuaInformation = shouldUpdateLuaInformation or CAC.Settings:GetSettingsGroup ("LuaWhitelistSettings"):GetWhitelistUpdateTrigger () == CAC.LuaWhitelistUpdateTrigger.Always
	shouldUpdateLuaInformation = shouldUpdateLuaInformation or CAC.Settings:GetSettingsGroup ("LuaWhitelistSettings"):ShouldUpdateWhitelistNextStartup ()
	
	if shouldUpdateLuaInformation then
		hook.Add ("Initialize", "CAC.LuaWhitelistController." .. self:GetHashCode (),
			function ()
				self:UpdateStaticLuaInformation ()
				
				CAC.Settings:GetSettingsGroup ("LuaWhitelistSettings"):SetUpdateWhitelistNextStartup (false)
				
				-- Save lua information with new metadata
				self:SaveLuaInformation ()
			end
		)
	end
	
	-- Garry.
	self.DynamicLuaInformation:AddSource ("LuaCmd" ):AddFunction (CAC.LuaFunctionInformation.FromFunction (CompileString ("game.CleanUpMap()",        "LuaCmd" )))
	self.DynamicLuaInformation:AddSource ("Startup"):AddFunction (CAC.LuaFunctionInformation.FromFunction (CompileString ("require('notification');", "Startup")))
	
	-- Recover lua information from last instance
	if CAC_GetStaticLuaInformation then
		self.StaticLuaInformation:Import (CAC_GetStaticLuaInformation ())
		self.Logger:Message ("Imported existing static lua information.")
	end
	if CAC_GetDynamicLuaInformation then
		self.DynamicLuaInformation:Import (CAC_GetDynamicLuaInformation ())
		self.Logger:Message ("Imported existing dynamic lua information.")
	end
	
	-- Set up lua information recovery
	local staticLuaInformation  = self.StaticLuaInformation
	local dynamicLuaInformation = self.DynamicLuaInformation
	function CAC_GetStaticLuaInformation  () return staticLuaInformation end
	function CAC_GetDynamicLuaInformation () return dynamicLuaInformation end
end

-- ISerializable
function self:Serialize (outBuffer)
	self:SerializeWorkshopInformation (outBuffer)
	self:SerializeLuaInformation (outBuffer)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:DeserializeWorkshopInformation (outBuffer)
	self:DeserializeLuaInformation (outBuffer)
	
	return self
end

function self:SerializeLuaInformation (outBuffer)
	self.LuaWhitelistStatus  :Serialize (outBuffer)
	self.StaticLuaInformation:Serialize (outBuffer)
	
	return outBuffer
end

function self:DeserializeLuaInformation (inBuffer)
	self.LuaWhitelistStatus  :Deserialize (inBuffer)
	self.StaticLuaInformation:Deserialize (inBuffer)
	
	self:UpdateCounts ()
	
	return self
end

function self:SerializeWorkshopInformation (outBuffer)
	for workshopFile, lastUpdateTime in pairs (self.WorkshopAddonUpdateTimes) do
		outBuffer:StringN16 (workshopFile)
		outBuffer:UInt32 (lastUpdateTime)
	end
	outBuffer:StringN16 ("")
	
	return outBuffer
end

function self:DeserializeWorkshopInformation (inBuffer)
	self.WorkshopAddonUpdateTimes = {}
	
	local workshopFile = inBuffer:StringN16 ()
	while workshopFile ~= "" do
		self.WorkshopAddonUpdateTimes [workshopFile] = inBuffer:UInt32 ()
		
		workshopFile = inBuffer:StringN16 ()
	end
	
	return self
end

function self:LoadInformation (path, deserializer, name)
	self.Logger:Message ("Loading " .. name .. "...")
	
	if not file.Exists (path, "DATA") then
		self.Logger:Message ("No existing " .. name .. " found!")
		return false
	end
	
	local data = file.Read (path, "DATA") or ""
	local inBuffer = CAC.StringInBuffer (data)
	
	local version = inBuffer:UInt32 ()
	if version ~= self.Version then
		self.Logger:Message ("Cannot handle version " .. version .. " " .. name .. ". Current version is " .. self.Version .. ".")
		return false
	else
		deserializer (self, inBuffer)
		self.Logger:Message ("Loaded " .. name .. ".")
		return true
	end
end

function self:SaveInformation (path, serializer, name)
	local outBuffer = CAC.StringOutBuffer ()
	
	outBuffer:UInt32 (self.Version)
	
	serializer (self, outBuffer)
	
	file.CreateDir (string.GetPathFromFilename (path))
	file.Write (path, outBuffer:GetString ())
end

function self:LoadLuaInformation ()
	return self:LoadInformation (self.ServerLuaInformationFile, self.DeserializeLuaInformation, "server lua information")
end

function self:LoadWorkshopInformation ()
	return self:LoadInformation (self.ServerWorkshopInformationFile, self.DeserializeWorkshopInformation, "server workshop information")
end

function self:SaveLuaInformation ()
	self:SaveInformation (self.ServerLuaInformationFile, self.SerializeLuaInformation, "server lua information")
end

function self:SaveWorkshopInformation ()
	self:SaveInformation (self.ServerWorkshopInformationFile, self.SerializeWorkshopInformation, "server workshop information")
end

-- Lua whitelist
function self:AddDynamicDump (sourceId, dump)
	self.DynamicLuaInformation:AddDump (sourceId, dump)
end

function self:GetLuaWhitelistStatus ()
	return self.LuaWhitelistStatus
end

function self:GetStaticLuaInformation ()
	return self.StaticLuaInformation
end

function self:GetDynamicLuaInformation ()
	return self.DynamicLuaInformation
end

function self:NormalizePath (path)
	return self.StaticLuaInformation:NormalizeSourceId (path)
end

local CAC_FunctionVerificationResult_Verified = CAC.FunctionVerificationResult.Verified
function self:VerifyFunction (functionVerificationInformation, dynamicLuaInformation, autorefresh, lowercaseNormalizedPath)
	if not lowercaseNormalizedPath then
		lowercaseNormalizedPath = functionVerificationInformation:GetPath ()
		lowercaseNormalizedPath = self.StaticLuaInformation:NormalizePath (lowercaseNormalizedPath)
		lowercaseNormalizedPath = string.lower (lowercaseNormalizedPath)
	end
	
	local functionVerificationResult = dynamicLuaInformation:VerifyFunction (functionVerificationInformation, lowercaseNormalizedPath)
	if functionVerificationResult == CAC_FunctionVerificationResult_Verified then return functionVerificationResult end
	
	functionVerificationResult = self.DynamicLuaInformation:VerifyFunction (functionVerificationInformation, lowercaseNormalizedPath)
	if functionVerificationResult == CAC_FunctionVerificationResult_Verified then return functionVerificationResult end
	
	functionVerificationResult = self.StaticLuaInformation:VerifyFunction (functionVerificationInformation, lowercaseNormalizedPath)
	if functionVerificationResult == CAC_FunctionVerificationResult_Verified then return functionVerificationResult end
	
	if not autorefresh then return functionVerificationResult end
	
	-- Auto-refresh
	local path = functionVerificationInformation:GetPath ()
	path = self.StaticLuaInformation:NormalizeSourceId (path)
	
	if not self.StaticLuaInformation:ContainsSource (path) then
		self.LastCreationCheckTimes [path] = self.LastCreationCheckTimes [path] or 0
		
		if SysTime () - self.LastCreationCheckTimes [path] > 10 then
			self.LastCreationCheckTimes [path] = SysTime ()
			
			-- Check if the file exists, or garry's filesystem bindings are blocking us
			local exists = file.Exists (path, self.StaticLuaInformation:GetPathId ())
			if exists == nil then
				exists = CompileFile (path) ~= nil
			end
			
			if exists then
				-- self.Logger:Message ("Adding information for new file " .. path)
				self.Logger:Message ("Disabling verification for new file " .. path)
				self.StaticLuaInformation:AddSource (path)
				self.StaticLuaInformation:UpdateFile (path, CAC.UpdateType.Overwrite)
				self:OnLiveUpdate ()
			end
		end
	else
		local sourceInformation = self.StaticLuaInformation:GetSourceInformation (path)
		if SysTime () - (self.LastFailedUpdateTimes [path] or 0) > 1 then
			if sourceInformation:IsOutdated () then
				-- self.Logger:Message ("Updating information for file " .. sourceInformation:GetSourceId ())
				self.Logger:Message ("Disabling verification for file " .. sourceInformation:GetSourceId ())
				sourceInformation:Update (CAC.UpdateType.Merge)
				self:OnLiveUpdate ()
			else
				self.LastFailedUpdateTimes [path] = SysTime ()
			end
		end
	end
	
	-- Test again
	functionVerificationResult = self.StaticLuaInformation:VerifyFunction (functionVerificationInformation, lowercaseNormalizedPath)
	
	-- Ignore updated files completely.
	if functionVerificationResult ~= CAC_FunctionVerificationResult_Verified then
		local sourceInformation = self.StaticLuaInformation:GetSourceInformation (path)
		if sourceInformation and
		   sourceInformation:GetTimestamp () > self.LuaWhitelistStatus:GetLastUpdateTime () then
			return CAC_FunctionVerificationResult_Verified
		end
	end
	
	return functionVerificationResult
end

if Profiler then
	self.VerifyFunction = Profiler:Wrap (self.VerifyFunction, "LuaWhitelistController:VerifyFunction")
end

-- Internal, do not call
function self:OnLiveUpdate ()
	self:UpdateLastLiveUpdateTime ()
	self:UpdateCounts ()
	
	if CAC.Settings:GetSettingsGroup ("LuaWhitelistSettings"):GetWhitelistUpdateTrigger () == CAC.LuaWhitelistUpdateTrigger.Auto then
		CAC.Settings:GetSettingsGroup ("LuaWhitelistSettings"):SetUpdateWhitelistNextStartup (true)
	end
end

function self:UpdateCounts ()
	self.LuaWhitelistStatus:SetFileCount               (self.StaticLuaInformation:GetSourceCount             ())
	self.LuaWhitelistStatus:SetFunctionCount           (self.StaticLuaInformation:GetFunctionCount           ())
	self.LuaWhitelistStatus:SetUniqueFunctionHashCount (self.StaticLuaInformation:GetUniqueFunctionHashCount ())
end

function self:UpdateLastLiveUpdateTime ()
	self.LuaWhitelistStatus:SetLastLiveUpdateTime (os.time ())
end

function self:UpdateStaticLuaInformation ()
	local t0 = SysTime ()
	
	self.StaticLuaInformation:UpdateIncremental ()
	self:UpdateCounts ()
	
	self.LuaWhitelistStatus:SetLastUpdateTime (os.time ())
	self.LuaWhitelistStatus:SetLastUpdateDuration (SysTime () - t0)
end

function self:UpdateWorkshopInformation ()
	self.Logger:Message ("Scanning workshop addons for changes...")
	
	local workshopAddonUpdateTimes = {}
	local workshopAddons = file.Find ("addons/*.gma", "GAME")
	
	self.Logger:Message (string.format ("%4d workshop addon%s found.", #workshopAddons, #workshopAddons == 1 and "" or "s"))
	
	for _, workshopFile in ipairs (workshopAddons) do
		workshopAddonUpdateTimes [workshopFile] = file.Time ("addons/" .. workshopFile, "GAME")
	end
	
	local newAddonCount      = 0
	local deletedAddonCount  = 0
	local modifiedAddonCount = 0
	
	for _, workshopFile in ipairs (workshopAddons) do
		if not self.WorkshopAddonUpdateTimes [workshopFile] then
			self.Logger:Message ("+ " .. workshopFile)
			newAddonCount = newAddonCount + 1
		end
	end
	for workshopFile, _ in pairs (self.WorkshopAddonUpdateTimes) do
		if not workshopAddonUpdateTimes [workshopFile] then
			self.Logger:Message ("- " .. workshopFile)
			deletedAddonCount = deletedAddonCount + 1
		end
	end
	for _, workshopFile in ipairs (workshopAddons) do
		if self.WorkshopAddonUpdateTimes [workshopFile] and
		   self.WorkshopAddonUpdateTimes [workshopFile] ~= workshopAddonUpdateTimes [workshopFile] then
			self.Logger:Message ("* " .. workshopFile)
			modifiedAddonCount = modifiedAddonCount + 1
		end
	end
	
	if newAddonCount > 0 or deletedAddonCount > 0 or modifiedAddonCount > 0 then
		self.WorkshopAddonUpdateTimes = workshopAddonUpdateTimes
		
		self.Logger:Message (string.format ("%4d workshop addon%s added.",    newAddonCount,      newAddonCount      == 1 and "" or "s"))
		self.Logger:Message (string.format ("%4d workshop addon%s deleted.",  deletedAddonCount,  deletedAddonCount  == 1 and "" or "s"))
		self.Logger:Message (string.format ("%4d workshop addon%s modified.", modifiedAddonCount, modifiedAddonCount == 1 and "" or "s"))
		
		return true
	else
		self.Logger:Message ("No workshop addon changes detected.")
		return false
	end
end