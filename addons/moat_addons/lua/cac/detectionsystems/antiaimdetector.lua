local self = {}
CAC.AntiAimDetector = CAC.MakeConstructor (self, CAC.Detector)

local _R_Angle___index       = debug.getregistry ().Angle.__index
local _R_CMoveData_GetAngles = debug.getregistry ().CMoveData.GetAngles

function self:ctor (playerMonitor)
end

function self:OnSetupMove (ply, moveData, userCmd)
	local playerState = self:GetPlayerState (ply)
	if not playerState then return end
	
	local angles = _R_CMoveData_GetAngles (moveData)
	local pitch  = _R_Angle___index (angles, 1)
	
	-- Normalize pitch
	pitch = pitch % 360
	if pitch > 180 then pitch = pitch - 360 end
	
	if -90 <= pitch and pitch <= 90 then
		playerState.ViewAngleValidSamples:AddSample (0)
		return
	end
	
	playerState.ViewAngleValidSamples:AddSample (1)
	pitch = math.Clamp (pitch, -90, 90)
	moveData:SetAngles (Angle (pitch, angles.y, angles.r))
	
	if playerState.ViewAngleValidSamples:GetSampleCount () >= playerState.ViewAngleValidSamples:GetWindowSize () and
	   playerState.ViewAngleValidSamples:GetMean () > 0.5 then
		if SysTime () - playerState.LastAntiAimDetectionTime > 10 then
			playerState.LastAntiAimDetectionTime = SysTime ()
			CAC.LivePlayerSessionManager:GetLivePlayerSession (ply):GetPlayerSession ():AddDetectionReasonFiltered ("AntiAim", "Invalid eye angles " .. string.format ("(%.3f, %.3f, %.3f)", angles.p, angles.y, angles.r))
		end
	end
end

-- Internal, do not call
function self:GetName ()
	return "AntiAimDetector"
end

function self:InitializePlayerState (ply, playerState)
	playerState.LastAntiAimDetectionTime = 0
	
	playerState.ViewAngleValidSamples = CAC.MovingWindowSampleSet ()
	playerState.ViewAngleValidSamples:SetWindowSize (180) -- about 3 seconds worth of commands on 66 tick
end

CAC.AntiAimDetector = CAC.AntiAimDetector ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.AntiAimDetector:dtor ()
		CAC.AntiAimDetector = nil
	end
)