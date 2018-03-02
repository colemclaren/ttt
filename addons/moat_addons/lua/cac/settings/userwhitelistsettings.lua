local self = {}
CAC.UserWhitelistSettings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
		BlacklistEnabledChanged (blacklistEnabled)
			Fired when the blacklist has been enabled or disabled.
		UserTrackingEnabledChanged (userTrackingEnabled)
			Fired when user tracking has been enabled or disabled.
]]

CAC.UserWhitelistSettings.Networking =
{
	Events =
	{
		BlacklistEnabledChanged    = { Handler = "SetBlacklistEnabled",    Parameters = { "Boolean" } },
		UserTrackingEnabledChanged = { Handler = "SetUserTrackingEnabled", Parameters = { "Boolean" } }
	},
	Commands =
	{
		SetBlacklistEnabled    = { Handler = "SetBlacklistEnabled",    Parameters = { "Boolean" } },
		SetUserTrackingEnabled = { Handler = "SetUserTrackingEnabled", Parameters = { "Boolean" } },
		
		RequestUserBlacklist =
		{
			Handler = function (self, object)
				self:GetChildNetworkerById ("UserBlacklist"):SendFullUpdate ()
			end,
			Parameters = {}
		}
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end,
	
	FullUpdateHandler = function (self, object)
		self:AddChild (object:GetUserWhitelist (), "UserWhitelist", self:IsReceiver () and CAC.UserWhitelistReceiver or CAC.UserWhitelistSender)
		self:AddChild (object:GetUserBlacklist (), "UserBlacklist", self:IsReceiver () and CAC.UserBlacklistReceiver or CAC.UserBlacklistSender)
	end,
	
	ObjectChangedHandler = function (self, lastObject, object)
		if lastObject then
			self:RemoveChildById ("UserWhitelist")
			self:RemoveChildById ("UserBlacklist")
		end
		if object then
			self:AddChild (object:GetUserWhitelist (), "UserWhitelist", self:IsReceiver () and CAC.UserWhitelistReceiver or CAC.UserWhitelistSender)
			self:AddChild (object:GetUserBlacklist (), "UserBlacklist", self:IsReceiver () and CAC.UserBlacklistReceiver or CAC.UserBlacklistSender)
		end
	end
}

CAC.UserWhitelistSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.UserWhitelistSettings)
CAC.UserWhitelistSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.UserWhitelistSettings)

CAC.SerializerRegistry:RegisterSerializable ("UserWhitelistSettings", 1)

function self:ctor ()
	self.UserWhitelist = CAC.UserWhitelist ()
	self.UserWhitelist:AddEventListener ("Changed",
		function (_)
			self:DispatchEvent ("Changed")
		end
	)
	
	self.BlacklistEnabled    = false
	self.UserTrackingEnabled = true
	
	self.UserBlacklist = CAC.UserBlacklist ()
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	self.UserWhitelist:Serialize (outBuffer)
	
	outBuffer:Boolean (self:IsBlacklistEnabled    ())
	outBuffer:Boolean (self:IsUserTrackingEnabled ())
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.UserWhitelist:Deserialize (inBuffer)
	
	self:SetBlacklistEnabled    (inBuffer:Boolean ())
	self:SetUserTrackingEnabled (inBuffer:Boolean ())
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:GetUserWhitelist ():Copy (source:GetUserWhitelist ())
	
	self:SetBlacklistEnabled    (source:IsBlacklistEnabled    ())
	self:SetUserTrackingEnabled (source:IsUserTrackingEnabled ())
	
	return self
end

-- User whitelist
function self:GetUserWhitelist ()
	return self.UserWhitelist
end

function self:GetUserBlacklist ()
	return self.UserBlacklist
end

function self:IsBlacklistEnabled ()
	return self.BlacklistEnabled
end

function self:IsUserTrackingEnabled ()
	return self.UserTrackingEnabled
end

function self:SetBlacklistEnabled (blacklistEnabled)
	-- No.
	blacklistEnabled = false
	
	if self.BlacklistEnabled == blacklistEnabled then return self end
	
	self.BlacklistEnabled = blacklistEnabled
	
	self:DispatchEvent ("BlacklistEnabledChanged", self.BlacklistEnabled)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetUserTrackingEnabled (userTrackingEnabled)
	if self.UserTrackingEnabled == userTrackingEnabled then return self end
	
	self.UserTrackingEnabled = userTrackingEnabled
	
	self:DispatchEvent ("UserTrackingEnabled", self.UserTrackingEnabled)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:__call (...)
	return self:Clone (...)
end