// System for lua animation events
// Not yet fully implemented

AE_INVALID = -1
AE_EMPTY = 0
AE_NPC_LEFTFOOT = 1
AE_NPC_RIGHTFOOT = 2
AE_NPC_BODYDROP_LIGHT = 3
AE_NPC_BODYDROP_HEAVY = 4
AE_NPC_SWISHSOUND = 5
AE_NPC_180TURN = 6
AE_NPC_ITEM_PICKUP = 7
AE_NPC_WEAPON_DROP = 8
AE_NPC_WEAPON_SET_SEQUENCE_NAME = 9
AE_NPC_WEAPON_SET_SEQUENCE_NUMBER = 10
AE_NPC_WEAPON_SET_ACTIVITY = 11
AE_NPC_HOLSTER = 12
AE_NPC_DRAW = 13
AE_NPC_WEAPON_FIRE = 14
AE_CL_PLAYSOUND = 15
AE_SV_PLAYSOUND = 16
AE_CL_STOPSOUND = 17
AE_START_SCRIPTED_EFFECT = 18
AE_STOP_SCRIPTED_EFFECT = 19
AE_CLIENT_EFFECT_ATTACH = 20
AE_MUZZLEFLASH = 21
AE_NPC_MUZZLEFLASH = 22
AE_THUMPER_THUMP = 23
AE_AMMOCRATE_PICKUP_AMMO = 24
AE_NPC_RAGDOLL = 25
AE_NPC_ADDGESTURE = 26
AE_NPC_RESTARTGESTURE = 27
AE_NPC_ATTACK_BROADCAST = 28
AE_NPC_HURT_INTERACTION_PARTNER = 29
AE_NPC_SET_INTERACTION_CANTDIE = 30
AE_SV_DUSTTRAIL = 31
AE_CL_CREATE_PARTICLE_EFFECT = 32
AE_RAGDOLL = 33
AE_CL_ENABLE_BODYGROUP = 34
AE_CL_DISABLE_BODYGROUP = 35
AE_CL_BODYGROUP_SET_VALUE = 36
AE_CL_BODYGROUP_SET_VALUE_CMODEL_WPN = 37
AE_WPN_PRIMARYATTACK = 38
AE_WPN_INCREMENTAMMO = 39
AE_WPN_HIDE = 40
AE_WPN_UNHIDE = 41
AE_WPN_PLAYWPNSOUND = 42
LAST_SHARED_ANIMEVENT = 43

local tbAnimationFrames = {
	["idle"] = 35	-- Amount of frames this animation has
} -- Animations that aren't defined here, can't have animation events
local bFramesInitialized
function ENT:Initialize()
	-- default NPC initialization stuff (model has to be set here!)
	if(!bFramesInitialized) then	-- this is stupid, but I'm too tired to think of something better right now
		bFramesInitialized = true
		for seq, numFrames in pairs(tbAnimationFrames) do
			tbAnimationFrames[seq] = nil
			tbAnimationFrames[seq] = self:LookupSequence(seq)
		end
	end
	self.m_tbAnimEvents = {}
	self.m_frameLast = -1
	self.m_seqLast = -1
	self:AddAnimationEvent(self:LookupSequence("idle"),35,AE_NPC_LEFTFOOT)	-- example animation event for a left footstep sound
end

function ENT:AddAnimationEvent(seq,frame,ev)	-- Sequence ID, target frame and animation event
	if(!tbAnimationFrames[seq]) then return end
	self.m_tbAnimEvents[seq] = self.m_tbAnimEvents[seq] || {}
	self.m_tbAnimEvents[seq][frame] = self.m_tbAnimEvents[seq][frame] || {}
	table.insert(self.m_tbAnimEvents[seq][frame],ev)
end

function ENT:Think()
	local seq = self:GetSequence()
	if(self.m_tbAnimEvents[seq]) then
		if(self.m_seqLast != seq) then self.m_seqLast = seq; self.m_frameLast = -1 end
		local frameNew = math.floor(self:GetCycle() *tbAnimationFrames[seq])	-- Despite what the wiki says, GetCycle doesn't return the frame, but a float between 0 and 1
		for frame = self.m_frameLast +1,frameNew do	-- a loop, just in case the think function is too slow to catch all frame changes
			if(self.m_tbAnimEvents[seq][frame]) then
				for _, ev in ipairs(self.m_tbAnimEvents[seq][frame]) do
					self:HandleAnimationEvent(ev)
				end
			end
		end
		self.m_frameLast = frameNew
	end
	self:NextThink(CurTime())
	return true
end

function ENT:HandleAnimationEvent(ev)
	if(ev == AE_NPC_LEFTFOOT) then self:EmitSound("npc/stalker/stalker_footstep_left" .. math.random(1,2) .. ".wav",75,100)
	elseif(ev == AE_NPC_RIGHTFOOT) then self:EmitSound("npc/stalker/stalker_footstep_right" .. math.random(1,2) .. ".wav",75,100)
	else -- other events
	end
end