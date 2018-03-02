local self = {}
CAC.SeedManipulationDetector = CAC.MakeConstructor (self, CAC.Detector)

function self:ctor (playerMonitor)
end

function self:OnSetupMove (ply, moveData, userCmd)
	local playerState = self:GetPlayerState (ply)
	if not playerState then return end
	
	local commandNumber      = userCmd:CommandNumber ()
	local lastCommandNumber  = playerState.LastCommandNumber or commandNumber
	local deltaCommandNumber = commandNumber - lastCommandNumber
	
	-- Check for overflow
	if lastCommandNumber > 0xFFFF0000 and
	   commandNumber < 0x00010000 then
		deltaCommandNumber = deltaCommandNumber + 4294967296
	end
	
	playerState.LastCommandNumber = commandNumber
	
	if deltaCommandNumber < -256 or
	   deltaCommandNumber >  256 then
		CAC.LivePlayerSessionManager:GetLivePlayerSession (ply):GetPlayerSession ():AddDetectionReasonFiltered ("SeedManipulation", "Command number changed by an improbably large amount (" .. tostring (deltaCommandNumber) .. ") in consecutive commands!")
	end
end

-- Internal, do not call
function self:GetName ()
	return "SeedManipulationDetector"
end

function self:InitializePlayerState (ply, playerState)
	playerState.LastCommandNumber = nil
end

CAC.SeedManipulationDetector = CAC.SeedManipulationDetector ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.SeedManipulationDetector:dtor ()
		CAC.SeedManipulationDetector = nil
	end
)