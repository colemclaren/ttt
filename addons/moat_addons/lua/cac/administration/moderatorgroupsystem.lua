local self = {}
CAC.ModeratorGroupSystem = CAC.MakeConstructor (self, CAC.SimpleReadOnlyGroupSystem)

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:GetId ()
	return "ModeratorGroupSystem"
end

function self:GetName ()
	return "Moderator"
end

function self:IsAvailable ()
	return istable (moderator)
end

-- Groups
function self:GetGroupEnumerator ()
	return CAC.KeyEnumerator (moderator.groups)
end

function self:GroupExists (groupId)
	return moderator.groups [groupId] ~= nil
end

function self:GetBaseGroup (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return moderator.groups [groupId].inherit
end

-- Group
function self:GetGroupColor (groupId)
	return nil
end

function self:GetGroupDisplayName (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return moderator.groups [groupId].name
end

function self:GetGroupIcon (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	if not moderator.groups [groupId].icon then return nil end
	
	return "icon16/" .. moderator.groups [groupId].icon .. ".png"
end

-- Users
function self:GetUserGroup (userId)
	local ply = CAC.PlayerMonitor:GetUserEntity (userId)
	if ply and not ply:IsValid () then ply = nil end
	
	if not ply then return nil end
	
	return moderator.GetGroup (ply)
end

CAC.SystemRegistry:RegisterSystem ("GroupSystem", CAC.ModeratorGroupSystem ())