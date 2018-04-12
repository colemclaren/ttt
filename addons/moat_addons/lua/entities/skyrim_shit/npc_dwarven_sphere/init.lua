AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DWARVEN,"npc_dwarven_sphere")
local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DWARVEN","npc_dwarven_sphere")
ENT.NPCFaction = NPC_FACTION_DWARVEN
ENT.iClass = CLASS_DWARVEN
ENT.sModel = "models/skyrim/spherecenturion.mdl"
ENT.fRangeDistance = 3200
ENT.fMeleeDistance	= 50
ENT.fMeleeForwardDistance = 160
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = false
ENT.bIgnitable = false
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.bPlayDeathSequence = false
ENT.UseActivityTranslator = true
ENT.CollisionBounds = Vector(20,20,140)
ENT.tblIgnoreDamageTypes = {DMG_DISSOLVE}
ENT.tblAlertAct = {ACT_IDLE_ANGRY}
ENT.possOffset = Vector(0,0,150)

ENT._PossNoHealthRegen = true

ENT.iBloodType = false
ENT.sSoundDir = "npc/dwarvensphere/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_SMALL_FLINCH,
	[HITBOX_CHEST] = ACT_FLINCH_CHEST,
	[HITBOX_HEAD] = ACT_BIG_FLINCH
}

ENT.m_tbSounds = {
	["AttackA"] = "dwarvensphere_attacka0[1-2].mp3",
	["AttackB"] = "dwarvensphere_attackb0[1-3].mp3",
	["AttackBowDraw"] = "dwarvensphere_attackbowdraw.mp3",
	["AttackBowRelease"] = "dwarvensphere_attackbowrelease.mp3",
	["AttackPower"] = "dwarvensphere_attackpower0[1-2].mp3",
	["Close"] = "dwarvensphere_close01.mp3",
	["Death"] = "dwarvensphere_death0[1-3].mp3",
	["Equip"] = "dwarvensphere_equip.mp3",
	["IdleCombatA"] = "dwarvensphere_idlecombat_a0[1-3].mp3",
	["IdleCombatB"] = "dwarvensphere_idlecombat_b0[1-3].mp3",
	["Pain"] = "dwarvensphere_injured0[1-3].mp3",
	["Open"] = "dwarvensphere_open01.mp3",
	["PortExitA"] = "dwarvensphere_portexit_a01.mp3",
	["PortExitB"] = "dwarvensphere_portexit_b01.mp3",
	["Recoil"] = "dwarvensphere_recoil01.mp3",
	["Scan"] = "dwarvensphere_scan.mp3",
	["StaggerHeavy"] = "dwarvensphere_staggerheavy.mp3",
	["StaggerLight"] = "dwarvensphere_staggerlight.mp3",
	["StaggerMedium"] = "dwarvensphere_staggermedium.mp3",
	["Taunt"] = "dwarvensphere_taunt0[1-2].mp3",
	["Warn"] = "dwarvensphere_warn01.mp3"
}

ENT.DamageScales = {
	[DMG_BURN] = 0.2,
	[DMG_BLAST] = 0.2,
	[DMG_SHOCK] = 1.4,
	[DMG_SONIC] = 2,
	[DMG_PARALYZE] = 0.6,
	[DMG_NERVEGAS] = 0.6,
	[DMG_POISON] = 0.5,
	[DMG_ACID] = 0.65,
	[DMG_DIRECT] = 0.3,
	[DMG_DIRECT] = 0.2,
	[DMG_ACID] = 1.2,
	[DMG_BURN] = 0.2,
	[DMG_DROWN] = 0,
	[DMG_RADIATION] = 1.2,
	[DMG_SLOWBURN] = 0.2,
	[DMG_PARALYZE] = 0.4,
	[DMG_DISSOLVE] = 0.4,
	[DMG_ENERGYBEAM] = 0.4,
	[DMG_SHOCK] = 0.3,
	[DMG_BLAST] = 1.2,
	[DMG_NERVEGAS] = 0.1,
	[DMG_SONIC] = 0.8,
	[DMG_POISON] = 0.2
}

function ENT:OnInit()
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_centurion_sphere_health"))
	self.m_nextForwardAttack = 0
	self.m_nextRangeAttack = 0
	self:PlayIdleSound()
end

function ENT:TranslateActivity(act)
	if(act == ACT_IDLE) then
		if(self:IsEquipped()) then return ACT_IDLE_AGITATED end
		if(self:IsFolded()) then return ACT_IDLE_RELAXED end
	end
	if(self:IsEquipped()) then
		if(act == ACT_WALK) then return ACT_WALK_AGITATED end
		if(act == ACT_RUN) then return ACT_RUN_AGITATED end
		if(act == ACT_BIG_FLINCH) then return ACT_FLINCH_STOMACH end
		if(act == ACT_SMALL_FLINCH) then return ACT_FLINCH_LEFTARM end
		if(act == ACT_FLINCH_CHEST) then return ACT_FLINCH_RIGHTARM end
	end
	return act
end

function ENT:IsFolded() return self.m_bFolded end

function ENT:Fold()
	if(self:IsFolded()) then return end
	self.m_bFolded = true
	self:PlayActivity(ACT_DISARM)
	self.bInSchedule = true
end

function ENT:Unfold()
	if(!self:IsFolded()) then return end
	self.m_bFolded = false
	self.bInSchedule = false
	self:PlayActivity(ACT_ARM)
end

function ENT:IsEquipped() return self.m_bEquipped end

function ENT:Equip()
	if(self:IsEquipped()) then return end
	self.m_bEquipped = true
	self:PlayActivity(ACT_SIGNAL1,false,self._PossScheduleDone)
end

function ENT:Unequip()
	if(!self:IsEquipped()) then return end
	self.m_bEquipped = false
	self:PlayActivity(ACT_SIGNAL2,false,self._PossScheduleDone)
end

function ENT:PlayIdleSound()
	if(self.m_cspIdle) then self.m_cspIdle:Stop() end
	self.m_cspIdle = CreateSound(self,self.sSoundDir .. "dwarvensphere_conscious_lp.wav")
	self.m_cspIdle:SetSoundLevel(70)
	self.m_cspIdle:Play()
	self:StopSoundOnDeath(self.m_cspIdle)
end

function ENT:PlayMovementSound()
	if(self.m_cspIdle) then self.m_cspIdle:Stop() end
	self.m_cspIdle = CreateSound(self,self.sSoundDir .. "dwarvensphere_movement_lp.wav")
	self.m_cspIdle:SetSoundLevel(70)
	self.m_cspIdle:Play()
	self:StopSoundOnDeath(self.m_cspIdle)
end

function ENT:_PossPrimaryAttack(possessor,fcDone)
	if(self:IsEquipped()) then
		if(CurTime() < self.m_nextRangeAttack) then fcDone(true); return end
		self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
		self.m_nextRangeAttack = CurTime() +math.Rand(0.6,1.4)
		fcDone(true)
		return
	end
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossSecondaryAttack(possessor,fcDone)
	if(!self:IsEquipped()) then self:Equip()
	else self:Unequip() end
end

function ENT:_PossJump(possessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK2,false,fcDone)
end

function ENT:_PossShouldFaceMoving(possessor)
	if(self:IsEquipped()) then return false end
	return true
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "mattack") then
		local dist = self.fMeleeDistance +80
		local dmg
		local ang
		local force
		local atk = select(2,...)
		if(atk == "backslash") then
			dmg = GetConVarNumber("sk_centurion_sphere_dmg_slash")
			ang = Angle(-30,20,-3)
			force = Vector(140,0,0)
		elseif(atk == "bash") then
			dmg = GetConVarNumber("sk_centurion_sphere_dmg_slash")
			ang = Angle(-28,28,-3)
			force = Vector(140,0,0)
		elseif(atk == "chop") then
			dmg = GetConVarNumber("sk_centurion_sphere_dmg_slash")
			ang = Angle(30,-20,3)
			force = Vector(180,0,0)
		elseif(atk == "forwardpowerchop") then
			dmg = GetConVarNumber("sk_centurion_sphere_dmg_slash_power")
			ang = Angle(30,-20,3)
			force = Vector(320,0,0)
		elseif(atk == "forwardpowerstab") then
			dist = dist +30
			dmg = GetConVarNumber("sk_centurion_sphere_dmg_slash_power")
			ang = Angle(34,0,0)
			force = Vector(320,0,0)
		elseif(atk == "slash") then
			dmg = GetConVarNumber("sk_centurion_sphere_dmg_slash")
			ang = Angle(0,-38,3)
			force = Vector(140,0,0)
		elseif(atk == "stab") then
			dmg = GetConVarNumber("sk_centurion_sphere_dmg_slash")
			ang = Angle(38,0,0)
			force = Vector(230,0,0)
		end
		self:DealMeleeDamage(dist,dmg,ang,force,DMG_SLASH)
		return true
	end
	if(event == "scan") then
		local ang = self:GetAngles()
		ang.y = ang.y +180
		self:GetEnemies(ang)
		return true
	end
	if(event == "rattack") then
		local attID = self:LookupAttachment("bow")
		local att = self:GetAttachment(attID)
		if(!att) then return end
		sound.Play("weapons/bow_fire0" .. math.random(1,3) .. ".mp3",att.Pos,75,100)
		local dir
		if(self:IsPossessed()) then
			local pos = self:GetPossessor():GetPossessionEyeTrace().HitPos
			dir = util.GetConstrictedDirection(att.Pos,pos,att.Ang,Angle(28,28,28))
		elseif(IsValid(self.entEnemy)) then
			local pos = self.entEnemy:GetPos() +self.entEnemy:OBBCenter() +self.entEnemy:GetVelocity() *0.2
			dir = util.GetConstrictedDirection(att.Pos,pos,att.Ang,Angle(28,28,28))
		else dir = att.Ang:Forward() end
		local ent = ents.Create("obj_centurion_arrow")
		ent:SetPos(att.Pos)
		ent:SetAngles(dir:Angle())
		ent:SetEntityOwner(self)
		ent:Spawn()
		ent:Activate()
		local phys = ent:GetPhysicsObject()
		if(phys:IsValid()) then
			phys:ApplyForceCenter(dir *10000)
		end
		return true
	end
end

function ENT:OnThink()
	self:UpdateLastEnemyPositions()
	if(self:IsMoving()) then
		if(!self.bMoveLoopPlaying) then
			self.bMoveLoopPlaying = true
			self:PlayMovementSound()
		end
	elseif(self.bMoveLoopPlaying) then
		self:EmitSound(self.sSoundDir .. "dwarvensphere_movement_end.wav",75,100)
		self:PlayIdleSound()
		self.bMoveLoopPlaying = false
	end
	if(self:IsEquipped() && IsValid(self.entEnemy)) then
		self:TurnToTarget(self.entEnemy,12)
	end
	self:NextThink(CurTime())
	return true
end

function ENT:OnAreaCleared()
	self:PlaySound("AreaClear")
	self:Unequip()
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			if(self:IsEquipped()) then
				if(dist <= 100 || !self:CanSee(enemy)) then
					self.m_nextRangeAttack = CurTime() +math.Rand(4,12)
					self:Unequip()
					return
				end
				if(CurTime() >= self.m_nextRangeAttack) then
					if(self.m_numShots == 0) then
						self.m_nextRangeAttack = CurTime() +math.Rand(4,12)
						self:Unequip()
						return
					end
					self.m_numShots = self.m_numShots -1
					self.m_nextRangeAttack = CurTime() +math.Rand(0.6,1.4)
					self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
				end
				if(dist >= self.fRangeDistance -100) then self:SetRunActivity(ACT_RUN)
				else
					if(dist <= self.fMeleeDistance +360) then self:StopMoving(); return end
					self:SetRunActivity(ACT_WALK)
				end
				self:ChaseEnemy()
				return
			end
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				self:PlayActivity(ACT_MELEE_ATTACK1, true)
				return
			end
			if(CurTime() >= self.m_nextForwardAttack) then
				local ang = self:GetAngleToPos(self.entEnemy:GetPos())
				if(ang.y <= 35 || ang.y >= 325) then
					local fTimeToGoal = self:GetPathTimeToGoal()
					if(self.bDirectChase && fTimeToGoal <= 0.8 && fTimeToGoal >= 0.3 && distPred <= self.fMeleeForwardDistance) then
						self:PlayActivity(ACT_MELEE_ATTACK2)
						self.m_nextForwardAttack = CurTime() +math.Rand(4,12)
						return
					end
				end
			end
			if(!self:IsEquipped() && dist <= self.fRangeDistance -200 && dist >= self.fMeleeDistance +200 && CurTime() >= self.m_nextRangeAttack) then
				self:Equip()
				self.m_numShots = math.random(2,12)
				self.m_nextRangeAttack = CurTime()
				return
			end
		end
		self:SetRunActivity(ACT_RUN)
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
