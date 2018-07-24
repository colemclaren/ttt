local PLAYER = FindMetaTable "Player"

function PLAYER:Steam()
	return self:SteamID64() or (self:IsBot() and "77777777777" .. self:Nick():sub(4))
end

function PLAYER:CanUseLogs()
	local grp = self:GetUserGroup()
	if (mlogs.cfg.Groups[grp] == nil) then return GetRoundState() == ROUND_ACTIVE end
	if (not mlogs.cfg.Groups[grp] and self:IsSpec()) then return false end
	return true
end

function PLAYER:CanUseLogsManager()
	return mlogs.cfg.StaffGroups[self:GetUserGroup()]
end