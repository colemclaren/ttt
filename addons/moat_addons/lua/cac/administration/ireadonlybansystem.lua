local self = {}
CAC.IReadOnlyBanSystem = CAC.MakeConstructor (self)

function self:ctor ()
end

function self:GetId ()
	CAC.Error ("IReadOnlyBanSystem:GetId : Not implemented.")
end

function self:GetName ()
	CAC.Error ("IReadOnlyBanSystem:GetName : Not implemented.")
end

function self:IsAvailable ()
	CAC.Error ("IReadOnlyBanSystem:IsAvailable : Not implemented.")
end

function self:IsDefault ()
	CAC.Error ("IReadOnlyBanSystem:IsDefault : Not implemented.")
end

-- Bans
function self:IsUserBanned (userId)
	CAC.Error ("IReadOnlyBanSystem:IsUserBanned : Not implemented.")
end

function self:GetCurrentBan (userId)
	CAC.Error ("IReadOnlyBanSystem:GetCurrentBan : Not implemented.")
end

function self:GetBanReason (banId)
	CAC.Error ("IReadOnlyBanSystem:GetBanReason : Not implemented.")
end

function self:GetBanTimeRemaining (banId)
	CAC.Error ("IReadOnlyBanSystem:GetBanTimeRemaining : Not implemented.")
end

function self:GetBannerId (banId)
	CAC.Error ("IReadOnlyBanSystem:GetBannerId : Not implemented.")
end