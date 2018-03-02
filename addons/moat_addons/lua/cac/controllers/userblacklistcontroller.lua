local self = {}
CAC.UserBlacklistController = CAC.MakeConstructor (self)

function self:ctor (logger)
	self.UserBlacklistStatus = CAC.UserBlacklistStatus ()
end

function self:GetUserBlacklistStatus ()
	return self.UserBlacklistStatus
end
