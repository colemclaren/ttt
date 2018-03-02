local self = {}
CAC.MaestroBanSystem = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "MaestroBanSystem"
end

function self:GetName ()
	return "Maestro"
end

function self:IsAvailable ()
	return istable (maestro)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	maestro.ban (userId, duration, reason)
end

function self:CanBanOfflineUsers ()
	return true
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.MaestroBanSystem ())