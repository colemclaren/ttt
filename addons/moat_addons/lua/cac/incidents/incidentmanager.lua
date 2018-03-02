local self = {}
CAC.IncidentManager = CAC.MakeConstructor (self)

--[[
	Events:
		IncidentCreated (Incident incident)
			Fired when an Incident has been created.
		IncidentDestroyed (Incident incident)
			Fired when an Incident has been destroyed.
		LiveIncidentCreated (LiveIncident liveIncident)
			Fired when a LiveIncident has been created.
		LiveIncidentDestroyed (LiveIncident liveIncident)
			Fired when a LiveIncident has been destroyed.
]]

function self:ctor ()
	self.Database          = CAC.Databases.SqliteDatabase ()
	self.Database:Query (CAC.Incident.GenerateTableCreationQuery ())
	
	self.Incidents         = {}
	self.UnsavedIncidents  = CAC.WeakKeyTable ()
	
	self.LiveIncidents     = {}
	self.LiveIncidentCount = 0
	
	CAC.EventProvider (self)
	
	if SERVER then
		timer.Create ("CAC.IncidentManager.SaveIncidents", 1, 0,
			function ()
				for incident, _ in pairs (self.UnsavedIncidents) do
					self:SaveIncident (incident)
					self.UnsavedIncidents [incident] = nil
				end
			end
		)
	end
end

function self:dtor ()
	if SERVER then
		timer.Destroy ("CAC.IncidentManager.SaveIncidents")
	end
end

function self:SerializeLiveIncidents (outBuffer)
	outBuffer:UInt16 (self:GetLiveIncidentCount ())
	
	for liveIncident in self:GetLiveIncidentEnumerator () do
		outBuffer:UInt32 (liveIncident:GetId ())
		liveIncident:GetIncident ():Serialize (outBuffer)
		liveIncident:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:DeserializeLiveIncidents (inBuffer)
	local liveIncidentCount = inBuffer:UInt16 ()
	
	for i = 1, liveIncidentCount do
		local incidentId = inBuffer:UInt32 ()
		
		local incident = self:CreateIncident (incidentId)
		incident:Deserialize (inBuffer)
		
		local liveIncident = self:CreateLiveIncident (incidentId)
		liveIncident:Deserialize (inBuffer)
	end
	
	return self
end

function self:AddIncidentExistenceListener (nameOrCallback, callback)
	callback = callback or nameOrCallback
	
	for incident in self:GetIncidentEnumerator () do
		callback (self, incident)
	end
	
	self:AddEventListener ("IncidentCreated", nameOrCallback, callback)
end

function self:RemoveIncidentExistenceListener (nameOrCallback)
	self:RemoveEventListener ("IncidentCreated", nameOrCallback)
end

function self:AddLiveIncidentExistenceListener (nameOrCallback, callback)
	callback = callback or nameOrCallback
	
	for liveIncident in self:GetLiveIncidentEnumerator () do
		callback (self, liveIncident)
	end
	
	self:AddEventListener ("LiveIncidentCreated", nameOrCallback, callback)
end

function self:RemoveLiveIncidentExistenceListener (nameOrCallback)
	self:RemoveEventListener ("LiveIncidentCreated", nameOrCallback)
end

function self:CreateIncident (id)
	if self.Incidents [id] then
		return self.Incidents [id]
	end
	
	local incident = CAC.Incident ()
	incident:SetId (id)
	
	self.Incidents [id] = incident
	
	self:HookIncident (incident)
	
	self:DispatchEvent ("IncidentCreated", incident)
	
	return incident
end

function self:CreateIncidentFromPlayerSession (playerSession, timestamp)
	timestamp = timestamp or os.time ()
	
	if playerSession:GetIncident () then
		return playerSession:GetIncident ()
	end
	
	local incident = CAC.Incident.FromPlayerSession (playerSession, timestamp)
	
	local success, result = self.Database:Query (incident:GenerateInsertQuery (self.Database) .. "; SELECT last_insert_rowid ();")
	
	if success then
		local id = tonumber (result [1] ["last_insert_rowid ()"])
		
		incident:SetId (id)
		playerSession:SetIncidentId (incident:GetId ())
		
		self.Incidents [id] = incident
		
		self:HookIncident (incident)
		
		self:DispatchEvent ("IncidentCreated", incident)
	end
	
	return incident
end

function self:GetIncident (id)
	return self.Incidents [id]
end

function self:GetIncidentEnumerator ()
	return CAC.ValueEnumerator (self.Incidents)
end

function self:IsLiveIncident (id)
	return self.LiveIncidents [id] ~= nil
end

function self:LoadIncident (id)
	if self.Incidents [id] then
		return self.Incidents [id]
	end
	
	local success, results = self.Database:Query (CAC.Incident.GenerateSelectQuery (id, self.Database))
	if not success then return nil end
	if not results then return nil end
	if not results [1] then return nil end
	
	return CAC.Incident.FromDatabaseRow (results [1])
end

function self:LoadIncidentRange (steamId, nameSearchTerm, dataRange)
	local query = CAC.Incident.GenerateRangeSelectQuery (steamId, nameSearchTerm, dataRange, self.Database)
	local success, results = self.Database:Query (query)
	
	if not success then return {} end
	if not results then return {} end
	
	for i = 1, #results do
		results [i] = CAC.Incident.FromDatabaseRow (results [i])
		if self.Incidents [results [i]:GetId ()] then
			results [i] = self.Incidents [results [i]:GetId ()]
		end
	end
	
	return results
end

function self:LoadIncidents (steamId, limit)
	limit = limit or 10
	
	local success, results = self.Database:Query (CAC.Incident.GenerateMultipleSelectQuery (steamId, limit, self.Database))
	if not success then return {} end
	if not results then return {} end
	
	for i = 1, #results do
		results [i] = CAC.Incident.FromDatabaseRow (results [i])
		if self.Incidents [results [i]:GetId ()] then
			results [i] = self.Incidents [results [i]:GetId ()]
		end
	end
	
	return results
end

function self:SaveIncident (incident)
	self.Database:Query (incident:GenerateUpdateQuery (self.Database))
	self.UnsavedIncidents [incident] = false
end

function self:CreateLiveIncident (id)
	if self.LiveIncidents [id] then
		return self.LiveIncidents [id]
	end
	
	local liveIncident = CAC.LiveIncident ()
	liveIncident:SetId (id)
	
	self.LiveIncidents [liveIncident:GetId ()] = liveIncident
	self.LiveIncidentCount = self.LiveIncidentCount + 1
	
	self:DispatchEvent ("LiveIncidentCreated", liveIncident)
	
	return liveIncident
end

function self:CreateLiveIncidentFromLivePlayerSession (livePlayerSession, timestamp)
	timestamp = timestamp or os.time ()
	
	if livePlayerSession:GetLiveIncident () then
		return livePlayerSession:GetLiveIncident ()
	end
	
	local incident = self:CreateIncidentFromPlayerSession (livePlayerSession:GetPlayerSession (), timestamp)
	
	local liveIncident = self:CreateLiveIncident (incident:GetId ())
	liveIncident:SetPlayer (livePlayerSession:GetPlayer ())
	
	return liveIncident
end

function self:DestroyLiveIncident (liveIncident)
	if not liveIncident then return end
	if not self.LiveIncidents [liveIncident:GetId ()] then return end
	
	self:SaveIncident (liveIncident:GetIncident ())
	
	self.LiveIncidents [liveIncident:GetId ()] = nil
	self.LiveIncidentCount = self.LiveIncidentCount - 1
	
	self:DispatchEvent ("LiveIncidentDestroyed", liveIncident)
end

function self:GetLiveIncident (id)
	return self.LiveIncidents [id]
end

function self:GetLiveIncidentCount ()
	return self.LiveIncidentCount
end

function self:GetLiveIncidentEnumerator ()
	return CAC.ValueEnumerator (self.LiveIncidents)
end

-- Internal, do not call
function self:HookIncident (incident)
	if not incident then return end
	
	incident:AddEventListener ("Changed", "CAC.IncidentManager." .. self:GetHashCode (),
		function (_)
			self.UnsavedIncidents [incident] = true
		end
	)
end

function self:UnhookIncident (incident)
	if not incident then return end
	
	incident:RemoveEventListener ("Changed", "CAC.IncidentManager." .. self:GetHashCode ())
end