AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_FALMER","npc_falmer")
ENT.NPCFaction = NPC_FACTION_FALMER
ENT.iClass = CLASS_FALMER
util.AddNPCClassAlly(CLASS_FALMER,"npc_falmer")
ENT.sModel = "models/skyrim/falmer.mdl"
ENT.skName = "falmer"
ENT.CollisionBounds = Vector(18,18,64)
ENT.BoneRagdollMain = "NPC Spine"

ENT.sSoundDir = "npc/falmer/"

ENT.m_tbSounds = {
	["AggroWarning"] = "falmer_aggrowarning0[1-3].mp3",
	["Attack"] = "falmer_attack0[1-3].mp3",
	["AttackPower"] = "falmer_attackpower0[1-2].mp3",
	["Death"] = "falmer_death0[1-3].mp3",
	["IdleDetection"] = "falmer_idle_detection01.mp3",
	["IdleScratch"] = "falmer_idlescratch01.mp3",
	["Pain"] = "falmer_injured0[1-3].mp3",
	["FootLeft"] = "foot/falmer_foot_walk_l0[1-2].mp3",
	["FootRight"] = "foot/falmer_foot_walk_r0[1-2].mp3"
}

local BaseClass = "npc_humanoid_base"
function ENT:OnInit()
	self:GetBaseClass(BaseClass).OnInit(self)
	
	self.m_cspIdle = CreateSound(self,self.sSoundDir .. "falmer_breathe_lp.wav")
	self.m_cspIdle:Play()
	self:StopSoundOnDeath(self.m_cspIdle)
end

function ENT:CanTaunt()
	return self:GetWeaponType() == "1hm"
end

function ENT:SelectTauntActivity()
	return ACT_SIGNAL_ADVANCE
end

function ENT:GenerateEquipment()
	local r = math.random(1,2)
	if(r == 1) then
		self:AddToEquipment("00038340") // Falmer Bow
		self:AddToEquipment("000302CD") // Falmer War Axe
		self:AddToEquipment("00038341") // Falmer Arrow
	else
		self:AddToEquipment("0005C06C") // Falmer Shield
		self:AddToEquipment(table.Random({"000302CD","0002E6D1"})) // Falmer War Axe / Falmer Sword
	end
	self:EquipSuitedEquipment()
end

function ENT:SelectGetUpActivity()
	local _,ang = self.ragdoll:GetBonePosition(self:GetMainRagdollBone())
	return ang.p >= 0 && ACT_ROLL_LEFT || ACT_ROLL_RIGHT
end

function ENT:GenerateArmor()
	self:SetBodygroup(1,math.random(1,3))
end

function ENT:InitSandbox()
	if(!self:GetSquad()) then self:SetSquad("npc_falmer_sbsquad") end
end

function ENT:TranslateActivity(act)
	if(self:IsBowDrawn()) then if(act == ACT_WALK_AIM_STIMULATED || act == ACT_RUN_AIM_STIMULATED) then return ACT_WALK_AIM_STIMULATED end end
	if(self:IsShieldDrawn()) then if(act == ACT_WALK_RELAXED) then return ACT_RUN_RELAXED end end
	local holdType = self:GetWeaponType()
	if(holdType == "bow" && self.m_bBowWalk && !self:IsPossessed()) then
		if(act == ACT_RUN_AIM_STIMULATED) then return ACT_WALK_AIM_STIMULATED end
	end
	return act
end

function ENT:EventHandle(...)
	if(self:GetBaseClass(BaseClass).EventHandle(self,...)) then return true end
	local event = select(1,...)
	if(event == "1hm") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid() || !wep.Strike) then return true end
		local atk = select(2,...)
		if(atk == "a") then
			local hit = wep:Strike(false)
		elseif(atk == "b") then
			local hit = wep:Strike(false)
		elseif(atk == "c") then
			local hit = wep:Strike(false)
		elseif(atk == "d") then
			local hit = wep:Strike(false)
		elseif(atk == "forwardpower") then
			local hit = wep:Strike(true)
		elseif(atk == "standingpower") then
			local hit = wep:Strike(true)
		end
		return true
	end
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	self:GetBaseClass(BaseClass).SelectScheduleHandle(self,enemy,dist,distPred,disp)
end