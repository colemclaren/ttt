local self = {}
CAC.LivePlayerSessionManager = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		LivePlayerSessionCreated (userId, Player ply, LivePlayerSession livePlayerSession)
			Fired when a LivePlayerSession has been created.
		LivePlayerSessionDestroyed (userId, Player ply, LivePlayerSession livePlayerSession)
			Fired when a LivePlayerSession has been destroyed.
]]

function self:ctor ()
	self.LivePlayerSessions           = {}
	self.LivePlayerSessionsByPlayer   = {}
	
	self.UnresolvedLivePlayerSessions = {} -- set of LivePlayerSessions with missing Players
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32 (table.Count (self.LivePlayerSessions))
	for livePlayerSession in self:GetEnumerator () do
		outBuffer:UInt32 (livePlayerSession:GetUserId ())
		outBuffer:StringN8 (livePlayerSession:GetSteamId ())
		livePlayerSession:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local livePlayerSessionCount = inBuffer:UInt32 ()
	for i = 1, livePlayerSessionCount do
		local userId  = inBuffer:UInt32   ()
		local steamId = inBuffer:StringN8 ()
		
		local livePlayerSession = self.LivePlayerSessions [userId]
		if not self.LivePlayerSessions [userId] then
			livePlayerSession = CAC.LivePlayerSession (self, steamId, userId, nil, nil)
		end
		
		livePlayerSession:Deserialize (inBuffer)
		
		if not self.LivePlayerSessions [userId] then
			self.LivePlayerSessions [userId] = livePlayerSession
			if livePlayerSession:GetPlayer () then
				self.LivePlayerSessionsByPlayer [livePlayerSession:GetPlayer ()] = livePlayerSession
			else
				self.UnresolvedLivePlayerSessions [livePlayerSession] = true
			end
			
			self:DispatchEvent ("LivePlayerSessionCreated", userId, livePlayerSession:GetPlayer (), livePlayerSession)
		end
	end
	
	return self
end

-- LivePlayerSessionManager
function self:GetEnumerator ()
	return CAC.ValueEnumerator (self.LivePlayerSessions)
end

function self:CreateLivePlayerSession (userId, steamId, playerSession)
	if type (userId) == "Player" then
		userId = userId:UserID ()
	end
	
	if self.LivePlayerSessions [userId] then
		return self.LivePlayerSessions [userId]
	end
	
	local ply = self:GetPlayerFromUserId (userId)
	local livePlayerSession = CAC.LivePlayerSession (self, steamId, userId, ply, playerSession)
	
	self.LivePlayerSessions [userId] = livePlayerSession
	if livePlayerSession:GetPlayer () then
		self.LivePlayerSessionsByPlayer [livePlayerSession:GetPlayer ()] = livePlayerSession
	else
		self.UnresolvedLivePlayerSessions [livePlayerSession] = true
	end
	
	self:DispatchEvent ("LivePlayerSessionCreated", userId, ply, livePlayerSession)
	
	return livePlayerSession
end

function self:DestroyLivePlayerSession (userId)
	if type (userId) == "Player" then
		userId = userId:UserID ()
	end
	
	if not self.LivePlayerSessions [userId] then return end
	
	local livePlayerSession = self.LivePlayerSessions [userId]
	self.LivePlayerSessions [userId] = nil
	if livePlayerSession:GetPlayer () then
		self.LivePlayerSessionsByPlayer [livePlayerSession:GetPlayer ()] = nil
	end
	self.UnresolvedLivePlayerSessions [livePlayerSession] = nil
	
	local ply = self:GetPlayerFromUserId (userId)
	self:DispatchEvent ("LivePlayerSessionDestroyed", userId, ply, livePlayerSession)
	
	livePlayerSession:dtor ()
end

-- Gotta go fast, this is used by the TimeoutDetector,
-- which is invoked every SetupMove
function self:GetLivePlayerSession (userId)
	local livePlayerSession = self.LivePlayerSessionsByPlayer [userId] or self.LivePlayerSessions [userId]
	if livePlayerSession then return livePlayerSession end
	
	-- End of code that needs to be fast
	if type (userId) ~= "Player" then return nil end
	
	-- Check unresolved live player sessions
	for livePlayerSession, _ in pairs (self.UnresolvedLivePlayerSessions) do
		local ply = livePlayerSession:GetPlayer ()
		if ply then
			self.LivePlayerSessionsByPlayer [ply] = livePlayerSession
			self.UnresolvedLivePlayerSessions [livePlayerSession] = nil
			if ply == userId then return livePlayerSession end
		end
	end
	
	return livePlayerSession
end

function self:GetPlayerFromUserId (userId)
	for _, ply in ipairs (player.GetAll ()) do
		if ply:UserID () == userId then
			return ply
		end
	end
	
	return nil
end

CAC.LivePlayerSessionManager = CAC.LivePlayerSessionManager ()