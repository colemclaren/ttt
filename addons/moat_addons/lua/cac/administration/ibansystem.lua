local self = {}
CAC.IBanSystem = CAC.MakeConstructor (self, CAC.IReadOnlyBanSystem)

function self:ctor ()
end

function self:Ban (userId, duration, reason, bannerId)
	CAC.Error ("IBanSystem:Ban : Not implemented.")
end

function self:CanBanOfflineUsers ()
	CAC.Error ("IBanSystem:CanBanOfflineUsers : Not implemented.")
end