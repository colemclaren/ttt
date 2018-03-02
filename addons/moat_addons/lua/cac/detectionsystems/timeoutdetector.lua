local self = {}
CAC.TimeoutDetector = CAC.MakeConstructor (self, CAC.Detector)

local math_min = math.min

local SysTime  = SysTime
local CurTime  = CurTime

local CUserCmd_IsForced = debug.getregistry ().CUserCmd.IsForced

function self:ctor (playerMonitor)
end

function self:OnSetupMove (ply, moveData, userCmd)
	if CUserCmd_IsForced (userCmd) then return end
	
	local playerState = self:GetPlayerState (ply)
	if not playerState then return end
	
	local t1 = SysTime ()
	local t2 = CurTime ()
	local dt1 = t1 - playerState.LastSetupMoveTime1
	local dt2 = t2 - playerState.LastSetupMoveTime2
	playerState.LastSetupMoveTime1 = t1
	playerState.LastSetupMoveTime2 = t2
	
	local dt = math_min (dt1, dt2)
	if dt < 0.5 then
		local livePlayerSession = CAC.LivePlayerSessionManager:GetLivePlayerSession (ply)
		if not livePlayerSession then return end
		
		livePlayerSession:CreditTimeout (dt)
	end
end

-- Internal, do not call
function self:GetName ()
	return "TimeoutDetector"
end

function self:InitializePlayerState (ply, playerState)
	playerState.LastSetupMoveTime1 = 0
	playerState.LastSetupMoveTime2 = 0
end

CAC.TimeoutDetector = CAC.TimeoutDetector ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.TimeoutDetector:dtor ()
		CAC.TimeoutDetector = nil
	end
)