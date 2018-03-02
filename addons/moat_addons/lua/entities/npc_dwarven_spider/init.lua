AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DWARVEN,"npc_dwarven_spider")
local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DWARVEN","npc_dwarven_spider")
ENT.NPCFaction = NPC_FACTION_DWARVEN
ENT.iClass = CLASS_DWARVEN
ENT.sModel = "models/skyrim/dwarvenspider.mdl"
ENT.fRangeDistance = 500
ENT.fMeleeDistance	= 40
ENT.fMeleeForwardDistance = 200
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = true
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.bPlayDeathSequence = false
ENT.UseActivityTranslator = true
ENT.bIgnitable = false
ENT.CollisionBounds = Vector(25,25,35)

ENT._PossNoHealthRegen = true

ENT.iBloodType = false
ENT.sSoundDir = "npc/dwarvenspider/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_SMALL_FLINCH,
	[HITBOX_HEAD] = ACT_BIG_FLINCH
}

ENT.m_tbSounds = {
	["AttackComboHigh"] = "dwarvenspider_attackcombohigh01.mp3",
	["AttackComboLow"] = "dwarvenspider_attackcombolow01.mp3",
	["AttackForwardJump"] = "dwarvenspider_attackforwardjump.mp3",
	["AttackLeftSide"] = "dwarvenspider_attackleftside01.mp3",
	["AttackSpin"] = "dwarvenspider_attackspin01.mp3",
	["AttackStab"] = "dwarvenspider_attackstab0[1-2].mp3",
	["Death"] = "dwarvenspider_death0[1-3].mp3",
	["IdlePick"] = "dwarvenspider_idlepick01.mp3",
	["IdlePickWall"] = "dwarvenspider_idlepickwall01.mp3",
	["IdleSearch"] = "dwarvenspider_idlesearch01.mp3",
	["IdleStall"] = "dwarvenspider_idlestall01.mp3",
	["Pain"] = "dwarvenspider_injured0[1-3].mp3",
	["Foot"] = "foot/dwarvenspider_foot0[1-9].mp3"
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
	self:SetHullType(HULL_TINY)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_spider_dwarven_health"))
	self.m_nextForwardAttack = 0
	self:PlayIdleSound()
end

function ENT:PlayIdleSound()
	if(self.cspIdleLoop) then self.cspIdleLoop:Stop() end
	self.cspIdleLoop = CreateSound(self, self.sSoundDir .. "dwarvenspider_conscious_lp.wav")
	self.cspIdleLoop:SetSoundLevel(70)
	self.cspIdleLoop:Play()
	self:StopSoundOnDeath(self.cspIdleLoop)
end

function ENT:PlayMovementSound()
	if(self.cspIdleLoop) then self.cspIdleLoop:Stop() end
	self.cspIdleLoop = CreateSound(self, self.sSoundDir .. "dwarvenspider_movement_lpm.wav")
	self.cspIdleLoop:SetSoundLevel(70)
	self.cspIdleLoop:Play()
	self:StopSoundOnDeath(self.cspIdleLoop)
end

function ENT:OnThink()
	self:UpdateLastEnemyPositions()
	if(self:IsMoving()) then
		if(!self.bMoveLoopPlaying) then
			self.bMoveLoopPlaying = true
			self:PlayMovementSound()
		end
	elseif(self.bMoveLoopPlaying) then
		self:PlayIdleSound()
		self.bMoveLoopPlaying = false
	end
end

function ENT:_PossPrimaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossJump(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK2,false,fcDone)
end

function ENT:TranslateActivity(act)
	if(act == ACT_IDLE) then
		local state = self:GetState()
		if(state == NPC_STATE_COMBAT || state == NPC_STATE_ALERT) then return ACT_IDLE_ANGRY end
	end
	return act
end

function ENT:SelectGetUpActivity()
	return ACT_ROLL_LEFT
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "mattack") then
		local dist = self.fMeleeDistance
		local dmg
		local ang
		local force
		local atk = select(2,...)
		if(atk == "combohighright") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash")
			ang = Angle(20,-15,3)
			force = Vector(80,0,0)
		elseif(atk == "combohighleft") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash")
			ang = Angle(20,15,-3)
			force = Vector(80,0,0)
		elseif(atk == "stabright") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash_power")
			ang = Angle(24,-20,3)
			force = Vector(160,0,0)
		elseif(atk == "combolowright") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash")
			ang = Angle(22,-12,3)
			force = Vector(80,0,0)
		elseif(atk == "combolowleft") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash")
			ang = Angle(22,12,-3)
			force = Vector(80,0,0)
		elseif(atk == "forwardjump") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash_power")
			ang = Angle(38,0,0)
			force = Vector(160,0,0)
		elseif(atk == "spinright") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash")
			ang = Angle(22,-12,3)
			force = Vector(80,0,0)
		elseif(atk == "spinleft") then
			dmg = GetConVarNumber("sk_spider_dwarven_dmg_slash")
			ang = Angle(22,12,-3)
			force = Vector(80,0,0)
		end
		self:DealMeleeDamage(dist,dmg,ang,force)
		return true
	end
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				self:PlayActivity(ACT_MELEE_ATTACK1, true)
				return
			end
			if(!self:LimbCrippled(HITBOX_LEFTLEG) && !self:LimbCrippled(HITBOX_RIGHTLEG) && CurTime() >= self.m_nextForwardAttack) then
				local ang = self:GetAngleToPos(self.entEnemy:GetPos())
				if(ang.y <= 35 || ang.y >= 325) then
					local fTimeToGoal = self:GetPathTimeToGoal()
					if(self.bDirectChase && fTimeToGoal <= 0.65 && fTimeToGoal >= 0.55 && distPred <= self.fMeleeForwardDistance) then
						self:PlayActivity(ACT_MELEE_ATTACK2)
						self.m_nextForwardAttack = CurTime() +math.Rand(4,12)
						return
					end
				end
			end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
