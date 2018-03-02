
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self.m_tRemove = CurTime() +8
end

function ENT:SetItem(itemID,data)
	self.m_dmg = data.dmg
	self:SetModel(data.model)
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
		sound.Play("weapons/arrow/impact_arrow_flesh0" .. math.random(1,4) .. ".mp3",self:GetPos(),75,100)
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamage(self.m_dmg || 8)
		dmgInfo:SetAttacker(IsValid(self.m_entOwner) && self.m_entOwner || self)
		dmgInfo:SetInflictor(self)
		dmgInfo:SetDamageType(DMG_SLASH)
		dmgInfo:SetDamagePosition(data.HitEntity:NearestPoint(self:GetPos()))
		data.HitEntity:TakeDamageInfo(dmgInfo)
		self:Remove()
		return true
	end
	sound.Play("weapons/arrow/impact_arrow_stick0" .. math.random(1,3) .. ".mp3",self:GetPos(),75,100)
	self:SetPos(data.HitPos +data.OurOldVelocity:GetNormal() *10)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetNotSolid(true)
	return true
end

