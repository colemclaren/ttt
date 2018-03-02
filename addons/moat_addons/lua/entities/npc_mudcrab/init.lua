// TODO:
-- Only burry in mud/dirt
-- Fix animations in enemy catalogue!

AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_MUDCRAB","npc_mudcrab")
ENT.NPCFaction = NPC_FACTION_MUDCRAB
ENT.iClass = CLASS_MUDCRAB
util.AddNPCClassAlly(CLASS_MUDCRAB,"npc_mudcrab")
ENT.sModel = "models/skyrim/mudcrab.mdl"
ENT.fMeleeDistance	= 24
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = true
ENT.CanBurrow = true
ENT.BoneRagdollMain = "Mcrab_Body"
ENT.skName = "mudcrab"
ENT.CollisionBounds = Vector(22,22,26)

ENT.iBloodType = BLOOD_COLOR_RED
ENT.sSoundDir = "npc/mudcrab/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_FLINCH_CHEST
}

ENT.m_tbSounds = {
	["Attack"] = "mudcrab_attack0[1-3].mp3",
	["AttackCombo"] = "mudcrab_attackcombo0[1-2].mp3",
	["AttackJump"] = "mudcrab_attackforwardjump01.mp3",
	["Death"] = "mudcrab_death0[1-2].mp3",
	["DigIn"] = "mudcrab_dig_in01.mp3",
	["DigOut"] = "mudcrab_dig_out01.mp3",
	["Idle"] = "mudcrab_idle0[1-2].mp3",
	["Pain"] = "mudcrab_injured0[1-2].mp3",
	["FootLeft"] = "foot/mudcrab_foot_l0[1-3].mp3",
	["FootRight"] = "foot/mudcrab_foot_r0[1-3].mp3"
}

function ENT:OnInit()
	self:SetHullType(HULL_WIDE_SHORT)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	self.nextMoveSideways = 0
	
	self:SetBodygroup(1,math.random(0,2))
	local cspLoop = CreateSound(self,self.sSoundDir .. "mudcrab_breathe_lp.wav")
	cspLoop:SetSoundLevel(75)
	cspLoop:Play()
	self.cspBreathe = cspLoop
	self.m_nextBurrow = 0
	self:StopSoundOnDeath(cspLoop)
	self:SubInit()
end

function ENT:InitAftermath()
	self:CallOnInitialized(function()
		self:SetBurrowed()
		self:UnBurrow()
	end)
end

function ENT:SubInit()
end

function ENT:DamageHandle(dmginfo)
	if(!self.CanBurrow) then return end
	if(self:Health() <= self:GetMaxHealth() *0.44 && !self:KnockedDown() && !self:IsBurrowed() && CurTime() >= self.m_nextBurrow && math.random(1,3) == 1) then
		self:Burrow(math.Rand(8,18))
	end
end

function ENT:GenerateInventory()
	self:AddToInventory("00151F7E")
end

function ENT:SelectGetUpActivity()
	local _, ang = self.ragdoll:GetBonePosition(self:GetMainRagdollBone())
	return ang.p >= 0 && ACT_ROLL_LEFT || ACT_ROLL_RIGHT
end

function ENT:_PossPrimaryAttack(entPossessor, fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:OnThink()
	self:UpdateLastEnemyPositions()
	if(self:IsBurrowed()) then
		if(self.m_unburrow && CurTime() >= self.m_unburrow) then self:UnBurrow()
		elseif(CurTime() >= self.m_burrowNextHpRegen) then
			local hp = self:Health()
			local hpMax = self:GetMaxHealth()
			if(hp < hpMax) then self:SetHealth(hp +2) end
			self.m_burrowNextHpRegen = CurTime() +1
		end
	end
	if(IsValid(self.entEnemy) && self.moveSideways && CurTime() < self.moveSideways) then
		local ang = self:GetAngles()
		local yawTgt = (self.entEnemy:GetPos() -self:GetPos()):Angle().y
		ang.y = math.ApproachAngle(ang.y,yawTgt,10)
		self:SetAngles(ang)
		self:NextThink(CurTime())
		return true
	end
end

function ENT:SetBurrowed()
	self:Sleep()
	self.m_bBurrowed = true
	self.bInSchedule = true
end

function ENT:KeyValueHandle(key,val)
	if(key == "startburrowed") then
		if(val == 1) then
			self:SetBurrowed()
		end
		return
	end
end

function ENT:IsBurrowed() return self.m_bBurrowed end

function ENT:UnBurrow()
	if(!self:IsBurrowed()) then return end
	self:Wake()
	self.m_bBurrowed = false
	self.bInSchedule = false
	self.cspBreathe:Play()
	self:CallOnInitialized(function() self:PlayActivity(ACT_DEPLOY) end)
	self.m_unburrow = nil
	self.bFlinchOnDamage = true
	self.m_burrowNextHpRegen = nil
	self.m_nextBurrow = CurTime() +math.Rand(4,30)
end

function ENT:Burrow(tmUnburrow)
	if(self:IsBurrowed()) then return end
	self.cspBreathe:FadeOut(0)
	self.m_bBurrowed = true
	if(tmUnburrow) then self.m_unburrow = CurTime() +tmUnburrow end
	self.m_burrowNextHpRegen = CurTime()
	self.bFlinchOnDamage = false
	self:CallOnInitialized(function() self:PlayActivity(ACT_UNDEPLOY) end)
end

function ENT:InputHandle(cvar,activator,caller,data)
	if(cvar == "unburrow") then
		self:UnBurrow()
		return true
	end
	if(cvar == "burrow") then
		self:Burrow(math.Rand(8,18))
		return true
	end
	return false
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "mattack") then
		local dist = self.fMeleeDistance
		local dmg = GetConVarNumber("sk_" .. self.skName .. "_dmg_slash")
		local ang
		local atk = select(2,...)
		if(atk == "righta") then ang = Angle(5,-15,2)
		elseif(atk == "lefta") then ang = Angle(5,15,-2)
		elseif(atk == "rightb") then ang = Angle(5,-15,2)
		elseif(atk == "leftb") then ang = Angle(16,15,-2)
		else ang = Angle(16,15,-2) end
		self:DealMeleeDamage(dist,dmg,ang)
		return true
	end
	if(event == "dig") then
		self:SetBurrowed()
		return true
	end
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			if(self.moveSideways) then
				if(CurTime() > self.moveSideways || dist > 120 || dist <= 40) then
					self:SetRunActivity(ACT_RUN)
					self.moveSideways = nil
					self.nextMoveSideways = CurTime() +4
				else
					self:MoveToPosDirect(self:GetPos() +self:GetRight() *(self.moveDir == 0 && 1 || -1) *80,true,true)
					return
				end
			elseif(dist <= 100 && dist > 40) then
				if(CurTime() >= self.nextMoveSideways) then
					if(math.random(1,3) == 1) then
						self.moveSideways = CurTime() +math.Rand(2,4)
						self.moveDir = math.random(0,1)
						self:SetRunActivity(self:GetWalkActivity())
						self:MoveToPosDirect(self:GetPos() +self:GetRight() *(self.moveDir == 0 && 1 || -1) *80,true,true)
						return
					else self.nextMoveSideways = CurTime() +4 end
				end
			end
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				self:PlayActivity(ACT_MELEE_ATTACK1, true)
				return
			end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
