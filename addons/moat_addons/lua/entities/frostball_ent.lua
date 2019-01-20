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
	
	/*timer.Create("effedsfs"..self:EntIndex(),0.01,0, function()
		if not IsValid(self) then return end
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
		util.Effect("effect_frostb_fly", ef, true, true)	
	end)*/
	
	self:SetMaterial("ice/ice1")
	self:SetColor(Color(197,227,255,255))
end

function ENT:Think()
    if CLIENT then return end
 
 	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:ApplyForceCenter(self.dir) end

    if self:WaterLevel() == 3 then
        local icebl = ents.Create("ice_ent")
        icebl:SetPos(self:GetPos())
        icebl:Spawn()          

        self:Remove()
    end
end

function ENT:PhysicsCollide(data, physobj)
	timer.Simple(0, function()
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
		util.Effect("effect_frostball_impact", ef, true, true)
		
		for i = 1,2 do self:EmitSound("physics/glass/glass_impact_bullet"..math.random(1,4)..".wav", 400) end
		
		for k, v in pairs(ents.FindInSphere(data.HitPos, 80)) do
			if (IsValid(v) and v:IsPlayer() and v:Team() ~= TEAM_SPEC) then
				local frozenTime = self.InventoryModifications[1]
				local frozenSpeed = self.InventoryModifications[2] / 100
				local frozenDelay = self.InventoryModifications[3]

				status.Inflict("Frost", {
					Player = v,
					Time = frozenTime,
					Speed = frozenSpeed,
					DamageDelay = frozenDelay,
					Weapon = self.Owner:GetActiveWeapon(),
					Attacker = self.Owner
				})

				v:Extinguish()
			end
		end

		self:Remove()
	end)
end