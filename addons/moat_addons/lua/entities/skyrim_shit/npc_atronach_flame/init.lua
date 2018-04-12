AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_ATRONACH","npc_atronach_flame")
ENT.NPCFaction = NPC_FACTION_ATRONACH
ENT.iClass = CLASS_ATRONACH
util.AddNPCClassAlly(CLASS_ATRONACH,"npc_atronach_flame")
ENT.sModel = "models/skyrim/atronachflame.mdl"
ENT.fMeleeDistance	= 44
ENT.fMeleeForwardDistance = 200
ENT.fRangeDistance = 2200
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = false
ENT.bIgnitable = false
ENT.bFreezable = false
ENT.bPlayDeathSequence = true
ENT.m_bForceDeathAnim = true
ENT.BoneRagdollMain = "FireAtrch_"
ENT.skName = "atronach_flame"
ENT.CollisionBounds = Vector(10,10,80)

ENT._PossNoHealthRegen = true

ENT.m_fFollowDistance = 110
ENT.m_fFollowDistanceOffensive = 550
ENT.m_fFollowDistanceOffensiveAttack = 2200
ENT.m_fFollowDistanceDefensive = 220
ENT.m_fFollowDistanceDefensiveAttack = 1000

ENT.DamageScales = {
	[DMG_BURN] = 0,
	[DMG_PARALYZE] = 0,
	[DMG_NERVEGAS] = 0,
	[DMG_POISON] = 0,
	[DMG_DIRECT] = 0
}

ENT.iBloodType = false
ENT.sSoundDir = "npc/atronachflame/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_FLINCH_CHEST,
	[HITBOX_HEAD] = ACT_FLINCH_HEAD,
	[HITBOX_LEFTARM] = ACT_FLINCH_LEFTARM,
	[HITBOX_RIGHTARM] = ACT_FLINCH_RIGHTARM
}

ENT.m_tbSounds = {
	["AttackA"] = "atronachflame_attack_a01.mp3",
	["AttackB"] = "atronachflame_attack_b01.mp3",
	["Death"] = "atronachflame_death01.mp3",
	["DeathExplosion2D"] = "atronachflame_deathexplosion2d.mp3",
	["DeathExplosion3D"] = "atronachflame_deathexplosion3d.mp3",
	["Pain"] = "atronachflame_injured0[1-2].mp3"
}

function ENT:OnInit()
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	
	self.cspIdleLoop = CreateSound(self,self.sSoundDir .. "atronachflame_conscious_lp.wav")
	self:StopSoundOnDeath(self.cspIdleLoop)
	self.cspMoveLoop = CreateSound(self,self.sSoundDir .. "atronachflame_movement_lp.wav")
	self:StopSoundOnDeath(self.cspMoveLoop)
	self.cspIdleLoop:Play()
	
	self.m_nextFireTrail = 0
	self.m_nextForwardAttack = 0
	self.m_nextAttack = 0
	self.m_nextHpRegen = 0
	
	self.m_fireTrail = {}
	for i = 1, 5 do
		local ent = ents.Create("env_fire")
		ent:SetPos(self:GetPos())
		ent:SetKeyValue("health",0)
		ent:SetKeyValue("firesize",12)
		ent:SetKeyValue("spawnflags",142)
		ent:Spawn()
		ent:Activate()
		self:DeleteOnRemove(ent)
		self.m_fireTrail[i] = ent
	end
end

function ENT:ShouldTakeDamage(ent)
	if(ent:GetClass() == "env_fire") then return false end
end

function ENT:_PossStart(entPossessor)
	self:SetRunActivity(ACT_RUN)
end

function ENT:_PossPrimaryAttack(entPossessor,fcDone)
	self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
	timer.Simple(1.3,fcDone)
end

function ENT:_PossSecondaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossJump(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK2,false,fcDone)
end

function ENT:PlayIdleLoop()
	self.cspIdleLoop:Stop()
	self.cspMoveLoop:Stop()
	self.cspIdleLoop = CreateSound(self,self.sSoundDir .. "atronachflame_conscious_lp.wav")
	self.cspIdleLoop:Play()
	self:StopSoundOnDeath(self.cspIdleLoop)
end

function ENT:PlayMoveLoop()
	self.cspMoveLoop:Stop()
	self.cspIdleLoop:Stop()
	self.cspMoveLoop = CreateSound(self,self.sSoundDir .. "atronachflame_movement_lp.wav")
	self.cspMoveLoop:Play()
	self:StopSoundOnDeath(self.cspMoveLoop)
end

function ENT:StopMovementSound()
	self.cspIdleLoop:Stop()
	self.cspMoveLoop:Stop()
end

function ENT:PlayMovementSound()
	if self:IsMoving() then
		self.bMoveLoopPlaying = true
		self:PlayMoveLoop()
	else
		self:PlayIdleLoop()
		self.bMoveLoopPlaying = false
	end
end

function ENT:Interrupt()
	if(IsValid(self.m_entFlame)) then self.m_entFlame:Remove(); self.m_entFlame = nil end
	if self.actReset then self:SetMovementActivity(self.actReset); self.actReset = nil end
	if self:IsPossessed() then self:_PossScheduleDone() end
	self.bInSchedule = false
end

function ENT:OnThink()
	self:UpdateLastEnemyPositions()
	if(CurTime() >= self.m_nextHpRegen) then
		self.m_nextHpRegen = CurTime() +0.5
		local hp = self:Health()
		local hpMax = self:GetMaxHealth()
		self:SetHealth(math.min(hp +1,hpMax))
		return
	end
	if(CurTime() >= self.m_nextFireTrail && self:OnGround()) then
		self.m_nextFireTrail = CurTime() +0.1
		local pos = self:GetPos()
		local tr = util.TraceLine({
			start = pos,
			endpos = pos -Vector(0,0,20),
			filter = self,
			mask = MASK_NPCWORLDSTATIC
		})
		for i = 5, 2, -1 do
			if(self.m_fireTrail[i]:IsValid() && self.m_fireTrail[i -1]:IsValid()) then
				self.m_fireTrail[i]:SetPos(self.m_fireTrail[i -1]:GetPos())
			end
		end
		self.m_fireTrail[1]:SetPos(tr.HitPos)
	end
	if(self:IsMoving()) then
		if(!self.bMoveLoopPlaying) then
			self.bMoveLoopPlaying = true
			self:PlayMoveLoop()
		end
	elseif(self.bMoveLoopPlaying) then
		self:EmitSound(self.sSoundDir .. "atronachflame_movement_lp_end.wav",75,100)
		self:PlayIdleLoop()
		self.bMoveLoopPlaying = false
	end
	if(self.m_bMoveBack && IsValid(self.entEnemy) && self:Visible(self.entEnemy)) then
		local ang = self:GetAngles()
		local yawTgt = (self.entEnemy:GetPos() -self:GetPos()):Angle().y
		ang.y = math.ApproachAngle(ang.y,yawTgt,10)
		self:SetAngles(ang)
		self:NextThink(CurTime())
		return true
	end
end

function ENT:OnFoundEnemy(iEnemies)
	self:SetIdleActivity(ACT_IDLE_ANGRY)
end

function ENT:OnAreaCleared()
	self:PlaySound("AreaClear")
	self:SetIdleActivity(ACT_IDLE)
end

function ENT:GenerateInventory()
	self:AddToInventory("004f8H4A")
end

function ENT:SelectGetUpActivity()
	local _, ang = self.ragdoll:GetBonePosition(self:GetMainRagdollBone())
	return ang.p >= 0 && ACT_ROLL_LEFT || ACT_ROLL_RIGHT
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "rattack") then
		local action = select(2,...)
		if(action == "fireball") then
			local att = select(3,...)
			local attID = self:LookupAttachment(select(3,...))
			if(attID != 0) then
				local attPosAng = self:GetAttachment(attID)
				local entFlame = ents.Create("obj_spit")
				entFlame:NoCollide(self)
				entFlame:SetPos(attPosAng.Pos)
				entFlame:SetEntityOwner(self)
				entFlame:SetParticleEffect("magic_spell_fireball")
				entFlame:SetParent(self)
				entFlame:Fire("SetParentAttachment",att,0)
				function entFlame:OnHit(ent,dist)
					ent:Ignite(ent:IsPlayer() && 1.2 || 6,nil,self)
				end
				entFlame:Spawn()
				entFlame:Activate()
				self.m_entFlame = entFlame
				self:DeleteOnRemove(entFlame)
			end
			return true
		elseif(action == "throw") then
			if(IsValid(self.m_entFlame)) then
				local flSpeed = 4000
				self.m_entFlame:SetParent()
				self.m_entFlame:PhysicsInit(SOLID_VPHYSICS)
				local phys = self.m_entFlame:GetPhysicsObject()
				if(phys:IsValid()) then
					local pos = self.m_entFlame:GetPos()
					local dir
					if(self:IsPossessed()) then
						local posTgt = self:GetPossessor():GetPossessionEyeTrace().HitPos
						dir = util.GetConstrictedDirection(pos,posTgt,self:GetAngles(),Angle(40,40,40))
					elseif(IsValid(self.entEnemy)) then
						local posEnemy = self.entEnemy:GetHeadPos()
						local vel = self.entEnemy:GetVelocity()
						vel.z = vel.z *0.5
						local dist = posEnemy:Distance(pos)
						local dur = dist /flSpeed *2
						dir = (posEnemy +vel *dur -pos):GetNormal()
					else dir = self:GetForward() end
					dir = dir +VectorRand() *0.02
					dir:ClampToDir(self:GetForward(),0.65)
					phys:EnableGravity(false)
					phys:SetVelocity(dir *flSpeed)
				end
				self:DontDeleteOnRemove(self.m_entFlame)
				self.m_entFlame = nil
			end
			return true
		end
	end
	if(event == "mattack") then
		local dist = self.fMeleeDistance
		local skDmg = "sk_" .. self.skName .. "_dmg"
		local force
		local ang
		local atk = select(2,...)
		if(atk == "left1") then
			ang = Angle(-25,30,-4)
			force = Vector(200,0,0)
		elseif(atk == "right1") then
			ang = Angle(20,-30,4)
			force = Vector(200,0,0)
		elseif(atk == "forward") then
			dist = dist +50
			skDmg = skDmg .. "_power"
			ang = Angle(20,30,-4)
			force = Vector(360,0,0)
		else
			dist = dist +50
			skDmg = skDmg .. "_power"
			ang = Angle(-30,-18,3)
			force = Vector(360,0,0)
		end
		self:DealMeleeDamage(dist,GetConVarNumber(skDmg),ang,force,DMG_BURN,nil,nil,nil,function(ent,dmgInfo)
			ent:Ignite(6,nil,self)
		end)
		return true
	end
end

function ENT:CanUseRangeAttack(entTarget)
	local ang = self:GetAngleToPos(entTarget:GetCenter())
	return (ang.y <= 35 || ang.y >= 325) && (ang.p <= 45 || ang.p >= 315)
end

function ENT:AttackMelee(ent)
	self:SetTarget(ent)
	self:PlayActivity(ACT_MELEE_ATTACK1,2)
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			local bMoveBack
			local hp = self:Health()
			local hpMax = self:GetMaxHealth()
			local bLowHp = hp <= hpMax *0.6
			if(bLowHp && dist <= 200) then
				local pos = self:GetCenter()
				local dirBack = self:GetForward() *-1
				local tr = util.TraceLine({
					start = pos,
					endpos = pos +dirBack *200,
					filter = self,
					mask = MASK_NPCWORLDSTATIC
				})
				bMoveBack = true
				self.m_bMoveBack = true
				if(tr.Hit) then self:Hide()
				else self:MoveToPosDirect(self:GetPos() +self:GetForward() *-200,true,true) end
			end
			if(!bMoveBack) then
				if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
					self:PlayActivity(ACT_MELEE_ATTACK1,true)
					return
				end
				if(CurTime() >= self.m_nextForwardAttack) then
					local ang = self:GetAngleToPos(self.entEnemy:GetPos())
					if(ang.y <= 35 || ang.y >= 325) then
						local fTimeToGoal = self:GetPathTimeToGoal()
						if(self.bDirectChase && fTimeToGoal <= 3 && fTimeToGoal >= 0.6 && distPred <= self.fMeleeForwardDistance) then
							self:PlayActivity(ACT_MELEE_ATTACK2)
							self.m_nextForwardAttack = CurTime() +math.Rand(1,4)
							return
						end
					end
				end
			end
			local bWalk
			if(dist <= self.fRangeDistance && self:CanUseRangeAttack(self.entEnemy)) then
				if(CurTime() >= self.m_nextAttack) then
					self.m_nextAttack = CurTime() +math.Rand(1,4)
					self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
				end
				if(!bMoveBack && dist <= 800) then
					bWalk = true
					self:SetRunActivity(ACT_WALK)
					if(dist <= 200 || (bLowHp && dist <= 600)) then
						self:StopMoving()
						return
					end
				end
			end
			if(!bWalk) then self:SetRunActivity(ACT_RUN) end
			if(bMoveBack) then return
			else self.dirMoveLR = nil end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
