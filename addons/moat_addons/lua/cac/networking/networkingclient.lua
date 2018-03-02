local self = {}
CAC.NetworkingClient = CAC.MakeConstructor (self)

function self:ctor ()
	self.PlayerInformationReceiver  = CAC.PlayerInformationReceiver ()
	self.PlayerSessionReceiver      = CAC.PlayerSessionReceiver     ()
	self.LivePlayerSessionReceiver  = CAC.LivePlayerSessionReceiver ()
	
	self.IncidentManagerReceiver    = CAC.IncidentManagerReceiver   ()
	self.IncidentManagerReceiver:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = CAC.StringOutBuffer () outBuffer:StringN8 ("IncidentManager") return outBuffer end)
	self.IncidentManagerReceiver:AddEventListener ("DispatchPacket",  function (_, outBuffer) self:DispatchPacket (outBuffer) end)
	self.IncidentManagerReceiver:AddEventListener ("RequestPlayerSession", function (_, steamId, sessionId) self:SendPlayerSessionRequest (steamId, sessionId) end)
	
	self.LuaScannerStatus           = CAC.LuaScannerStatus ()
	self.LuaScannerStatusSubscribed = false
	self.LuaScannerStatusReceiver   = CAC.LuaScannerStatusReceiver  (self.LuaScannerStatus)
	self.LuaScannerStatusReceiver:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = CAC.StringOutBuffer () outBuffer:StringN8 ("LuaScannerStatus") return outBuffer end)
	self.LuaScannerStatusReceiver:AddEventListener ("DispatchPacket",  function (_, outBuffer) self:DispatchPacket (outBuffer) end)
	
	self.SettingsReceiver           = CAC.SettingsReceiver          (CAC.Settings)
	self.SettingsReceiver:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = CAC.StringOutBuffer () outBuffer:StringN8 ("Settings") return outBuffer end)
	self.SettingsReceiver:AddEventListener ("DispatchPacket",  function (_, outBuffer) self:DispatchPacket (outBuffer) end)
	
	CAC.WaitForLocalPlayer (
		function ()
			if util.NetworkStringToID (CAC.Identifiers.AdminChannelName) == 0 then return end
			
			local outBuffer = CAC.StringOutBuffer ()
			outBuffer:StringN8 ("Subscribe")
			outBuffer:StringN8 ("LivePlayerSessions")
			self:DispatchPacket (outBuffer)
		end
	)
end

function self:dtor ()
	self.PlayerInformationReceiver:dtor ()
	self.PlayerSessionReceiver    :dtor ()
	self.LivePlayerSessionReceiver:dtor ()
	
	self.IncidentManagerReceiver  :dtor ()
	
	self.SettingsReceiver         :dtor ()
end

function self:GetObject ()
	return nil
end

function self:GetIncidentManagerClient ()
	return self.IncidentManagerReceiver
end

function self:GetSettingsClient ()
	return self.SettingsReceiver
end

function self:DispatchPacket (outBuffer)
	if util.NetworkStringToID (CAC.Identifiers.AdminChannelName) == 0 then return end
	
	local data = outBuffer:GetString ()
	net.Start (CAC.Identifiers.AdminChannelName)
		net.WriteUInt (#data, 16)
		net.WriteData (data, #data)
	net.SendToServer ()
end

function self:HandlePacket (inBuffer, object)
	object = object or self:GetObject ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if handlerMethodName == "HandlePacket" then return end
	
	if not self [handlerMethodName] then
		MsgC (Color (255, 0, 0, 255), "CAC.NetworkingClient:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName) .. "\n")
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, object)
end

function self:HandleInitialSync (inBuffer)
	local target = inBuffer:StringN8 ()
	if target == "LivePlayerSessions" then
		local inBuffer = CAC.StringInBuffer (util.Decompress (inBuffer:StringN16 ()))
		
		-- CheckRegistry
		CAC.Checks:Deserialize (inBuffer)
		
		-- PlayerInformation and PlayerSessions
		local steamId = inBuffer:StringN8 ()
		while steamId ~= "" do
			local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (steamId, true, true)
			playerInformation:Deserialize (inBuffer)
			
			local sessionId = inBuffer:UInt32 ()
			local playerSession = playerInformation:CreateSession (sessionId)
			playerSession:Deserialize (inBuffer)
			
			steamId = inBuffer:StringN8 ()
		end
		
		-- LivePlayerSessions
		CAC.LivePlayerSessionManager:Deserialize (inBuffer)
		
		-- Request incidents
		local outBuffer = CAC.StringOutBuffer ()
		outBuffer:StringN8 ("Subscribe")
		outBuffer:StringN8 ("Everything Else")
		self:DispatchPacket (outBuffer)
	elseif target == "Everything Else" then
		local inBuffer = CAC.StringInBuffer (util.Decompress (inBuffer:StringN16 ()))
		
		-- Settings
		self.SettingsReceiver:HandleFullUpdate (inBuffer, CAC.Settings)
		
		-- Incident PlayerSessions
		local steamId = inBuffer:StringN8 ()
		while steamId ~= "" do
			local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (steamId, true, true)
			
			local sessionId = inBuffer:UInt32 ()
			local playerSession = playerInformation:CreateSession (sessionId)
			self.PlayerSessionReceiver:HandleFullUpdate (inBuffer, playerSession)
			
			steamId = inBuffer:StringN8 ()
		end
		
		-- Incidents
		self.IncidentManagerReceiver:HandleFullUpdate (inBuffer, CAC.Incidents)
	else
		CAC.Error ("Unhandled InitialSync target " .. target)
	end
end

function self:HandleLivePlayerSessionCreated (inBuffer)
	local userId  = inBuffer:UInt32   ()
	local steamId = inBuffer:StringN8 ()
	
	local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (steamId, true, true)
	if inBuffer:Boolean () then
		playerInformation:Deserialize (inBuffer)
	end
	
	local sessionId = inBuffer:UInt32 ()
	local playerSession = playerInformation:CreateSession (sessionId)
	playerSession:Deserialize (inBuffer)
	
	local livePlayerSession = CAC.LivePlayerSessionManager:CreateLivePlayerSession (userId, steamId, playerSession)
	livePlayerSession:Deserialize (inBuffer)
end

function self:HandleLivePlayerSessionDestroyed (inBuffer)
	local userId = inBuffer:UInt32 ()
	CAC.LivePlayerSessionManager:DestroyLivePlayerSession (userId)
end

function self:HandleLivePlayerSession (inBuffer)
	local userId = inBuffer:UInt32 ()
	local livePlayerSession = CAC.LivePlayerSessionManager:GetLivePlayerSession (userId)
	if not livePlayerSession and not CAC.IsDebug then return end
	self.LivePlayerSessionReceiver:HandlePacket (inBuffer, livePlayerSession)
end

function self:HandlePlayerInformation (inBuffer)
	local steamId = inBuffer:StringN8 ()
	local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (steamId, true, true)
	self.PlayerInformationReceiver:HandlePacket (inBuffer, playerInformation)
end

function self:HandlePlayerSession (inBuffer)
	local steamId   = inBuffer:StringN8 ()
	local sessionId = inBuffer:UInt32   ()
	local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (steamId, true, true)
	local playerSession     = playerInformation:CreateSession (sessionId)
	self.PlayerSessionReceiver:HandlePacket (inBuffer, playerSession)
end

function self:HandleIncidentManager (inBuffer)
	self.IncidentManagerReceiver:HandlePacket (inBuffer, CAC.Incidents)
end

function self:HandleLuaScannerStatus (inBuffer)
	self.LuaScannerStatusReceiver:HandlePacket (inBuffer, self.LuaScannerStatus)
end

function self:HandleSettings (inBuffer)
	self.SettingsReceiver:HandlePacket (inBuffer, CAC.Settings)
end

function self:GetLuaScannerStatus ()
	if not self.LuaScannerStatusSubscribed then
		self.LuaScannerStatusSubscribed = true
		
		local outBuffer = CAC.StringOutBuffer ()
		outBuffer:StringN8 ("Subscribe")
		outBuffer:StringN8 ("LuaScannerStatus")
		self:DispatchPacket (outBuffer)
	end
	
	return self.LuaScannerStatus
end

function self:SendPlayerSessionRequest (steamId, sessionId)
	local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (steamId, false, false)
	if playerInformation then
		local playerSession = playerInformation:GetSession (sessionId)
		if playerSession then return end
	end
	
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:StringN8 ("PlayerSessionRequest")
	outBuffer:StringN8 (steamId)
	outBuffer:UInt32 (sessionId)
	self:DispatchPacket (outBuffer)
end