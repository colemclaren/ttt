EFFECT.Mat = Material("effects/yellowflare")

/*---------------------------------------------------------
   EFFECT:Init(data)
---------------------------------------------------------*/
function EFFECT:Init(data)

	self.StartPos 	= data:GetStart()	
	self.EndPos 	= data:GetOrigin()
	self.Dir 		= self.EndPos - self.StartPos
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	self.TracerTime 	= 0.4
	
	// Die when it reaches its target
	self.DieTime 	= CurTime() + self.TracerTime
	
	// Play ricochet sound with random pitch
	
	local vGrav 	= Vector(0, 0, -450)
	local Dir 		= self.Dir:GetNormalized()
	
	local emitter = ParticleEmitter(self.StartPos)
	
	for i = 1, 10 do
	
		local particle = emitter:Add("effects/yellowflare", self.StartPos)
		
			particle:SetVelocity((Dir + VectorRand() * 0.5) * math.Rand(50, 150))
			particle:SetDieTime(math.Rand(0.5, 2))
			particle:SetStartAlpha(255)
			particle:SetStartSize(math.Rand(2, 4))
			particle:SetEndSize(0)
			particle:SetRoll(0)
			particle:SetGravity(vGrav * 0.4)
			particle:SetCollide(true)
			particle:SetBounce(0.8)
			particle:SetAirResistance(50)
			particle:SetStartLength(0.2)
			particle:SetEndLength(0)
			particle:SetVelocityScale(true)
			particle:SetCollide(true)
	end
	
		local particle = emitter:Add("effects/yellowflare", self.StartPos)

			particle:SetDieTime(0.1)
			particle:SetStartAlpha(255)
			particle:SetStartSize(128)
			particle:SetEndSize(0)
			particle:SetRoll(math.Rand(0, 360))
			
		local particle = emitter:Add("effects/yellowflare", self.StartPos)

			particle:SetDieTime(0.4)
			particle:SetStartAlpha(255)
			particle:SetStartSize(32)
			particle:SetEndSize(0)
			particle:SetRoll(math.Rand(0, 360))
				
	emitter:Finish()
	
	local dlight = DynamicLight(0)
		if (dlight) then
			dlight.Pos 		= self.StartPos
			dlight.r 		= 255
			dlight.g 		= 255
			dlight.b 		= 255
			dlight.Brightness = 4
			dlight.size 	= 64
			dlight.DieTime 	= CurTime() + 0.1
		end
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think()

	if (CurTime() > self.DieTime) then return false end
	
	return true
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

	local fDelta = (self.DieTime - CurTime()) / self.TracerTime
	fDelta = math.Clamp(fDelta, 0, 1)
			
	render.SetMaterial(self.Mat)
	
	local sinWave = math.sin(fDelta * math.pi)
	
	local color = Color(255, 255, 255, 255 * fDelta)
	
	render.DrawBeam(self.StartPos, self.EndPos, 8 * fDelta, 0.5, 0.5, color)
end