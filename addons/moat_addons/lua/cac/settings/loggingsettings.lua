local self = {}
CAC.LoggingSettings = CAC.MakeConstructor (self)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
]]

CAC.LoggingSettings.Networking =
{
	Events =
	{
	},
	Commands =
	{
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end
}

CAC.LoggingSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.LoggingSettings)
CAC.LoggingSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.LoggingSettings)

function self:ctor ()
	CAC.EventProvider (self)
end