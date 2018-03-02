local self = {}
CAC.ClockworkBanSystem = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "ClockworkBanSystem"
end

function self:GetName ()
	return "Clockwork"
end

function self:IsAvailable ()
	return istable (Clockwork)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	Clockwork.bans:Add (userId, duration, reason)
end

function self:CanBanOfflineUsers ()
	return true
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.ClockworkBanSystem ())