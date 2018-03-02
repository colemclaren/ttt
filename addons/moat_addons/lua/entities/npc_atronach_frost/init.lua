AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
local faction = _R.NPCFaction.Create("NPC_FACTION_ATRONACH")
faction:AddClass("npc_atronach_frost")

ENT.NPCFaction = NPC_FACTION_ATRONACH
ENT.iClass = CLASS_ATRONACH
util.AddNPCClassAlly(CLASS_ATRONACH,"npc_atronach_frost")
ENT.sModel = "models/skyrim/atronachfrost.mdl"
ENT.fMeleeDistance	= 64
ENT.fMeleeForwardDistance = 250
ENT.bFlinchOnDamage = false
ENT.m_bKnockDownable = false
ENT.bIgnitable = false
ENT.bFreezable = false
ENT.m_bForceDeathAnim = true
ENT.UseActivityTranslator = true
ENT.BoneRagdollMain = "NPC COM [COM ]"
ENT.skName = "atronach_frost"
ENT.CollisionBounds = Vector(30,30,120)
ENT.SurvivalCollisionBounds = Vector(26,26,90)

ENT._PossNoHealthRegen = true

ENT.m_fFollowDistance = 110
ENT.m_fFollowDistanceOffensive = 550
ENT.m_fFollowDistanceOffensiveAttack = 2200
ENT.m_fFollowDistanceDefensive = 220
ENT.m_fFollowDistanceDefensiveAttack = 1000

ENT.DamageScales = {
	[DMG_BURN] = 1.5,
	[DMG_PARALYZE] = 0,
	[DMG_NERVEGAS] = 0,
	[DMG_POISON] = 0,
	[DMG_DIRECT] = 1.5
}

ENT.iBloodType = false
ENT.sSoundDir = "npc/atronachfrost/"

ENT.m_tbSounds = {
	["Attack"] = "atronachfrost_attack01.mp3",
	["FootLeft"] = "foot/atronachfrost_foot_l0[1-2].mp3",
	["FootRight"] = "foot/atronachfrost_foot_r0[1-2].mp3",
	["Death"] = "atronachfrost_death01.mp3"
}

PrecacheParticleSystem("frost_atro_bodyice")
function ENT:OnInit()
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	
	self.cspIdleLoop = CreateSound(self,self.sSoundDir .. "atronachfrost_breathe_lp.wav")
	self:StopSoundOnDeath(self.cspIdleLoop)
	self.cspIdleLoop:Play()
	
	self.m_nextForwardAttack = 0
	self.m_nextGroundSmash = 0
end

function ENT:_PossPrimaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossSecondaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK2,false,fcDone)
end

function ENT:_PossJump(entPossessor,fcDone)
	self:PlayActivity(ACT_RANGE_ATTACK1_LOW,false,fcDone)
end

function ENT:TranslateActivity(act)
	if(act == ACT_IDLE && self:IsArmed()) then return ACT_IDLE_ANGRY end
	return act
end

function ENT:IsArmed() return self.m_bArmed end

function ENT:Arm()
	self:PlayActivity(ACT_ARM,true)
	self.m_bArmed = true
end

function ENT:Disarm()
	if(self:GetActivity() == ACT_DISARM) then return end
	self:PlayActivity(ACT_DISARM)
end

function ENT:OnStateChanged(old, new)
	if((old == NPC_STATE_COMBAT || old == NPC_STATE_ALERT) && new == NPC_STATE_IDLE && self:IsArmed()) then self:Disarm() end
	if((new == NPC_STATE_COMBAT || new == NPC_STATE_ALERT) && old != NPC_STATE_COMBAT && old != NPC_STATE_ALERT) then self:Arm() end
end

function ENT:OnAreaCleared()
	if(self:IsArmed()) then self:Disarm() end
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
		local bKnockdown
		local sndHit
		local freeze = 10
		if(atk == "pl1") then
			dist = dist +20
			ang = Angle(55,0,0)
			force = Vector(350,0,200)
			local att = self:GetAttachment(self:LookupAttachment("lhand"))
			util.ScreenShake(att.Pos,500,500,1.5,2500)
			self:EmitSound(self.sSoundDir .. "atronachfrost_attackpower_impact01.mp3",100,100)
			ParticleEffect("frost_atro_gpound",att.Pos,Angle(0,0,0),self)
			skDmg = skDmg .. "_power"
			self:DealMeleeDamage(dist,GetConVarNumber(skDmg),ang,force,DMG_SLASH,nil,true,nil,function(ent,dmgInfo)
				local dist = ent:NearestPoint(att.Pos):Distance(att.Pos)
				if(dist <= 15 && ent.KnockDown) then ent:KnockDown(2) end
				if(ent:IsPlayer()) then ent:SetFrozen(10) end
			end)
			for _, ent in ipairs(ents.FindInSphere(att.Pos,200)) do
				if((ent:IsNPC() || ent:IsPlayer()) && ent != self && ent:Alive() && self:IsVisible(ent)) then
					local dist = att.Pos:Distance(ent:NearestPoint(att.Pos))
					ent:SetFrozen((1 -dist /160) *85)
				end
			end
			return true
		elseif(atk == "pr1") then
			sndHit = self.sSoundDir .. "atronachfrost_attackpower_02b.mp3"
			dist = dist +30
			ang = Angle(38,-14,3)
			bKnockdown = true
			freeze = 45
		elseif(atk == "l1") then
			sndHit = self.sSoundDir .. "atronachfrost_attackpower_01b.mp3"
			ang = Angle(-45,10,-2)
			force = Vector(860,0,140)
		elseif(atk == "r1") then
			sndHit = self.sSoundDir .. "atronachfrost_attackpower_02b.mp3"
			ang = Angle(45,-12,3)
			force = Vector(680,0,120)
		end
		local bHit = self:DealMeleeDamage(dist,GetConVarNumber(skDmg),ang,force,DMG_SLASH,nil,true,nil,function(ent,dmgInfo)
			if(ent:IsPlayer()) then ent:SetFrozen(freeze) end
			if(bKnockdown && ent.KnockDown) then ent:KnockDown(3) end
		end)
		self:EmitSound(sndHit,75,100)
		--self:EmitSound(bHit && ("npc/zombie/claw_strike" .. math.random(1,3) .. ".wav") || ("npc/zombie/claw_miss" .. math.random(1,2) .. ".wav"),75,100)
		return true
	end
end

function ENT:AttackMelee(ent)
	self:SetTarget(ent)
	self:PlayActivity(ACT_MELEE_ATTACK1,2)
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				if(CurTime() >= self.m_nextGroundSmash) then
					self.m_nextGroundSmash = CurTime() +math.Rand(4,8)
					if(math.random(1,2) == 1) then
						self:PlayActivity(ACT_MELEE_ATTACK2,true)
						return
					end
				end
				self:PlayActivity(ACT_MELEE_ATTACK1,true)
				return
			end
			if(CurTime() >= self.m_nextForwardAttack) then
				local ang = self:GetAngleToPos(self.entEnemy:GetPos())
				if(ang.y <= 20 || ang.y >= 340) then
					local fTimeToGoal = self:GetPathTimeToGoal()
					if(self.bDirectChase && fTimeToGoal <= 2.75 && fTimeToGoal >= 0.3 && distPred <= self.fMeleeForwardDistance) then
						self:PlayActivity(ACT_RANGE_ATTACK1_LOW)
						self.m_nextForwardAttack = CurTime() +math.Rand(1,4)
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
