local self = {}
CAC.ServerGuardBanSystem = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "ServerGuardBanSystem"
end

function self:GetName ()
	return "ServerGuard"
end

function self:IsAvailable ()
	return istable (serverguard)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	serverguard:BanPlayer (nil, userId, duration, reason, false)
end

function self:CanBanOfflineUsers ()
	return true
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.ServerGuardBanSystem ())