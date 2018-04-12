AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local DEBUG_POSEPARAMETERS = false
local DEBUG_OBSTACLES = false
local DEBUG_TRACES = false

-- Some helper variables
local FLY_HOVER = 1
local FLY_GLIDE = 2

local ATTACK_STATE_NONE = -1

local ATTACK_STATE_FLY_AWAY = 1
local ATTACK_STATE_FLY_APPROACH = 2
local ATTACK_STATE_FLY_HOVER = 3
local ATTACK_STATE_FLY_IDLE = 4
//local ATTACK_STATE_FLY_CIRCLE -- UNUSED

SHOUT_UNRELENTING_FORCE = 1
SHOUT_DISMAY = 2
SHOUT_ICE_STORM = 4
SHOUT_DISARM = 8
SHOUT_FIREBALL = 16
SHOUT_FIRE_BREATH = 32
SHOUT_FROST_BREATH = 64
SHOUT_DRAIN_VITALITY = 128 // Not yet implemented

local shoutParticles = {
	[SHOUT_ICE_STORM] = "dragonshout_icestorm",
	[SHOUT_FIREBALL] = "dragonshout_fireball",
	[SHOUT_FIRE_BREATH] = "dragon_fire",
	[SHOUT_FROST_BREATH] = "dragon_frost"
}

util.AddNPCClassAlly(CLASS_DRAGON,"npc_dragon")

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAGON","npc_dragon")
ENT.NPCFaction = NPC_FACTION_DRAGON
ENT.sModel = "models/skyrim/dragon.mdl"
ENT.iClass = CLASS_DRAGON
ENT.fRangeDistance = 1400
ENT.fShoutDistance = 2500
ENT.fMeleeDistance	= 80
ENT.fRangeHover = 1500
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = false
ENT.CanFly = true
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.bPlayDeathSequence = true
ENT.UseActivityTranslator = true
ENT.CollisionBounds = Vector(210,210,180)
ENT.bIgnitable = false
ENT.bFreezable = false
ENT.skName = "dragon"
ENT.m_shouts = 0
ENT.ScaleExp = 4
ENT.ScaleLootChance = 0.06

ENT._PossNoHealthRegen = true

ENT.iBloodType = BLOOD_COLOR_GREEN
ENT.sSoundDir = "npc/dragon/"

// Possessor stuff
ENT.possOffsetGround = Vector(-150,0,280)
ENT.possOffsetFlight = Vector(-400,0,150)
ENT.possOffset = ENT.possOffsetGround
//

ENT.m_tbSounds = {
	["Attack"] = "dragon_attack0[1-4].mp3",
	["AttackBite"] = "dragon_attackbite0[1-2].mp3",
	["Death"] = "dragon_death0[1-2].mp3",
	["DeathAlduinA"] = "dragon_alduin_death_a.mp3",
	["DeathAlduinB"] = "dragon_alduin_death_b.mp3",
	["DeathAlduinC"] = "dragon_alduin_death_c.mp3",
	["DeathAlduinD"] = "dragon_alduin_death_d.mp3",
	["DeathAlduinE"] = "dragon_alduin_death_e.mp3",
	//["Idle"] = "dragon_idle01.mp3",
	["Pain"] = "dragon_injured0[1-3].mp3",
	["PainFlight"] = "dragon_injuredflight01.mp3",
	["Land"] = "dragon_land0[1-2].mp3",
	["WingFlap"] = "dragon_wingflap0[1-4].mp3",
	["FootLeft"] = "foot/dragon_foot_walkl0[1-2].mp3",
	["FootRight"] = "foot/dragon_foot_walkr0[1-2].mp3",
	["Shout1a"] = "shouts/dragonshout_dragon01_a_fus.mp3",
	["Shout1b"] = "shouts/dragonshout_dragon01_b_rodah.mp3",
	["Shout2a"] = "shouts/dragonshout_dragon02_a_faas.mp3",
	["Shout2b"] = "shouts/dragonshout_dragon02_b_rumaar.mp3",
	["Shout4a"] = "shouts/dragonshout_dragon03_a_iiz.mp3",
	["Shout4b"] = "shouts/dragonshout_dragon03_b_slennus.mp3",
	["Shout8a"] = "shouts/dragonshout_dragon04_a_zun.mp3",
	["Shout8b"] = "shouts/dragonshout_dragon04_b_halviik.mp3",
	["Shout16a"] = "shouts/dragonshout_dragon05_a_yol.mp3",
	["Shout16b"] = "shouts/dragonshout_dragon05_b_torshul.mp3"
}

ENT.DamageScales = {
	[DMG_BURN] = 0.25,
	[DMG_BLAST] = 0.2,
	[DMG_SHOCK] = 1.4,
	[DMG_SONIC] = 2,
	[DMG_PARALYZE] = 0.6,
	[DMG_NERVEGAS] = 0.6,
	[DMG_POISON] = 0.5,
	[DMG_ACID] = 0.65,
	[DMG_DIRECT] = 0.3
}
ENT.tblIgnoreDamageTypes = {DMG_DISSOLVE}
AccessorFunc(ENT,"m_posFlyTarget","FlyTarget")
function ENT:OnInit()
	self:SetHullType(HULL_LARGE)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(CAP_MOVE_GROUND)
	self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	
	local cspLoop = CreateSound(self,self.sSoundDir .. "dragon_breathe_lp.wav")
	cspLoop:SetSoundLevel(65)
	cspLoop:Play()
	self.cspBreathe = cspLoop
	self:StopSoundOnDeath(cspLoop)
	
	self.m_bFlying = false
	self.m_bCrippled = false
	self.m_flSpeed = 0
	self.m_flSpeedAng = 0
	self.m_lastFlyStateChanged = 0
	self.m_nextRoar = CurTime() +math.Rand(6,30)
	
	self.m_tbPoseParam = {}
	self:AddPoseParameter("neck_lower_yaw","y",-24,24,2,"NPC Neck4")
	self:AddPoseParameter("neck_yaw","y",-30,30,2,"NPC Neck5","neck_lower_yaw")
	self:AddPoseParameter("head_yaw","y",-40,40,1,"NPC Head","neck_yaw")
	
	self:AddPoseParameter("neck_lower_pitch","p",-24,24,2,"NPC Neck4")
	self:AddPoseParameter("neck_pitch","p",-20,20,2,"NPC Neck5","neck_lower_pitch")
	self:AddPoseParameter("head_pitch","p",-20,20,1,"NPC Head","neck_pitch")
	
	self:SetSoundLevel(100)
	//self:SetSoundVolume(300)
	//self.cspFlame = CreateSound(self, self.sSoundDir .. "gar_flamerun1.wav")
	//self:StopSoundOnDeath(self.cspFlame)
	//self:SetSoundLevel(100)
	
	//timer.Simple(1,function() self:TakeOff() end)
	//timer.Simple(6,function()
	//	self:SetFlyTarget(Vector(0,0,1000))
	//end)
	
	self:SetDefaultState(NPC_STATE_ALERT)
	self.m_nextTakeOff = CurTime() +math.Rand(3,15)
	self.m_nextFlameAttack = 0
	
	self:SubInit()
	if(self:CanUseShout(SHOUT_FIRE_BREATH)) then self.DamageScales[DMG_BURN] = 0.25
	elseif(self:CanUseShout(SHOUT_FROST_BREATH)) then self.DamageScales[DMG_BURN] = 1.25 end
	
	self:SetFlyingAngles(self:GetAngles())
	self.m_nextAngleUpdate = 0
end

function ENT:SetFlyingAngles(ang) self.m_angFlying = ang end
function ENT:GetFlyingAngles() return self.m_angFlying end

function ENT:SubInit()
	if(math.random(1,2) == 1) then self:AddShouts(bit.bor(SHOUT_FIRE_BREATH,SHOUT_FIREBALL))
	else self:AddShouts(bit.bor(SHOUT_FROST_BREATH,SHOUT_ICE_STORM)) end
end

function ENT:AddShouts(shouts)
	self.m_shouts = bit.bor(self.m_shouts,shouts)
end

function ENT:RemoveShouts(shouts)
	self.m_shouts = self.m_shouts -bit.band(self.m_shouts,shouts)
end

function ENT:CanUseShout(shout,ent)
	if(bit.band(self.m_shouts,shout) == 0) then return false end
	if(!ent) then return true end
	if(!ent:IsValid()) then return false end
	if(shout == SHOUT_DISARM) then
		local wep = ent:GetActiveWeapon()
		if(!wep:IsValid()) then return false end
		return wep:GetClass() != "translator"
	elseif(shout == SHOUT_UNRELENTING_FORCE) then
		if(ent:IsNPC()) then return ent.CanBeKnockedDown && ent:CanBeKnockedDown() || false end
		return false // TODO: Player Knockdown
	end
	return true
end

function ENT:_PossStart(possessor)
	self:EndAttack()
	self:SetAttackState(ATTACK_STATE_NONE)
	self.m_bLanding = nil
	if(self.m_bTakeOff) then
		self.m_bTakeOff = nil
		self:SetFlyingAngles(self:GetAngles())
		self.m_bFlying = 1
		self:OnTakenOff()
	end
end

function ENT:_PossDuck(entPossessor,fcDone)
	if(!self.CanFly) then timer.Simple(0,fcDone) return end
	if(self:IsFlying()) then self:Land() end
end

function ENT:_PossJump(entPossessor,fcDone)
	if(!self.CanFly) then timer.Simple(0,fcDone) return end
	if(!self:IsFlying()) then self:TakeOff() end
end

function ENT:_PossPrimaryAttack(entPossessor,fcDone)
	self:StopMoving()
	self:StopMoving()
	self:UseShout()
end

function ENT:_PossSecondaryAttack(entPossessor,fcDone)
	local flying = self:IsFlying()
	if(flying) then
		if(flying == FLY_HOVER) then
			if(self:IsCrippled()) then fcDone(); return end
			self:StartHovering()
		else self:StartHovering() end
		return
	end
	//if(yaw <= 0) then return yaw >= -45 && ACT_MELEE_ATTACK1 || yaw >= -135 && ACT_MELEE_ATTACK_SWING_GESTURE || ACT_MELEE_ATTACK2 end
	//return yaw <= 45 && ACT_MELEE_ATTACK1 || yaw <= 135 && ACT_MELEE_ATTACK_SWING || ACT_MELEE_ATTACK2
	self:StopMoving()
	self:StopMoving()
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossFaceForward(entPossessor,fcDone)
	if(self:IsFlying() != FLY_GLIDE) then return true end
end

function ENT:SelectDeathActivity() return ACT_DIESIMPLE end

function ENT:DoDeath(dmginfo)
	if(self:IsFlying()) then self:Crash(true)
	else
		self:SetNPCState(NPC_STATE_DEAD)
		self:SetState(NPC_STATE_DEAD)
		//self:SetSchedule(SCHED_DIE)
		self:StopMoving()
		self:StopMoving()
		local SCHED_DIE = ai_schedule_slv.New()
		SCHED_DIE:EngTask("TASK_PLAY_SEQUENCE",self:SelectDeathActivity())
		self:StartSchedule(SCHED_DIE)
	end
end

function ENT:EndAttack()
	self.m_rattackShout = nil
	if(self:IsPossessed()) then
		self:_PossScheduleDone()
		self:ResetActivity()
	end
	self:StopParticles()
end

function ENT:SelectFlinchActivity(dmg,dmgType,hitgroup,bHeavy)
	local flying = self:IsFlying()
	if(!flying) then return bHeavy && ACT_FLINCH_CHEST || ACT_GESTURE_BIG_FLINCH end
	if(flying == FLY_HOVER) then return bHeavy && ACT_GESTURE_FLINCH_BLAST || ACT_GESTURE_FLINCH_CHEST end
	return bHeavy && ACT_FLINCH_HEAD || ACT_FLINCH_STOMACH
end

function ENT:OnLimbCrippled(hitbox,attacker)
	if(hitbox == HITBOX_LEFTARM || hitbox == HITBOX_RIGHTARM) then
		self.m_bCrippled = true
		if(self:IsFlying() == FLY_GLIDE) then
			if(self:GetActivity() == ACT_IDLE) then self:ResetActivity() end
			self.m_tmForceLand = CurTime() +6
		end
	end
end

function ENT:IsCrippled() return self.m_bCrippled end

function ENT:CustomFlinch(dmginfo,hitgroup)
	self:EndAttack()
	self:PlaySound("Pain")
	if(self.m_bTakeOff) then return end
	local dmgType = dmginfo:GetDamageType()
	local dmg = dmginfo:GetDamage()
	local bHeavy = dmgType == DMG_BLAST || dmgType == DMG_DISSOLVE || dmgType == DMG_SHOCK || dmgType == DMG_SONIC || dmgType == DMG_ENERGYBEAM
		|| dmgType == DMG_PLASMA || dmgType == DMG_BLAST_SURFACE || dmg >= 60
	if(self:IsFlying() && bHeavy && math.random(1,7) == 1) then	-- Slight chance of crashing to the ground
		--self:Crash()
		return
	end
	local act = self:SelectFlinchActivity(dmg,dmgType,hitgroup,bHeavy)
	self:StopMoving()
	self:PlayActivity(act)
	self:OnFlinch(dmginfo:GetAttacker(),hitgroup)
end

function ENT:SelectDefaultSchedule()
	-- Our usual idle behavior
	if(self:IsFlying() || !self.CanFly) then return end
	if(CurTime() >= self.m_nextTakeOff) then
		self.m_nextTakeOff = CurTime() +math.Rand(8,30)
		if(math.random(1,3) <= 3) then
			self:TakeOff()
		end
	end
end

function ENT:OnAreaCleared()
	self:SetAttackState(ATTACK_STATE_NONE)
	local flying = self:IsFlying()
	if(flying) then
		if(self:IsCrippled()) then self:Land(); return end
		if(flying == FLY_HOVER) then	// TODO: Randomly land instead?
			self:StartGliding()
			self:FlyToRandomPosition()
		elseif(flying == FLY_GLIDE) then self:FlyToRandomPosition() end
	end
end

function ENT:OnFoundEnemy(numEnemies)
	if(!self.CanFly || self:IsPossessed()) then return end
	if(!self:IsFlying()) then
		if((self:IsCrippled() && (!IsValid(self.entEnemy) || !self:IsInHoverRange(self.entEnemy,-100))) || math.random(1,4) == 1) then return end -- Stay on the ground for now
		self:TakeOff()
		return
	end
	local ent = self.entEnemy
	if(!IsValid(ent)) then self:SetAttackState(ATTACK_STATE_FLY_APPROACH); return end
	local dist = self:GetAirDistance(ent:GetPos())
	if(dist >= 2600) then self:SetAttackState(ATTACK_STATE_FLY_APPROACH)
	else self:SetAttackState(ATTACK_STATE_FLY_AWAY) end
end

function ENT:IsInHoverRange(ent,offset)
	return self:GetAirDistance(ent:GetPos()) <= self.fRangeHover
end

function ENT:OnTakenOff()
	self.m_lastFlyStateChanged = CurTime()
	local bPossessed = self:IsPossessed()
	if(!bPossessed && IsValid(self.entEnemy)) then
		if(self:IsInHoverRange(self.entEnemy) || self:IsCrippled()) then
			self:SetAttackState(ATTACK_STATE_FLY_HOVER)
			return
		end
		self:StartHovering()
		local dist = self:GetAirDistance(self.entEnemy:GetPos())
		if(dist >= 2600) then self:SetAttackState(ATTACK_STATE_FLY_APPROACH)
		else self:SetAttackState(ATTACK_STATE_FLY_AWAY) end
		return
	end--elseif(self:IsCrippled()) then self:Land(); return end
	self:StartHovering()
	self.possOffset = self.possOffsetFlight
	if(bPossessed) then
		local possessor = self:GetPossessor()
		possessor:SetPossessionCamPos(self.possOffset)
		return
	end
	self:FlyToRandomPosition()
end

function ENT:FlyToRandomPosition()
	self:SetFlyTarget(self:FindRandomFlyPosition())
end

function ENT:OnReachedFlyTarget()
	if(!IsValid(self.entEnemy)) then
		self:FlyToRandomPosition()
		return
	end
	local attackState = self:GetAttackState()
	if(attackState == ATTACK_STATE_FLY_AWAY) then
		self:SetAttackState(ATTACK_STATE_FLY_APPROACH)
	elseif(attackState == ATTACK_STATE_FLY_IDLE) then
		self:SetAttackState(ATTACK_STATE_FLY_AWAY)
	end
end

function ENT:SetVelocityForce(force,tmFull,tmEndStart,tmEnd)
	local tm = CurTime()
	self.m_tbVelForce = {
		force = force,
		tmStart = tm,
		tmFull = tm +tmFull,
		tmEndStart = tmEndStart && tm +tmEndStart || nil,
		tmEnd = tmEnd && tm +tmEnd || nil
	}
end

function ENT:FlyToPos(pos)
	self:SetFlyTarget(pos)
end

function ENT:GetMaxSpeed() return 750 end

function ENT:GetAcceleration() return 15 end

function ENT:GetSpeed() return self.m_flSpeed end

function ENT:GetAirDistance(pos)
	pos = Vector(pos.x,pos.y,self:GetPos().z)
	return self:NearestPoint(pos):Distance(pos)
end

function ENT:GetLookTarget()
	return IsValid(self.entEnemy) && self.entEnemy || self.m_entLook || NULL
end

function ENT:SetLookTarget(ent) self.m_entLook = ent end

function ENT:AddPoseParameter(pp,axis,min,max,speed,bone,parent)
	self.m_tbPoseParam[pp] = {
		min = min,
		max = max,
		axis = axis,
		speed = speed,
		parent = parent,
		bone = self:LookupBone(bone),
		cur = 0
	}
end

function ENT:GetPredictedPoseParameter(pp,tgt,ppChild)
	local data = self.m_tbPoseParam[pp]
	local pos,ang,posParent,angParent
	if(data.parent) then
		local axisParent
		axisParent,posParent,angParent,pos,ang = self:GetPredictedPoseParameter(data.parent,tgt,pp)
	else pos,ang = self:GetBonePosition(data.bone) end
	local angReal = Angle(ang.p,ang.y,ang.r)
	local angTgt = (tgt -pos):Angle()
	local axisOrigin = ang[data.axis] -data.cur
	local axis = math.ClampAngle(angTgt[data.axis],axisOrigin +data.min,axisOrigin +data.max)
	
	ang[data.axis] = axis
	local posChild,angChild
	if(DEBUG_POSEPARAMETERS) then util.CreateSpriteTrace(pos,pos +Vector(0,0,100),0.1,60,Color(0,255,0,255)) end
	if(ppChild) then
		local child = self.m_tbPoseParam[ppChild]
		posChild,angChild = self:GetBonePosition(child.bone)
		local dist = pos:Distance(posChild)
		posChild = pos +ang:Forward() *dist
		angChild = angChild +(ang -angReal)
		if(DEBUG_POSEPARAMETERS) then util.CreateSpriteTrace(pos,posChild,0.1,60,Color(0,0,255,255)) end
	end
	return math.NormalizeAngle(ang[data.axis] -axisOrigin),pos,ang,posChild || posParent || pos,angChild || angParent || ang
end

function ENT:MaintainPoseParameter(pp,pos)
	local data = self.m_tbPoseParam[pp]
	local tgt
	if(!pos) then tgt = 0
	else tgt = self:GetPredictedPoseParameter(pp,pos) end
	data.cur = math.Clamp(math.ApproachAngle(data.cur,tgt,data.speed),data.min,data.max)
	tgt = math.Clamp(tgt,data.min,data.max)
	self:SetPoseParameter(pp,data.cur)
end

function ENT:MaintainPoseParameters(posLook)
	-- Order is important
	self:MaintainPoseParameter("neck_lower_yaw",posLook)
	self:MaintainPoseParameter("neck_lower_pitch",posLook)
	self:MaintainPoseParameter("neck_yaw",posLook)
	self:MaintainPoseParameter("neck_pitch",posLook)
	self:MaintainPoseParameter("head_yaw",posLook)
	self:MaintainPoseParameter("head_pitch",posLook)
end

local scVelKeep = 0//0.05
local scAxisKeep = 0.05
local axisLimit = Angle(30,0,90)
local axisTurnSpeed = Angle(10,10,10)

function ENT:ApproachAngle(angTgt)
	local ang = self:GetFlyingAngles()
	/*if(self.m_avoidDir) then	-- We're close to an obstacle, so we'll try to avoid it by flying in the opposite direction
		local yawDiff = math.AngleDifference(ang.y,angTgt.y)
		if(self.m_avoidDir == 0) then if(yawDiff < 0) then angTgt.y = ang.y +yawDiff *-1 end -- MoveToRight
		elseif(yawDiff > 0) then angTgt.y = ang.y +yawDiff *-1 end
	end // TODO: Does it actually work properly?*/
	// Yaw
	ang.y = math.ApproachAngle(ang.y,angTgt.y,math.min((math.abs(math.AngleDifference(ang.y,angTgt.y)) *scAxisKeep) *axisTurnSpeed.y,axisTurnSpeed.y))
	
	// Roll
	local rTgt = math.sin(math.rad(math.AngleDifference(ang.y,angTgt.y)))
	ang.r = math.ApproachAngle(ang.r,axisLimit.r *rTgt,axisTurnSpeed.r)
	
	// Pitch
	ang.p = math.ApproachAngle(ang.p,math.ClampAngle(angTgt.p,-axisLimit.p,axisLimit.p),math.min((math.abs(math.AngleDifference(ang.p,angTgt.p) *scAxisKeep)) *axisTurnSpeed.p,axisTurnSpeed.p))

	self:SetFlyingAngles(Angle(angTgt.p, angTgt.y, angTgt.r))
end

function ENT:FindLookTarget()
	if(self:IsPossessed()) then return self:GetPossessor():GetPossessionEyeTrace().HitPos end
	local entLook = self:GetLookTarget()
	if(!entLook:IsValid() || !self:Visible(entLook) || self:IsDead() || (IsValid(self.entEnemy) && entLook == self.entEnemy && self:GetAttackState() == ATTACK_STATE_FLY_AWAY)) then return end
	return entLook:GetPos() +entLook:OBBCenter()
end

function ENT:FindFlyTarget()
	if(!self:IsPossessed()) then return self:GetFlyTarget() end
	local entPossessor = self:GetPossessor()
	return self:GetPos() +entPossessor:GetAimVector() *800
end

util.AddNetworkString("dragon_roar")
function ENT:OnThink()
	self:UpdateLastEnemyPositions()
	if(CurTime() >= self.m_nextRoar) then
		self.m_nextRoar = CurTime() +math.Rand(18,60)
		if(math.random(1,2) == 1) then
			net.Start("dragon_roar")
				net.WriteEntity(self)
			net.Broadcast()

			util.ScreenShake(self:GetPos(), 5, 5, 5, 5000)
		end
	end
	local posLook = self:FindLookTarget()
	self:MaintainPoseParameters(posLook)
	local flying = self:IsFlying()
	if(flying || self.m_bTakeOff) then
		// TODO: Clean this stuff up
		if(flying == FLY_HOVER) then
			local ang = self:GetFlyingAngles()
			ang.p = 0
			ang.r = 0
			if(posLook) then
				local pos = self:GetPos()
				ang.y = (posLook -pos):Angle().y
			end
			self:ApproachAngle(ang)
		elseif(self.m_tmForceLand && CurTime() >= self.m_tmForceLand) then
			self.m_tmForceLand = nil
			if(flying == FLY_GLIDE) then self:Land() end
		end
		local vel = vector_origin
		if(self.m_bLongCrash) then	-- Long crash
			local pos = self:GetPos()
			local endpos = pos +self:GetVelocity():GetNormal() *150
			local tr  = self:TracePath(pos,endpos)
			if(tr.Hit) then
				self:OnCrash()
				self:PlayActivity(ACT_SIGNAL2)
			end
		end
		if(self.m_tbVelForce) then
			local fData = self.m_tbVelForce
			local tm = CurTime()
			local tmDiff = tm -fData.tmStart
			local force = fData.force.x *self:GetForward() +fData.force.y *self:GetRight() +Vector(0,0,fData.force.z)
			if(fData.tmEndStart && CurTime() >= fData.tmEndStart) then
				if(!fData.tmEnd) then self.m_tbVelForce = nil
				else
					local tmFade = fData.tmEnd -fData.tmEndStart
					local tmDiff = tm -fData.tmEndStart
					if(tmDiff >= tmFade) then self.m_tbVelForce = nil
					else vel = force *(1 -(tmDiff /tmFade)) end
				end
			else
				local tmDiffFull = fData.tmFull -fData.tmStart
				vel = force *math.min(tmDiff /tmDiffFull,1)
			end
		elseif(flying) then
			vel = self:GetVelocity()
			local len = vel:Length()
			vel = self:GetForward() *len *(1 -scVelKeep) +vel *len *scVelKeep
			local posTgt = self:FindFlyTarget()
			if(self.m_bLanding && flying == FLY_GLIDE) then
				local posSelf = self:GetPos()
				posTgt = posSelf +self:GetForward() *1000 -self:GetUp() *500
				local tr = self:TracePath(posSelf,posTgt)
				if(tr.Fraction <= 0.175) then self:OnLanded()
				else
					local ang = self:GetFlyingAngles()
					ang.r = 0
					ang.p = axisLimit.p *0.8
					if(!self:IsPossessed()) then ang.p = tr.Fraction *ang.p end
					self:ApproachAngle(ang)
				end
			elseif(self:GetAttackState() == ATTACK_STATE_FLY_APPROACH) then
				local ent = self.entEnemy
				if(!IsValid(ent)) then self:Land(); self:EndAttack()
				else
					local posEnt = ent:GetPos()
					local dist = self:GetAirDistance(posEnt)
					if(self.m_bGlideApproach) then
						if(self.m_bGlideApproach == 3) then
							if(dist <= 2000) then
								self:Land()
								self.m_bGlideApproach = nil
							end
						elseif(dist >= 200) then
							if(self.m_bGlideApproach == 2) then
								local pos = self:GetPos()
								local dir = (posEnt -pos):GetNormal()
								dir.z = 0
								local dirAng = self:GetFlyingAngles():Forward()
								dirAng.z = 0
								local dotProd = dir:DotProduct(dirAng)
								if(dotProd <= 0.5) then
									self.m_bGlideApproach = nil
									self:SetAttackState(ATTACK_STATE_FLY_IDLE)
									posTgt = self:GetFlyTarget()
								end
							end
						else self.m_bGlideApproach = 2 end
					elseif(dist <= self.fRangeHover -100) then
						self:SetAttackState(ATTACK_STATE_FLY_HOVER)
					end
				end
			end
			//if(flying == FLY_GLIDE) then
			//	posTgt = self:GetPos() +self:GetForward() *600
			//end
			if(flying != FLY_HOVER && posTgt) then
				if(DEBUG_TRACES) then util.CreateSpriteTrace(posTgt,posTgt +Vector(0,0,500),0.1,60,Color(255,0,255,255)) end
				local pos = self:GetPos()
				local dirTgt = (posTgt -pos):GetNormal()
				local dirCur = self:GetForward()
				local dirNew = dirCur +(dirTgt -dirCur) *0.5
				dirNew = self:ImproveDirection(dirNew,self.m_flSpeed +(self:GetAcceleration() *2))
				local ang = dirNew:Angle()
				self:ApproachAngle(ang)
				
				local dirLast = vel:GetNormal()
				local dotProd
				local len = vel:Length()
				if(len == 0) then dotProd = 1
				else dotProd = math.max(dirLast:DotProduct(dirNew),-0.5) end
				self.m_flSpeed = math.Clamp(self.m_flSpeed +self:GetAcceleration() *dotProd,self:GetMaxSpeed() *-1,self:GetMaxSpeed())
				local speedKeep = math.abs(self.m_flSpeed *0.975)
				if(len <= self:GetMaxSpeed() *0.01) then speedKeep = len end
				local speedNewDir = math.abs(self.m_flSpeed) -speedKeep
				vel = dirLast *math.min(len,speedKeep) +dirNew *speedNewDir
				
				if(!self.m_bLanding) then
					local dist = self:GetAirDistance(posTgt) // self:NearestPoint(posTgt):GetAirDistance(posTgt) // TODO: What about the height?
					if(dist <= 20) then
						self:OnReachedFlyTarget()
					end
				end
			else vel = self:GetVelocity() end //vel = vel *0.95 end
		end
		if(CurTime() >= self.m_nextAngleUpdate) then
			self:SetAngles(self:GetFlyingAngles())
			self.m_nextAngleUpdate = CurTime() +0.02
		end
		self:SetLocalVelocity(vel)
		self:NextThink(CurTime())
		return true
	end
	if(posLook) then
		self:NextThink(CurTime())
		return true
	end
end

local angDown = Angle(16,0,0)
local angSide = Angle(0,25,0)
function ENT:ImproveDirection(dir,speed)	-- Checking for obstacles and trying to avoid them. Speed is just aproximately.
	local ang = dir:Angle()
	local angDown = ang +angDown
	local angLeft = ang +angSide
	local angRight = ang -angSide
	local dirForward = ang:Forward()
	local dirDown = angDown:Forward()
	local dirLeft = angLeft:Forward()
	local dirRight = angRight:Forward()
	
	local pos = self:GetPos()
	local trLeft = self:TracePath(pos,pos +dirLeft *speed)
	local trRight = self:TracePath(pos,pos +dirRight *speed)
	if(trLeft.Hit || trRight.Hit) then
		if(trLeft.Fraction < trRight.Fraction) then
			ang.y = ang.y -(1 -trLeft.Fraction) *20 -- Try to move to the right
			self.m_avoidDir = 0
		else
			ang.y = ang.y +(1 -trRight.Fraction) *20 -- To the left
			self.m_avoidDir = 1
		end
	else self.m_avoidDir = nil end
	if(DEBUG_OBSTACLES) then	-- Start the lightshow!
		util.CreateSpriteTrace(pos,trRight.HitPos,1,60,Color(255,0,255,255))
		util.CreateSpriteTrace(pos,trDown.HitPos,1,60,Color(0,255,255,255))
	end
	if(!self.m_bLanding) then	-- Ignore this shit when landing
		if(self:GetAttackState() != ATTACK_STATE_FLY_APPROACH) then speed = speed *0.3 end -- We're a bit more tolerant if we're attacking.
		local tr = self:TracePath(pos,pos +dirForward *speed *2)
		local trDown = self:TracePath(pos,pos +dirDown *speed)
		if(DEBUG_OBSTACLES) then	-- Start the lightshow!
			util.CreateSpriteTrace(pos,tr.HitPos,1,60,Color(255,255,255,255))
			util.CreateSpriteTrace(pos,trLeft.HitPos,1,60,Color(255,255,0,255))
		end
		if(trDown.Hit || tr.Hit) then
			local pMin = axisLimit.p *-1
			ang.p = ang.p +trDown.Fraction *math.AngleDifference(pMin,ang.p)
			local fractionMin
			local degTurn
			tr.Fraction = math.min(tr.Fraction,0.8)
			if(tr.Fraction <= trDown.Fraction) then -- Something big directly in front of us? Try to fly around it asap
				fractionMin = tr.Fraction
				degTurn = 45
			else
				fractionMin = trDown.Fraction
				degTurn = 20
			end
			if(fractionMin <= 0.8) then -- Try to move to the side if we're very close
				local yawAdd = (1 -fractionMin /0.8) *degTurn
				if(trLeft.Fraction < trRight.Fraction) then -- TODO: Random direction if both sides are clear?
					ang.y = ang.y -yawAdd
				else
					ang.y = ang.y +yawAdd
				end
			end
		end
	end
	dir = ang:Forward()
	return dir
end

function ENT:OnLanded()
	self:TransitionToGroundMovement()
	self:OnHitGround()
	self:PlayActivity(ACT_LAND,false,self._PossScheduleDone)
end

function ENT:OnHitGround()
	self.m_bLanding = nil
	self.m_bLongCrash = nil
	self.m_nextTakeOff = CurTime() +math.Rand(12,45)
	self.m_lastFlyStateChanged = CurTime()
	local min = self:OBBMins()
	local max = self:OBBMaxs()
	local pos = self:GetPos() -Vector(0,0,math.abs(min.z) +math.abs(max.z))
	for _, ent in ipairs(ents.FindInBox(pos +min,pos +max)) do
		if(((ent:IsPlayer() || (ent:IsNPC() && ent != self)) && self:Disposition(ent) != D_LI) || ent:IsPhysicsEntity()) then
			local dmginfo = DamageInfo()
			dmginfo:SetDamageType(DMG_SLASH)
			dmginfo:SetDamage(ent:IsPlayer() && 38 || 400)
			dmginfo:SetAttacker(self)
			dmginfo:SetInflictor(self)
			ent:TakeDamageInfo(dmginfo)
		end
	end
	local pos = self:GetPos()
	for i = 1,4 do
		util.ScreenShake(pos,1000,1000,2,1500)	// Increasing the amplitude or frequency doesn't do much. Stacking these, however, does
	end
	self:PlaySound("Land")
	self:CreateDustWave(pos,560)
	self.possOffset = self.possOffsetGround
	if(self:IsPossessed()) then
		local possessor = self:GetPossessor()
		possessor:SetPossessionCamPos(self.possOffset)
	end
end

function ENT:TransitionToGroundMovement()
	self.m_bFlying = false
	self:SetMoveType(MOVETYPE_STEP)
	self:CapabilitiesClear()
	self:CapabilitiesAdd(CAP_MOVE_GROUND)
	self:SetAIType(AI_TYPE_GROUND)
	local ang = self:GetAngles()
	ang.p = 0
	ang.r = 0
	self:SetAngles(ang)
end

function ENT:TranslateActivity(act)
	//print("Translating activity " .. self:GetActivityName(act))
	if(act == ACT_IDLE) then
		local flying = self:IsFlying()
		if(flying) then
			if(self.m_bLongCrash) then return ACT_SHIPLADDER_UP end
			return flying == FLY_GLIDE && self:GetVelocity():Length() >= 50 && (!self:IsCrippled() && ACT_FLY || ACT_RUN_SCARED) || ACT_IDLE_AGITATED
		end
	end
	return act
end

function ENT:GenerateInventory()
	if(math.random(1,5) <= 4) then self:AddToInventory("000SPHV",math.random(1,3)) end
	if(math.random(1,6) <= 5) then self:AddToInventory("000PISZ",math.random(1,4)) end
end

function ENT:CreateDustWave(pos,scale)
	local effectdata = EffectData()
	effectdata:SetOrigin(pos)
	effectdata:SetScale(scale || 460)
	util.Effect("ThumperDust",effectdata) 
end

function ENT:StartGliding()
	if(!self:IsHovering()) then return end
	self:StopMoving()
	self:StopMoving()
	self:PlayActivity(ACT_SIGNAL_ADVANCE,false,self._PossScheduleDone)
	self.m_bFlying = 2
	self.m_lastFlyStateChanged = CurTime()
	self.possOffset = self.possOffsetFlight
	if(self:IsPossessed()) then
		local possessor = self:GetPossessor()
		possessor:SetPossessionCamPos(self.possOffset)
	end
end

function ENT:StartHovering()
	if(!self:IsGliding()) then return end
	self:StopMoving()
	self:StopMoving()
	self:PlayActivity(ACT_SIGNAL_HALT,false,self._PossScheduleDone)
	self.m_bFlying = 1
	self.m_lastFlyStateChanged = CurTime()
	self:SetVelocityForce(self:GetLocalVelocity(),0,0,2)
	self.possOffset = self.possOffsetGround
	if(self:IsPossessed()) then
		local possessor = self:GetPossessor()
		possessor:SetPossessionCamPos(self.possOffset)
	end
end

function ENT:TakeOff()
	if(!self.CanFly || self:IsFlying()) then return end
	self:SetMoveType(MOVETYPE_FLY)
	self:CapabilitiesClear()
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_FLY,CAP_SKIP_NAV_GROUND_CHECK))
	self:SetAIType(AI_TYPE_AIR)
	self:PlayActivity(ACT_HOP)
	self.m_bTakeOff = true
	self:SetFlyingAngles(self:GetAngles())
	self:SetVelocityForce(Vector(0,0,280),2,4)
end

function ENT:Land()
	local flying = self:IsFlying()
	if(!flying) then return end
	self.m_bLanding = true
	self:SetFlyingAngles(self:GetAngles())
	if(flying == FLY_HOVER) then
		// TODO: Don't land immediately if we're too high
		self:SetVelocityForce(Vector(0,0,-1200),0.3,0,6)
		self:PlayActivity(ACT_LEAP)
		return
	end
	self:ResetActivity()
end

function ENT:GetMouthAttachment()
	return self:LookupAttachment(self:IsFlying() && "mouth" || "mouth_ground")
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "foot") then
		local foot = select(2,...)
		self:EmitEventSound(foot == "left" && "FootLeft" || "FootRight")
		util.ScreenShake(self:GetPos(),100,100,1,1000)
		return true
	end
	if(event == "inhale") then
		if(self.m_rattackShout && self.m_rattackShout != SHOUT_FROST_BREATH && self.m_rattackShout != SHOUT_FIRE_BREATH) then self:PlaySound("Shout" .. self.m_rattackShout .. "a") end
		return true
	end
	if(event == "exhale") then
		if(self.m_rattackShout == SHOUT_FROST_BREATH || self.m_rattackShout == SHOUT_FIRE_BREATH) then
			self:PlaySound("Attack")
		end
		self:PlayActivity(self:SelectShoutActivity(self.m_rattackShout),!self:IsFlying(),self:IsPossessed() && self._PossScheduleDone)
		return true
	end
	if(event == "rattack") then
		local type = select(2,...)
		if(type == "firebreath") then
			local act = select(3,...)
			if(act == "hit") then self:RangeAttack()	-- Unleash hell on everything below
			elseif(act == "start") then
				if(!self.m_rattackShout) then return true end	-- Something unexpected happened that ended the attack prematurely (This actually shouldn't happen, but it does, usually when flinching) TODO: Find cause?
				local att = self:GetMouthAttachment()
				ParticleEffectAttach(shoutParticles[self.m_rattackShout] || "dragon_fire",PATTACH_POINT_FOLLOW,self,att)
			elseif(act == "end") then self:EndAttack() end
		end
		return true
	end
	if(event == "mattack") then
		local dist = self.fMeleeDistance +300
		local dmg = GetConVarNumber("sk_" .. self.skName .. "_dmg_slash")
		local ang
		local force
		local atk = select(2,...)
		local fcHit
		local fcRot
		local bNoSound
		if(!atk) then
			ang = Angle(-35,-12,6)
			force = Vector(120,0,0)
			fcRot = function(ent)
				local ang = self:GetAngles()
				local angToEnemy = (ent:GetPos() -self:GetPos()):Angle()
				local yaw = math.AngleDifference(ang.y,angToEnemy.y)
				return yaw >= -45 && yaw <= 45
			end
		elseif(atk == "tail") then
			self:CreateDustWave(self:GetPos() -self:GetForward() *450)
			util.ScreenShake(self:GetPos(),160,160,1.25,1000)
			ang = Angle(56,0,0)
			force = Vector(120,0,0)
			fcRot = function(ent)
				local ang = self:GetAngles()
				local angToEnemy = (ent:GetPos() -self:GetPos()):Angle()
				local yaw = math.AngleDifference(ang.y,angToEnemy.y)
				return yaw < -135 || yaw > 135
			end
			bNoSound = true
			self:EmitEventSound(math.random(1,2) == 1 && "FootLeft" || "FootRight")
		elseif(atk == "wings") then
			dmg = 10
			local dir = select(3,...)
			ang = Angle(35,0,0)
			force = vector_origin
			local force = self:GetRight() *(dir == "right" && 1 || -1) *600 +Vector(0,0,200)
			fcRot = function(ent)
				local ang = self:GetAngles()
				local angToEnemy = (ent:GetPos() -self:GetPos()):Angle()
				local yaw = math.AngleDifference(ang.y,angToEnemy.y)
				if(dir == "right") then return yaw > 45 && yaw <= 135 end
				return yaw < -45 && yaw >= -135
			end
			fcHit = function(ent,dmginfo)
				ent:SetGroundEntity()
				ent:SetVelocity(force)
			end
		end
		self:DealMeleeDamage(dist,dmg,ang,force,nil,fcRot,bNoSound,true,fcHit)
		return true
	end
	if(event == "fly") then
		local act = select(2,...)
		if(act == "start") then
			self.m_bTakeOff = nil
			self.m_bFlying = 1
			self:OnTakenOff()
		end
		return true
	end
	if(event == "crash") then
		local type = select(2,...)
		if(type == "long") then
			self:PlayActivity(ACT_SIGNAL3,false,self._PossScheduleDone) -- We're done crashing. Standing up
		else	-- Short crash; We just hit the ground
			self:OnCrash()
			self:PlayActivity(ACT_SIGNAL_LEFT,false,self._PossScheduleDone)
		end
		return true
	end
	if(event == "shout") then
		if(!self.m_rattackShout) then return true end
		local att = self:GetAttachment(self:GetMouthAttachment())
		self:PlaySound("Shout" .. self.m_rattackShout .. "b")
		local pos = att.Pos
		local ang = att.Ang
		if(IsValid(self.entEnemy)) then
			ang = util.GetConstrictedDirection(pos,self.entEnemy:GetHeadPos(),ang,Angle(30,30,30)):Angle()
		end
		self:RangeAttack()
		ParticleEffect(shoutParticles[self.m_rattackShout] || "dragonshout",pos,ang,self)
		return true
	end
end

local cvMusic = GetConVar("sk_dragon_chance_music")
function ENT:InitSandbox()
	self:RemoveShouts(SHOUT_UNRELENTING_FORCE) // These only work in aftermath
	local f = cvMusic:GetFloat()
	if(f == 0) then return end
	if(math.Rand(0,1) <= f && !SLVBase.IsSoundtrackNPCActive(self)) then self:PlaySoundtrack() end
end

function ENT:DisarmTarget(ent)
	if(!ent:IsPlayer() && !ent:IsNPC()) then return end
	local wep = ent:GetActiveWeapon()
	if(!wep:IsValid() || wep:GetClass() == "translator") then return end
	local class = wep:GetClass()
	if(ent:IsPlayer()) then
		ent:StripWeapon(class)
		if(ent:GetWeapon(class):IsValid()) then return end // Can't remove the weapon?
	else wep:Remove() end
	local pos = ent:GetShootPos()
	local att = self:GetAttachment(self:GetMouthAttachment())
	local dir = (pos -att.Pos):GetNormal()
	local ent = ents.Create(class)
	ent:SetPos(pos +dir *60)
	ent:SetAngles(dir:Angle())
	ent:SetKeyValue("spawnflags","2") // Disable player pickup
	ent:Spawn()
	ent:Activate()
	timer.Simple(0.5,function()
		if(ent:IsValid()) then
			ent:SetKeyValue("spawnflags","0") // Enable player pickup
		end
	end)
	local phys = ent:GetPhysicsObject()
	if(!phys:IsValid()) then ent:DropToFloor()
	else phys:ApplyForceCenter(dir *500 *phys:GetMass()) end
end

function ENT:IgniteTarget(ent,pl,npc)
	if(ent:IsPlayer()) then
		local sc = GetConVarNumber("sk_dragon_ignite_scalar_players")
		if(sc == 0) then return end
		ent:Ignite(pl *sc)
		return
	end
	local sc = GetConVarNumber("sk_dragon_ignite_scalar_npcs")
	if(sc == 0) then return end
	ent:Ignite(npc *sc,0)
end

function ENT:OnHit(ent)
	local shout = self.m_rattackShout
	if(!shout) then return end
	if(shout == SHOUT_FIRE_BREATH) then
		self:IgniteTarget(ent,2,8)
		local dmginfo = DamageInfo()
		dmginfo:SetDamageType(DMG_SLOWBURN)
		dmginfo:SetDamage(GetConVarNumber("sk_" .. self.skName .. "_dmg_flame"))
		if(ent:IsPlayer()) then dmginfo:ScaleDamage(0.25) end
		dmginfo:SetAttacker(self)
		dmginfo:SetInflictor(self)
		ent:TakeDamageInfo(dmginfo)
		return
	end
	if(shout == SHOUT_FROST_BREATH) then
		if(ent:IsNPC() || ent:IsPlayer()) then ent:SetFrozen(5) end
		local dmginfo = DamageInfo()
		dmginfo:SetDamageType(DMG_GENERIC)
		dmginfo:SetDamage(GetConVarNumber("sk_" .. self.skName .. "_dmg_flame"))
		if(ent:IsPlayer()) then dmginfo:ScaleDamage(0.25) end
		dmginfo:SetAttacker(self)
		dmginfo:SetInflictor(self)
		ent:TakeDamageInfo(dmginfo)
		return
	end
	if(shout == SHOUT_UNRELENTING_FORCE) then
		if(ent:IsPlayer() || (ent.CanBeKnockedDown && ent:CanBeKnockedDown())) then
			local ragdoll = ent:KnockDown(3)
			if(IsValid(ragdoll)) then
				local att = self:GetAttachment(self:GetMouthAttachment())
				local pos = att.Pos
				ragdoll:SetVelocity((pos -ragdoll:GetPos()):GetNormal() *2000)
			end
		end
		return
	end
	if(shout == SHOUT_DISMAY) then
		if(ent:IsNPC()) then
			-- TODO: Reset relationship after a short while?
			ent:AddEntityRelationship(self,D_FR,100)
			return
		end
	end
	if(shout == SHOUT_ICE_STORM) then
		if(ent:IsPlayer() || (ent.CanBeFrozen && ent:CanBeFrozen())) then ent:SetFrozen(60) end
		local dmginfo = DamageInfo()
		dmginfo:SetDamageType(DMG_GENERIC)
		dmginfo:SetDamage(GetConVarNumber("sk_" .. self.skName .. "_dmg_flame") *2)
		if(ent:IsPlayer()) then dmginfo:ScaleDamage(0.5) end
		dmginfo:SetAttacker(self)
		dmginfo:SetInflictor(self)
		ent:TakeDamageInfo(dmginfo)
		return
	end
	if(shout == SHOUT_DISARM) then
		if(GAMEMODE.Aftermath) then
			if((ent:IsPlayer() || ent.Humanoid) && ent.Disarm) then
				local wep = ent:Disarm()
				if(IsValid(wep)) then
					local phys = wep:GetPhysicsObject()
					if(phys:IsValid()) then
						phys:EnableMotion(true)
						local att = self:GetAttachment(self:GetMouthAttachment())
						local pos = att.Pos
						local posWep = wep:GetPos()
						phys:ApplyForceCenter((pos -posWep):GetNormal() *2000)
					end
				end
			end
		else self:DisarmTarget(ent) end
		return
	end
	if(shout == SHOUT_FIREBALL) then
		self:IgniteTarget(ent,6,12)
		local dmginfo = DamageInfo()
		dmginfo:SetDamageType(DMG_SLOWBURN)
		dmginfo:SetDamage(GetConVarNumber("sk_" .. self.skName .. "_dmg_flame") *2)
		if(ent:IsPlayer()) then dmginfo:ScaleDamage(0.5) end
		dmginfo:SetAttacker(self)
		dmginfo:SetInflictor(self)
		ent:TakeDamageInfo(dmginfo)
	end
end

function ENT:RangeAttack()
	local att = self:GetAttachment(self:GetMouthAttachment())
	local pos = att.Pos
	local dir = att.Ang:Forward()
	local dist
	if(self.m_rattackShout != SHOUT_FIRE_BREATH && self.m_rattackShout != SHOUT_FROST_BREATH) then dist = self.fShoutDistance
	else dist = self.fRangeHover +75 end
	local cone = 0.4
	for _, ent in ipairs(ents.FindInSphere(pos,dist)) do
		if(ent:IsValid() && ent != self && self:IsEnemy(ent) && self:Visible(ent)) then
			local posEnt = ent:GetPos() +ent:OBBCenter()
			local dirEnt = (posEnt -pos):GetNormal()
			if(1 -dirEnt:DotProduct(dir) <= cone) then
				self:OnHit(ent)
			end
		end
	end
	if(self.m_rattackShout != SHOUT_FIRE_BREATH) then return end
	local tr = self:TracePath(pos,pos +dir *dist)
	if(tr.HitWorld) then
		local ent = ents.Create("env_fire")
		ent:SetPos(tr.HitPos)
		ent:SetKeyValue("health",8)
		ent:SetKeyValue("firesize",120)
		ent:SetKeyValue("spawnflags",134)
		ent:Spawn()
		ent:Activate()
		local csp = CreateSound(ent,"ambient/fire/fire_small1.wav")
		csp:Play()
		ent:CallOnRemove("stopflamesound",function()
			if(csp) then csp:Stop() end
		end)
	end
end

function ENT:OnCrash()
	self:OnHitGround()
	if(self:IsDead()) then
		self:SetNPCState(NPC_STATE_DEAD)
		self:SetState(NPC_STATE_DEAD)
		self:SetSchedule(SCHED_DIE_RAGDOLL)
		self:DoRagdollDeath(dmginfo)
		return
	end
	self:TransitionToGroundMovement()
end

function ENT:GetDistanceToFloor()
	local pos = self:GetPos()
	local tr = self:TracePath(pos,pos -Vector(0,0,32768))
	return pos:Distance(tr.HitPos)
end

function ENT:Crash(bForceLong)
	// TODO: Prevent flinch (And any other interrupts) while crashing or landing
	local flying = self:IsFlying()
	if(!flying) then return end
	if(!bForceLong && flying == FLY_HOVER) then self:Land(); return end -- If we're hovering, just land like usual
	local vel = self:GetVelocity()
	vel.x = math.max(vel.x,1600)
	vel.z = -1200
	self:SetVelocityForce(vel,1)
	local dir = vel:GetNormal()
	local pos = self:GetPos()
	local tr = self:TracePath(pos,pos +dir *32768)
	if(!bForceLong && pos.z -tr.HitPos.z <= 1000) then	-- Close enough to the ground to do a short crash
		self:PlayActivity(ACT_SIGNAL_RIGHT)
		return
	end
	self.m_bLongCrash = true
	self:PlayActivity(ACT_SIGNAL1) -- TODO: Make sure all subsequent animations are playing when possessed
end

function ENT:SetAttackState(state)
	self.m_attackState = state
	if(state == ATTACK_STATE_FLY_AWAY) then
		if(!self:FindFarPosition()) then -- Not enough space for a gliding attack
			self:EndAttack()
			if(IsValid(self.entEnemy) && math.random(1,2) == 1 && self:IsInHoverRange(self.entEnemy,-100)) then
				self:Land()
				return
			end
			self:SetAttackState(ATTACK_STATE_FLY_APPROACH)
			return
		end
	elseif(state == ATTACK_STATE_FLY_APPROACH) then
		if(math.random(1,2) == 1 || CurTime() -self.m_lastFlyStateChanged <= 6) then
			if(self:IsFlying() == FLY_GLIDE && math.random(1,4) == 4) then self.m_bGlideApproach = 3
			else self.m_bGlideApproach = 1 end
		end -- Else hover
		self:UpdateFlyTarget()
	elseif(state == ATTACK_STATE_FLY_IDLE) then
		local pos = self:GetPos()
		pos.z = self:FindConvenientHeight()
		local forward = self:GetForward()
		forward.z = 0
		local posTgt = pos +forward *1000
		local tr = self:TracePath(pos,posTgt)
		if(tr.Hit) then posTgt = tr.HitPos -forward *(self:OBBMaxs().x * 3.5) end
		self:SetFlyTarget(posTgt)
	elseif(state == ATTACK_STATE_FLY_HOVER) then
		self:StartHovering()
	end
end

function ENT:FindConvenientHeight()
	local zMin = self:GetMinFlyHeight()
	local zMax = self:GetMaxFlyHeight()
	if(IsValid(self.entEnemy)) then
		return math.Clamp(self.entEnemy:GetPos().z +500,zMin,zMax)
	end
	return math.min(zMin +1500,zMax),math.min(zMin +3200,zMax)
end

function ENT:UpdateFlyTarget()
	local ent = self.entEnemy
	local pos = self:GetPos()
	local posEnt = ent:GetPos()
	local dir = (posEnt -pos):GetNormal()
	dir.z = 0
	posEnt.z = posEnt.z +300
	posEnt = posEnt +dir *800
	self:SetFlyTarget(posEnt)
	if(DEBUG_TRACES) then util.CreateSpriteTrace(pos,posEnt,4,60,Color(255,0,0,255)) end
end

function ENT:GetAttackState()
	return self.m_attackState || ATTACK_STATE_NONE
end

function ENT:IsGliding() return self.m_bFlying == 2 end

function ENT:IsHovering() return self.m_bFlying == 1 end

function ENT:SelectFlyActivity()
	local flyType = self.m_bFlying
	return flyType == 1 && ACT_FLY || ACT_GLIDE
end

function ENT:IsFlying()
	return self.m_bFlying
end

function ENT:SelectMeleeActivity()
	local ang = self:GetAngles()
	local angToEnemy = (self.entEnemy:GetPos() -self:GetPos()):Angle()
	local yaw = math.AngleDifference(ang.y,angToEnemy.y)
	if(yaw <= 0) then return yaw >= -45 && ACT_MELEE_ATTACK1 || yaw >= -135 && ACT_MELEE_ATTACK_SWING_GESTURE || ACT_MELEE_ATTACK2 end
	return yaw <= 45 && ACT_MELEE_ATTACK1 || yaw <= 135 && ACT_MELEE_ATTACK_SWING || ACT_MELEE_ATTACK2
end

function ENT:SelectRangeActivity()
	local flying = self:IsFlying()
	return flying == FLY_GLIDE && ACT_SPECIAL_ATTACK1 || flying == FLY_HOVER && ACT_RANGE_ATTACK2_LOW || ACT_RANGE_ATTACK1_LOW
end

function ENT:SelectExhaleActivity()
	local flying = self:IsFlying()
	return flying == FLY_GLIDE && ACT_SPECIAL_ATTACK2 || flying == FLY_HOVER && ACT_RANGE_ATTACK2 || ACT_RANGE_ATTACK1
end

function ENT:SelectShoutActivity(shout)
	if(shout == SHOUT_FIRE_BREATH || shout == SHOUT_FROST_BREATH) then return self:SelectExhaleActivity() end
	local flying = self:IsFlying()
	return flying == FLY_GLIDE && ACT_GESTURE_RANGE_ATTACK1_LOW || flying == FLY_HOVER && ACT_GESTURE_RANGE_ATTACK1 || ACT_GESTURE_RANGE_ATTACK2
end

function ENT:EntInAttackCone(ent)
	local i = 0
	local ang = self:GetAngleToPos(ent:GetCenter())
	return (ang.y <= 35 || ang.y >= 325) && (ang.p <= 45 || ang.p >= 315)
end

function ENT:GetMaxFlyHeight()
	local pos = self:GetPos() +self:OBBCenter()
	local tr = self:TracePath(pos,pos +Vector(0,0,32768))
	return tr.HitPos.z -self:OBBMaxs().z *1.5
end

function ENT:GetMinFlyHeight()
	local pos = self:GetPos()
	local tr = self:TracePath(pos,pos -Vector(0,0,32768))
	return tr.HitPos.z +self:OBBMaxs().z *1.5
end

function ENT:TracePath(start,endpos)
	return util.TraceHull({
		start = start,
		endpos = endpos,
		filter = self,
		mask = MASK_SOLID,//MASK_NPCWORLDSTATIC,
		mins = self:OBBMins(),
		maxs = self:OBBMaxs()
	})
end

function ENT:IsPathClear(posTgt)
	return !self:TracePath(self:GetPos(),posTgt).Hit
end

function ENT:FindFarPosition()
	local pos = self:GetPos()
	local heightMax = self:GetMaxFlyHeight()
	if(heightMax -pos.z <= 1600) then return false end
	pos.z = pos.z +600
	local ent = self.entEnemy
	local posEnt = ent:GetPos()
	local dist = self:GetAirDistance(posEnt)
	local dir = self:GetForward()//(pos -posEnt):GetNormal()
	dir.z = 0
	pos = pos +dir *5000
	local tr = self:TracePath(self:GetPos(),pos)
	if(DEBUG_TRACES) then util.CreateSpriteTrace(self:GetPos(),pos,12,60,Color(0,0,255,255)) end
	if(tr.Fraction >= 0.7) then
		pos = tr.HitPos
		if(tr.Hit) then
			pos = pos -tr.Normal *(self:OBBMaxs().x *4)	-- We'll need enough space to turn around
		end
		self:SetFlyTarget(pos)
		return true
	end
	return false
end

function ENT:FindRandomFlyPosition()
	local pos = self:GetPos()
	local min,max = self:FindConvenientHeight()
	pos.z = math.Rand(min,max)
	local yaw = math.random(0,359)
	local ang = Angle(0,yaw,0)
	local dist = math.Rand(1000,18000)
	local frMax = 0
	local posMax
	local heightMax = self:GetMaxFlyHeight()
	for i = 1,7 do
		local dir = ang:Forward()
		local posTgt = pos +dir *dist
		local tr = self:TracePath(pos,posTgt) -- Trying to avoid low obstacles. We can still fly over them later
		if(!tr.Hit) then return posTgt end
		if(tr.Fraction > frMax) then
			frMax = tr.Fraction
			posMax = tr.HitPos -tr.Normal *(self:OBBMaxs().x *4.5)
		end
		ang.y = ang.y +45
	end
	return posMax || self:GetPos()
end

local dashouts = {
	{SHOUT_FROST_BREATH, "Frost Breath"},
	{SHOUT_FIRE_BREATH, "Fire Breath"},
	{SHOUT_UNRELENTING_FORCE, "Unrelenting Force"},
	{SHOUT_DISMAY, "Dismay"},
	{SHOUT_ICE_STORM, "Ice Storm"},
	{SHOUT_DISARM, "Disarm"},
	{SHOUT_FIREBALL, "Fireball"}
}
local curshout = 1
local cango = true

function ENT:_PossReload(entPossessor, fcDone, swag)
	fcDone(true)

	if (not swag) then
		return
	end

	if (curshout < #dashouts) then
		curshout = curshout + 1 
	else 
		curshout = 1
	end

	entPossessor:ChatPrint("Selected Shout: " .. dashouts[curshout][2])
end

function ENT:SelectShout()
	/*local ent = self.entEnemy
	local valid = IsValid(ent)
	local shouts = {}
	local r = math.random(1,3)
	if(r <= 2) then
		if(self:CanUseShout(SHOUT_FROST_BREATH,ent)) then table.insert(shouts,SHOUT_FROST_BREATH) end
		if(self:CanUseShout(SHOUT_FIRE_BREATH,ent)) then table.insert(shouts,SHOUT_FIRE_BREATH) end
	end
	if(r == 3 || #shouts == 0) then
		if(self:CanUseShout(SHOUT_UNRELENTING_FORCE,ent) && (!valid || ent:IsPlayer() || (ent.CanBeKnockedDown && ent:CanBeKnockedDown()))) then table.insert(shouts,SHOUT_UNRELENTING_FORCE) end
		if(self:CanUseShout(SHOUT_DISMAY,ent) && (!valid || (ent:IsNPC() && ent:Disposition(self) != D_FR))) then table.insert(shouts,SHOUT_DISMAY) end
		if(self:CanUseShout(SHOUT_ICE_STORM,ent) && (!valid || ent:IsPlayer() || (ent.CanBeFrozen && ent:CanBeFrozen()))) then table.insert(shouts,SHOUT_ICE_STORM) end
		if(self:CanUseShout(SHOUT_DISARM,ent) && (!valid || ((ent:IsPlayer() || ent.Humanoid) && IsValid(ent:GetActiveWeapon()) && ent:GetActiveWeapon():GetClass() != "translator"))) then table.insert(shouts,SHOUT_DISARM) end
		if(self:CanUseShout(SHOUT_FIREBALL,ent) && (!valid || ent:IsPlayer() || (ent.Ignitable && ent:Ignitable()))) then table.insert(shouts,SHOUT_FIREBALL) end
		if(#shouts == 0) then
			if(self:CanUseShout(SHOUT_FROST_BREATH,ent)) then table.insert(shouts,SHOUT_FROST_BREATH) end
			if(self:CanUseShout(SHOUT_FIRE_BREATH,ent)) then table.insert(shouts,SHOUT_FIRE_BREATH) end
		end
	end
	if(#shouts == 0) then return false end
	return table.Random(shouts)*/

	return dashouts[curshout][1]
end

function ENT:UseShout()
	local shout = self:SelectShout()
	if(!shout) then return end	-- We don't have any shouts at all?
	self.m_rattackShout = shout
	self:StopMoving()
	self:StopMoving()
	self:PlayActivity(self:SelectRangeActivity(),!self:IsFlying() && !self:IsPossessed())
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	local tmLastSeen = self:GetLastTimeSeen(enemy)
	if(CurTime() -tmLastSeen >= 20) then	-- Don't bother waiting for the enemy
		self:RemoveFromMemory(enemy)
		return
	end
	local bFlying = self:IsFlying()
	if(bFlying || self:Visible(enemy)) then
		if(!bFlying) then	-- We're on the ground doing our usual stuff
			if(self.CanFly && ((CurTime() -self.m_lastFlyStateChanged >= 6 && math.random(1,6) == 1) || (CurTime() -self.m_lastFlyStateChanged >= 4 && self:GetAirDistance(enemy:GetPos()) >= 800))) then self:TakeOff(); return end
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				self:PlayActivity(self:SelectMeleeActivity())
				return
			end
			if(CurTime() >= self.m_nextFlameAttack) then
				self.m_nextFlameAttack = CurTime() +math.Rand(4,6)
				if(self.CanFly && CurTime() -self.m_lastFlyStateChanged >= 6 && math.random(1,3) == 1) then self:TakeOff(); return end
				if(dist <= self.fRangeDistance) then
					self:UseShout()
					return
				end
			end
		else
			local stateAttack = self:GetAttackState()
			local posEnt = self.entEnemy:GetPos()
			local distAir = self:GetAirDistance(posEnt)
			if(stateAttack == ATTACK_STATE_FLY_HOVER) then
				if(distAir <= self.fRangeHover) then
					if(CurTime() >= self.m_nextFlameAttack) then
						self.m_nextFlameAttack = CurTime() +math.Rand(4,6)
						if(CurTime() -self.m_lastFlyStateChanged >= 7) then
							if(!self:IsCrippled() && (math.random(1,2) == 1 || dist >= self.fRangeDistance +80)) then
								self:StartGliding()
								self:SetAttackState(ATTACK_STATE_FLY_AWAY)
							end--else self:Land() end
							return
						end
						self:UseShout()
						return
					end
				else
					if(self:IsCrippled() || (CurTime() -self.m_lastFlyStateChanged >= 7 && math.random(1,5) == 1)) then self:Land() return end
					self:StartGliding()
					self:SetAttackState(ATTACK_STATE_FLY_APPROACH)
					return
				end
			elseif(self:GetAttackState() == ATTACK_STATE_FLY_APPROACH) then
				self:UpdateFlyTarget()
				if(self.m_bGlideApproach && self.m_bGlideApproach != 3 && distAir <= 2500 && self:CanSee(enemy)) then
					self:UseShout()
					return
				end
				-- Land in glide mode?
			end
		end
	elseif(!bFlying && CurTime() -tmLastSeen >= 3) then
		self:TakeOff()
		return
	end
	if(!bFlying) then self:ChaseEnemy() end
end
