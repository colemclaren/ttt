local self = {}
CAC.SettingsReceiver = CAC.MakeConstructor (self, CAC.ObjectReceiver)

CAC.SettingsReceiver.Children =
{
	"DetectorSettings",
	"DetectionResponseSettings",
	"ResponseSettings",
	"LuaWhitelistSettings",
	"UserWhitelistSettings",
	"PermissionSettings",
	"LoggingSettings",
	
	"LuaScannerSettings"
}

function self:ctor (object)
	self.LuaWhitelistStatus  = CAC.LuaWhitelistStatus  ()
	self.UserBlacklistStatus = CAC.UserBlacklistStatus ()
	
	self:AddChild (self.LuaWhitelistStatus,  "LuaWhitelistStatus",  CAC.LuaWhitelistStatusReceiver )
	self:AddChild (self.UserBlacklistStatus, "UserBlacklistStatus", CAC.UserBlacklistStatusReceiver)
	
	self:AddEventListener ("ObjectChanged",
		function (_, lastObject, object)
			for _, settingsGroupName in ipairs (CAC.SettingsReceiver.Children) do
				self:RemoveChildById (settingsGroupName)
			end
			
			if not object then return end
			
			for _, settingsGroupName in ipairs (CAC.SettingsReceiver.Children) do
				self:AddChild (object:GetSettingsGroup (settingsGroupName), settingsGroupName, CAC [settingsGroupName .. "Receiver"])
			end
		end
	)
	
	self:DispatchEvent ("ObjectChanged", nil, self:GetObject ())
end

function self:DeserializeFullUpdate (inBuffer, object)
	object:Deserialize (inBuffer)
	self:GetChildNetworker (self.LuaWhitelistStatus ):HandleFullUpdate (inBuffer, self.LuaWhitelistStatus )
	self:GetChildNetworker (self.UserBlacklistStatus):HandleFullUpdate (inBuffer, self.UserBlacklistStatus)
end

function self:HookObject (object)
	if not object then return end
	
	object:GetSettingsGroup ("LuaWhitelistSettings"):AddEventListener ("GetLuaWhitelistStatus", "CAC.SettingsReceiver." .. self:GetHashCode (),
		function (_)
			return self.LuaWhitelistStatus
		end
	)
	object:GetSettingsGroup ("UserWhitelistSettings"):AddEventListener ("GetUserBlacklistStatus", "CAC.SettingsReceiver." .. self:GetHashCode (),
		function (_)
			return self.UserBlacklistStatus
		end
	)
end

function self:UnhookObject (object)
	if not object then return end
	
	object:GetSettingsGroup ("LuaWhitelistSettings" ):RemoveEventListener ("GetLuaWhitelistStatus",  "CAC.SettingsReceiver." .. self:GetHashCode ())
	object:GetSettingsGroup ("UserWhitelistSettings"):RemoveEventListener ("GetUserBlacklistStatus", "CAC.SettingsReceiver." .. self:GetHashCode ())
end
