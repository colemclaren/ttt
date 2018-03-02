local self = {}
CAC.MaestroGroupSystem = CAC.MakeConstructor (self, CAC.SimpleReadOnlyGroupSystem)

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:GetId ()
	return "MaestroGroupSystem"
end

function self:GetName ()
	return "Maestro"
end

function self:IsAvailable ()
	return istable (maestro) and istable (maestro.ranks)
end

-- Groups
function self:GetGroupEnumerator ()
	return CAC.KeyEnumerator (maestro.ranks)
end

function self:GroupExists (groupId)
	return maestro.rankget (groupId) ~= nil
end

function self:GetBaseGroup (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	local baseGroupId = maestro.rankget (groupId).inherits
	if baseGroupId == groupId then return nil end
	
	return groupId
end

-- Group
function self:GetGroupColor (groupId)
	return nil
end

function self:GetGroupDisplayName (groupId)
	return groupId
end

function self:GetGroupIcon (groupId)
	return nil
end

-- Users
function self:GetUserGroup (userId)
	local ply = CAC.PlayerMonitor:GetUserEntity (userId)
	if ply and not ply:IsValid () then ply = nil end
	
	if not ply then return nil end
	
	return maestro.userrank (ply)
end

CAC.SystemRegistry:RegisterSystem ("GroupSystem", CAC.MaestroGroupSystem ())