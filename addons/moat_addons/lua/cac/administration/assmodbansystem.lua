local self = {}
CAC.ASSModBanSystem = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "ASSModBanSystem"
end

function self:GetName ()
	return "ASSMod"
end

function self:IsAvailable ()
	return isfunction (ASS_BanPlayer)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	local banner = CAC.PlayerMonitor:GetUserEntity (bannerId) or NULL
	if not banner:IsValid () then banner = NULL end
	
	ASS_BanPlayer(banner, CAC.SteamIdToUniqueId (userId), duration / 60, reason)
end

function self:CanBanOfflineUsers ()
	return false
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.ASSModBanSystem ())