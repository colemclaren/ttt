local self = {}
CAC.LuaScannerSettings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)
--[[
	Events:
		Changed ()
			Fired when the settings have changed.
		LuaScanningEnabledChanged (luaScanningEnabled)
			Fired when lua scanning has been enabled or disabled.
		AutomaticPatchingEnabledChanged (automaticPatchingEnabled)
			Fired when automatic patching has been enabled or disabled.
]]

CAC.LuaScannerSettings.Networking =
{
	Events =
	{
		LuaScanningEnabledChanged       = { Handler = "SetLuaScanningEnabled",       Parameters = { "Boolean" } },
		AutomaticPatchingEnabledChanged = { Handler = "SetAutomaticPatchingEnabled", Parameters = { "Boolean" } },
	},
	Commands =
	{
		SetLuaScanningEnabled           = { Handler = "SetLuaScanningEnabled",       Parameters = { "Boolean" } },
		SetAutomaticPatchingEnabled     = { Handler = "SetAutomaticPatchingEnabled", Parameters = { "Boolean" } },
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end
}

CAC.LuaScannerSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.LuaScannerSettings)
CAC.LuaScannerSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.LuaScannerSettings)

CAC.SerializerRegistry:RegisterSerializable ("LuaScannerSettings", 1)

function self:ctor ()
	self.LuaScanningEnabled       = false
	self.AutomaticPatchingEnabled = true
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Boolean (self:IsLuaScanningEnabled       ())
	outBuffer:Boolean (self:IsAutomaticPatchingEnabled ())
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetLuaScanningEnabled       (inBuffer:Boolean ())
	self:SetAutomaticPatchingEnabled (inBuffer:Boolean ())
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetLuaScanningEnabled       (source:IsLuaScanningEnabled       ())
	self:SetAutomaticPatchingEnabled (source:IsAutomaticPatchingEnabled ())
	
	return self
end

-- Lua scanning
function self:IsLuaScanningEnabled ()
	return self.LuaScanningEnabled
end

function self:IsAutomaticPatchingEnabled ()
	return self.AutomaticPatchingEnabled
end

function self:SetLuaScanningEnabled (luaScanningEnabled)
	if self.LuaScanningEnabled == luaScanningEnabled then return self end
	
	self.LuaScanningEnabled = luaScanningEnabled
	
	self:DispatchEvent ("LuaScanningEnabledChanged", self.LuaScanningEnabled)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetAutomaticPatchingEnabled (automaticPatchingEnabled)
	if self.AutomaticPatchingEnabled == automaticPatchingEnabled then return self end
	
	self.AutomaticPatchingEnabled = automaticPatchingEnabled
	
	self:DispatchEvent ("AutomaticPatchingEnabledChanged", self.AutomaticPatchingEnabled)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:__call (...)
	return self:Clone (...)
end