local self = {}
CAC.IncidentController = CAC.MakeConstructor (self, CAC.BaseLivePlayerSessionController)

-- This controller:
--     Creates LiveIncidents (and Incidents) for PlayerSessions with newly added Detections
--     Updates the response for Incidents when PlayerSession detections are added
--     Initiates execution of Incident responses when LiveIncident Countdowns finish

function self:ctor (livePlayerSessionManager)
	timer.Create ("CAC.IncidentController", 1, 0,
		function ()
			for liveIncident in CAC.Incidents:GetLiveIncidentEnumerator () do
				if not liveIncident:GetIncident ():GetResponseExecuted () and
				   liveIncident:GetResponseCountdown ():IsRunning () and
				   liveIncident:GetResponseCountdown ():IsFinished () then
					liveIncident:ExecuteResponse ()
				end
			end
		end
	)
end

function self:dtor ()
	timer.Destroy ("CAC.IncidentController")
end

function self:OnLivePlayerSessionDestroyed (userId, ply, livePlayerSession)
	local liveIncident = livePlayerSession:GetLiveIncident ()
	if not liveIncident then return end
	
	-- Don't destroy the LiveIncident, since ban responses need to be carried out still!
	-- CAC.Incidents:DestroyLiveIncident (liveIncident)
end

-- Internal, do not call
function self:DispatchNotification (liveIncident, response)
	if response == CAC.DetectionResponse.Ignore then return end
	
	local incidentMessageParameters = CAC.IncidentMessageParameters.FromLiveIncident (liveIncident)
	local message = CAC.FormatMessage (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetResponseNotification (), incidentMessageParameters)
	
	for _, ply in ipairs (player.GetAll ()) do
		if CAC.Permissions.PlayerHasPermission (ply, "ViewMenu") then
			ply:ChatPrint (message)
		end
	end
	
	MsgC (CAC.Colors.Red, message .. "\n")
end

function self:CalculateResponse (playerSession, settings)
	if settings:GetSettingsGroup ("UserWhitelistSettings"):GetUserWhitelist ():GetUserWhitelistStatus (playerSession:GetSteamId ()) >= CAC.WhitelistStatus.SuppressResponse then
		return CAC.DetectionResponse.Ignore
	end
	
	local clientsideLuaAllowed = playerSession:HasFlag ("sv_allowcslua") or playerSession:HasFlag ("sv_cheats")
	
	local detectionResponse = CAC.DetectionResponse.Ignore
	
	for detection in playerSession:GetDetectionEnumerator () do
		local detectionType = detection:GetDetectionType ()
		clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse = settings:GetDetectionResponseSettings ():GetDetectionResponse (detectionType)
		if clientsideLuaAllowed then
			detectionResponse = math.max (detectionResponse, clientsideLuaAllowedResponse   )
		else
			detectionResponse = math.max (detectionResponse, clientsideLuaDisallowedResponse)
		end
	end
	
	return detectionResponse
end

function self:UpdateResponse (playerSession, livePlayerSession, liveIncident)
	local detectionResponse = self:CalculateResponse (playerSession, CAC.Settings)
	liveIncident:StartResponse (detectionResponse)
	
	if detectionResponse == CAC.DetectionResponse.Ignore and
	   CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):GetUserWhitelist ():GetUserWhitelistStatus (playerSession:GetSteamId ()) >= CAC.WhitelistStatus.SuppressResponse then
		playerSession:GetLog ():AppendLine ("!!! DETECTION !!!: Player is whitelisted, response suppressed.")
	end
	
	self:DispatchNotification (liveIncident, detectionResponse)
end

function self:HookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	self:HookPlayerSession (livePlayerSession:GetPlayerSession (), livePlayerSession)
end

function self:UnhookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	self:UnhookPlayerSession (livePlayerSession:GetPlayerSession (), livePlayerSession)
end

function self:HookPlayerSession (playerSession, livePlayerSession)
	if not playerSession     then return end
	if not livePlayerSession then return end
	
	playerSession:AddEventListener ("DetectionAdded", "CAC.IncidentController." .. self:GetHashCode (),
		function (_, detection)
			local liveIncident = CAC.Incidents:CreateLiveIncidentFromLivePlayerSession (livePlayerSession)
			
			-- Ensure that the log for this player session is saved
			playerSession:SetSaveLog (true)
			
			self:UpdateResponse (playerSession, livePlayerSession, liveIncident)
		end
	)
	
	playerSession:AddEventListener ("DetectionsCleared", "CAC.IncidentController." .. self:GetHashCode (),
		function (_)
			local liveIncident = playerSession:GetLiveIncident ()
			
			-- There should be a LiveIncident, but w/e
			if not liveIncident then return end
			
			self:UpdateResponse (playerSession, livePlayerSession, liveIncident)
		end
	)
	
	playerSession:AddEventListener ("DetectionRemoved", "CAC.IncidentController." .. self:GetHashCode (),
		function (_, detection)
			local liveIncident = playerSession:GetLiveIncident ()
			
			-- There should be a LiveIncident, but w/e
			if not liveIncident then return end
			
			self:UpdateResponse (playerSession, livePlayerSession, liveIncident)
		end
	)
end

function self:UnhookPlayerSession (playerSession, livePlayerSession)
	if not playerSession     then return end
	if not livePlayerSession then return end
	
	playerSession:RemoveEventListener ("DetectionAdded",    "CAC.IncidentController." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionsCleared", "CAC.IncidentController." .. self:GetHashCode ())
	playerSession:RemoveEventListener ("DetectionRemoved",  "CAC.IncidentController." .. self:GetHashCode ())
end