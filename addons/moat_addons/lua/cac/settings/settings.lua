local self = {}
CAC.Settings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
		DetectionResponseSettingsChanged ()
			Fired when the detection response settings have changed.
]]

CAC.SerializerRegistry:RegisterSerializable ("Settings", 2)

function self:ctor ()
	self.SaveAllSessions          = false
	
	self.SettingsGroups           = {}
	self:AddSettingsGroup ("DetectorSettings",          CAC.DetectorSettings          ())
	self:AddSettingsGroup ("DetectionResponseSettings", CAC.DetectionResponseSettings ())
	self:AddSettingsGroup ("ResponseSettings",          CAC.ResponseSettings          ())
	self:AddSettingsGroup ("LuaWhitelistSettings",      CAC.LuaWhitelistSettings      ())
	self:AddSettingsGroup ("UserWhitelistSettings",     CAC.UserWhitelistSettings     ())
	
	self:AddSettingsGroup ("LuaScannerSettings",        CAC.LuaScannerSettings        ())
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	for settingsGroupName, settingsGroup in pairs (self.SettingsGroups) do
		outBuffer:StringN8 (settingsGroupName)
		
		local version    = CAC.SerializerRegistry:GetLatestSerializerVersion (settingsGroupName)
		local serializer = CAC.SerializerRegistry:GetSerializer (settingsGroupName, version)
		
		outBuffer:UInt32 (version)
		
		local subOutBuffer = CAC.StringOutBuffer ()
		serializer (settingsGroup, subOutBuffer)
		
		outBuffer:StringN32 (subOutBuffer:GetString ())
	end
	
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local settingsGroupName = inBuffer:StringN8 ()
	while settingsGroupName ~= "" do
		local settingsGroup = self:GetSettingsGroup (settingsGroupName)
		
		local version       = inBuffer:UInt32 ()
		local deserializer  = CAC.SerializerRegistry:GetDeserializer (settingsGroupName, version)
		
		local subInBuffer = CAC.StringInBuffer (inBuffer:StringN32 ())
		if settingsGroup and deserializer then
			deserializer (settingsGroup, subInBuffer)
		else
			CAC.Logger:Message ("Settings:Deserialize : Cannot load version " .. version .. " " .. settingsGroupName .. ".")
		end
		
		settingsGroupName = inBuffer:StringN8 ()
	end
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self.DetectionResponseSettings:Copy (source:GetDetectionResponseSettings ())
	
	return self
end

-- Save
function self:ShouldSaveAllSessions ()
	return self.SaveAllSessions
end

-- Settings groups
function self:AddSettingsGroup (settingsGroupName, settingsGroup)
	self.SettingsGroups [settingsGroupName] = settingsGroup
	
	settingsGroup:AddEventListener ("Changed", "CAC.Settings." .. self:GetHashCode (),
		function (_)
			self:DispatchEvent (settingsGroupName .. "Changed")
			self:DispatchEvent ("Changed")
		end
	)
end

function self:GetSettingsGroup (settingsGroupName)
	return self.SettingsGroups [settingsGroupName]
end

function self:GetDetectionResponseSettings ()
	return self:GetSettingsGroup ("DetectionResponseSettings")
end

function self:__call (...)
	return self:Clone (...)
end