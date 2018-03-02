AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_CHAURUS,"npc_chaurus_flyer")
ENT.iClass = CLASS_CHAURUS
ENT.sModel = "models/skyrim/chaurusflyer.mdl"
ENT.fRangeDistance = 1050
ENT.fMeleeDistance	= 60
ENT.fMeleeForwardDistance = 300
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = true
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.bPlayDeathSequence = false
ENT.UseActivityTranslator = true
ENT.CollisionBounds = Vector(42,42,120)
ENT.UsePoison = true

ENT._PossNoHealthRegen = true

ENT.iBloodType = BLOOD_COLOR_GREEN
ENT.sSoundDir = "npc/chaurusinsect/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_SMALL_FLINCH,
	[HITBOX_HEAD] = ACT_BIG_FLINCH
}

ENT.m_tbSounds = {
	["Attack"] = "chaurusinsect_attack0[1-3].mp3",
	["AttackSpit"] = "chaurusinsect_attackspit01.mp3",
	["AttackGroundDive"] = "chaurusinsect_attackgrounddive01.mp3",
	["Death"] = "chaurusinsect_death0[1-2].mp3",
	["Pain"] = "chaurusinsect_injured0[1-2].mp3"
}

function ENT:UpdateModel()
	self:SetModel("models/skyrim/" .. table.Random({"chaurusflyer","chaurusflyer_variant"}) .. ".mdl")
end

function ENT:OnDeath(dmginfo)
	self:SetBodygroup(1,0)
end

function ENT:OnInit()
	self:SetHullType(HULL_WIDE_SHORT)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_chaurus_hunter_health"))
	self.nextRangeAttack = 0
	
	self:SetBodygroup(1,1)
	
	local cspLoop = CreateSound(self,self.sSoundDir .. "chaurusinsect_idle_wings_lp.wav")
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
	local _, ang = self.ragdoll:GetBonePosition(self:GetMainRagdollBone())
	return ang.r < 0 && ACT_ROLL_LEFT || ACT_ROLL_RIGHT
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
		entSpit:SetDamage(GetConVarNumber("sk_chaurus_hunter_dmg_spit"))
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
		local bPower
		if(atk == "grounddive") then
			dmg = GetConVarNumber("sk_chaurus_hunter_dmg_slash")
			ang = Angle(34,13,-3)
			force = Vector(120,0,0)
		elseif(atk == "power") then
			bPower = true
			dmg = GetConVarNumber("sk_chaurus_hunter_dmg_slash_power")
			ang = Angle(34,0,0)
			dist = dist +100
			force = Vector(320,0,0)
		else
			dmg = GetConVarNumber("sk_chaurus_hunter_dmg_slash")
			ang = Angle(43,-13,3)
			force = Vector(120,0,0)
		end
		local fcPoison
		if(self.UsePoison) then
			fcPoison = function(ent,dmginfo)
				if(bPower || math.random(1,4) == 1) then
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
			if(CurTime() >= self.nextRangeAttack && dist <= self.fRangeDistance && self:EntInAttackCone(self.entEnemy)) then
				self.nextRangeAttack = CurTime() +math.Rand(2,4)
				//self:PlayActivity(ACT_RANGE_ATTACK1,true)
				//return
				//if(math.random(1,2) == 2) then self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1) end
				self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
			end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
