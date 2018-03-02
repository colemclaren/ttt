local self = {}
CAC.IncidentManagerReceiver = CAC.MakeConstructor (self)

--[[
	Events:
		CreateOutBuffer ()
			Fired when an OutBuffer instance is needed.
		DispatchPacket (OutBuffer packet)
			Fired when a packet needs to be dispatched.
]]

function self:ctor (incidentManager)
	self.IncidentManager = nil
	
	self.IncidentReceiver      = CAC.IncidentReceiver     ()
	self.LiveIncidentReceivers = {}
	
	self.ReplyHandlers         = {}
	self.NextReplyHandlerId    = 0
	
	CAC.EventProvider (self)
	
	self:SetIncidentManager (incidentManager)
end

function self:dtor ()
	self:SetIncidentManager (nil)
end

function self:GetIncidentManager ()
	return self.IncidentManager
end

function self:SetIncidentManager (incidentManager)
	self.IncidentManager = incidentManager
	return self
end

function self:HandlePacket (inBuffer, incidentManager)
	incidentManager = incidentManager or self:GetIncidentManager ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if not self [handlerMethodName] then
		CAC.Error ("CAC.IncidentManagerReceiver:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName))
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, incidentManager)
end

function self:HandleFullUpdate (inBuffer, incidentManager)
	incidentManager:DeserializeLiveIncidents (inBuffer)
	
	for liveIncident in incidentManager:GetLiveIncidentEnumerator () do
		self:AddLiveIncident (liveIncident)
	end
end

function self:HandleReply (inBuffer, incidentManager)
	local replyId = inBuffer:UInt32 ()
	local replyHandler = self.ReplyHandlers [replyId]
	
	if not replyHandler then
		CAC.Error ("CAC.IncidentManagerReceiver:HandleReply : Unhandled reply ID " .. string.format ("0x%08x", replyId))
		return
	end
	
	local moreData = replyHandler (inBuffer, incidentManager)
	if not moreData then
		self.ReplyHandlers [replyId] = nil
	end
end

function self:HandleIncidentCreated (inBuffer, incidentManager)
	local incidentId = inBuffer:UInt32 ()
	
	local incident = incidentManager:CreateIncident (incidentId)
	incident:Deserialize (inBuffer)
	
	self:DispatchEvent ("RequestPlayerSession", incident:GetPlayerSteamId (), incident:GetSessionId ())
end

function self:HandleLiveIncidentCreated (inBuffer, incidentManager)
	local incidentId = inBuffer:UInt32 ()
	
	local incident = incidentManager:CreateIncident (incidentId)
	incident:Deserialize (inBuffer)
	
	local liveIncident = incidentManager:CreateLiveIncident (incidentId)
	liveIncident:Deserialize (inBuffer)
	
	self:AddLiveIncident (liveIncident)
end

function self:HandleLiveIncidentDestroyed (inBuffer, incidentManager)
	local incidentId = inBuffer:UInt32 ()
	
	local liveIncident = incidentManager:GetLiveIncident (incidentId)
	incidentManager:DestroyLiveIncident (liveIncident)
	
	self:RemoveLiveIncident (liveIncident)
end

function self:HandleIncident (inBuffer, incidentManager)
	local incidentId = inBuffer:UInt32 ()
	local incident   = incidentManager:GetIncident (incidentId)
	
	self.IncidentReceiver:HandlePacket (inBuffer, incident)
end

function self:HandleLiveIncident (inBuffer, incidentManager)
	local incidentId   = inBuffer:UInt32 ()
	
	self.LiveIncidentReceivers [incidentId]:HandlePacket (inBuffer)
end

function self:SendIncidentRangeRequest (steamId, nameSearchTerm, dataRange, callback)
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8 ("IncidentRangeRequest")
	outBuffer:UInt32 (self:CreateReplyHandler (
		function (inBuffer, incidentManager)
			local hasPrevious   = inBuffer:Boolean ()
			local hasNext       = inBuffer:Boolean ()
			
			local incidents     = {}
			local incidentCount = inBuffer:UInt16 ()
			for i = 1, incidentCount do
				local incidentId = inBuffer:UInt32 ()
				
				local incident = incidentManager:CreateIncident (incidentId)
				incident:Deserialize (inBuffer)
				
				self:DispatchEvent ("RequestPlayerSession", incident:GetPlayerSteamId (), incident:GetSessionId ())
				
				incidents [#incidents + 1] = incident
			end
			
			table.sort (incidents,
				function (a, b)
					return a:GetId () > b:GetId ()
				end
			)
			
			callback (incidents, hasPrevious, hasNext)
		end
	))
	
	outBuffer:StringN8 (steamId or "")
	outBuffer:StringN8 (nameSearchTerm or "")
	
	dataRange:Serialize (outBuffer)
	
	self:DispatchEvent ("DispatchPacket", outBuffer)
end

function self:SendIncidentRequest (steamId, incidentId, callback)
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8 ("IncidentRequest")
	outBuffer:UInt32 (self:CreateReplyHandler (
		function (inBuffer, incidentManager)
			local success = inBuffer:Boolean ()
			if success then
				local incidentId = inBuffer:UInt32 ()
				
				local incident = incidentManager:CreateIncident (incidentId)
				incident:Deserialize (inBuffer)
				
				self:DispatchEvent ("RequestPlayerSession", incident:GetPlayerSteamId (), incident:GetSessionId ())
				
				callback (incident)
			else
				callback (nil)
			end
		end
	))
	
	outBuffer:StringN8 (steamId)
	outBuffer:UInt32 (incidentId)
	self:DispatchEvent ("DispatchPacket", outBuffer)
end

function self:CreateReplyHandler (callback)
	local replyHandlerId = self.NextReplyHandlerId
	self.ReplyHandlers [replyHandlerId] = callback
	
	self.NextReplyHandlerId = self.NextReplyHandlerId + 1
	if self.NextReplyHandlerId >= 65536 then
		self.NextReplyHandlerId = 1
	end
	
	return replyHandlerId
end

function self:AddLiveIncident (liveIncident)
	local incidentId = liveIncident:GetId ()
	
	if self.LiveIncidentReceivers [incidentId] then return end
	
	local liveIncidentReceiver = CAC.LiveIncidentReceiver (liveIncident)
	
	self.LiveIncidentReceivers [incidentId] = liveIncidentReceiver
	self.LiveIncidentReceivers [incidentId]:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("LiveIncident") outBuffer:UInt32 (incidentId) return outBuffer end)
	self.LiveIncidentReceivers [incidentId]:AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
end

function self:RemoveLiveIncident (liveIncident)
	local incidentId = liveIncident:GetId ()
	
	self.LiveIncidentReceivers [incidentId]:dtor ()
	self.LiveIncidentReceivers [incidentId] = nil
end

function self:__call (...)
	return self.__ictor (...)
end

CAC.IncidentManagerReceiver = CAC.IncidentManagerReceiver ()