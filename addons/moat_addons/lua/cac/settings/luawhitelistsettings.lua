local self = {}
CAC.LuaWhitelistSettings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
		WhitelistUpdateTriggerChanged (whitelistUpdateTrigger)
		UpdateWhitelistNextStartupChanged (updateWhitelistNextStartup)
]]

CAC.LuaWhitelistSettings.Networking =
{
	Events =
	{
		WhitelistUpdateTriggerChanged     = { Handler = "SetWhitelistUpdateTrigger",     Parameters = { "UInt8"   } },
		UpdateWhitelistNextStartupChanged = { Handler = "SetUpdateWhitelistNextStartup", Parameters = { "Boolean" } }
	},
	Commands =
	{
		SetWhitelistUpdateTrigger         = { Handler = "SetWhitelistUpdateTrigger",     Parameters = { "UInt8"   } },
		SetUpdateWhitelistNextStartup     = { Handler = "SetUpdateWhitelistNextStartup", Parameters = { "Boolean" } },
		
		Reset =
		{
			Handler = function (sender, object)
				local referenceObject = object.__ictor ()
				object:SetWhitelistUpdateTrigger (referenceObject:GetWhitelistUpdateTrigger ())
			end
		}
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end
}

CAC.LuaWhitelistSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.LuaWhitelistSettings)
CAC.LuaWhitelistSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.LuaWhitelistSettings)

CAC.SerializerRegistry:RegisterSerializable ("LuaWhitelistSettings", 1)

function self:ctor ()
	self.WhitelistUpdateTrigger     = CAC.LuaWhitelistUpdateTrigger.Auto
	self.UpdateWhitelistNextStartup = false
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt8   (self.WhitelistUpdateTrigger    )
	outBuffer:Boolean (self.UpdateWhitelistNextStartup)
	
	return outBuffer
end

function self:Deserialize(inBuffer)
	self:SetWhitelistUpdateTrigger     (inBuffer:UInt8   ())
	self:SetUpdateWhitelistNextStartup (inBuffer:Boolean ())
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	clone:SetWhitelistUpdateTrigger     (source:GetWhitelistUpdateTrigger   ())
	clone:SetUpdateWhitelistNextStartup (source:ShouldUpdateWhitelistNextStartup ())
	
	return self
end

-- Lua whitelist
function self:GetWhitelistUpdateTrigger ()
	return self.WhitelistUpdateTrigger
end

function self:ShouldUpdateWhitelistNextStartup ()
	return self.UpdateWhitelistNextStartup
end

function self:SetWhitelistUpdateTrigger (whitelistUpdateTrigger)
	if self.WhitelistUpdateTrigger == whitelistUpdateTrigger then return self end
	
	self.WhitelistUpdateTrigger = whitelistUpdateTrigger
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("WhitelistUpdateTriggerChanged", self.WhitelistUpdateTrigger)
	
	return self
end

function self:SetUpdateWhitelistNextStartup (updateWhitelistNextStartup)
	if self.UpdateWhitelistNextStartup == updateWhitelistNextStartup then return self end
	
	self.UpdateWhitelistNextStartup = updateWhitelistNextStartup
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("UpdateWhitelistNextStartupChanged", self.UpdateWhitelistNextStartup)
	
	return self
end

function self:__call (...)
	return self:Clone (...)
end