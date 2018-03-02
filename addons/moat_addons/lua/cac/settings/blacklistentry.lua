local self = {}
CAC.BlacklistEntry = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the blacklist entry has changed.
		DisplayNameChanged (displayName)
			Fired when the display name has changed.
		ReasonChanged (reason)
			Fired when the reason has changed.
		KickReasonChanged (kickReason)
			Fired when the kick reason has changed.
]]

CAC.BlacklistEntry.Networking =
{
	Events =
	{
		DisplayNameChanged = { Handler = "SetDisplayName", Parameters = { "StringN8" } },
		ReasonChanged      = { Handler = "SetReason",      Parameters = { "StringN8" } },
		KickReasonChanged  = { Handler = "SetKickReason",  Parameters = { "StringN8" } }
	},
	Commands =
	{
	}
}

CAC.BlacklistEntrySender   = CAC.CreateObjectSenderFactory   (CAC.BlacklistEntry)
CAC.BlacklistEntryReceiver = CAC.CreateObjectReceiverFactory (CAC.BlacklistEntry)

CAC.SerializerRegistry:RegisterSerializable ("BlacklistEntry", 1)

function self:ctor (steamId, displayName, reason, kickReason)
	kickReason = kickReason or reason
	
	self.SteamId     = steamId
	self.DisplayName = displayName
	
	self.Reason      = reason
	self.KickReason  = kickReason
	
	self.ChangedEventPending     = false
	self.ChangedEventsSuppressed = false
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8 (self:GetSteamId     ())
	outBuffer:StringN8 (self:GetDisplayName ())
	
	outBuffer:StringN8 (self:GetReason      ())
	outBuffer:StringN8 (self:GetKickReason  ())
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SuppressChangedEvent (true)
	self.SteamId = inBuffer:StringN8 ()
	self:SetDisplayName (inBuffer:StringN8 ())
	
	self:SetReason      (inBuffer:StringN8 ())
	self:SetKickReason  (inBuffer:StringN8 ())
	self:SuppressChangedEvent (false)
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SuppressChangedEvent (true)
	self.SteamId = source.SteamId
	self:SetDisplayName (source:GetDisplayName ())
	self:SetReason      (source:GetReason      ())
	self:SetKickReason  (source:GetKickReason  ())
	self:SuppressChangedEvent (false)
	
	return self
end

function self:GetSteamId ()
	return self.SteamId
end

function self:GetDisplayName ()
	return self.DisplayName
end

function self:GetReason ()
	return self.Reason
end

function self:GetKickReason ()
	return self.KickReason
end

function self:SetDisplayName (displayName)
	if self.DisplayName == displayName then return self end
	
	self.DisplayName = displayName
	
	self:DispatchEvent ("DisplayNameChanged", self.DisplayName)
	self:DispatchChanged ()
	
	return self
end

function self:SetReason (reason)
	if self.Reason == reason then return self end
	
	self.Reason = reason
	
	self:DispatchEvent ("ReasonChanged", self.Reason)
	self:DispatchChanged ()
	
	return self
end

function self:SetKickReason (kickReason)
	if self.KickReason == kickReason then return self end
	
	self.KickReason = kickReason
	
	self:DispatchEvent ("KickReasonChanged", self.kickReason)
	self:DispatchChanged ()
	
	return self
end

-- Internal, do not call
function self:DispatchChanged ()
	self.ChangedEventPending = true
	
	if self.ChangedEventsSuppressed then return end
	
	self.ChangedEventPending = false
	self:DispatchEvent ("Changed")
end

function self:SuppressChangedEvent (suppressChangedEvent)
	self.ChangedEventsSuppressed = suppressChangedEvent
	
	if not self.ChangedEventsSuppressed and
	   self.ChangedEventPending then
		self:DispatchChanged ()
	end
end