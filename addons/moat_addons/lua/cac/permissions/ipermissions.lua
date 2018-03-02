local self = {}
CAC.Permissions.IPermissions = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor ()
end

function self:GetPermissionAccess (actorReference, permissionId)
	CAC.Error ("IPermission:GetPermissionAccess : Not implemented.")
end