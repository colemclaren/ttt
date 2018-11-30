if SERVER then

	AddCSLuaFile("ttt_kfc.lua")

/*	resource.AddFile("models/mymodels/kfc/kfc.mdl")

	resource.AddFile("materials/mymodels/kfc/cylinder1_auv.vmt")
*/
end



if CLIENT then

   ENT.Icon = "vgui/ttt/icon_gpi_kfc"

end



ENT.Type = "anim"



ENT.CanUseKey = true

ENT.CanHavePrints = true

ENT.Projectile = true

ENT.Icon = "vgui/ttt/icon_gpi_kfc"

ENT.PrintName = "KFC (Nomnomnom)"

ENT.AllowPropspec = true

ENT.CanPickup	  = true



function ENT:Initialize()

	if SERVER then

		self.Entity:SetModel("models/mymodels/kfc/kfc.mdl")

		self.HP = 50

		self:PhysicsInit( SOLID_VPHYSICS )

		self:SetSolid( SOLID_VPHYSICS )

		self:SetMoveType( MOVETYPE_VPHYSICS )	

		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		self.fingerprints = {}

		self:PhysWake()

		self:Activate()

	end

end



function ENT:UseOverride(activator)

	if SERVER then

		if IsValid(activator) and activator:IsPlayer() and activator:IsActive() then

			local health = activator:Health()

			if health <= 125 then

				activator:SetHealth(health + 35)

				activator:EmitSound("mtg_nom.wav")

				self.Entity:Remove()

			end

		end

	end

end



function ENT:OnTakeDamage( dmginfo )

	if SERVER then

		self.HP = self.HP - dmginfo:GetDamage()

		if self.HP < 0 then

			self:Remove()

			util.EquipmentDestroyed(self:GetPos())

		end

	end

end



