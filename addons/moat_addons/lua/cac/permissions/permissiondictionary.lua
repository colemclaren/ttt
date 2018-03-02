local self = {}
CAC.Permissions.PermissionDictionary = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the permission dictionary has changed.
		Cleared
			Fired when the permission dictionary has been cleared.
		PermissionAdded (id, displayName, description)
			Fired when a permission has been added.
		PermissionRemoved (id)
			Fired when a permission has been removed.
		PermissionDisplayNameChanged (id, displayName)
			Fired when a permission's display name has been changed.
		PermissionDescriptionChanged (id, description)
			Fired when a permission's description has been changed.
]]

CAC.Permissions.PermissionDictionary.Networking =
{
	Events =
	{
		Cleared                      = { Handler = "Clear",                    Parameters = {} },
		PermissionAdded              = { Handler = "AddPermission",            Parameters = { "StringN8", "StringN32", "StringN32" } },
		PermissionRemoved            = { Handler = "RemovePermission",         Parameters = { "StringN8" } },
		PermissionDisplayNameChanged = { Handler = "SetPermissionDisplayName", Parameters = { "StringN8", "StringN32" } },
		PermissionDescriptionChanged = { Handler = "SetPermissionDescription", Parameters = { "StringN8", "StringN32" } }
	},
	Commands = {}
}

CAC.Permissions.PermissionDictionarySender   = CAC.CreateObjectSenderFactory   (CAC.Permissions.PermissionDictionary)
CAC.Permissions.PermissionDictionaryReceiver = CAC.CreateObjectReceiverFactory (CAC.Permissions.PermissionDictionary)


function self:ctor ()
	self.Permissions            = {}
	self.PermissionDisplayNames = {}
	self.PermissionDescriptions = {}
end

-- ISerializable
function self:Serialize (outBuffer)
	for id, _ in pairs (self.Permissions) do
		outBuffer:StringN8 (id)
		outBuffer:StringN32 (self.PermissionDisplayNames [id])
		outBuffer:StringN32 (self.PermissionDescriptions [id])
	end
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local id = inBuffer:StringN8 ()
	while id ~= "" do
		local displayName = inBuffer:StringN32 ()
		local description = inBuffer:StringN32 ()
		self:AddPermission (id, displayName, description)
		
		id = inBuffer:StringN8 ()
	end
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:Clear ()
	for id in source:GetEnumerator () do
		self:AddPermission (id, source:GetPermissionDisplayName (id), source:GetPermissionDescription (id))
	end
	
	return self
end

-- PermissionDictionary
function self:AddPermission (id, displayName, description)
	displayName = displayName or ""
	description = description or ""
	
	if not self.Permissions [id] then
		self.Permissions [id] = true
		self.PermissionDisplayNames [id] = displayName
		self.PermissionDescriptions [id] = description
		
		self:DispatchEvent ("PermissionAdded", id, self.PermissionDisplayNames [id], self.PermissionDescriptions [id])
		self:DispatchEvent ("Changed")
	else
		self:SetPermissionDisplayName (id, displayName)
		self:SetPermissionDescription (id, description)
	end
end

function self:Clear ()
	if not next (self.Permissions) then return end
	
	self.Permissions = {}
	self.PermissionDisplayNames = {}
	self.PermissionDescriptions = {}
	
	self:DispatchEvent ("Cleared")
	self:DispatchEvent ("Changed")
end

function self:GetEnumerator ()
	return CAC.KeyEnumerator (self.Permissions)
end

function self:GetPermissionDisplayName (id)
	return self.PermissionDisplayNames [id]
end

function self:GetPermissionDescription (id)
	return self.PermissionDescription [id]
end

function self:RemovePermission (id)
	if not self.Permissions [id] then return end
	
	self.Permissions [id] = nil
	self.PermissionDisplayNames [id] = nil
	self.PermissionDescriptions [id] = nil
	
	self:DispatchEvent ("PermissionRemoved")
	self:DispatchEvent ("Changed")
end

function self:SetPermissionDisplayName (id, displayName)
	displayName = displayName or ""
	
	if self.PermissionDisplayNames [id] == displayName then return self end
	
	self.PermissionDisplayNames [id] = displayName
	
	self:DispatchEvent ("PermissionDisplayNameChanged", id, self.PermissionDisplayNames [id])
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetPermissionDescription (id, description)
	description = description or ""
	
	if self.PermissionDescriptions [id] == description then return self end
	
	self.PermissionDescriptions [id] = description
	
	self:DispatchEvent ("PermissionDescriptionChanged", id, self.PermissionDescriptions [id])
	self:DispatchEvent ("Changed")
	
	return self
end