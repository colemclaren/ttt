
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

AccessorFunc(ENT,"m_dmg","Damage",FORCE_NUMBER)
AccessorFunc(ENT,"m_sndHit","HitSound",FORCE_STRING)
AccessorFunc(ENT,"m_particle","ParticleEffect",FORCE_STRING)
AccessorFunc(ENT,"m_force","Force")
AccessorFunc(ENT,"m_dmgType","DamageType",FORCE_NUMBER)
function ENT:Initialize()
	self:SetModel("models/fallout/goregrenade.mdl")
	self:DrawShadow(false)
	self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
		phys:SetBuoyancyRatio(0)
	end
	self.m_dmg = self.m_dmg || 0
	self.m_force = self.m_force || vector_origin
	self.m_dmgType = self.m_dmgType || DMG_ACID
	self.delayRemove = CurTime() +8
	self.m_sndHit = self.m_sndHit || "fx/bullet/impact/flesh/fx_bullet_impact_flesh04.mp3"
	self.m_particle = self.m_particle || "centaur_spit"
	self:DeleteOnRemove(util.ParticleEffect(self:GetParticleEffect(),self:GetPos(),self:GetAngles(),self,nil,false))
end

function ENT:SetEntityOwner(ent)
	self:SetOwner(ent)
	self.entOwner = ent
end

function ENT:OnRemove()
end

function ENT:Think()
	if(CurTime() < self.delayRemove) then return end
	self:Remove()
end

function ENT:OnHit(ent,dist) end

function ENT:PhysicsCollide(data, physobj)
	local valid = IsValid(self.entOwner)
	sound.Play(self:GetHitSound(),self:GetPos(),75,100)
	local tbEnts = util.DealBlastDamage(self:GetPos(),50,self:GetDamage(),self:GetForce(),valid && self.entOwner || self,self,bReduce,self:GetDamageType(),function(ent)
		if(!valid) then return true end
		local disp = self.entOwner:Disposition(ent)
		return disp == D_HT || disp == D_FR
	end)
	for ent,dist in pairs(tbEnts) do self:OnHit(ent,dist) end
	self:Remove()
	return true
end

