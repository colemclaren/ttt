AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Owner = self.Entity:GetOwner()

	if !IsValid(self.Owner) then
		self:Remove()
		return
	end

	self.Entity:SetModel("models/weapons/b_flare.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:EmitSound("Weapon_FlareGun.Burn")
	
	self.Timer = CurTime() + 1
	self.RepeatTimer = CurTime() + 1

	self.Entity:SetNWBool("Smoke", true)
	self.Entity.Explode = false
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	if self.RepeatTimer < CurTime() then
		local effectdata = EffectData()
			effectdata:SetOrigin(self.Entity:GetPos())
		util.Effect("effect_mad_flare_fire", effectdata)
	end

	if self.Timer < CurTime() then
		self:Explosion()
		self.Timer = CurTime() + 10
	end

	if self.Entity:WaterLevel() > 2 then
		self.Entity:Remove()
	end

	if self.Entity.Explode then
		local tracedata = {}
		tracedata.start = self.Entity:GetPos()
		tracedata.endpos = Vector(self.Entity:GetPos().x, self.Entity:GetPos().y, self.Entity:GetPos().z - 100)
		tracedata.filter = self.Entity
		local tr = util.TraceLine(tracedata)

		local flame = ents.Create("point_hurt")
		flame:SetPos(self.Entity:GetPos())
		flame:SetOwner(self.Owner)
		flame:SetKeyValue("DamageRadius", 100)
		flame:SetKeyValue("Damage", 5)
		flame:SetKeyValue("DamageDelay", 0.4)
		flame:SetKeyValue("DamageType", 8)
		flame:Spawn()
		flame:Fire("TurnOn", "", 0) 
		flame:Fire("kill", "", 0.5)

		if (math.random(0, 6) < 1 and self.Entity:WaterLevel() <= 0 and tr.HitWorld) then
			local fire = ents.Create("env_fire")
			fire:SetPos(self.Entity:GetPos() + Vector( math.random(-60, 60), math.random(-60, 60), 0))
			fire:SetKeyValue("health", math.random(5, 15))
			fire:SetKeyValue("firesize", "32")
			fire:SetKeyValue("fireattack", "10")
			fire:SetKeyValue("damagescale", "1.0")
			fire:SetKeyValue("StartDisabled", "0")
			fire:SetKeyValue("firetype", "0")
			fire:SetKeyValue("spawnflags", "128")
			fire:Spawn()
			fire:Fire("StartFire", "", 0)
		end
	end
end

/*---------------------------------------------------------
   Name: ENT:Explosion()
---------------------------------------------------------*/
function ENT:Explosion()

	self.Entity.Explode = true

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("effect_mad_flare_explosion", effectdata)

	local explo = ents.Create("env_explosion")
		explo:SetOwner(self.Owner)
		explo:SetPos(self.Entity:GetPos())
		explo:SetKeyValue("iMagnitude", "50")
		explo:SetKeyValue("spawnflags", "783")
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode", "", 0)

	self.Entity:Fire("kill", "", 5)
end

/*---------------------------------------------------------
   Name: ENT:OnRemove()
---------------------------------------------------------*/
function ENT:OnRemove()

	self.Entity:StopSound("Weapon_FlareGun.Burn")
end