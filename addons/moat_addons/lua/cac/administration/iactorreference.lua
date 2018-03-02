local self = {}
CAC.IActorReference = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function CAC.IActorReference.Serialize (outBuffer, actorReference)
	if actorReference:IsUserReference () then
		outBuffer:UInt8 (1)
	elseif actorReference:IsGroupReference () then
		outBuffer:UInt8 (2)
	else
		outBuffer:UInt8 (0)
		CAC.Error ("IActorReference:Serialize : Unknown ActorReference type.")
	end
	
	actorReference:Serialize (outBuffer)
	
	return outBuffer
end

function CAC.IActorReference.Deserialize (inBuffer)
	local actorReference     = nil
	local actorReferenceType = inBuffer:UInt8 ()
	
	if actorReferenceType == 1 then
		actorReference = CAC.UserReference ()
	elseif actorReferenceType == 2 then
		actorReference = CAC.GroupReference ()
	else
		CAC.Error ("WhitelistEntry:Deserialize : Unknown ActorReference type (" .. actorReferenceType .. ").")
	end
	
	actorReference:Deserialize (inBuffer)
	
	return actorReference
end

function CAC.IActorReference.FromString (text)
	text = string.Trim (text)
	
	-- Steam ID
	if string.match (string.lower (text), "^steam_[0-9]+:[0-9]+:[0-9]+$") then
		return CAC.UserReference (text)
	end
	
	-- Community ID
	local url = string.lower (text)
	url = string.gsub (url, "^https?://", "")
	url = string.gsub (url, "^www%.", "")
	if string.match (url, "^steamcommunity.com/profiles/7656[0-9]+") then
		local communityId = string.match (url, "7656[0-9]+")
		return CAC.UserReference (util.SteamIDFrom64 (communityId))
	end
	
	-- Group
	local groupSystemId, groupId = string.match (text, "(.*)/(.*)")
	if groupSystemId and groupId then
		local groupReference = CAC.GroupReference (groupSystemId, groupId)
		
		if not groupReference:GetGroupSystem () then return nil end
		if not groupReference:GetGroupSystem ():GroupExists (groupReference:GetGroupId  ()) then return nil end
		
		return groupReference
	end
	
	return nil
end

function self:ctor ()
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	CAC.Error ("IActorReference:Copy : Not implemented.")
end

-- Reference
function self:GetDisplayName ()
	CAC.Error ("IActorReference:GetDisplayName : Not implemented.")
end

function self:IsGroupReference ()
	CAC.Error ("IActorReference:IsGroupReference : Not implemented.")
end

function self:IsUserReference ()
	CAC.Error ("IActorReference:IsUserReference : Not implemented.")
end

function self:ToString ()
	CAC.Error ("IActorReference:ToString : Not implemented.")
end

-- Membership
function self:ContainsUser (userId)
	CAC.Error ("IActorReference:ContainsUser : Not implemented.")
end

function self:MatchesReference (actorReference)
	CAC.Error ("IActorReference:MatchesReference :Not implemented.")
end

function self:MatchesUser (userId)
	CAC.Error ("IActorReference:MatchesUser : Not implemented.")
end