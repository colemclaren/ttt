AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_CHAURUS,"npc_chaurus")
ENT.iClass = CLASS_CHAURUS
ENT.sModel = "models/skyrim/chaurus.mdl"
ENT.fRangeDistance = 1050
ENT.fMeleeDistance	= 60
ENT.fMeleeForwardDistance = 300
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = true
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.bPlayDeathSequence = true
ENT.UseActivityTranslator = true
ENT.CollisionBounds = Vector(44,44,68)
ENT.UsePoison = true

ENT._PossNoHealthRegen = true

ENT.iBloodType = BLOOD_COLOR_YELLOW
ENT.sSoundDir = "npc/chaurus/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_SMALL_FLINCH
}

ENT.tblDeathActivities = {
	[HITGROUP_GENERIC] = ACT_DIESIMPLE
}

ENT.m_tbSounds = {
	["Attack"] = "chaurus_attack01.mp3",
	["Death"] = "chaurus_death0[1-2].mp3",
	["Feed"] = "chaurus_feed0[1-2].mp3",
	["Pain"] = "chaurus_injured0[1-2].mp3",
	["Mandibles"] = "chaurus_mandibles0[1-3].mp3",
	["Taunt"] = "chaurus_taunt01.mp3",
	["WarningCall"] = "chaurus_warningcall01.mp3",
	["WarningTail"] = "chaurus_warningtail01.mp3",
	["FootWalkBack"] = "foot/chaurus_foot_walk_back0[1-8].mp3",
	["FootWalkFront"] = "foot/chaurus_foot_walk_front0[1-8].mp3"
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
	[DMG_DIRECT] = 0.3
}

function ENT:OnInit()
	self:SetHullType(HULL_WIDE_SHORT)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_chaurus_health"))
	self.m_nextForwardAttack = 0
	self.nextRangeAttack = 0
	
	local cspLoop = CreateSound(self,self.sSoundDir .. "chaurus_breathe_lp.wav")
	cspLoop:SetSoundLevel(85)
	cspLoop:Play()
	self.cspBreathe = cspLoop
	self:StopSoundOnDeath(cspLoop)
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

function ENT:TranslateActivity(act)
	if(act == ACT_IDLE) then
		local state = self:GetState()
		if(state == NPC_STATE_COMBAT || state == NPC_STATE_ALERT) then return ACT_IDLE_ANGRY end
	end
	return act
end

function ENT:GenerateInventory()
	self:AddToInventory("005J8YOF")
end

function ENT:SelectGetUpActivity()
	return ACT_ROLL_RIGHT
end

function ENT:Poison(ent)
	if(ent:IsPlayer()) then ent:ConCommand("play fx/fx_poison_stinger.mp3") end
	local tm = "npcpoison" .. self:EntIndex() .. "_" .. ent:EntIndex()
	timer.Create(tm,0.35,12,function()
		if(!ent:IsValid() || !ent:Alive()) then timer.Remove(tm)
		else
			local attacker
			if(self:IsValid()) then attacker = self
			else attacker = ent end
			local dmg = DamageInfo()
			dmg:SetDamageType(DMG_NERVEGAS)
			dmg:SetDamage(2)
			dmg:SetAttacker(attacker)
			dmg:SetInflictor(attacker)
			dmg:SetDamagePosition(ent:GetPos() +ent:OBBCenter())
			ent:TakeDamageInfo(dmg)
		end
	end)
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "rattack") then
		local att = self:GetAttachment(self:LookupAttachment("spit"))
		if(!att) then return true end
		local vTarget
		if(self:IsPossessed()) then
			vTarget = self:GetPossessor():GetPossessionEyeTrace().HitPos
			local dir = (vTarget -att.Pos):GetNormal()
			vTarget = att.Pos +dir *math.min(att.Pos:Distance(vTarget),1000)
		else vTarget = self:GetPredictedEnemyPosition(0.8) || (att.Pos +self:GetForward() *500) end
		local entSpit = ents.Create("obj_spit")
		entSpit:SetPos(att.Pos)
		entSpit:SetEntityOwner(self)
		entSpit:SetDamage(GetConVarNumber("sk_chaurus_dmg_spit"))
		entSpit.OnHit = function(entSpit,ent,dist)
			if(self.UsePoison) then
				if(ent:IsPlayer() && GAMEMODE.Aftermath) then ent:AddEffect("AnimalPoison",true,0.35,12,4,self)
				else self:Poison(ent) end
			end
		end
		entSpit:Spawn()
		entSpit:Activate()
		local eta = entSpit:SetArcVelocity(att.Pos,vTarget,600,self:GetForward(),0.65,VectorRand() *0.0125)
		return true
	end
	if(event == "mattack") then
		local dist = self.fMeleeDistance
		local dmg
		local ang
		local force
		local atk = select(2,...)
		if(atk == "combitea") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(16,-4,1)
			force = Vector(120,0,0)
		elseif(atk == "combiteb") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(16,0,0)
			force = Vector(120,0,0)
		elseif(atk == "biteforward") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash_power")
			ang = Angle(24,0,0)
			dist = dist +100
			force = Vector(320,0,0)
		elseif(atk == "biteleft") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(18,-16,3)
			force = Vector(120,0,0)
		elseif(atk == "bitepowera") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash_power")
			ang = Angle(28,0,0)
			force = Vector(120,0,0)
		elseif(atk == "bitepowerb") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(6,0,0)
			force = Vector(120,0,0)
		elseif(atk == "biteleftb") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(18,-16,3)
			force = Vector(120,0,0)
		elseif(atk == "biterleftc") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(12,-32,4)
			force = Vector(120,0,0)
		elseif(atk == "chop") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(18,-4,1)
			force = Vector(120,0,0)
		elseif(atk == "headbash") then
			dmg = GetConVarNumber("sk_chaurus_dmg_slash")
			ang = Angle(-18,24,-3)
			force = Vector(360,200,60)
		end
		local fcPoison
		if(self.UsePoison) then
			fcPoison = function(ent,dmginfo)
				if(math.random(1,4) == 1) then
					if(ent:IsPlayer() && GAMEMODE.Aftermath) then ent:AddEffect("AnimalPoison",true,0.35,12,4,self)
					else self:Poison(ent) end
				end
			end
		end
		self:DealMeleeDamage(dist,dmg,ang,force,nil,nil,nil,nil,fcPoison)
		return true
	end
end

function ENT:EntInAttackCone(ent)
	local i = 0
	local ang = self:GetAngleToPos(ent:GetCenter())
	return (ang.y <= 35 || ang.y >= 325) && (ang.p <= 45 || ang.p >= 315)
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
			if(CurTime() >= self.nextRangeAttack && dist <= self.fRangeDistance && self:EntInAttackCone(self.entEnemy)) then
				self.nextRangeAttack = CurTime() +math.Rand(2,4)
				if(math.random(1,3) == 3) then self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1) end
			end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
