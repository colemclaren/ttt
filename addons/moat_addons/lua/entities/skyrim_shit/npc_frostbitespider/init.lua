AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_SPIDER","npc_frostbitespider")
ENT.NPCFaction = NPC_FACTION_SPIDER
ENT.iClass = CLASS_SPIDER_FROSTBITE
util.AddNPCClassAlly(CLASS_SPIDER_FROSTBITE,"npc_frostbitespider")
ENT.sModel = "models/skyrim/frostbitespider.mdl"
ENT.fMeleeDistance	= 64
ENT.fMeleeForwardDistance = 250
ENT.possOffset = Vector(-30,0,50)
ENT.fRangeDistance = 800
ENT.bFlinchOnDamage = false
ENT.m_bForceDeathAnim = true
ENT.UseActivityTranslator = true
ENT.CanSpit = true
ENT.m_bAttackFreeze = false
ENT.m_bAttackPoison = true
ENT.BoneRagdollMain = "NPC Root [Root ]"
ENT.skName = "frostbitespider"
ENT.CollisionBounds = Vector(45,45,40)

ENT.DamageScales = {
	[DMG_BURN] = 1.5,
	[DMG_PARALYZE] = 0,
	[DMG_NERVEGAS] = 0,
	[DMG_POISON] = 0,
	[DMG_DIRECT] = 1.5
}

ENT.iBloodType = BLOOD_COLOR_RED
ENT.sSoundDir = "npc/frostbitespider/"

ENT.m_tbSounds = {
	["AttackA"] = "spiderfrostbite_attack_a0[1-2].mp3",
	["AttackB"] = "spiderfrostbite_attack_b0[1-2].mp3",
	["AttackSpit"] = "spiderfrostbite_attackspit0[1-2],mp3",
	["AttackBite"] = "spiderfrostbite_attack_bite01.mp3",
	["Death"] = "spiderfrostbite_death0[1-3].mp3",
	["Pain"] = "spiderfrostbite_injured0[1-3].mp3",
	["FootLeft"] = "foot/spiderfrostbite_foot_l0[1-3].mp3",
	["FootRight"] = "foot/spiderfrostbite_foot_r0[1-3].mp3"
}

function ENT:OnInit()
	self:SetHullType(HULL_WIDE_SHORT)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	self:PlayIdleSound()
	
	self.m_nextForwardAttack = 0
	self.m_tNextRangeAttack = 0
	if(!self.m_type) then self:SetType(math.random(1,2)) end
end

function ENT:KeyValueHandle(key,val)
	if(key == "type") then
		self:SetType(tonumber(val))
		return true
	end
end

function ENT:SetType(type)
	self:SetSkin(type)
	self.m_bAttackFreeze = type == 1
	if(type == 1) then self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health") *2) end
	self.m_type = type
end

function ENT:PlayIdleSound()
	self.cspIdleLoop = CreateSound(self,self.sSoundDir .. "spiderfrostbite_breathe_lp.wav")
	self:StopSoundOnDeath(self.cspIdleLoop)
	self.cspIdleLoop:Play()
end

function ENT:OnDeath(dmginfo)
	local pos = self:GetPos()
	local tbEnts = {}
	for i = 1,math.random(3,8) do
		local ent = ents.Create("npc_frostbitespider_small")
		ent:SetPos(pos +Angle(0,math.random(0,360),0):Forward() *math.random(0,75))
		ent:SetAngles(Angle(0,math.random(0,360),0))
		ent:SetDTBool(3,self:GetDTBool(3))
		ent:Spawn()
		ent:Activate()
		ent:SetType(self.m_type)
		ent:MergeMemory(self:GetMemory())
		for _, entTgt in ipairs(tbEnts) do ent:NoCollide(entTgt) end
		table.insert(tbEnts,ent)
	end
end

function ENT:TranslateActivity(act)
	if(act == ACT_IDLE) then
		local state = self:GetState()
		if(state == NPC_STATE_ALERT || state == NPC_STATE_COMBAT) then return ACT_IDLE_ANGRY end
	end
	return act
end

function ENT:GenerateInventory()
	--self:AddToInventory("004f8H4A")
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "mattack") then
		local dist = self.fMeleeDistance
		local skDmg = "sk_" .. self.skName .. "_dmg_slash"
		local force
		local ang
		local atk = select(2,...)
		if(atk == "bite") then
			force = Vector(50,0,0)
			ang = Angle(48,0,0)
		elseif(atk == "chopr") then
			force = Vector(50,0,0)
			ang = Angle(48,-10,4)
		elseif(atk == "chopl") then
			force = Vector(50,0,0)
			ang = Angle(48,10,-4)
		elseif(atk == "forwardjump") then
			skDmg = skDmg .. "_power"
			force = Vector(180,0,20)
			ang = Angle(-80,0,0)
		end
		local bHit = self:DealMeleeDamage(dist,GetConVarNumber(skDmg),ang,force,DMG_SLASH,nil,true,nil,function(ent,dmgInfo)
			if(self.m_bAttackFreeze && math.random(1,5) == 1) then
				ent:SetFrozen(35)
			end
			if(self.m_bAttackPoison && ent:IsPlayer()) then
				if(ent.AddEffect) then ent:AddEffect("AnimalPoison",true,0.35,10,3,self) end
			end
		end)
		self:EmitSound(self.sSoundDir .. "spiderfrostbite_attack_impact0" .. math.random(1,2) .. ".mp3",75,100)
		return true
	end
	if(event == "rattack") then
		local att = self:GetAttachment(self:LookupAttachment("mouth"))
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
		entSpit:SetDamage(GetConVarNumber("sk_frostbitespider_dmg_spit"))
		entSpit.OnHit = function(entSpit,ent,dist)
			if(ent:IsPlayer()) then if(ent.AddEffect) then ent:AddEffect("AnimalPoison",true,0.2,24,2,self) end end
			if(self.m_bAttackFreeze) then ent:SetFrozen(35) end
		end
		entSpit:Spawn()
		entSpit:Activate()
		local eta = entSpit:SetArcVelocity(att.Pos,vTarget,600,self:GetForward(),0.65,VectorRand() *0.0125)
		return true
	end
end

function ENT:AttackMelee(ent)
	self:SetTarget(ent)
	self:PlayActivity(ACT_MELEE_ATTACK1,2)
end

function ENT:_PossPrimaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossSecondaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_RANGE_ATTACK1,false,fcDone)
end

function ENT:_PossJump(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK2,false,fcDone)
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				self:PlayActivity(ACT_MELEE_ATTACK1,true)
				return
			end
			if(CurTime() >= self.m_nextForwardAttack) then
				local ang = self:GetAngleToPos(self.entEnemy:GetPos())
				if(ang.y <= 25 || ang.y >= 335) then
					local fTimeToGoal = self:GetPathTimeToGoal()
					if(self.bDirectChase && fTimeToGoal <= 3 && fTimeToGoal >= 0.6 && distPred <= self.fMeleeForwardDistance) then
						self:PlayActivity(ACT_MELEE_ATTACK2)
						self.m_nextForwardAttack = CurTime() +math.Rand(1,4)
						return
					end
				end
			end
			if(self.CanSpit && CurTime() >= self.m_tNextRangeAttack && dist <= self.fRangeDistance) then
				self.m_tNextRangeAttack = CurTime() +math.Rand(3,10)
				if(math.random(1,2) == 1) then
					self:PlayActivity(ACT_RANGE_ATTACK1,true)
					return
				end
			end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
