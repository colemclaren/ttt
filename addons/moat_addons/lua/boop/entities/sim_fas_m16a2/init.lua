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
	
	local ent = ents.Create("sim_fas_m16a2")
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
	self.Entity:SetModel("models/weapons/b_m16a2.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end


/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, phys)
	
	if (data.Speed > 120 and data.DeltaTime > 0.4) then
		self.Entity:EmitSound("BaseCombatWeapon.WeaponDrop")
	end
end

/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use(ply)
	if ply:IsPlayer() and not ply:HasWeapon("weapon_fas_m16a2") then
		self.Entity:EmitSound("BaseCombatCharacter.AmmoPickup")
		ply:Give("weapon_fas_m16a2")
		self:Remove()
	end
end
