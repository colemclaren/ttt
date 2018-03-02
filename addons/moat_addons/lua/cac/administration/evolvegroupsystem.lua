local self = {}
CAC.EvolveGroupSystem = CAC.MakeConstructor (self, CAC.SimpleReadOnlyGroupSystem)

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:GetId ()
	return "EvolveGroupSystem"
end

function self:GetName ()
	return "Evolve"
end

function self:IsAvailable ()
	return istable (evolve)
end

-- Groups
function self:GetGroupEnumerator ()
	return CAC.KeyEnumerator (evolve.ranks)
end

function self:GroupExists (groupId)
	return evolve.ranks [groupId] ~= nil
end

function self:GetBaseGroup (groupId)
	return nil
end

-- Group
function self:GetGroupColor (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return evolve.ranks [groupId].Color
end

function self:GetGroupDisplayName (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return evolve.ranks [groupId].Title
end

function self:GetGroupIcon (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return "icon16/" .. evolve.ranks [groupId].Icon .. ".png"
end

-- Users
function self:GetUserGroup (userId)
	local ply = CAC.PlayerMonitor:GetUserEntity (userId)
	if ply and not ply:IsValid () then ply = nil end
	
	if ply then
		return ply:GetNWString ("EV_UserGroup")
	end
	
	local uniqueId = CAC.SteamIdToUniqueId (userId)
	return evolve:GetProperty (uniqueId, "Rank")
end

CAC.SystemRegistry:RegisterSystem ("GroupSystem", CAC.EvolveGroupSystem ())