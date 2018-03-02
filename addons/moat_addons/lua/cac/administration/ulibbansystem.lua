local self = {}
CAC.ULibBanSystem = CAC.MakeConstructor (self, CAC.IBanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "ULibBanSystem"
end

function self:GetName ()
	return "ULX"
end

function self:IsAvailable ()
	return istable (ULib)
end

function self:IsDefault ()
	return false
end

-- Bans
function self:IsUserBanned (userId)
	local banInfo = ULib.bans [userId]
	if not banInfo then return false end
	
	if banInfo.unban == 0 then return true end
	
	return os.time () <= banInfo.unban
end

function self:GetCurrentBan (userId)
	if self:IsUserBanned (userId) then return userId end
	return nil
end

function self:GetBanReason (banId)
	local banInfo = ULib.bans [banId]
	if not banInfo then return nil end
	
	return banInfo.reason
end

function self:GetBanTimeRemaining (banId)
	local banInfo = ULib.bans [banId]
	if not banInfo then return nil end
	
	if banInfo.unban == 0 then return math.huge end
	
	return os.time () - banInfo.unban
end

function self:GetBannerId (banId)
	local banInfo = ULib.bans [banId]
	if not banInfo then return nil end
	
	if banInfo.admin_name == "(Console)" then return "Console" end
	
	local bannerId = string.match (banInfo.adminName, "%(([^%(%)]+)%)$")
	return bannerId
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	local banner = CAC.PlayerMonitor:GetUserEntity (bannerId) or NULL
	if not banner:IsValid () then banner = NULL end
	
	ulx.banid (banner, userId, duration / 60, reason)
end

function self:CanBanOfflineUsers ()
	return true
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.ULibBanSystem ())