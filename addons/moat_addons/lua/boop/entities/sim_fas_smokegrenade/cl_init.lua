include('shared.lua')

language.Add("ent_mad_smoke", "Grenade")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()
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
if self.Entity:GetDTBool(0) then
		self:Smoke()
		self.Entity:SetDTBool(0, false)
	end
end

/*---------------------------------------------------------
   Name: ENT:Smoke()
---------------------------------------------------------*/
function ENT:Smoke()

	local vPos = Vector(math.Rand(-5, 5), math.Rand(-5, 5), 0)
	local vOffset = self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))

	local emitter = ParticleEmitter(vOffset)
	
	for i = 1, 400 do 
		timer.Simple(i / 75, function()
			if not IsValid(self.Entity) or self.Entity:WaterLevel() > 2 then return end

			local vPos = Vector(math.Rand(-5, 5), math.Rand(-5, 5), 0)
			local vOffset = self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))

			local smoke = emitter:Add("particle/particle_smokegrenade", vOffset) // + vPos)
			smoke:SetVelocity(VectorRand() * 300)
			smoke:SetGravity(Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(0, 25)))
			smoke:SetDieTime(45)
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(0)
			smoke:SetEndSize(350)
			smoke:SetRoll(math.Rand(-180, 180))
			smoke:SetRollDelta(math.Rand(-0.2,0.2))
			smoke:SetColor(0, 106, 23)
			smoke:SetAirResistance(math.Rand(150, 600))
			smoke:SetBounce(0.5)
			smoke:SetCollide(true)
			
			if i == 400 then
				emitter:Finish()
			end	
		end)
	end
end

/*---------------------------------------------------------
   Name: ENT:IsTranslucent()
---------------------------------------------------------*/
function ENT:IsTranslucent()

	return true
end


