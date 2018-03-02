local self = {}
CAC.UserBlacklist = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		VersionChanged (version)
			Fired when the version has changed.
		VersionTimestampChanged (versionTimestamp)
			Fired when the version timestamp has changed.
		Changed ()
			Fired when the blacklist has changed.
		Cleared ()
			Fired when the blacklist has been cleared.
		EntryAdded (BlacklistEntry blacklistEntry)
			Fired when a blacklist entry has been added.
		EntryRemoved (BlacklistEntry blacklistEntry)
			Fired when a blacklist entry has been removed.
		EntryChanged (BlacklistEntry blacklistEntry)
			Fired when a blacklist entry has been changed.
]]

CAC.UserBlacklist.Networking =
{
	Events =
	{
		VersionChanged          = { Handler = "SetVersion",             Parameters = { "StringN8" } },
		VersionTimestampChanged = { Handler = "SetVersionTimestamp",    Parameters = { "UInt32"   } },
		Cleared                 = { Handler = "Clear",                  Parameters = {} },
		
		EntryAdded =
		{
			Handler = function (self, object, steamId, displayName, reason, kickReason)
				local blacklistEntry = object:AddEntry (steamId, displayName, reason, kickReason)
				self:AddChild (blacklistEntry, blacklistEntry:GetSteamId (), self:IsReceiver () and CAC.BlacklistEntryReceiver or CAC.BlacklistEntrySender)
			end,
			ArgumentTransformer = function (self, blacklistEntry)
				return blacklistEntry:GetSteamId (), blacklistEntry:GetDisplayName (), blacklistEntry:GetReason (), blacklistEntry:GetKickReason ()
			end,
			Parameters = { "StringN8", "StringN8", "StringN8", "StringN8" }
		},
		EntryRemoved =
		{
			Handler = function (self, object, steamId, displayName, reason, kickReason)
				object:RemoveEntry (steamId)
				self:RemoveChildById (steamId)
			end,
			ArgumentTransformer = function (self, blacklistEntry)
				return blacklistEntry:GetSteamId ()
			end,
			Parameters = { "StringN8" }
		}
	},
	Commands =
	{
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end,
	
	FullUpdateHandler = function (self, object)
		for blacklistEntry in object:GetEnumerator () do
			self:AddChild (blacklistEntry, blacklistEntry:GetSteamId (), self:IsReceiver () and CAC.BlacklistEntryReceiver or CAC.BlacklistEntrySender)
		end
	end,
	
	ObjectChangedHandler = function (self, lastObject, object)
		if lastObject then
			self:ClearChildren ()
		end
		if object then
			for blacklistEntry in object:GetEnumerator () do
				self:AddChild (blacklistEntry, blacklistEntry:GetSteamId (), self:IsReceiver () and CAC.BlacklistEntryReceiver or CAC.BlacklistEntrySender)
			end
		end
	end
}

CAC.UserBlacklistSender   = CAC.CreateObjectSenderFactory   (CAC.UserBlacklist)
CAC.UserBlacklistReceiver = CAC.CreateObjectReceiverFactory (CAC.UserBlacklist)

CAC.SerializerRegistry:RegisterSerializable ("UserBlacklist", 1)

function self:ctor ()
	self.Version                 = ""
	self.VersionTimestamp        = 0
	
	self.BlacklistEntryCount     = 0
	self.BlacklistEntries        = {}
	self.OrderedBlacklistEntries = {}
	
	self.ChangedEventPending     = false
	self.ChangedEventsSuppressed = false
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8 (self.Version            )
	outBuffer:UInt32   (self.VersionTimestamp   )
	
	outBuffer:UInt32   (self.BlacklistEntryCount)
	
	for _, blacklistEntry in ipairs (self.OrderedBlacklistEntries) do
		blacklistEntry:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SuppressChangedEvent (true)
	
	self:SetVersion          (inBuffer:StringN8 ())
	self:SetVersionTimestamp (inBuffer:UInt32   ())
	
	self:Clear ()
	
	local blacklistEntryCount = inBuffer:UInt32 ()
	for i = 1, blacklistEntryCount do
		local blacklistEntry = CAC.BlacklistEntry ()
		blacklistEntry:Deserialize (inBuffer)
		
		self:AddEntry (blacklistEntry)
	end
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
	
	self:SetVersion          (source:GetVersion          ())
	self:SetVersionTimestamp (source:GetVersionTimestamp ())
	
	self:Clear ()
	for blacklistEntry in source:GetEnumerator () do
		self:AddEntry (blacklistEntry:Clone ())
	end
	self:SuppressChangedEvent (false)
	
	return self
end

-- UserBlacklist
-- Version
function self:GetVersion ()
	return self.Version
end

function self:GetVersionTimestamp ()
	return self.VersionTimestamp
end

function self:SetVersion (version)
	if self.Version == version then return self end
	
	self.Version = version
	
	self:DispatchEvent ("VersionChanged", self.Version)
	self:DispatchChanged ()
	
	return self
end

function self:SetVersionTimestamp (versionTimestamp)
	if self.VersionTimestamp == versionTimestamp then return self end
	
	self.VersionTimestamp = versionTimestamp
	
	self:DispatchEvent ("VersionTimestampChanged", self.VersionTimestamp)
	self:DispatchChanged ()
	
	return self
end

function self:UpdateVersion ()
	local versionTimestamp = os.time ()
	local version          = os.date ("%Y-%m-%d", versionTimestamp)
	
	self:SetVersion          (version)
	self:SetVersionTimestamp (versionTimestamp)
end

-- Entries
function self:AddEntry (steamId, displayName, reason, kickReason)
	if istable (steamId) then
		local blacklistEntry = steamId
		steamId = blacklistEntry:GetSteamId ()
		
		if self:ContainsEntry (steamId) then
			self:GetEntry (steamId):Copy (blacklistEntry)
		else
			self.BlacklistEntryCount = self.BlacklistEntryCount + 1
			self.BlacklistEntries [steamId] = blacklistEntry
			self.OrderedBlacklistEntries [#self.OrderedBlacklistEntries + 1] = blacklistEntry
			
			self:HookBlacklistEntry (blacklistEntry)
			
			self:DispatchEvent ("EntryAdded", blacklistEntry)
			self:DispatchChanged ()
		end
	else
		local blacklistEntry = self:GetEntry (steamId) or CAC.BlacklistEntry (steamId)
		blacklistEntry:SetDisplayName (displayName)
		blacklistEntry:SetReason      (reason     )
		blacklistEntry:SetKickReason  (kickReason )
		
		if not self:ContainsEntry (steamId) then
			self.BlacklistEntryCount = self.BlacklistEntryCount + 1
			self.BlacklistEntries [steamId] = blacklistEntry
			self.OrderedBlacklistEntries [#self.OrderedBlacklistEntries + 1] = blacklistEntry
			
			self:HookBlacklistEntry (blacklistEntry)
			
			self:DispatchEvent ("EntryAdded", blacklistEntry)
			self:DispatchChanged ()
		end
	end
	
	return self.BlacklistEntries [steamId]
end

function self:Clear ()
	for _, blacklistEntry in pairs (self.BlacklistEntries) do
		self:UnhookBlacklistEntry (blacklistEntry)
		self:DispatchEvent ("EntryRemoved", blacklistEntry)
	end
	
	self.BlacklistEntryCount     = 0
	self.BlacklistEntries        = {}
	self.OrderedBlacklistEntries = {}
	
	self:DispatchEvent ("Cleared")
	self:DispatchChanged ()
end

function self:ContainsEntry (steamId)
	return self.BlacklistEntries [steamId] ~= nil
end

function self:GetEntry (steamId)
	return self.BlacklistEntries [steamId]
end

function self:GetEnumerator ()
	return CAC.ArrayEnumerator (self.OrderedBlacklistEntries)
end

function self:RemoveEntry (steamId)
	local blacklistEntry = self.BlacklistEntries [steamId]
	if not blacklistEntry then return end
	
	self:UnhookBlacklistEntry (blacklistEntry)
	
	self.BlacklistEntryCount = self.BlacklistEntryCount - 1
	self.BlacklistEntries [steamId] = nil
	
	for i = 1, #self.OrderedBlacklistEntries do
		if self.OrderedBlacklistEntries [i] == blacklistEntry then
			table.remove (self.OrderedBlacklistEntries, i)
			break
		end
	end
	
	self:DispatchEvent ("EntryRemoved", blacklistEntry)
	self:DispatchChanged ()
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

function self:HookBlacklistEntry (blacklistEntry)
	if not blacklistEntry then return end
	
	blacklistEntry:AddEventListener ("Changed", "CAC.UserBlacklist." .. self:GetHashCode (),
		function (_)
			self:DispatchEvent ("EntryChanged", blacklistEntry)
		end
	)
end

function self:UnhookBlacklistEntry (blacklistEntry)
	if not blacklistEntry then return end
	
	blacklistEntry:RemoveEventListener ("Changed", "CAC.UserBlacklist." .. self:GetHashCode ())
end