local self = {}
CAC.NetworkingHost = CAC.MakeConstructor (self)

function self:ctor (ply)
	self.Player = ply
	
	self.SubscribedLivePlayerSessionManager = nil
	self.SubscribedPlayerInformation  = {}
	self.SubscribedPlayerSessions     = {}
	self.SubscribedLivePlayerSessions = {}
	
	CAC.EventProvider (self)
	
	self.IncidentManagerSender = CAC.IncidentManagerSender (self.Player, CAC.Incidents)
	self.IncidentManagerSender:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = CAC.StringOutBuffer () outBuffer:StringN8 ("IncidentManager") return outBuffer end)
	self.IncidentManagerSender:AddEventListener ("DispatchPacket",  function (_, outBuffer) self:DispatchPacket (outBuffer) end)
	
	self.LuaScannerStatusSender = CAC.LuaScannerStatusSender (self.Player)
	self.LuaScannerStatusSender:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = CAC.StringOutBuffer () outBuffer:StringN8 ("LuaScannerStatus") return outBuffer end)
	self.LuaScannerStatusSender:AddEventListener ("DispatchPacket",  function (_, outBuffer) self:DispatchPacket (outBuffer) end)
	
	self.SettingsSender = CAC.SettingsSender (self.Player, CAC.Settings)
	self.SettingsSender:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = CAC.StringOutBuffer () outBuffer:StringN8 ("Settings") return outBuffer end)
	self.SettingsSender:AddEventListener ("DispatchPacket",  function (_, outBuffer) self:DispatchPacket (outBuffer) end)
end

function self:dtor ()
	self:UnhookLivePlayerSessionManager (self.SubscribedLivePlayerSessionManager)
	
	for playerInformation, _ in pairs (self.SubscribedPlayerInformation) do
		self:UnhookPlayerInformation (playerInformation)
	end
	
	for playerSession, _ in pairs (self.SubscribedPlayerSessions) do
		self:UnhookPlayerSession (playerSession)
	end
	
	for livePlayerSession, _ in pairs (self.SubscribedLivePlayerSessions) do
		self:UnhookLivePlayerSession (livePlayerSession)
	end
	
	self.SubscribedPlayerInformation  = {}
	self.SubscribedPlayerSessions     = {}
	self.SubscribedLivePlayerSessions = {}
	
	self.IncidentManagerSender :dtor ()
	self.LuaScannerStatusSender:dtor ()
	self.SettingsSender        :dtor ()
end

function self:GetObject ()
	return nil
end

-- Cisco Systems Incorporated
function self:DispatchPacket (outBuffer)
	local data = outBuffer:GetString ()
	
	net.Start (CAC.Identifiers.AdminChannelName)
		net.WriteUInt (#data, 16)
		net.WriteData (data, #data)
		if CAC.IsDebug then
			CAC.Logger:Message ("Sent admin UI data (" .. CAC.FormatFileSize (net.BytesWritten ()) .. ") to " .. self.Player:Nick () .. " (" .. self.Player:SteamID () .. ") via AdminChannel.")
		end
	net.Send (self.Player)
end

function self:HandlePacket (inBuffer, object)
	object = object or self:GetObject ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if handlerMethodName == "HandlePacket" then return end
	
	if not self [handlerMethodName] then
		CAC.Error ("CAC.NetworkingHost:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName))
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, object)
end

function self:HandleSubscribe (inBuffer)
	local target = inBuffer:StringN8 ()
	if target == "LivePlayerSessions" then
		local outBuffer = CAC.StringOutBuffer ()
		
		-- CheckRegistry
		CAC.Checks:Serialize (outBuffer)
		
		self.SubscribedLivePlayerSessionManager = CAC.LivePlayerSessionManager
		self:HookLivePlayerSessionManager (self.SubscribedLivePlayerSessionManager)
		
		-- PlayerInformation and PlayerSessions
		for livePlayerSession in CAC.LivePlayerSessionManager:GetEnumerator () do
			local playerSession     = livePlayerSession:GetPlayerSession ()
			local playerInformation = livePlayerSession:GetPlayerInformation ()
			
			self:SubscribePlayerInformation (playerInformation)
			self:SubscribePlayerSession     (playerSession    )
			self:SubscribeLivePlayerSession (livePlayerSession)
			
			outBuffer:StringN8 (livePlayerSession:GetPlayerInformation ():GetSteamId ())
			playerInformation:Serialize (outBuffer)
			
			outBuffer:UInt32 (livePlayerSession:GetPlayerSession ():GetSessionId ())
			playerSession:Serialize (outBuffer)
		end
		outBuffer:StringN8 ("")
		
		-- LivePlayerSessions
		CAC.LivePlayerSessionManager:Serialize (outBuffer)
		
		local data = outBuffer:GetString ()
		
		local outBuffer = CAC.StringOutBuffer ()
		outBuffer:StringN8 ("InitialSync")
		outBuffer:StringN8 ("LivePlayerSessions")
		outBuffer:StringN16 (util.Compress (data))
		
		self:DispatchPacket (outBuffer)
	elseif target == "Everything Else" then
		local outBuffer = CAC.StringOutBuffer ()
		
		-- Settings
		self.SettingsSender:SerializeFullUpdate (outBuffer, self.SettingsSender:GetObject ())
		
		-- Incident PlayerSessions
		for liveIncident in self.IncidentManagerSender:GetIncidentManager ():GetLiveIncidentEnumerator () do
			local playerSession = liveIncident:GetPlayerSession ()
			
			self:SubscribePlayerSession (playerSession)
			
			outBuffer:StringN8 (playerSession:GetSteamId ())
			outBuffer:UInt32 (playerSession:GetSessionId ())
			self.SubscribedPlayerSessions [playerSession]:SerializeFullUpdate (outBuffer, playerSession)
		end
		outBuffer:StringN8 ("")
		
		-- Incidents
		self.IncidentManagerSender:SerializeFullUpdate (outBuffer, self.IncidentManagerSender:GetIncidentManager ())
		
		local data = outBuffer:GetString ()
		
		local outBuffer = CAC.StringOutBuffer ()
		outBuffer:StringN8 ("InitialSync")
		outBuffer:StringN8 ("Everything Else")
		outBuffer:StringN16 (util.Compress (data))
		
		self:DispatchPacket (outBuffer)
	elseif target == "LuaScannerStatus" then
		self.LuaScannerStatusSender:SetObject (CAC.LuaScanner:GetLuaScannerStatus ())
		self.LuaScannerStatusSender:SendFullUpdate ()
	else
		CAC.Error ("CAC.NetworkingHost:HandleSubscribe : Unhandled subscription command " .. CAC.String.EscapeNonprintable (target))
	end
end

function self:HandleIncidentManager (inBuffer)
	self.IncidentManagerSender:HandlePacket (inBuffer, CAC.Incidents)
end

function self:HandleLuaScannerStatus (inBuffer)
	self.LuaScannerStatusSender:HandlePacket (inBuffer, CAC.LuaScanner:GetLuaScannerStatus ())
end

function self:HandleSettings (inBuffer)
	self.SettingsSender:HandlePacket (inBuffer, CAC.Settings)
end

function self:HandlePlayerSessionRequest (inBuffer)
	local steamId = inBuffer:StringN8 ()
	local sessionId = inBuffer:UInt32 ()
	
	local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (steamId, true, false)
	if not playerInformation then return end
	
	local playerSession = playerInformation:LoadSession (sessionId)
	if not playerSession then return end
	
	self:SubscribePlayerSession (playerSession)
	
	self.SubscribedPlayerSessions [playerSession]:SendFullUpdate ()
end

-- Internal, do not call
function self:IsPlayerInformationSubscribed (playerInformation)
	return self.SubscribedPlayerInformation [playerInformation] ~= nil
end

function self:IsPlayerSessionSubscribed (playerSession)
	return self.SubscribedPlayerSessions [playerSession] ~= nil
end

function self:IsLivePlayerSessionSubscribed (livePlayerSession)
	return self.SubscribedLivePlayerSessions [livePlayerSession] ~= nil
end

function self:SubscribePlayerInformation (playerInformation)
	if self.SubscribedPlayerInformation [playerInformation] then
		self.SubscribedPlayerInformation [playerInformation].RefCount = self.SubscribedPlayerInformation [playerInformation].RefCount + 1
	else
		self.SubscribedPlayerInformation [playerInformation] = CAC.PlayerInformationSender (playerInformation)
		self.SubscribedPlayerInformation [playerInformation].RefCount = 1
		self:HookPlayerInformation (playerInformation)
		self:HookPlayerInformationSender (self.SubscribedPlayerInformation [playerInformation])
	end
end

function self:UnsubscribePlayerInformation (playerInformation)
	self.SubscribedPlayerInformation [playerInformation].RefCount = self.SubscribedPlayerInformation [playerInformation].RefCount - 1
	
	if self.SubscribedPlayerInformation [playerInformation].RefCount == 0 then
		self:UnhookPlayerInformation (playerInformation)
		self:UnhookPlayerInformationSender (self.SubscribedPlayerInformation [playerInformation])
		
		self.SubscribedPlayerInformation [playerInformation]:dtor ()
		self.SubscribedPlayerInformation [playerInformation] = nil
	end
end

function self:SubscribePlayerSession (playerSession)
	if self.SubscribedPlayerSessions [playerSession] then
		self.SubscribedPlayerSessions [playerSession].RefCount = self.SubscribedPlayerSessions [playerSession].RefCount + 1
	else
		self.SubscribedPlayerSessions [playerSession] = CAC.PlayerSessionSender (playerSession)
		self.SubscribedPlayerSessions [playerSession].RefCount = 1
		self:HookPlayerSession (playerSession)
		self:HookPlayerSessionSender (self.SubscribedPlayerSessions [playerSession])
	end
end

function self:UnsubscribePlayerSession (playerSession)
	self.SubscribedPlayerSessions [playerSession].RefCount = self.SubscribedPlayerSessions [playerSession].RefCount - 1
	
	if self.SubscribedPlayerSessions [playerSession].RefCount == 0 then
		self:UnhookPlayerSession (playerSession)
		self:UnhookPlayerSessionSender (self.SubscribedPlayerSessions [playerSession])
		
		self.SubscribedPlayerSessions [playerSession]:dtor ()
		self.SubscribedPlayerSessions [playerSession] = nil
	end
end

function self:SubscribeLivePlayerSession (livePlayerSession)
	if self.SubscribedLivePlayerSessions [livePlayerSession] then
		self.SubscribedLivePlayerSessions [livePlayerSession].RefCount = self.SubscribedLivePlayerSessions [livePlayerSession].RefCount + 1
	else
		self.SubscribedLivePlayerSessions [livePlayerSession] = CAC.LivePlayerSessionSender (livePlayerSession)
		self.SubscribedLivePlayerSessions [livePlayerSession].RefCount = 1
		self:HookLivePlayerSession (livePlayerSession)
		self:HookLivePlayerSessionSender (self.SubscribedLivePlayerSessions [livePlayerSession])
	end
end

function self:UnsubscribeLivePlayerSession (livePlayerSession)
	self.SubscribedLivePlayerSessions [livePlayerSession].RefCount = self.SubscribedLivePlayerSessions [livePlayerSession].RefCount - 1
	
	if self.SubscribedLivePlayerSessions [livePlayerSession].RefCount == 0 then
		self:UnhookLivePlayerSession (livePlayerSession)
		self:UnhookLivePlayerSessionSender (self.SubscribedLivePlayerSessions [livePlayerSession])
		
		self.SubscribedLivePlayerSessions [livePlayerSession]:dtor ()
		self.SubscribedLivePlayerSessions [livePlayerSession] = nil
	end
end

function self:HookLivePlayerSessionManager (livePlayerSessionManager)
	if not livePlayerSessionManager then return end
	
	livePlayerSessionManager:AddEventListener ("LivePlayerSessionCreated", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_, userId, ply, livePlayerSession)
			local outBuffer = CAC.StringOutBuffer ()
			outBuffer:StringN8 ("LivePlayerSessionCreated")
			outBuffer:UInt32 (livePlayerSession:GetUserId ())
			
			local playerInformation = livePlayerSession:GetPlayerInformation ()
			local playerSession     = livePlayerSession:GetPlayerSession ()
			
			outBuffer:StringN8 (livePlayerSession:GetSteamId ())
			
			-- Avoid sending duplicate PlayerInformation data
			if not self:IsPlayerInformationSubscribed (playerInformation) then
				outBuffer:Boolean (true)
				playerInformation:Serialize (outBuffer)
			else
				outBuffer:Boolean (false)
			end
			
			self:SubscribePlayerInformation (playerInformation)
			self:SubscribePlayerSession     (playerSession    )
			self:SubscribeLivePlayerSession (livePlayerSession)
			
			-- PlayerSession
			outBuffer:UInt32 (playerSession:GetSessionId ())
			playerSession:Serialize (outBuffer)
			
			-- LivePlayerSession
			livePlayerSession:Serialize (outBuffer)
			
			self:DispatchPacket (outBuffer)
		end
	)
	
	livePlayerSessionManager:AddEventListener ("LivePlayerSessionDestroyed", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_, userId, ply, livePlayerSession)
			local outBuffer = CAC.StringOutBuffer ()
			outBuffer:StringN8 ("LivePlayerSessionDestroyed")
			outBuffer:UInt32 (userId)
			self:DispatchPacket (outBuffer)
			
			self:UnsubscribePlayerInformation (livePlayerSession:GetPlayerInformation ())
			self:UnsubscribePlayerSession     (livePlayerSession:GetPlayerSession     ())
			self:UnsubscribeLivePlayerSession (livePlayerSession                        )
		end
	)
end

function self:UnhookLivePlayerSessionManager (livePlayerSessionManager)
	if not livePlayerSessionManager then return end
	
	livePlayerSessionManager:RemoveEventListener ("LivePlayerSessionCreated",   "CAC.NetworkingHost." .. self:GetHashCode ())
	livePlayerSessionManager:RemoveEventListener ("LivePlayerSessionDestroyed", "CAC.NetworkingHost." .. self:GetHashCode ())
end

function self:HookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
end

function self:UnhookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
end

function self:HookLivePlayerSessionSender (livePlayerSessionSender)
	if not livePlayerSessionSender then return end
	
	livePlayerSessionSender:AddEventListener ("CreateOutBuffer", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_)
			local outBuffer = CAC.StringOutBuffer ()
			outBuffer:StringN8 ("LivePlayerSession")
			outBuffer:UInt32   (livePlayerSessionSender:GetLivePlayerSession ():GetUserId ())
			return outBuffer
		end
	)
	
	livePlayerSessionSender:AddEventListener ("DispatchPacket", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_, outBuffer)
			self:DispatchPacket (outBuffer)
		end
	)
end

function self:UnhookLivePlayerSessionSender (livePlayerSessionSender)
	if not livePlayerSessionSender then return end
	
	livePlayerSessionSender:AddEventListener ("CreateOutBuffer", "CAC.NetworkingHost." .. self:GetHashCode ())
	livePlayerSessionSender:AddEventListener ("DispatchPacket",  "CAC.NetworkingHost." .. self:GetHashCode ())
end

function self:HookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:HookPlayerSessionSender (playerSessionSender)
	if not playerSessionSender then return end
	
	playerSessionSender:AddEventListener ("CreateOutBuffer", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_)
			local outBuffer = CAC.StringOutBuffer ()
			outBuffer:StringN8 ("PlayerSession")
			outBuffer:StringN8 (playerSessionSender:GetPlayerSession ():GetSteamId ())
			outBuffer:UInt32   (playerSessionSender:GetPlayerSession ():GetSessionId ())
			return outBuffer
		end
	)
	
	playerSessionSender:AddEventListener ("DispatchPacket", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_, outBuffer)
			self:DispatchPacket (outBuffer)
		end
	)
end

function self:UnhookPlayerSessionSender (playerSessionSender)
	if not playerSessionSender then return end
	
	playerSessionSender:AddEventListener ("CreateOutBuffer", "CAC.NetworkingHost." .. self:GetHashCode ())
	playerSessionSender:AddEventListener ("DispatchPacket",  "CAC.NetworkingHost." .. self:GetHashCode ())
end

function self:HookPlayerInformation (playerInformation)
	if not playerInformation then return end
end

function self:UnhookPlayerInformation (playerInformation)
	if not playerInformation then return end
end

function self:HookPlayerInformationSender (playerInformationSender)
	if not playerInformationSender then return end
	
	playerInformationSender:AddEventListener ("CreateOutBuffer", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_)
			local outBuffer = CAC.StringOutBuffer ()
			outBuffer:StringN8 ("PlayerInformation")
			outBuffer:StringN8 (playerInformationSender:GetPlayerInformation ():GetSteamId ())
			return outBuffer
		end
	)
	
	playerInformationSender:AddEventListener ("DispatchPacket", "CAC.NetworkingHost." .. self:GetHashCode (),
		function (_, outBuffer)
			self:DispatchPacket (outBuffer)
		end
	)
end

function self:UnhookPlayerInformationSender (playerInformationSender)
	if not playerInformationSender then return end
	
	playerInformationSender:AddEventListener ("CreateOutBuffer", "CAC.NetworkingHost." .. self:GetHashCode ())
	playerInformationSender:AddEventListener ("DispatchPacket",  "CAC.NetworkingHost." .. self:GetHashCode ())
end