local self = {}
CAC.ULibGroupSystem = CAC.MakeConstructor (self, CAC.SimpleReadOnlyGroupSystem)

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:GetId ()
	return "ULibGroupSystem"
end

function self:GetName ()
	return "ULX"
end

function self:IsAvailable ()
	return istable (ULib) and istable (ULib.ucl)
end

-- Groups
function self:GetGroupEnumerator ()
	return CAC.KeyEnumerator (ULib.ucl.groups)
end

function self:GroupExists (groupId)
	return ULib.ucl.groups [groupId] ~= nil
end

function self:GetBaseGroup (groupId)
	local baseGroupId = ULib.ucl.groupInheritsFrom (groupId)
	
	if baseGroupId == false then return nil end
	
	return baseGroupId
end

-- Group
function self:GetGroupColor (groupId)
	if groupId == ULib.ACCESS_SUPERADMIN or self:IsGroupSubsetOfGroup (groupId, ULib.ACCESS_SUPERADMIN) then return Color (255,   0,   0, 255) end
	if groupId == ULib.ADMIN             or self:IsGroupSubsetOfGroup (groupId, ULib.ACCESS_ADMIN     ) then return Color (255, 127,   0, 255) end
	
	return Color (127, 127, 127, 255)
end

function self:GetGroupDisplayName (groupId)
	return groupId
end

function self:GetGroupIcon (groupId)
	if groupId == ULib.ACCESS_SUPERADMIN or self:IsGroupSubsetOfGroup (groupId, ULib.ACCESS_SUPERADMIN) then return "icon16/shield_add.png" end
	if groupId == ULib.ACCESS_ADMIN      or self:IsGroupSubsetOfGroup (groupId, ULib.ACCESS_ADMIN     ) then return "icon16/shield.png"     end
	
	return "icon16/user.png"
end

-- Users
function self:GetUserGroup (userId)
	local ply = CAC.PlayerMonitor:GetUserEntity (userId)
	if ply and not ply:IsValid () then ply = nil end
	
	if not ply then return ULib.ACCESS_ALL end
	
	return ply:GetUserGroup ()
end

CAC.SystemRegistry:RegisterSystem ("GroupSystem", CAC.ULibGroupSystem ())