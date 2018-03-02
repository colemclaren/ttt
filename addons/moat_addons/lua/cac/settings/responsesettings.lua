local self = {}
CAC.ResponseSettings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
		CountdownDurationChanged (countdownDuration)
			Fired when the countdown duration has been changed.
		BanDurationChanged (banDuration)
			Fired when the ban duration has been changed.
		BanSystemChanged (banSystem)
			Fired when the ban system has been changed.
		ResponseNotificationChanged (responseNotification)
			Fired when the response notification has been changed.
		KickMessageChanged (kickMessage)
			Fired when the kick message has been changed.
		BanMessageChanged (banMessage)
			Fired when the ban message has been changed.
		BanReasonChanged (banReason)
			Fired when the ban reason has been changed.
]]

CAC.ResponseSettings.Networking =
{
	Events =
	{
		CountdownDurationChanged    = { Handler = "SetCountdownDuration",    Parameters = { "Double"    } },
		BanDurationChanged          = { Handler = "SetBanDuration",          Parameters = { "Double"    } },
		BanSystemChanged            = { Handler = "SetBanSystem",            Parameters = { "StringN8"  } },
		ResponseNotificationChanged = { Handler = "SetResponseNotification", Parameters = { "StringN16" } },
		KickMessageChanged          = { Handler = "SetKickMessage",          Parameters = { "StringN16" } },
		BanMessageChanged           = { Handler = "SetBanMessage",           Parameters = { "StringN16" } },
		BanReasonChanged            = { Handler = "SetBanReason",            Parameters = { "StringN16" } }
	},
	Commands =
	{
		SetCountdownDuration        = { Handler = "SetCountdownDuration",    Parameters = { "Double"    } },
		SetBanDuration              = { Handler = "SetBanDuration",          Parameters = { "Double"    } },
		SetBanSystem                = { Handler = "SetBanSystem",            Parameters = { "StringN8"  } },
		SetResponseNotification     = { Handler = "SetResponseNotification", Parameters = { "StringN16" } },
		SetKickMessage              = { Handler = "SetKickMessage",          Parameters = { "StringN16" } },
		SetBanMessage               = { Handler = "SetBanMessage",           Parameters = { "StringN16" } },
		SetBanReason                = { Handler = "SetBanReason",            Parameters = { "StringN16" } },
		
		ResetCountdownSettings =
		{
			Handler = function (sender, object)
				local referenceObject = object.__ictor ()
				object:SetCountdownDuration (referenceObject:GetCountdownDuration ())
			end
		},
		
		ResetBanSettings =
		{
			Handler = function (sender, object)
				local referenceObject = object.__ictor ()
				object:SetBanDuration (referenceObject:GetBanDuration ())
				object:SetBanSystem   (referenceObject:GetBanSystem   ())
			end
		},
		
		ResetMessageSettings =
		{
			Handler = function (sender, object)
				local referenceObject = object.__ictor ()
				object:SetResponseNotification (referenceObject:GetResponseNotification ())
				object:SetKickMessage          (referenceObject:GetKickMessage          ())
				object:SetBanMessage           (referenceObject:GetBanMessage           ())
				object:SetBanReason            (referenceObject:GetBanReason            ())
			end
		},
		
		Reset =
		{
			Handler = function (sender, object)
				object:Copy (object.__ictor ())
			end
		}
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end,
	
	Requests =
	{
		BanSystemStatus =
		{
			Handler = function (sender, object, replyId)
				local outBuffer = CAC.StringOutBuffer ()
				CAC.BanSystemStatus ():Serialize (outBuffer)
				sender:DispatchReply (replyId, outBuffer:GetString ())
			end
		}
	},
	RequestPermissionPredicate = function (sender, object)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ViewMenu")
	end
}

CAC.ResponseSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.ResponseSettings)
CAC.ResponseSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.ResponseSettings)

CAC.SerializerRegistry:RegisterSerializable ("ResponseSettings", 1)

function self:ctor ()
	self.CountdownDuration = 15           -- seconds
	self.BanDuration       = 60 * 60 * 24 -- seconds
	
	self.BanSystem         = "Auto"
	
	self.ResponseNotification = "!cake Anti-Cheat: {name} will be {responsed} {ban?{permanentban?permanently :for {banduration} }:}in {countdowntimeremaining}. " ..
	                            "You can use the !cac_menu chat command or +cac_menu console command to view details."
	
	self.KickMessage          = "{responsed:titlecase} by anticheat:\n" ..
	                            "        Incident ID: {incidentid} (note this if you want to appeal)\n" ..
					            "        Reason: {detectionnames}"
	self.BanMessage           = "{responsed:titlecase} by anticheat {permanentban?permanently:for {banduration}}:\n" ..
	                            "        Incident ID: {incidentid} (note this if you want to appeal)\n" ..
					            "{approved?        {response:titlecase} approved by{:} {approvername} ({approversteamid})\n:}" ..
					            "        Reason: {detectionnames}"
	self.BanReason            = "!cake Anticheat: Incident {incidentid}: {fulldetectionnames}"
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Double    (self.CountdownDuration   )
	outBuffer:Double    (self.BanDuration         )
	
	outBuffer:StringN8  (self.BanSystem           )
	
	outBuffer:StringN16 (self.ResponseNotification)
	outBuffer:StringN16 (self.KickMessage         )
	outBuffer:StringN16 (self.BanMessage          )
	outBuffer:StringN16 (self.BanReason           )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetCountdownDuration    (inBuffer:Double    ())
	self:SetBanDuration          (inBuffer:Double    ())
	
	self:SetBanSystem            (inBuffer:StringN8  ())
	
	self:SetResponseNotification (inBuffer:StringN16 ())
	self:SetKickMessage          (inBuffer:StringN16 ())
	self:SetBanMessage           (inBuffer:StringN16 ())
	self:SetBanReason            (inBuffer:StringN16 ())
	
	return inBuffer
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetCountdownDuration    (source:GetCountdownDuration    ())
	self:SetBanDuration          (source:GetBanDuration          ())
	
	self:SetBanSystem            (source:GetBanSystem            ())
	
	self:SetResponseNotification (source:GetResponseNotification ())
	self:SetKickMessage          (source:GetKickMessage          ())
	self:SetBanMessage           (source:GetBanMessage           ())
	self:SetBanReason            (source:GetBanReason            ())
	
	return self
end

-- Responses
function self:GetCountdownDuration ()
	return self.CountdownDuration
end

function self:SetCountdownDuration (countdownDuration)
	if self.CountdownDuration == countdownDuration then return self end
	
	self.CountdownDuration = countdownDuration
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("CountdownDurationChanged", self.CountdownDuration)
	
	return self
end

function self:GetBanDuration ()
	return self.BanDuration
end

function self:GetBanSystem ()
	return self.BanSystem
end

function self:SetBanDuration (banDuration)
	if self.BanDuration == banDuration then return self end
	
	self.BanDuration = banDuration
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("BanDurationChanged", self.BanDuration)
	
	return self
end

function self:SetBanSystem (banSystem)
	if self.BanSystem == banSystem then return self end
	
	self.BanSystem = banSystem
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("BanSystemChanged", self.BanSystem)
	
	return self
end

-- Messages
function self:GetResponseNotification ()
	return self.ResponseNotification
end

function self:GetKickMessage ()
	return self.KickMessage
end

function self:GetBanMessage ()
	return self.BanMessage
end

function self:GetBanReason ()
	return self.BanReason
end

function self:SetResponseNotification (responseNotification)
	if self.ResponseNotification == responseNotification then return self end
	
	self.ResponseNotification = responseNotification
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("ResponseNotificationChanged", self.ResponseNotification)
	
	return self
end

function self:SetKickMessage (kickMessage)
	if self.KickMessage == kickMessage then return self end
	
	self.KickMessage = kickMessage
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("KickMessageChanged", self.KickMessage)
	
	return self
end

function self:SetBanMessage (banMessage)
	if self.BanMessage == banMessage then return self end
	
	self.BanMessage = banMessage
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("BanMessageChanged", self.BanMessage)
	
	return self
end

function self:SetBanReason (banReason)
	if self.BanReason == banReason then return self end
	
	self.BanReason = banReason
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("BanReasonChanged", self.BanReason)
	
	return self
end

function self:__call (...)
	return self:Clone (...)
end