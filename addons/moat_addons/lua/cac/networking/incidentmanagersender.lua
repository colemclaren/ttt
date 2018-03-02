local self = {}
CAC.IncidentManagerSender = CAC.MakeConstructor (self)

--[[
	Events:
		CreateOutBuffer ()
			Fired when an OutBuffer instance is needed.
		DispatchPacket (OutBuffer packet)
			Fired when a packet needs to be dispatched.
]]

function self:ctor (ply, incidentManager)
	self.Player = ply
	
	self.IncidentManager     = nil
	
	self.IncidentSenders     = {}
	self.LiveIncidentSenders = {}
	
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
	if self.IncidentManager == incidentManager then return self end
	
	if self.IncidentManager then
		self:UnhookIncidentManager (self.IncidentManager)
		
		for incidentId, liveIncidentSender in pairs (self.LiveIncidentSenders) do
			self:RemoveLiveIncident (liveIncidentSender:GetObject ())
		end
	end
	
	self.IncidentManager = incidentManager
	
	if self.IncidentManager then
		self:HookIncidentManager (self.IncidentManager)
		
		for liveIncident in self.IncidentManager:GetLiveIncidentEnumerator () do
			self:AddLiveIncident (liveIncident)
		end
	end
	
	return self
end

function self:HandlePacket (inBuffer, incidentManager)
	incidentManager = incidentManager or self:GetIncidentManager ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if not self [handlerMethodName] then
		CAC.Error ("CAC.IncidentManagerSender:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName))
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, incidentManager)
end

function self:HandleLiveIncident (inBuffer, incidentManager)
	local incidentId = inBuffer:UInt32 ()
	
	self.LiveIncidentSenders [incidentId]:HandlePacket (inBuffer)
end

function self:HandleIncidentRangeRequest (inBuffer, incidentManager)
	if not CAC.Permissions.PlayerHasPermission (self.Player, "ViewMenu") then return end
	
	local requestId      = inBuffer:UInt32 ()
	local steamId        = inBuffer:StringN8 ()
	local nameSearchTerm = inBuffer:StringN8 ()
	local dataRange      = CAC.DataRange ()
	dataRange:Deserialize (inBuffer)
	
	if steamId        == "" then steamId        = nil end
	if nameSearchTerm == "" then nameSearchTerm = nil end
	
	if dataRange:GetLimit () > 20 then
		-- nope.avi
		dataRange:SetLimit (20)
	end
	
	-- Query
	local incidents = incidentManager:LoadIncidentRange (steamId, nameSearchTerm, dataRange)
	
	if #incidents < dataRange:GetLimit () and
	   dataRange:GetDirection () == CAC.PageDirection.Previous then
		-- Hit the first page, realign
		incidents = incidentManager:LoadIncidentRange (steamId, nameSearchTerm, CAC.DataRange.FirstPage ():SetLimit (dataRange:GetLimit ()))
	end
	
	table.sort (incidents,
		function (a, b)
			return a:GetId () > b:GetId ()
		end
	)
	
	-- Send results
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8 ("Reply")
	outBuffer:UInt32 (requestId)
	
	if #incidents == 0 then
		outBuffer:Boolean (#incidentManager:LoadIncidentRange (steamId, nameSearchTerm, dataRange:Clone ():MovePreviousPage ():SetLimit (1)) > 0)
		outBuffer:Boolean (#incidentManager:LoadIncidentRange (steamId, nameSearchTerm, dataRange:Clone ():MoveNextPage     ():SetLimit (1)) > 0)
	else
		outBuffer:Boolean (#incidentManager:LoadIncidentRange (steamId, nameSearchTerm, CAC.DataRange.PreviousPage (incidents [1         ]:GetId (), 1)) > 0)
		outBuffer:Boolean (#incidentManager:LoadIncidentRange (steamId, nameSearchTerm, CAC.DataRange.NextPage     (incidents [#incidents]:GetId (), 1)) > 0)
	end
	
	outBuffer:UInt16 (#incidents)
	for _, incident in ipairs (incidents) do
		outBuffer:UInt32 (incident:GetId ())
		incident:Serialize (outBuffer)
		
		self:AddIncident (incident)
	end
	
	self:DispatchEvent ("DispatchPacket", outBuffer)
end

function self:HandleIncidentRequest (inBuffer, incidentManager)
	if not CAC.Permissions.PlayerHasPermission (self.Player, "ViewMenu") then return end
	
	local requestId      = inBuffer:UInt32 ()
	local steamId        = inBuffer:StringN8 ()
	local incidentId     = inBuffer:UInt32 ()
	
	-- Query
	local incident = nil
	if self.IncidentSenders [incidentId] then
		incident = self.IncidentSenders [incidentId]:GetObject ()
	else
		incident = incidentManager:LoadIncident (incidentId)
	end
	
	-- Send results
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8 ("Reply")
	outBuffer:UInt32 (requestId)
	
	if incident and
	   incident:GetPlayerSteamId () == steamId then
		outBuffer:Boolean (true)
		
		outBuffer:UInt32 (incident:GetId ())
		incident:Serialize (outBuffer)
		
		self:AddIncident (incident)
	else
		outBuffer:Boolean (false)
	end
	
	self:DispatchEvent ("DispatchPacket", outBuffer)
end

function self:SendFullUpdate ()
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8  ("FullUpdate")
	self:SerializeFullUpdate (outBuffer, self.IncidentManager)
	self:DispatchEvent  ("DispatchPacket", outBuffer)
end

function self:SerializeFullUpdate (outBuffer, incidentManager)
	incidentManager:SerializeLiveIncidents (outBuffer)
	
	return outBuffer
end

function self:HookIncidentManager (incidentManager)
	if not incidentManager then return end
	
	incidentManager:AddEventListener ("LiveIncidentCreated", "CAC.IncidentManagerSender." .. self:GetHashCode (),
		function (_, liveIncident)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8 ("LiveIncidentCreated")
			outBuffer:UInt32 (liveIncident:GetId ())
			liveIncident:GetIncident ():Serialize (outBuffer)
			liveIncident:Serialize (outBuffer)
			self:DispatchEvent ("DispatchPacket", outBuffer)
			
			self:AddLiveIncident (liveIncident)
		end
	)
	
	incidentManager:AddEventListener ("LiveIncidentDestroyed", "CAC.IncidentManagerSender." .. self:GetHashCode (),
		function (_, liveIncident)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8 ("LiveIncidentDestroyed")
			outBuffer:UInt32 (liveIncident:GetId ())
			self:DispatchEvent ("DispatchPacket", outBuffer)
			
			self:RemoveLiveIncident (liveIncident)
		end
	)
end

function self:UnhookIncidentManager (incidentManager)
	if not incidentManager then return end
	
	incidentManager:RemoveEventListener ("LiveIncidentCreated",   "CAC.IncidentManagerSender." .. self:GetHashCode ())
	incidentManager:RemoveEventListener ("LiveIncidentDestroyed", "CAC.IncidentManagerSender." .. self:GetHashCode ())
end

function self:AddIncident (incident)
	if self.IncidentSenders [incident:GetId ()] then return end
	
	local incidentSender = CAC.IncidentSender (self.Player, incident)
	
	self.IncidentSenders [incident:GetId ()] = incidentSender
	self.IncidentSenders [incident:GetId ()]:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("Incident") outBuffer:UInt32 (incident:GetId ()) return outBuffer end)
	self.IncidentSenders [incident:GetId ()]:AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
end

function self:RemoveIncident (incident)
	self.IncidentSenders [incident:GetId ()]:dtor ()
	self.IncidentSenders [incident:GetId ()] = nil
end

function self:AddLiveIncident (liveIncident)
	if self.LiveIncidentSenders [liveIncident:GetId ()] then return end
	
	self:AddIncident (liveIncident:GetIncident ())
	
	local liveIncidentSender = CAC.LiveIncidentSender (self.Player, liveIncident)
	
	self.LiveIncidentSenders [liveIncident:GetId ()] = liveIncidentSender
	self.LiveIncidentSenders [liveIncident:GetId ()]:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("LiveIncident") outBuffer:UInt32 (liveIncident:GetId ()) return outBuffer end)
	self.LiveIncidentSenders [liveIncident:GetId ()]:AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
end

function self:RemoveLiveIncident (liveIncident)
	self.LiveIncidentSenders [liveIncident:GetId ()]:dtor ()
	self.LiveIncidentSenders [liveIncident:GetId ()] = nil
	
	self:RemoveIncident (liveIncident)
end