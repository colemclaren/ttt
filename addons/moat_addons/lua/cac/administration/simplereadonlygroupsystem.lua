local self = {}
CAC.SimpleReadOnlyGroupSystem = CAC.MakeConstructor (self, CAC.IReadOnlyGroupSystem)

-- Each group can only have one base group maximum
-- Each user can only be in one group

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:IsDefault ()
	return false
end

-- Groups
function self:GetGroupReference (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return CAC.GroupReference (self:GetId (), groupId)
end

function self:GetBaseGroupEnumerator (groupId)
	return CAC.SingleValueEnumerator (self:GetBaseGroup (groupId))
end

function self:IsGroupSubsetOfGroup (groupId, baseGroupId)
	-- Does groupId inherit from baseGroupId?
	groupId = self:GetBaseGroup (groupId)
	
	while groupId do
		if groupId == baseGroupId then return true end
		
		groupId = self:GetBaseGroup (groupId)
	end
	
	return false
end

function self:IsGroupSupersetOfGroup (baseGroupId, groupId)
	-- Does groupId inherit from baseGroupId?
	return self:IsGroupSubsetOfGroup (groupId, baseGroupId)
end

-- Users
function self:GetUserGroupEnumerator (userId)
	return CAC.SingleValueEnumerator (self:GetUserGroup (groupId))
end

function self:IsUserInGroup (userId, groupId)
	local userGroupId = self:GetUserGroup (userId)
	if userGroupId == groupId then return true end
	
	return self:IsGroupSubsetOfGroup (userGroupId, groupId)
end