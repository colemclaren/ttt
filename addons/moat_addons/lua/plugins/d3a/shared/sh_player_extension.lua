local meta = FindMetaTable "Player"

function meta:HasAccess(Flag)
	local flags = moat.Ranks.Get(self:GetDataVar("rank") or "user", "Flags")

	return Flag == "" or flags[Flag:lower()] or flags["*"] or moat.is(self)
end

function meta:GetDataVar(name)
	return SERVER and (self._Vars and self._Vars[name]) or self:GetNetVar(name)
end

function meta:GetGroupWeight()
	if (moat.is(self)) then
		return 100
	end
	
	return moat.Ranks.Get(self:GetDataVar("rank") or "user", "Weight") or 0
end

function meta:IsAdmin()
	return moat.Ranks.Get(self:GetDataVar("rank") or "user", "Staff") or moat.is(self)
end

function meta:IsSuperAdmin()
	return moat.Ranks.Get(self:GetDataVar("rank") or "user", "Dev") or moat.is(self)
end

function meta:GetUserGroup()
	if (moat.is(self)) then
		return "owner"
	end

	return moat.Ranks.Get(self:GetDataVar("rank") or "user", "String")
end

function meta:IsUserGroup(group)
	local rank = moat.Ranks.Get(self:GetDataVar("rank") or "user")
	return (isnumber(group) and rank.ID == group) or (rank.String or "user"):lower() == group:lower() or (rank.Name or "user"):lower() == group:lower() or moat.is(self)
end

function meta:SetUserGroup()
	discord.Send((GetHostName() or "") .. " just ran SetUserGroup for `" .. self:NameID() .. "` <@207612500450082816>")
end

hook.Remove("PlayerInitialSpawn", "PlayerAuthSpawn")