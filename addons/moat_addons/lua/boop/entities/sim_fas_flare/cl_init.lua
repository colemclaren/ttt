include('shared.lua')

language.Add("ent_mad_flare", "Flare")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Timer = CurTime() + 1

	local vOffset 	= self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))
	local vNormal 	= (vOffset - self.Entity:GetPos()):GetNormalized()

	local emitter 	= ParticleEmitter(vOffset)

	for i = 1, 1500 do 
		timer.Simple(i / 150, function()
			if not IsValid(self.Entity) or not self.Entity:GetNWBool("Smoke") then return end

			local vOffset 	= self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))
			local vNormal 	= (vOffset - self.Entity:GetPos()):GetNormalized()

			local particle = emitter:Add("particle/particle_smokegrenade", vOffset)
			particle:SetVelocity(vNormal * 10)
			particle:SetDieTime(0.5)
			particle:SetStartAlpha(255)
			particle:SetStartSize(4)
			particle:SetEndSize(30)
			particle:SetRoll(math.Rand(-5, 5))
			particle:SetColor(180, 0, 0)
			
			if i == 1500 then
				emitter:Finish()
			end			
		end)
	end
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

	if (self.Timer < CurTime()) then
		local light = DynamicLight(self:EntIndex())
		if (light) then
			light.Pos = self:GetPos()
			light.r = 255
			light.g = 100
			light.b = 100
			light.Brightness = 1
			light.Decay = math.random(500, 800) * 5
			light.Size = math.random(500, 800)
			light.DieTime = CurTime() + 1
		end
	end
end

/*---------------------------------------------------------
   Name: ENT:IsTranslucent()
---------------------------------------------------------*/
function ENT:IsTranslucent()

	return true
end


