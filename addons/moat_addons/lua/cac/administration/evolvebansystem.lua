local self = {}
CAC.EvolveBanSystem = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "EvolveBanSystem"
end

function self:GetName ()
	return "Evolve"
end

function self:IsAvailable ()
	return istable (evolve)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	local bannerUniqueId = 0
	if bannerId then bannerUniqueId = CAC.SteamIdToUniqueId (bannerId) end
	
	evolve:Ban (CAC.SteamIdToUniqueId (userId), banDuration, reason, bannerUniqueId)
end

function self:CanBanOfflineUsers ()
	return true
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.EvolveBanSystem ())