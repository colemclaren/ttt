AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
	self:DrawModel()	
end

if CLIENT then return end

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	
	/*local indx = self:EntIndex()
	timer.Create("effedfs"..indx,0.01,0, function()
		if (not IsValid(self)) then return end
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
		util.Effect("effect_acidb_fly", ef, true, true)	
	end)*/
	
	self:SetMaterial("acid/acid1")
	self:SetColor(Color(0,255,0,255))
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:ApplyForceCenter(self.dir) end
	
	if self:WaterLevel() == 3 then
		self:Remove()
	end
end

function ENT:PhysicsCollide(data, physobj)
	timer.Simple(0, function()

	local ef = EffectData()
	ef:SetOrigin(self:GetPos())
	ef:SetAttachment(1)
	util.Effect("effect_acidball_impact", ef, true, true)
	
	self:EmitSound("ambient/water/water_splash"..math.random(1,3)..".wav", 400)

	for k, v in pairs(ents.FindInSphere(data.HitPos, 80)) do
		if (IsValid(v) and v:IsPlayer() and v:Team() ~= TEAM_SPEC) then
			local tesla_dmg = self.InventoryModifications[1]
			local tesla_delay = self.InventoryModifications[2]
			local tesla_reps = self.InventoryModifications[3]
			
			status.Inflict("Suffering", {
				Time = tesla_delay * tesla_reps,
				Amount = tesla_reps,
				Damage = tesla_dmg,
				Weapon = self.Owner:GetActiveWeapon(),
				Attacker = self.Owner,
				Player = v
			})
		end
	end
	
	util.Decal("Scorch", self:GetPos() + self:GetPos():GetNormalized(), self:GetPos() - self:GetPos():GetNormalized())
	
	self:Remove()

	end)
end