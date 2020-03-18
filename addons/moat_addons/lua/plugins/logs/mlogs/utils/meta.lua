local PLAYER = FindMetaTable "Player"

function PLAYER:Steam()
	return self:IsBot() and "0" or self:SteamID64()
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