local meta = FindMetaTable("Player")

function meta:HasAccess(Flag)
	if (Flag == "") then return true end
	
	Flag = Flag:lower()

	local flags = self:GetDataVar("rank") and self:GetDataVar("rank").Flags

	return (flags ~= nil) and ((flags["*"] or flags[Flag]) == true)
end

function meta:GetDataVar(name)
	return SERVER and (self._Vars and self._Vars[name]) or self:GetNetVar(name)
end

function meta:GetGroupWeight()
	return self:GetDataVar("rank") and self:GetDataVar("rank").Weight or 0
end

function meta:IsAdmin()
	return self:HasAccess(D3A.Config.IsAdmin)
end

function meta:IsSuperAdmin()
	return self:HasAccess(D3A.Config.IsSuperAdmin)
end

function meta:GetUserGroup()
	return self:GetDataVar("rank") and self:GetDataVar("rank").Name or "user"
end

function meta:IsUserGroup(group)
	return self:GetUserGroup():lower() == group:lower()
end

function meta:SetUserGroup() ErrorNoHalt("PLAYER:SetUserGroup() is not supported\n") end

function meta:NameID()
	return self:Name() .. " (" .. self:SteamID() .. ")"
end

hook.Remove("PlayerInitialSpawn", "PlayerAuthSpawn")