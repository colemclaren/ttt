
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/skyrim/weapons/dwarvenarrow.mdl")
	self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end
	self.m_tRemove = CurTime() +8
	self:SetSkin(1)
end

function ENT:SetEntityOwner(ent)
	self:SetOwner(ent)
	self.m_entOwner = ent
end

function ENT:OnRemove()
end

function ENT:Think()
	if(CurTime() < self.m_tRemove) then return end
	self:Remove()
end

function ENT:PhysicsCollide(data,physobj)
	if(self.m_bHit) then return true end
	self.m_bHit = true
	if(IsValid(data.HitEntity) && (data.HitEntity:IsNPC() || data.HitEntity:IsPlayer())) then
		sound.Play("fx/bullet/impact/flesh/fx_bullet_impact_flesh0" .. math.random(1,9) .. ".mp3", self:GetPos(), 75, 100)
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamage(8)
		dmgInfo:SetAttacker(IsValid(self.m_entOwner) && self.m_entOwner || self)
		dmgInfo:SetInflictor(self)
		dmgInfo:SetDamageType(DMG_SLASH)
		dmgInfo:SetDamagePosition(data.HitEntity:NearestPoint(self:GetPos()))
		data.HitEntity:TakeDamageInfo(dmgInfo)
		self:Remove()
		return true
	end
	self:SetPos(data.HitPos +data.OurOldVelocity:GetNormal() *10)
	self:SetMoveType(MOVETYPE_NONE)
	return true
end

