local self = {}
CAC.SpeedhackDetectorRunner = CAC.MakeConstructor (self, CAC.Detector)

local host_timescale = GetConVar ("host_timescale")

function self:ctor (playerMonitor)
end

function self:OnSetupMove (ply, moveData, userCmd)
	local playerState = self:GetPlayerState (ply)
	if not playerState then return end
	
	playerState.SimulationTimeDetector:Impulse ()
	playerState.RealTimeDetector      :Impulse ()
	
	if playerState.SimulationTimeDetector:IsInSpeedhack () and
	   playerState.RealTimeDetector      :IsInSpeedhack () then
		if playerState.SimulationTimeDetector:GetSpeedhackTime () >= playerState.SimulationTimeDetector:GetBuffer1Duration () and
		   playerState.RealTimeDetector      :GetSpeedhackTime () >= playerState.RealTimeDetector      :GetBuffer1Duration () then
			if not playerState.SpeedhackReported then
				playerState.SpeedhackReported = true
				
				local dtSimulation = playerState.SimulationTimeDetector:GetBuffer1TimeAhead ()
				local dtReal       = playerState.RealTimeDetector      :GetBuffer1TimeAhead ()
				local dt = math.min (dtSimulation, dtReal)
				
				local buffer1Duration = playerState.SimulationTimeDetector:GetBuffer1Duration ()
				CAC.LivePlayerSessionManager:GetLivePlayerSession (ply):GetPlayerSession ():AddDetectionReasonFiltered ("Speedhack", "Player command rate was too high! (~" .. string.format ("%.2f", 1 + dt / buffer1Duration) .. "x normal, over a sampling window of " .. CAC.FormatDuration (buffer1Duration) .. ")")
			end
		end
	else
		playerState.SpeedhackReported = false
	end
end

-- Internal, do not call
function self:GetName ()
	return "SpeedhackDetector"
end

function self:InitializePlayerState (ply, playerState)
	playerState.SimulationTimeDetector = CAC.SpeedhackDetector (CurTime, function () return 1 end)
	playerState.RealTimeDetector       = CAC.SpeedhackDetector (SysTime, function () return game.GetTimeScale () * host_timescale:GetFloat () end)
end

CAC.SpeedhackDetectorRunner = CAC.SpeedhackDetectorRunner ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.SpeedhackDetectorRunner:dtor ()
		CAC.SpeedhackDetectorRunner = nil
	end
)