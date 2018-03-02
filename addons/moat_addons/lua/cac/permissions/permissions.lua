local self = {}
CAC.Permissions.Permissions = CAC.MakeConstructor (self, CAC.Permissions.IPermissions)

--[[
	Events:
		Changed ()
			Fired when the permissions have changed.
		Cleared ()
			Fired when the permissions have been cleared.
		ActorPermissionsAdded (ActorReference actorReference, ActorPermissions actorPermissions)
			Fired when actor permissions have been added.
		ActorPermissionsRemoved (ActorReference actorReference)
			Fired when actor permissions have been removed.
]]

CAC.Permissions.Permissions.Networking =
{
	Serializers =
	{
		ActorReference   = CAC.IActorReference.Serialize,
		ActorPermissions = function (outBuffer, object) return object:Serialize (outBuffer) end
	},
	Deserializers =
	{
		ActorReference   = CAC.IActorReference.Deserialize,
		ActorPermissions = function (inBuffer) return CAC.Permissions.ActorPermissions ():Deserialize (inBuffer) end
	},
	
	Events =
	{
		Cleared                 = { Handler = "Clear", Parameters = {} },
		ActorPermissionsAdded =
		{
			PreHandler = function (self, object, actorReference, actorPermissions)
				self:AddChild (actorPermissions, actorReference:ToString (), self:IsReceiver () and CAC.Permissions.ActorPermissionsReceiver or CAC.Permissions.ActorPermissionsSender)
			end,
			Handler = "AddActorPermissions",
			Parameters = { "ActorReference", "ActorPermissions" }
		},
		ActorPermissionsRemoved =
		{
			PreHandler = function (self, object, actorReference)
				self:RemoveChildById (actorReference:ToString ())
			end,
			Handler = "RemoveActorPermissions",
			Parameters = { "ActorReference" }
		}
	},
	Commands =
	{
		AddActorPermissions     = { Handler = "AddActorPermissions",    Parameters = { "ActorReference" } },
		RemoveActorPermissions  = { Handler = "RemoveActorPermissions", Parameters = { "ActorReference" } },
		
		-- Full updates to the parent object may create actor permissions without explicitly doing a full update on
		-- the Permissions.
		ActorPermissionsAdded =
		{
			Networked = false,
			PreHandler = function (self, object, actorReference, actorPermissions)
				self:AddChild (actorPermissions, actorReference:ToString (), self:IsReceiver () and CAC.Permissions.ActorPermissionsReceiver or CAC.Permissions.ActorPermissionsSender)
			end
		},
		ActorPermissionsRemoved =
		{
			Networked = false,
			PreHandler = function (self, object, actorReference)
				self:RemoveChildById (actorReference:ToString ())
			end
		}
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end,
	
	FullUpdateHandler = function (self, object)
		for actorReference in object:GetEnumerator () do
			local actorPermissions = object:GetActorPermissions (actorReference)
			self:AddChild (actorPermissions, actorReference:ToString (), self:IsReceiver () and CAC.Permissions.ActorPermissionsReceiver or CAC.Permissions.ActorPermissionsSender)
		end
	end,
	
	ObjectChangedHandler = function (self, lastObject, object)
		if lastObject then
			self:ClearChildren ()
		end
		if object then
			for actorReference in object:GetEnumerator () do
				local actorPermissions = object:GetActorPermissions (actorReference)
				self:AddChild (actorPermissions, actorReference:ToString (), self:IsReceiver () and CAC.Permissions.ActorPermissionsReceiver or CAC.Permissions.ActorPermissionsSender)
			end
		end
	end
}

CAC.Permissions.PermissionsSender   = CAC.CreateObjectSenderFactory   (CAC.Permissions.Permissions)
CAC.Permissions.PermissionsReceiver = CAC.CreateObjectReceiverFactory (CAC.Permissions.Permissions)

CAC.SerializerRegistry:RegisterSerializable ("Permissions", 1)

function self:ctor ()
	self.ActorPermissionsCount     = 0
	self.ActorReferences           = {}
	self.ActorReferencePermissions = {}
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt16 (self.ActorReferenceCount)
	
	for actorReference in self:GetActorEnumerator () do
		local actorPermissions = self:GetActorPermissions (actorReference)
		
		CAC.IActorReference.Serialize (outBuffer, actorReference)
		actorPermissions:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local actorPermissionsCount = inBuffer:UInt16 ()
	
	for i = 1, actorPermissionCount do
		local actorReference   = CAC.IActorReference.Deserialize (inBuffer)
		local actorPermissions = CAC.Permissions.ActorPermissions ()
		actorPermissions:Deserialize (inBuffer)
		
		self:AddActorPermissions (actorReference, actorPermissions)
	end
	
	return self
end

-- IPermissions
function self:GetPermissionAccess (testActorReference, permissionId)
	local access = CAC.Permissions.Access.None
	
	for actorReference in self:GetActorEnumerator () do
		if actorReference:MatchesReference (testActorReference) then
			local actorPermissions = self:GetActorPermissions (actorReference)
			access = math.max (access, actorPermissions:GetPermissionAccess (testActorReference, permissionId))
		end
	end
end

-- Permissions
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:Clear ()
	for actorReference in source:GetActorEnumerator () do
		self:AddActorPermissions (actorReference, source:GetActorPermissions (actorReference))
	end
	
	return self
end

function self:AddActorPermissions (actorReference, actorPermissions)
	local existingActorPermissions = self:GetActorPermissions (actorReference)
	if existingActorPermissions then
		if actorPermissions then
			existingActorPermissions:Copy (actorPermissions)
		end
		
		return existingActorPermissions
	else
		actorPermissions = actorPermissions or CAC.Permissions.ActorPermissions ()
		
		self.ActorReferences [actorReference:ToString ()] = actorReference
		self.ActorReferencePermissions [actorReference:ToString ()] = actorPermissions
		self.ActorPermissionsCount = self.ActorPermissionsCount + 1
		
		self:HookActorPermissions (actorPermissions)
		
		self:DispatchEvent ("ActorPermissionsAdded", actorReference, actorPermissions)
		self:DispatchEvent ("Changed")
		
		return actorPermissions
	end
end

function self:Clear ()
	if self.ActorPermissionsCount == 0 then return end
	
	for actorReference in self:GetActorEnumerator () do
		local actorPermissions = self.ActorReferencePermissions [actorReference:ToString ()]
		self:UnhookActorPermissions (actorPermissions)
		self:DispatchEvent ("ActorPermissionsRemoved", actorReference)
	end
	
	self.ActorPermissionsCount     = 0
	self.ActorReferences           = {}
	self.ActorReferencePermissions = {}
	
	self:DispatchEvent ("Cleared")
	self:DispatchEvent ("Changed")
end

function self:ContainsActorPermissions (actorReference)
	return self.ActorReferencePermissions [actorReference:ToString ()] ~= nil
end

function self:Evaluate (testActorReference)
	local evaluatedActorPermissions = CAC.Permissions.ActorPermissions ()
	
	for actorReference in self:GetActorEnumerator () do
		if actorReference:MatchesReference (testActorReference) then
			local actorPermissions = self:GetActorPermissions (actorReference)
			for permissionId, access in actorPermissions:GetEnumerator () do
				evaluatedActorPermissions:SetPermissionAccess (testActorReference, permissionId, math.max (access, actorPermissions:GetPermissionAccess (testActorReference, permissionId)))
			end
		end
	end
	
	return evaluatedActorPermissions
end

function self:GetActorEnumerator ()
	return CAC.ValueEnumerator (self.ActorReferences)
end

function self:GetActorPermissions (actorReference)
	return self.ActorReferencePermissions [actorReference:ToString ()]
end

function self:RemoveActorPermissions (actorReference)
	if not self:ContainsActorPermissions (actorReference) then return end
	
	self:UnhookActorPermissions (self.ActorReferencePermissions [actorReference:ToString ()])
	
	self.ActorReferences [actorReference:ToString ()] = nil
	self.ActorReferencePermissions [actorReferenec:ToString ()] = nil
	self.ActorPermissionsCount = self.ActorPermissionsCount - 1
	
	self:DispatchEvent ("ActorPermissionsRemoved", actorReference)
	self:DispatchEvent ("Changed")
end

-- Internal, do not call
function self:HookActorPermissions (actorPermissions)
	if not actorPermissions then return end
	
	actorPermissions:AddEventListener ("Changed", "Permissions." .. self:GetHashCode (),
		function (_)
			self:DispatchEvent ("Changed")
		end
	)
end

function self:UnhookActorPermissions (actorPermissions)
	if not actorPermissions then return end
	
	actorPermissions:RemoveEventListener ("Changed", "Permissions." .. self:GetHashCode ())
end