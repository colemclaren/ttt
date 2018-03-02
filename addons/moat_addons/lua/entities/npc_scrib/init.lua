AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_SCRIB,"npc_scrib")
local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_SCRIB","npc_scrib")
ENT.NPCFaction = NPC_FACTION_SCRIB
ENT.iClass = CLASS_SCRIB
ENT.sModel = "models/skyrim/scrib.mdl"
ENT.fMeleeDistance	= 20
ENT.fMeleeForwardDistance = 120
ENT.fUnburrowDistance = 120
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = true
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.bPlayDeathSequence = false
ENT.UseActivityTranslator = true
ENT.CollisionBounds = Vector(25,25,28)

ENT.iBloodType = BLOOD_COLOR_GREEN
ENT.sSoundDir = "npc/scrib/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_SMALL_FLINCH,
	[HITBOX_HEAD] = ACT_BIG_FLINCH
}

ENT.m_tbSounds = {
	["AmbushDigin"] = "scrib_ambush_digin0[1-2].mp3",
	["AmbushDigout"] = "scrib_ambush_digout0[1-2].mp3",
	["Attack1"] = "scrib_attack101.mp3",
	["Attack2"] = "scrib_attack201.mp3",
	["AttackBash"] = "scrib_attackbash01.mp3",
	["AttackPowerForward"] = "scrib_attackpowerforward01.mp3",
	["AttackPowerForwardLarge"] = "scrib_attackpowerforwardlarge01.mp3",
	["AttackPowerStance"] = "scrib_attackpowerstance01.mp3",
	["Death"] = "scrib_death0[1-3].mp3",
	["Foot"] = "scrib_foot0[1-6].mp3",
	["FootDirt"] = "scrib_foot_dirt0[1-6].mp3",
	["IdleCleanFace"] = "scrib_idle3_cleanface01.mp3",
	["Idle"] = "scrib_idle201.mp3",
	["Pain"] = "scrib_injured0[1-3].mp3"
}

function ENT:OnInit()
	self:SetHullType(HULL_TINY)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_ash_hopper_health"))
	self.m_nextForwardAttack = 0
	
	self.m_cspIdle = CreateSound(self,self.sSoundDir .. "scrib_breathe_lp.wav")
	self.m_cspIdle:SetSoundLevel(70)
	self.m_cspIdle:Play()
	self:StopSoundOnDeath(self.m_cspIdle)
end

function ENT:KeyValueHandle(key,val)
	if(key == "startburrowed") then
		if(tonumber(val) != 0) then self:SetBurrowed() end
	end
end

function ENT:InitSandbox()
	if(self:CanBurrow()) then self:SetBurrowed() end
end

function ENT:SetBurrowed()
	self:Sleep()
	self.m_bBurrowed = true
	self.bInSchedule = true
	self.m_cspIdle:FadeOut(0)
	self.m_tBurrowedWait = 0
	self.m_tNextHeal = CurTime() +1
end

function ENT:IsBurrowed() return self.m_bBurrowed end

function ENT:UnBurrow()
	if(!self:IsBurrowed()) then return end
	self.m_bBurrowed = false
	self.bInSchedule = false
	self.m_cspIdle:Play()
	self:CallOnInitialized(function() self:PlayActivity(ACT_SIGNAL2,false,self._PossScheduleDone) end)
	self.m_unburrow = nil
	self.bFlinchOnDamage = true
	self.m_burrowNextHpRegen = nil
	self.m_nextBurrow = CurTime() +math.Rand(4,30)
end

function ENT:Burrow(tmUnburrow)
	if(self:IsBurrowed()) then return end
	self.m_cspIdle:FadeOut(0)
	self.m_bBurrowed = true
	self.m_tBurrowedWait = CurTime() +math.Rand(3,8)
	self.m_tNextHeal = CurTime() +1
	self.m_burrowNextHpRegen = CurTime()
	self.bFlinchOnDamage = false
	self:CallOnInitialized(function() self:PlayActivity(ACT_SIGNAL1,false,self._PossScheduleDone) end)
end

function ENT:OnThink()
	self:UpdateLastEnemyPositions()
	if(self:IsBurrowed()) then
		if(CurTime() >= self.m_tNextHeal) then
			local hp = self:Health()
			local hpMax = self:GetMaxHealth()
			self:SetHealth(math.min(hp +1),hpMax)
			self.m_tNextHeal = CurTime() +1
		end
		if(CurTime() >= self.m_tBurrowedWait) then
			local ent = self.entEnemy
			if(IsValid(ent)) then
				if(self.m_pursuing == ent) then self:UnBurrow()
				else
					local d = self:OBBDistance(ent)
					if(d <= self.fUnburrowDistance) then
						self:UnBurrow()
					end
				end
			end
		end
	end
end

function ENT:_PossPrimaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossJump(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK2,false,fcDone)
end

function ENT:_PossReload(entPossessor,fcDone)
	if(self:IsBurrowed()) then self:UnBurrow(); return end
	if(!self:CanBurrow()) then fcDone(true); return end
	self:Burrow()
end

function ENT:TranslateActivity(act)
	if(act == ACT_IDLE) then
		local state = self:GetState()
		if(state == NPC_STATE_COMBAT || state == NPC_STATE_ALERT) then return ACT_IDLE_ANGRY end
	end
	return act
end

function ENT:SelectGetUpActivity()
	local _, ang = self.ragdoll:GetBonePosition(self:GetMainRagdollBone())
	return ang.r >= 0 && ACT_ROLL_RIGHT || ACT_ROLL_LEFT
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "digin") then
		self:Sleep()
		return true
	elseif(event == "digout") then
		self:Wake()
		return true
	elseif(event == "mattack") then
		local dist = self.fMeleeDistance
		local dmg
		local ang
		local force
		local atk = select(2,...)
		if(atk == "jump") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash")
			ang = Angle(10,0,0)
			force = Vector(30,0,0)
		elseif(atk == "headbash") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash")
			ang = Angle(15,0,0)
			force = Vector(30,0,0)
		elseif(atk == "dash") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash")
			ang = Angle(14,0,0)
			force = Vector(30,0,0)
		elseif(atk == "left") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash")
			ang = Angle(0,0,0)
			force = Vector(30,0,0)
		elseif(atk == "forward") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash_power")
			ang = Angle(20,0,0)
			force = Vector(60,0,0)
		elseif(atk == "forwardlarge") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash_power")
			ang = Angle(24,0,0)
			force = Vector(80,0,0)
		elseif(atk == "forwardshort") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash_power")
			ang = Angle(22,0,0)
			force = Vector(60,0,0)
		elseif(atk == "power") then
			dmg = GetConVarNumber("sk_ash_hopper_dmg_slash_power")
			ang = Angle(18,0,0)
			force = Vector(70,0,0)
		end
		self:DealMeleeDamage(dist,dmg,ang,force)
		return true
	end
end

function ENT:CanBurrow()
	local pos = self:GetPos()
	local tr = util.TraceLine({
		start = pos,
		endpos = pos -Vector(0,0,10),
		filter = self,
		mask = MASK_NPCWORLDSTATIC
	})
	return tr.HitWorld && (tr.MatType == MAT_SAND || tr.MatType == MAT_DIRT)
end

function ENT:OnDamaged(healthOld,healthNew,dmgTagen,attacker,inflictor,dmgInfo)
	if(healthNew <= self:GetMaxHealth() *0.4 && math.random(1,5) <= 4) then
		if(self:CanBurrow()) then
			self:Burrow()
		end
	end
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(self:IsBurrowed()) then return end
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			self.m_pursuing = self.entEnemy
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				self:PlayActivity(ACT_MELEE_ATTACK1, true)
				return
			end
			if(!self:LimbCrippled(HITBOX_LEFTLEG) && !self:LimbCrippled(HITBOX_RIGHTLEG) && CurTime() >= self.m_nextForwardAttack) then
				local ang = self:GetAngleToPos(self.entEnemy:GetPos())
				if(ang.y <= 35 || ang.y >= 325) then
					local fTimeToGoal = self:GetPathTimeToGoal()
					if(self.bDirectChase && fTimeToGoal <= 0.76 && fTimeToGoal >= 0.35 && distPred <= self.fMeleeForwardDistance) then
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
