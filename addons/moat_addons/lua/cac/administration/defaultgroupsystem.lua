local self = {}
CAC.DefaultGroupSystem = CAC.MakeConstructor (self, CAC.SimpleReadOnlyGroupSystem)

local defaultGroups =
{
	["user"      ] = { BaseGroup = nil,     Color = Color (127, 127, 127, 255), DisplayName = "Users",                Icon = "icon16/user.png"       },
	["admin"     ] = { BaseGroup = "user",  Color = Color (255, 127,   0, 255), DisplayName = "Administrators",       Icon = "icon16/shield.png"     },
	["superadmin"] = { BaseGroup = "admin", Color = Color (255,   0,   0, 255), DisplayName = "Super Administrators", Icon = "icon16/shield_add.png" }
}

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:GetId ()
	return "DefaultGroupSystem"
end

function self:GetName ()
	return "Default"
end

function self:IsAvailable ()
	return true
end

function self:IsDefault ()
	return true
end

-- Groups
function self:GetGroupEnumerator ()
	return CAC.KeyEnumerator (defaultGroups)
end

function self:GroupExists (groupId)
	return defaultGroups [groupId] ~= nil
end

function self:GetBaseGroup (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return defaultGroups [groupId].BaseGroup
end

-- Group
function self:GetGroupColor (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return defaultGroups [groupId].Color
end

function self:GetGroupDisplayName (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return defaultGroups [groupId].DisplayName
end

function self:GetGroupIcon (groupId)
	if not self:GroupExists (groupId) then return nil end
	
	return defaultGroups [groupId].Icon
end

-- Users
function self:GetUserGroup (userId)
	local ply = CAC.PlayerMonitor:GetUserEntity (userId)
	if ply and not ply:IsValid () then ply = nil end
	
	if not ply then return "user" end
	
	if ply:IsSuperAdmin () then return "superadmin" end
	if ply:IsAdmin      () then return "admin"      end
	
	return "user"
end

CAC.SystemRegistry:RegisterSystem ("GroupSystem", CAC.DefaultGroupSystem ())