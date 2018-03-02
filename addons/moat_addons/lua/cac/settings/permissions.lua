CAC.Permissions = CAC.Permissions or {}

-- To change permissions, uncomment the lines marked below

-- Uncomment these lines:
CAC.Permissions.ViewMenu       = { "STEAM_0:0:46558052" }
CAC.Permissions.ChangeSettings = { "STEAM_0:0:46558052" }

-- eg. { "admin", "superadmin" }
-- eg. { "STEAM_0:1:1234", "admin", "STEAM_0:1:4321" }

function CAC.Permissions.PlayerHasPermission (ply, permissionName)
	if not ply            then return false end
	if not ply:IsValid () then return false end
	
	local permissionTable = CAC.Permissions [permissionName]
	if not permissionTable then return ply:IsAdmin () or ply:IsSuperAdmin () end
	
	local steamId = ply:SteamID ()
	for _, groupId in ipairs (permissionTable) do
		if groupId == steamId then return true end
		if ply:IsUserGroup (groupId) then return true end
	end
	
	return false
end
