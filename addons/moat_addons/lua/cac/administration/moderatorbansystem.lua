local self = {}
CAC.ModeratorBanSystem = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "ModeratorBanSystem"
end

function self:GetName ()
	return "Moderator"
end

function self:IsAvailable ()
	return istable (moderator)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	local ply = CAC.PlayerMonitor:GetUserEntity (userId) or NULL
	if not ply:IsValid () then ply = NULL end
	
	local banner = CAC.PlayerMonitor:GetUserEntity (bannerId) or NULL
	if not banner:IsValid () then banner = NULL end
	
	moderator.BanPlayer (ply:IsValid () and ply or userId, reason, duration, banner)
end

function self:CanBanOfflineUsers ()
	return false
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.ModeratorBanSystem ())