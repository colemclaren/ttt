local self = {}
CAC.ServerGuardGroupSystem = CAC.MakeConstructor (self, CAC.SimpleReadOnlyGroupSystem)

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:GetId ()
	return "ServerGuardGroupSystem"
end

function self:GetName ()
	return "ServerGuard"
end

function self:IsAvailable ()
	return istable (serverguard)
end

-- Groups
function self:GetGroupEnumerator ()
	return CAC.KeyEnumerator (serverguard.ranks:GetStored ())
end

function self:GroupExists (groupId)
	return serverguard.ranks:GetStored () [groupId] ~= nil
end

function self:GetBaseGroup (groupId)
	return nil
end

-- Group
function self:GetGroupColor (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return serverguard.ranks:GetStored () [groupId].color
end

function self:GetGroupDisplayName (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return serverguard.ranks:GetStored () [groupId].name
end

function self:GetGroupIcon (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return serverguard.ranks:GetStored () [groupId].texture
end

-- Users
function self:GetUserGroup (userId)
	local ply = CAC.PlayerMonitor:GetUserEntity (userId)
	if ply and not ply:IsValid () then ply = nil end
	
	if not ply then return nil end
	
	return serverguard.player:GetRank (ply)
end

CAC.SystemRegistry:RegisterSystem ("GroupSystem", CAC.ServerGuardGroupSystem ())