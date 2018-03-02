local self = {}
CAC.IReadOnlyGroupSystem = CAC.MakeConstructor (self)

function self:ctor ()
end

function self:GetId ()
	CAC.Error ("IReadOnlyGroupSystem:GetId : Not implemented.")
end

function self:GetName ()
	CAC.Error ("IReadOnlyGroupSystem:GetName : Not implemented.")
end

function self:IsAvailable ()
	CAC.Error ("IReadOnlyGroupSystem:IsAvailable : Not implemented.")
end

function self:IsDefault ()
	CAC.Error ("IReadOnlyGroupSystem:IsDefault : Not implemented.")
end

-- Groups
function self:GetGroupEnumerator ()
	CAC.Error ("IReadOnlyGroupSystem:GetGroupEnumerator : Not implemented.")
end

function self:GroupExists (groupId)
	CAC.Error ("IReadOnlyGroupSystem:GroupExists : Not implemented.")
end

function self:GetBaseGroup (groupId)
	CAC.Error ("IReadOnlyGroupSystem:GetBaseGroup : Not implemented.")
end

function self:GetBaseGroupEnumerator (groupId)
	CAC.Error ("IReadOnlyGroupSystem:GetBaseGroupEnumerator : Not implemented.")
end

function self:IsGroupSubsetOfGroup (baseGroupId, groupId)
	CAC.Error ("IReadOnlyGroupSystem:IsGroupSubsetOfGroup : Not implemented.")
end

function self:IsGroupSupersetOfGroup (groupId, baseGroupId)
	CAC.Error ("IReadOnlyGroupSystem:IsGroupSupersetOfGroup : Not implemented.")
end

-- Group
function self:GetGroupColor (groupId)
	CAC.Error ("IReadOnlyGroupSystem:GetGroupColor : Not implemented.")
end

function self:GetGroupDisplayName (groupId)
	CAC.Error ("IReadOnlyGroupSystem:GetGroupDisplayName : Not implemented.")
end

function self:GetGroupIcon (groupId)
	CAC.Error ("IReadOnlyGroupSystem:GetGroupIcon : Not implemented.")
end

-- Users
function self:GetUserGroup (userId)
	CAC.Error ("IReadOnlyGroupSystem:GetUserGroup : Not implemented.")
end

function self:GetUserGroupEnumerator (userId)
	CAC.Error ("IReadOnlyGroupSystem:GetUserGroupEnumerator : Not implemented.")
end

function self:IsUserInGroup (userId, groupId)
	CAC.Error ("IReadOnlyGroupSystem:IsUserInGroup : Not implemented.")
end