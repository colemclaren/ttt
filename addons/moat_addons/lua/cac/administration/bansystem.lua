local self = {}
CAC.BanSystem = CAC.MakeConstructor (self, CAC.IBanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:IsDefault ()
	return false
end

-- Bans
function self:IsUserBanned (userId)
	return false
end

function self:GetCurrentBan (userId)
	return nil
end

function self:GetBanReason (banId)
	return nil
end

function self:GetBanTimeRemaining (banId)
	return nil
end

function self:GetBannerId (banId)
	return nil
end
