local self = {}
CAC.AimbotDetector = CAC.MakeConstructor (self, CAC.Detector)

function self:ctor (playerMonitor)
	hook.Add ("PlayerDeath", "CAC.AimbotDetector",
		function (victim, inflictor, attacker)
			if not attacker:IsValid () then return end
			if not attacker:IsPlayer () then return end
			
			self:OnKill (attacker, victim)
		end
	)
	
	hook.Add ("OnNPCKilled", "CAC.Aimbotdetector",
		function (victim, attacker, inflictor)
			if not attacker:IsValid () then return end
			if not attacker:IsPlayer () then return end
			
			self:OnKill (attacker, victim)
		end
	)
end

function self:dtor ()
	hook.Remove ("PlayerDeath", "CAC.AimbotDetector")
	hook.Remove ("OnNPCKilled", "CAC.Aimbotdetector")
end

function self:OnSetupMove (ply, moveData, userCmd)
	local playerState = self:GetPlayerState (ply)
	if not playerState then return end
	
	local angles  = moveData:GetAngles ()
	local forward = angles:Forward ()
	
	-- CMoveData:GetAngles () doesn't catch context menu aiming
	local eyeTrace = ply:GetEyeTrace ()
	forward = eyeTrace.HitPos - eyeTrace.StartPos
	forward:Normalize ()
	
	if playerState.PreviousAngles and
	   playerState.PreviousForward then
		local deltaAngle = math.deg (math.acos (math.min (math.abs (forward:Dot (playerState.PreviousForward)), 1)))
		
		if deltaAngle > 0.05 then
			playerState.DAngleSamples:AddSample (deltaAngle)
		end
		
		if playerState.PreviousDAngle then
			local deltaDeltaAngle = math.abs (deltaAngle - playerState.PreviousDAngle)
			
			if deltaDeltaAngle > 0.05 then
				playerState.DDAngleSamples:AddSample (deltaDeltaAngle)
				
				if playerState.DDAngleSamples:GetSampleCount () >= playerState.DDAngleSamples:GetWindowSize () and
				   deltaDeltaAngle > playerState.DDAngleSamples:GetMean () + 3 * playerState.DDAngleSamples:GetStandardDeviation () then
					playerState.LastSnapEventTime = SysTime ()
					playerState.LastSnapDDAngle = deltaDeltaAngle
				end
			end
		end
		
		playerState.PreviousDAngle = deltaAngle
	end
	
	playerState.PreviousAngles  = angles
	playerState.PreviousForward = forward
end

function self:OnKill (ply, victim)
	if not self:PlayerStateExists (ply) then return end
	
	if ply == victim then return end
	
	local playerState = self:GetPlayerState (ply)
	
	if playerState.LastSnapEventTime and
	   SysTime () - playerState.LastSnapEventTime < 0.25 then
		local name = victim:GetClass ()
		if victim:IsPlayer () then
			name = victim:GetName ()
		end
		
		CAC.LivePlayerSessionManager:GetLivePlayerSession (ply):GetPlayerSession ():AddDetectionReasonFiltered ("Aimbot", "Player aim direction snapped " .. string.format ("%.2f", playerState.LastSnapDDAngle) .. " degrees in one frame before killing " .. name .. "!")
	end
end

-- Internal, do not call
function self:GetName ()
	return "AimbotDetector"
end

function self:InitializePlayerState (ply, playerState)
	playerState.PreviousAngles    = nil
	playerState.PreviousForward   = nil
	playerState.PreviousDAngle    = nil
	playerState.LastSnapEventTime = nil
	playerState.LastSnapDDAngle   = nil
	
	playerState.DAngleSamples = CAC.MovingWindowSampleSet ()
	playerState.DAngleSamples:SetWindowSize (180) -- about 3 seconds on 66 tick
	playerState.DDAngleSamples = CAC.MovingWindowSampleSet ()
	playerState.DDAngleSamples:SetWindowSize (180) -- about 3 seconds on 66 tick
end

CAC.AimbotDetector = CAC.AimbotDetector ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.AimbotDetector:dtor ()
		CAC.AimbotDetector = nil
	end
)