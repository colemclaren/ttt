include('shared.lua')

language.Add("ent_mad_grenadelauncher", "Grenade")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	local vOffset 	= self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))
	local vNormal 	= (vOffset - self.Entity:GetPos()):GetNormalized()

	local emitter 	= ParticleEmitter(vOffset)

	for i = 1, 1500 do 
		timer.Simple(i / 150, function()
			if not self.Entity or self.Entity:GetNWBool("Explode") then return end

			local vOffset 	= self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))
			local vNormal 	= (vOffset - self.Entity:GetPos()):GetNormalized()

			local particle = emitter:Add("particle/particle_smokegrenade", vOffset)
			particle:SetVelocity(vNormal * 5)
			particle:SetDieTime(5)
			particle:SetStartAlpha(155)
			particle:SetStartSize(2)
			particle:SetEndSize(10)
			particle:SetRoll(math.Rand(-5, 5))
			particle:SetColor(150, 150, 150)
		end)
	end

	emitter:Finish()
end

/*---------------------------------------------------------
   Name: ENT:Draw()
---------------------------------------------------------*/
function ENT:Draw()

	self.Entity:DrawModel()
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()
end

/*---------------------------------------------------------
   Name: ENT:IsTranslucent()
---------------------------------------------------------*/
function ENT:IsTranslucent()

	return true
end


