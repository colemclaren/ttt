local self = {}
CAC.SettingsSender = CAC.MakeConstructor (self, CAC.ObjectSender)

CAC.SettingsSender.Children =
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

function self:ctor (ply, object)
	self.LuaWhitelistStatus  = CAC.LuaWhitelistController :GetLuaWhitelistStatus  ()
	self.UserBlacklistStatus = CAC.UserBlacklistController:GetUserBlacklistStatus ()
	
	self:AddChild (self.LuaWhitelistStatus,  "LuaWhitelistStatus",  CAC.LuaWhitelistStatusSender )
	self:AddChild (self.UserBlacklistStatus, "UserBlacklistStatus", CAC.UserBlacklistStatusSender)
	
	self:AddEventListener ("ObjectChanged",
		function (_, lastObject, object)
			for _, settingsGroupName in ipairs (CAC.SettingsSender.Children) do
				self:RemoveChildById (settingsGroupName)
			end
			
			if not object then return end
			
			for _, settingsGroupName in ipairs (CAC.SettingsSender.Children) do
				self:AddChild (object:GetSettingsGroup (settingsGroupName), settingsGroupName, CAC [settingsGroupName .. "Sender"])
			end
		end
	)
	
	self:DispatchEvent ("ObjectChanged", nil, self:GetObject ())
end

function self:SerializeFullUpdate (outBuffer, object)
	object:Serialize (outBuffer)
	self:GetChildNetworker (self.LuaWhitelistStatus ):SerializeFullUpdate (outBuffer, self.LuaWhitelistStatus )
	self:GetChildNetworker (self.UserBlacklistStatus):SerializeFullUpdate (outBuffer, self.UserBlacklistStatus)
	
	return outBuffer
end
