
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	//self:SetModel("models/gibs/agibs.mdl")
	self:SetMoveCollide(COLLISION_GROUP_DEBRIS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_CUSTOM)
	//local vecMin = Vector(-20,-20,-20)
	//local vecMax = Vector(20,20,20)
	//self:SetCollisionBounds(vecMin, vecMax)
	//self:PhysicsInitBox(vecMin, vecMax)
	//self:PhysicsInitSphere(5)
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetMass(1)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end
	self.delayRemove = CurTime() +math.Rand(8,16)
end

function ENT:OnRemove()
end

function ENT:Think()
	if !self.bDead && CurTime() >= self.delayRemove then self.bDead = true; self:FadeOut() end
end
