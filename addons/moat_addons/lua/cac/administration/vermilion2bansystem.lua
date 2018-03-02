local self = {}
CAC.Vermilion2BanSystem = CAC.MakeConstructor (self, CAC.IBanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "Vermilion2BanSystem"
end

function self:GetName ()
	return "Vermilion 2"
end

function self:IsAvailable ()
	return istable (Vermilion) and
	       istable (Vermilion.Modules) and
	       istable (Vermilion.Modules.bans)
end

function self:IsDefault ()
	return false
end

-- Bans
function self:IsUserBanned (userId)
	local banInfo = Vermilion.Modules.bans:GetBanData (userId)
	if not banInfo then return false end
	
	if banInfo.ExpiryTime == 0 then return true end
	
	return os.time () <= banInfo.ExpiryTime
end

function self:GetCurrentBan (userId)
	if self:IsUserBanned (userId) then return userId end
	
	return nil
end

function self:GetBanReason (banId)
	if not self:IsUserBanned (banId) then return nil end
	
	local banInfo = Vermilion.Modules.bans:GetBanData (banId)
	if not banInfo then return nil end
	
	return banInfo.Reason
end

function self:GetBanTimeRemaining (banId)
	if not self:IsUserBanned (banId) then return nil end
	
	local banInfo = Vermilion.Modules.bans:GetBanData (banId)
	if not banInfo then return nil end
	
	if banInfo.ExpiryTime == 0 then return math.huge end
	
	return math.max (0, os.time () - banInfo.ExpiryTime)
end

function self:GetBannerId (banId)
	if not self:IsUserBanned (banId) then return nil end
	
	local banInfo = Vermilion.Modules.bans:GetBanData (banId)
	if not banInfo then return nil end
	
	local bannerId = banInfo.BannerSteamID
	if bannerId == "VERMILION" then
		bannerId = "Server"
	end
	
	return bannerId
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	local ply = CAC.PlayerMonitor:GetUserEntity (userId) or NULL
	if not ply:IsValid () then ply = NULL end
	
	local banner = CAC.PlayerMonitor:GetUserEntity (bannerId) or NULL
	if not banner:IsValid () then banner = NULL end
	
	Vermilion.Modules.bans:BanPlayer (ply, banner, duration, reason)
end

function self:CanBanOfflineUsers ()
	return false
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.Vermilion2BanSystem ())