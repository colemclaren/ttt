AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

/*---------------------------------------------------------
   Name: Initialize

   This is the spawn function. It's called when a client calls the entity to be spawned.
   If you want to make your SENT spawnable you need one of these functions to properly create the entity.
   ply is the name of the player that is spawning it.
   tr is the trace from the player's eyes.
---------------------------------------------------------*/
function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("sim_ent_ammo_shotgun")
		ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end


/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	// Use the helibomb model just for the shadow (because it's about the same size)
	self.Entity:SetModel("models/Items/BoxBuckshot.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end


/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, physobj)
	
	// Play sound on bounce
	if (data.Speed > 80 and data.DeltaTime > 0.2) then
		self.Entity:EmitSound("Default.ImpactSoft")
	end
end

/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage(dmginfo)

	// React physically when shot/getting blown
	self.Entity:TakePhysicsDamage(dmginfo)
end


/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use(activator, caller)

	self.Entity:Remove()

//	self.Entity:EmitSound("BaseCombatCharacter.AmmoPickup")
	
	if (activator:IsPlayer()) then
		// Give the collecting player some free health
		activator:GiveAmmo(120, "shotgunshell")
	end
end