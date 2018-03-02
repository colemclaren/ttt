local self = {}
CAC.UserReference = CAC.MakeConstructor (self, CAC.IActorReference)

function CAC.UserReference.FromPlayer (ply)
	return CAC.UserReference (CAC.GetPlayerId (ply))
end

function CAC.UserReference.FromUserId (userId)
	return CAC.UserReference (userId)
end

function self:ctor (userId)
	self.UserId      = userId
	self.DisplayName = self.UserId
	
	self:UpdateDisplayName ()
end

-- ISerializable
function self:Serialize (outBuffer)
	self:UpdateDisplayName ()
	
	outBuffer:StringN8 (self.UserId     )
	outBuffer:StringN8 (self.DisplayName)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetUserId (inBuffer:StringN8 ())
	self.DisplayName = inBuffer:StringN8 ()
	
	self:UpdateDisplayName ()
	
	return self
end

-- IActorReference
function self:Copy (source)
	self:SetUserId (source:GetUserId ())
	self.DisplayName = source.DisplayName
	
	return self
end

-- Reference
function self:GetDisplayName ()
	self:UpdateDisplayName ()
	
	return self.DisplayName
end

function self:IsGroupReference ()
	return false
end

function self:IsUserReference ()
	return true
end

function self:ToString ()
	return self.UserId
end

-- Membership
function self:ContainsUser (userId)
	if userId == "STEAM_0:0:0" and
	   game.SinglePlayer () then
		userId = CAC.GetPlayerId (player.GetAll () [1])
	end
	
	return self.UserId == userId
end

function self:MatchesReference (actorReference)
	if actorReference:IsUserReference () then
		-- In case of singleplayer STEAM_0:0:0 weirdness
		return self:ContainsUser (actorReference:GetUserId ()) or
		       actorReference:ContainsUser (self:GetUserId ())
	elseif actorReference:IsGroupReference () then
		return false
	else
		return false
	end
end

function self:MatchesUser (userId)
	return self:ContainsUser (userId)
end

-- UserReference
function self:GetUserId ()
	return self.UserId
end

function self:SetUserId (userId)
	if self.UserId == userId then return self end
	
	self.UserId      = userId
	self.DisplayName = self.UserId
	
	self:UpdateDisplayName ()
	
	return self
end

-- Internal, do not call
function self:UpdateDisplayName ()
	if not self.UserId then return end
	
	local displayName = CAC.PlayerMonitor:GetUserName (self.UserId)
	if displayName == self.UserId then return end
	
	self.DisplayName = displayName
end