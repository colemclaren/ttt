local self = {}
CAC.AutoBunnyHopDetector = CAC.MakeConstructor (self, CAC.Detector)

local IN_JUMP              = IN_JUMP

local _R_CUserCmd_KeyDown  = debug.getregistry ().CUserCmd.KeyDown
local _R_Entity_IsOnGround = debug.getregistry ().Entity.IsOnGround

function self:ctor (playerMonitor)
end

function self:dtor ()
end

function self:OnSetupMove (ply, moveData, userCmd)
	local playerState = self:GetPlayerState (ply)
	if not playerState then return end
	
	local lastOnGround = playerState.OnGround
	local lastInJump   = playerState.InJump
	
	local onGround = _R_Entity_IsOnGround (ply)
	local inJump   = _R_CUserCmd_KeyDown (userCmd, IN_JUMP)
	
	if lastOnGround and not onGround then
		playerState.Count2 = 0
	elseif not lastOnGround and onGround then
		if not lastInJump and inJump then
			playerState.Count1 = playerState.Count1 + 1
			if playerState.Count1 == 14 then
				local a, b, c = 0, 0, 0
				for i = 1, #playerState.Buffer do
					local x = playerState.Buffer [i]
					a = a + 1 
					b = b + x
					c = c + x * x
				end
				
				if (c - b * b / a) / a < 0.1 then
					CAC.LivePlayerSessionManager:GetLivePlayerSession (ply):GetPlayerSession ():AddDetectionReasonFiltered ("AutoBunnyHop", "Player bunny hopped perfectly 14 times in a row.")
				end
			end
		else
			self:ResetCounters (ply, playerState)
		end
	elseif onGround then
		if lastInJump ~= inJump then
			self:ResetCounters (ply, playerState)
		end
	end
	
	if not onGround and
	   lastInJump and not inJump and
	   playerState.Count2 >= 0 then
		playerState.Buffer[#playerState.Buffer + 1] = playerState.Count2
		playerState.Count2 = -math.huge
	end
	
	playerState.Count2 = playerState.Count2 + 1
	
	playerState.OnGround = onGround
	playerState.InJump   = inJump
end

-- Internal, do not call
function self:GetName ()
	return "AutoBunnyHopDetector"
end

function self:InitializePlayerState (ply, playerState)
	playerState.Count1 = 0
	playerState.Count2 = 0
	playerState.Buffer = {}
	playerState.OnGround = ply:IsOnGround ()
	playerState.InJump   = ply:IsOnGround ()
end

function self:ResetCounters (ply, playerState)
	playerState.Count1 = 0
	playerState.Count2 = 0
	for i = #playerState.Buffer, 1, -1 do
		playerState.Buffer [i] = nil
	end
end

CAC.AutoBunnyHopDetector = CAC.AutoBunnyHopDetector ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.AutoBunnyHopDetector:dtor ()
		CAC.AutoBunnyHopDetector = nil
	end
)