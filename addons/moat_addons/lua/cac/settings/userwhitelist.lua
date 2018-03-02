local self = {}
CAC.UserWhitelist = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the whitelist has changed.
		Cleared ()
			Fired when the whitelist has been cleared.
		EntryAdded (WhitelistEntry whitelistEntry)
			Fired when a whitelist entry has been added.
		EntryRemoved (WhitelistEntry whitelistEntry)
			Fired when a whitelist entry has been removed.
		EntryChanged (WhitelistEntry whitelistEntry)
			Fired when a whitelist entry has been changed.
]]

CAC.UserWhitelist.Networking =
{
	Serializers   = { WhitelistEntry = function (outBuffer, object) return object:Serialize (outBuffer) end },
	Deserializers = { WhitelistEntry = function (inBuffer) return CAC.WhitelistEntry ():Deserialize (inBuffer) end },

	Events =
	{
		Cleared    = { Handler = "Clear", Parameters = {} },
		EntryAdded =
		{
			PreHandler = function (self, object, whitelistEntry)
				self:AddChild (whitelistEntry, whitelistEntry:GetActorReference ():ToString (), self:IsReceiver () and CAC.WhitelistEntryReceiver or CAC.WhitelistEntrySender)
			end,
			Handler = "AddEntry",
			Parameters = { "WhitelistEntry" }
		},
		EntryRemoved =
		{
			PreHandler = function (self, object, whitelistEntry)
				self:RemoveChild (whitelistEntry)
			end,
			Handler = "RemoveEntry",
			ArgumentTransformer = function (self, whitelistEntry)
				return whitelistEntry:GetActorReference ():ToString ()
			end,
			Parameters = { "StringN8" }
		}
	},
	Commands =
	{
		AddEntry = { Handler = "AddEntry", Parameters = { "WhitelistEntry" } },
		RemoveEntry =
		{
			Handler = "RemoveEntry",
			ArgumentTransformer = function (self, whitelistEntry)
				return whitelistEntry:GetActorReference ():ToString ()
			end,
			Parameters = { "StringN8" }
		},
		
		-- Full updates to the parent object may create entries without explicitly doing a full update on
		-- the UserWhitelist.
		EntryAdded =
		{
			Networked = false,
			PreHandler = function (self, object, whitelistEntry)
				self:AddChild (whitelistEntry, whitelistEntry:GetActorReference ():ToString (), self:IsReceiver () and CAC.WhitelistEntryReceiver or CAC.WhitelistEntrySender)
			end
		},
		EntryRemoved =
		{
			Networked = false,
			PreHandler = function (self, object, whitelistEntry)
				self:RemoveChild (whitelistEntry)
			end
		}
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end,
	
	FullUpdateHandler = function (self, object)
		for whitelistEntry in object:GetEnumerator () do
			self:AddChild (whitelistEntry, whitelistEntry:GetActorReference ():ToString (), self:IsReceiver () and CAC.WhitelistEntryReceiver or CAC.WhitelistEntrySender)
		end
	end,
	
	ObjectChangedHandler = function (self, lastObject, object)
		if lastObject then
			self:ClearChildren ()
		end
		if object then
			for whitelistEntry in object:GetEnumerator () do
				self:AddChild (whitelistEntry, whitelistEntry:GetActorReference ():ToString (), self:IsReceiver () and CAC.WhitelistEntryReceiver or CAC.WhitelistEntrySender)
			end
		end
	end
}

CAC.UserWhitelistSender   = CAC.CreateObjectSenderFactory   (CAC.UserWhitelist)
CAC.UserWhitelistReceiver = CAC.CreateObjectReceiverFactory (CAC.UserWhitelist)

CAC.SerializerRegistry:RegisterSerializable ("UserWhitelist", 1)

function self:ctor ()
	self.WhitelistEntryCount = 0
	self.WhitelistEntries    = {}
	
	self.EvaluationCache      = {}
	self.EvaluationCacheTimes = {} -- needed because group members can change without us knowing
	
	self.ChangedEventPending     = false
	self.ChangedEventsSuppressed = false
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32 (self.WhitelistEntryCount)
	
	for _, whitelistEntry in pairs (self.WhitelistEntries) do
		whitelistEntry:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SuppressChangedEvent (true)
	self:Clear ()
	
	local whitelistEntryCount = inBuffer:UInt32 ()
	for i = 1, whitelistEntryCount do
		local whitelistEntry = CAC.WhitelistEntry ()
		whitelistEntry:Deserialize (inBuffer)
		
		self:AddEntry (whitelistEntry)
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
	self:Clear ()
	for whitelistEntry in source:GetEnumerator () do
		self:AddEntry (whitelistEntry:Clone ())
	end
	self:SuppressChangedEvent (false)
	
	return self
end

-- UserWhitelist
function self:AddEntry (actorReference, whitelistStatus)
	if not whitelistStatus then
		local whitelistEntry = actorReference
		actorReference = whitelistEntry:GetActorReference ()
		
		if self:ContainsEntry (actorReference) then
			self:GetEntry (actorReference):Copy (whitelistEntry)
		else
			self.WhitelistEntryCount = self.WhitelistEntryCount + 1
			self.WhitelistEntries [actorReference:ToString ()] = whitelistEntry
			
			self:HookWhitelistEntry (whitelistEntry)
			
			self:InvalidateEvaluationCache ()
			
			self:DispatchEvent ("EntryAdded", whitelistEntry)
			self:DispatchChanged ()
		end
	else
		local whitelistEntry = self:GetEntry (actorReference:ToString ()) or CAC.WhitelistEntry (actorReference)
		whitelistEntry:SetWhitelistStatus (whitelistStatus)
		
		if not self:ContainsEntry (actorReference) then
			self.WhitelistEntryCount = self.WhitelistEntryCount + 1
			self.WhitelistEntries [actorReference:ToString ()] = whitelistEntry
			
			self:HookWhitelistEntry (whitelistEntry)
			
			self:InvalidateEvaluationCache ()
			
			self:DispatchEvent ("EntryAdded", whitelistEntry)
			self:DispatchChanged ()
		end
	end
	
	return self.WhitelistEntries [actorReference:ToString ()]
end

function self:Clear ()
	for _, whitelistEntry in pairs (self.WhitelistEntries) do
		self:UnhookWhitelistEntry (whitelistEntry)
		self:DispatchEvent ("EntryRemoved", whitelistEntry)
	end
	
	self.WhitelistEntryCount = 0
	self.WhitelistEntries    = {}
	
	self:InvalidateEvaluationCache ()
	
	self:DispatchEvent ("Cleared")
	self:DispatchChanged ()
end

function self:ContainsEntry (actorReference)
	if istable (actorReference) then
		actorReference = actorReference:ToString ()
	end
	
	return self.WhitelistEntries [actorReference] ~= nil
end

function self:GetEntry (actorReference)
	if istable (actorReference) then
		actorReference = actorReference:ToString ()
	end
	
	return self.WhitelistEntries [actorReference]
end

function self:GetEnumerator ()
	return CAC.ValueEnumerator (self.WhitelistEntries)
end

function self:RemoveEntry (actorReference)
	if not isstring (actorReference) then
		actorReference = actorReference:ToString ()
	end
	
	local whitelistEntry = self.WhitelistEntries [actorReference]
	if not whitelistEntry then return end
	
	self:UnhookWhitelistEntry (whitelistEntry)
	
	self.WhitelistEntryCount = self.WhitelistEntryCount - 1
	self.WhitelistEntries [actorReference] = nil
	
	self:InvalidateEvaluationCache ()
	
	self:DispatchEvent ("EntryRemoved", whitelistEntry)
	self:DispatchChanged ()
end

-- Evaluation
function self:GetUserWhitelistStatus (userId)
	if not self.EvaluationCache [userId] or
	   SysTime () - (self.EvaluationCacheTimes [userId] or 0) > 5 then
		local whitelistStatus = CAC.WhitelistStatus.Normal
		for whitelistEntry in self:GetEnumerator () do
			if whitelistEntry:MatchesUser (userId) then
				whitelistStatus = math.max (whitelistStatus, whitelistEntry:GetWhitelistStatus ())
			end
		end
		
		self.EvaluationCache      [userId] = whitelistStatus
		self.EvaluationCacheTimes [userId] = SysTime ()
	end
	
	return self.EvaluationCache [userId]
end

-- Internal, do not call
function self:InvalidateEvaluationCache ()
	self.EvaluationCache      = {}
	self.EvaluationCacheTimes = {}
end

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

function self:HookWhitelistEntry (whitelistEntry)
	if not whitelistEntry then return end
	
	whitelistEntry:AddEventListener ("Changed", "CAC.UserWhitelist." .. self:GetHashCode (),
		function (_)
			self:InvalidateEvaluationCache ()
			
			self:DispatchEvent ("EntryChanged", whitelistEntry)
			self:DispatchChanged ()
		end
	)
end

function self:UnhookWhitelistEntry (whitelistEntry)
	if not whitelistEntry then return end
	
	whitelistEntry:RemoveEventListener ("Changed", "CAC.UserWhitelist." .. self:GetHashCode ())
end
