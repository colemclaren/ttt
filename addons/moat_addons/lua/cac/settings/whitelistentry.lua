local self = {}
CAC.WhitelistEntry = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the whitelist entry has changed.
		WhitelistStatusChanged (whitelistStatus)
]]

CAC.WhitelistEntry.Networking =
{
	Events =
	{
		WhitelistStatusChanged = { Handler = "SetWhitelistStatus", Parameters = { "UInt8" } }
	},
	Commands =
	{
		SetWhitelistStatus     = { Handler = "SetWhitelistStatus", Parameters = { "UInt8" } }
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end
}

CAC.WhitelistEntrySender   = CAC.CreateObjectSenderFactory   (CAC.WhitelistEntry)
CAC.WhitelistEntryReceiver = CAC.CreateObjectReceiverFactory (CAC.WhitelistEntry)

CAC.SerializerRegistry:RegisterSerializable ("WhitelistEntry", 1)

function self:ctor (actorReference, whitelistStatus)
	whitelistStatus = whitelistStatus or CAC.WhitelistStatus.SuppressResponse
	
	self.ActorReference  = actorReference
	self.WhitelistStatus = whitelistStatus
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	CAC.IActorReference.Serialize (outBuffer, self.ActorReference)
	outBuffer:UInt8 (self.WhitelistStatus)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.ActorReference = CAC.IActorReference.Deserialize (inBuffer)
	self.WhitelistStatus = inBuffer:UInt8 ()
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self.ActorReference = source:GetActorReference ():Clone ()
	self:SetWhitelistStatus (source:GetWhitelistStatus ())
	
	return self
end

function self:GetActorReference ()
	return self.ActorReference
end

function self:GetWhitelistStatus ()
	return self.WhitelistStatus
end

function self:MatchesUser (userId)
	return self.ActorReference:MatchesUser (userId)
end

function self:SetWhitelistStatus (whitelistStatus)
	if self.WhitelistStatus == whitelistStatus then return self end
	
	self.WhitelistStatus = whitelistStatus
	
	self:DispatchEvent ("WhitelistStatusChanged", self.WhitelistStatus)
	self:DispatchEvent ("Changed")
	
	return self
end