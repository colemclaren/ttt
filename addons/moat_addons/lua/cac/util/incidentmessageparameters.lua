local self = {}
CAC.IncidentMessageParameters = CAC.MakeConstructor (self, CAC.MessageParameters)

function CAC.IncidentMessageParameters.CreateExample (incidentMessageParameters)
	incidentMessageParameters = incidentMessageParameters or CAC.IncidentMessageParameters ()
	
	local ply = CLIENT and LocalPlayer () or table.Random (player.GetHumans ())
	incidentMessageParameters:SetPlayer (ply)
	incidentMessageParameters:SetDetectionResponse (CAC.DetectionResponse.Ban)
	incidentMessageParameters:SetParameter ("incidentid", ply:SteamID () .. "/37")
	
	incidentMessageParameters:SetParameter ("countdownduration",      CAC.FormatBanDuration (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetCountdownDuration ()))
	incidentMessageParameters:SetParameter ("countdowntimeremaining", CAC.FormatBanDuration (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetCountdownDuration () * 0.95))
	
	incidentMessageParameters:SetBanDuration (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetBanDuration ())
	
	local detections = {}
	detections [#detections + 1] = CAC.Detections:CreateDetection ("ClientsideLuaExecution")
	detections [#detections + 1] = CAC.Detections:CreateDetection ("Aimbot")
	
	incidentMessageParameters:SetDetections (CAC.ArrayEnumerator (detections))
	
	return incidentMessageParameters
end

function CAC.IncidentMessageParameters.FromLiveIncident (liveIncident, incidentMessageParameters)
	incidentMessageParameters = incidentMessageParameters or CAC.IncidentMessageParameters ()
	
	incidentMessageParameters = CAC.IncidentMessageParameters.FromIncident (liveIncident:GetIncident (), incidentMessageParameters)
	
	incidentMessageParameters:SetParameter ("countdownduration",      CAC.FormatBanDuration (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetCountdownDuration ()))
	incidentMessageParameters:SetParameter ("countdowntimeremaining", CAC.FormatBanDuration (liveIncident:GetResponseCountdown ():GetTimeRemaining ()))
	
	incidentMessageParameters:SetBanDuration (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetBanDuration ())
	
	incidentMessageParameters:SetDetections (liveIncident:GetPlayerSession ():GetDetectionEnumerator ())
	
	return incidentMessageParameters
end

function CAC.IncidentMessageParameters.FromIncident (incident, incidentMessageParameters)
	incidentMessageParameters = incidentMessageParameters or CAC.IncidentMessageParameters ()
	
	incidentMessageParameters:SetParameter ("name",            incident:GetPlayerName             ())
	incidentMessageParameters:SetParameter ("steamid",         incident:GetPlayerSteamId          ())
	
	incidentMessageParameters:SetDetectionResponse (incident:GetResponse ())
	incidentMessageParameters:SetParameter ("incidentid",      incident:GetQualifiedIncidentId    ())
	
	incidentMessageParameters:SetParameter ("approved",        incident:GetResponseApproved       ())
	incidentMessageParameters:SetParameter ("approvername",    incident:GetResponseApproverName   ())
	incidentMessageParameters:SetParameter ("approversteamid", incident:GetResponseApproverSteamId ())
	
	return incidentMessageParameters
end

function self:ctor ()
	self:SetParameter ("name",       "{name}")
	self:SetParameter ("steamid",    "{steamid}")
	
	self:SetParameter ("incidentid", "{incidentid}")
	
	-- Response
	self:SetParameter ("response",   "{response}")
	self:SetParameter ("responsed",  "{responsed}")
	
	self:SetParameter ("ignore",     false)
	self:SetParameter ("kick",       false)
	self:SetParameter ("ban",        false)
	
	-- Countdown duration
	self:SetParameter ("countdownduration",      "{countdownduration}")
	self:SetParameter ("countdowntimeremaining", "{countdowntimeremaining}")
	
	-- Ban duration
	self:SetParameter ("permanentban", false)
	self:SetParameter ("banduration",  "{banduration}")
	
	-- Approval
	self:SetParameter ("approved",        false)
	self:SetParameter ("approvername",    "{approvername}")
	self:SetParameter ("approversteamid", "{approversteamid}")
	
	-- Detections
	self:SetParameter ("detectionnames",     "{detectionnames}")
	self:SetParameter ("fulldetectionnames", "{fulldetectionnames}")
end

function self:SetPlayer (ply)
	self:SetParameter ("name",    ply:Nick ())
	self:SetParameter ("steamid", ply:SteamID ())
end

function self:SetDetectionResponse (detectionResponse)
	self:SetParameter ("response", string.lower (CAC.DetectionResponse [detectionResponse]))
	
	if detectionResponse == CAC.DetectionResponse.Ignore then
		self:SetParameter ("responsed", "ignored")
	elseif detectionResponse == CAC.DetectionResponse.Kick then
		self:SetParameter ("responsed", "kicked")
	elseif detectionResponse == CAC.DetectionResponse.Ban then
		self:SetParameter ("responsed", "banned")
	end
	
	self:SetParameter ("ignore", detectionResponse == CAC.DetectionResponse.Ignore)
	self:SetParameter ("kick",   detectionResponse == CAC.DetectionResponse.Kick  )
	self:SetParameter ("ban",    detectionResponse == CAC.DetectionResponse.Ban   )
end

function self:SetBanDuration (banDuration)
	self:SetParameter ("permanentban", banDuration == math.huge)
	self:SetParameter ("banduration", CAC.FormatBanDuration (banDuration))
end

function self:SetDetections (detectionEnumerator)
	local detectionNames = ""
	local fullDetectionNames = ""
	local first = true
	
	for detection in detectionEnumerator do
		if first then first = false
		else
			detectionNames     = detectionNames     .. ", "
			fullDetectionNames = fullDetectionNames .. ", "
		end
		
		local detectionInformation = detection:GetInformation ()
		
		detectionNames     = detectionNames     .. string.lower (detectionInformation:GetKickName ())
		fullDetectionNames = fullDetectionNames .. string.lower (detectionInformation:GetName     ())
	end
	
	self:SetParameter ("detectionnames",     detectionNames    )
	self:SetParameter ("fulldetectionnames", fullDetectionNames)
end