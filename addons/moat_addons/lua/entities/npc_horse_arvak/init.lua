AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_PLAYER","npc_horse_arvak")
ENT.skName = "horse_arvak"
ENT.sModel = "models/skyrim/shadowmeresoulcairn.mdl"

local tbSounds = {
	["Attack"] = "horse_attack0[1-2].mp3",
	["Death"] = "horse_death0[1-2].mp3",
	["Dismount"] = "horse_dismount01.mp3",
	["Graze"] = "horse_idle_graze0[1-3].mp3",
	["Idle"] = {"horse_idle_head01_a0[1-3].mp3","horse_idle_head01_b0[1-3].mp3"},
	["HeadShake"] = "horse_idle_headshake0[1-2].mp3",
	["Paw"] = "horse_idle_paw01.mp3",
	["Tail"] = "horse_idle_tail0[1-3].mp3",
	["Pain"] = "horse_injured0[1-3].mp3",
	["Mount"] = "horse_mount01.mp3",
	["RearUp"] = "horse_rearup0[1-3].mp3",
	["FootWalkFront"] = "foot/horseskeleton_walk_front0[1-3].mp3",
	["FootWalkBack"] = "foot/horseskeleton_walk_front0[1-3].mp3",
	["FootSprintFront"] = "foot/horseskeleton_sprint_front0[1-4].mp3",
	["FootSprintBack"] = "foot/horseskeleton_sprint_back0[1-4].mp3"
}

function ENT:GetSoundEvents() return tbSounds end

function ENT:OnInit()
	self:SetHullType(HULL_WIDE_SHORT)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(CAP_MOVE_GROUND)
	self:SetHealth(GetConVarNumber("sk_horse_health"))
	self.m_bMounted = false
	
	self.m_exhaustion = 0
	local cspLoop = CreateSound(self,self.sSoundDir .. "horse_breathe0" .. math.random(1,2) .. "_lp.wav")
	cspLoop:SetSoundLevel(58)
	cspLoop:Play()
	self.cspBreathe = cspLoop
	self:StopSoundOnDeath(cspLoop)
	self:SetSkin(math.random(1,4))
	self:SetUseType(SIMPLE_USE)
	
	for i = 1,7 do
		local att = self:LookupAttachment("flame0" .. i)
		//ParticleEffectAttach("twilight_sprinkle",PATTACH_POINT_FOLLOW,self,att)
	end
	//ParticleEffectAttach("arvak_eye",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("leye"))
	//ParticleEffectAttach("arvak_eye",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("reye"))
end