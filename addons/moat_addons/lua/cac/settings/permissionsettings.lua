local self = {}
CAC.PermissionSettings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
]]

CAC.PermissionSettings.Networking =
{
	Events =
	{
	},
	Commands =
	{
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end,
	
	FullUpdateHandler = function (self, object)
		self:AddChild (object:GetPermissions (), "Permissions", self:IsReceiver () and CAC.PermissionsReceiver or CAC.PermissionsSender)
	end,
	
	ObjectChangedHandler = function (self, lastObject, object)
		if lastObject then
			self:RemoveChildById ("Permissions")
		end
		if object then
			self:AddChild (object:GetPermissions (), "Permissions", self:IsReceiver () and CAC.PermissionsReceiver or CAC.PermissionsSender)
		end
	end
}

CAC.PermissionSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.PermissionSettings)
CAC.PermissionSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.PermissionSettings)

CAC.SerializerRegistry:RegisterSerializable ("PermissionSettings", 1)

function self:ctor ()
	self.Permissions = CAC.Permissions.Permissions ()
	self.Permissions:AddEventListener ("Changed",
		function (_)
			self:DispatchEvent ("Changed")
		end
	)
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	self.Permissions:Serialize (outBuffer)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Permissions:Deserialize (inBuffer)
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:GetPermissions ():Copy (source:GetPermissions ())
	
	return self
end

-- Permissions
function self:GetPermissions ()
	return self.Permissions
end