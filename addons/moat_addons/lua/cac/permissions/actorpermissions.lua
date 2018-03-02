local self = {}
CAC.Permissions.ActorPermissions = CAC.MakeConstructor (self, CAC.Permissions.IPermissions)

--[[
	Events:
		Changed ()
			Fired when the evaluted permissions have changed.
		Cleared ()
			Fired when the evaluated permissions have been cleared.
		PermissionAccessChanged (permissionId, Access access)
			Fired when a permission access has changed.
]]

CAC.Permissions.ActorPermissions.Networking =
{
	Events =
	{
		Cleared                 = { Handler = "Clear",               Parameters = {} },
		PermissionAccessChanged = { Handler = "SetPermissionAccess", Parameters = { "Nil", "StringN8", "UInt8" } }
	},
	Commands =
	{
		SetPermissionAccess     = { Handler = "SetPermissionAccess", Parameters = { "Nil", "StringN8", "UInt8" } }
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end,
}

-- Note that users will be able to change their own evaluated permissions, but only if they already
-- have the permissions to change permissions

CAC.Permissions.ActorPermissionsSender   = CAC.CreateObjectSenderFactory   (CAC.Permissions.ActorPermissions)
CAC.Permissions.ActorPermissionsReceiver = CAC.CreateObjectReceiverFactory (CAC.Permissions.ActorPermissions)

CAC.SerializerRegistry:RegisterSerializable ("ActorPermissions", 1)

function self:ctor ()
	self.Permissions = {}
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	for permissionId, access in pairs (self.Permissions) do
		outBuffer:StringN8 (permissionId)
		outBuffer:UInt8 (access)
	end
	
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local permissionId = inBuffer:StringN8 ()
	while permissionId ~= "" do
		local access = inBuffer:UInt8 ()
		self:SetPermissionAccess (permissionId, access)
		
		permissionId = inBuffer:StringN8 ()
	end
	
	return self
end

-- IPermissions
function self:GetPermissionAccess (actorReference, permissionId)
	return self.Permissions [permissionId] or CAC.Permissions.Access.None
end

-- ActorPermissions
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	for permissionId, access in source:GetEnumerator () do
		self:SetPermissionAccess (nil, permissionId, access)
	end
	
	return self
end

function self:Clear ()
	if not next (self.Permissions) then return end
	
	self.Permissions = {}
	
	self:DispatchEvent ("Cleared")
	self:DispatchEvent ("Changed")
end

function self:Evaluate (permissionDictionary, permissions, actorReference)
	for permissionId in permissionDictionary:GetEnumerator () do
		self:SetPermissionAccess (actorReference, permissionId, permissions:GetPermissionAccess (actorReference, permissionId))
	end
end

function self:GetEnumerator ()
	return CAC.KeyValueEnumerator (self.Permissions)
end

function self:SetPermissionAccess (actorReference, permissionId, access)
	if self.Permissions [permissionId] == access then return self end
	
	self.Permissions [permissionId] = access
	
	self:DispatchEvent ("PermissionAccessChanged", permissionId, access)
	self:DispatchEvent ("Changed")
	
	return self
end