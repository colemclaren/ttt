function EFFECT:Init(data)	
	local Startpos = self:GetTracerShootPos(self.Position, data:GetEntity(), data:GetAttachment())
	local Hitpos = data:GetOrigin()
			
	if data:GetEntity():IsValid() && Startpos && Hitpos then
		self.Emitter = ParticleEmitter(Startpos)
		
		if !self.Emitter then return end
		
		for i = 1, 4 do
			local p = self.Emitter:Add("effects/splashwake1", Startpos)	
			p:SetDieTime(1.8)
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(0.8, 1.5))
			p:SetEndSize(math.random(75, 105))
			p:SetRoll(math.random(-10, 10))
			p:SetRollDelta(math.random(-10, 10))	
			p:SetVelocity(((Hitpos - Startpos):GetNormal() * math.random(500, 800)) + VectorRand() * math.random(1, 20))
			p:SetCollide(true)
			p:SetColor(185,201,255)
			//p:SetGravity(Vector(0, 0, -50))
		end
		
		for i = 1, 4 do
			local p = self.Emitter:Add("effects/blood", Startpos)	
			p:SetDieTime(1.8)
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(0.2, 0.5))
			p:SetEndSize(math.random(25, 45))
			p:SetRoll(math.random(-10, 10))
			p:SetRollDelta(math.random(-10, 10))	
			p:SetVelocity(((Hitpos - Startpos):GetNormal() * math.random(500, 800)) + VectorRand() * math.random(1, 20))
			p:SetCollide(true)
			p:SetColor(185,201,255)
			//p:SetGravity(Vector(0, 0, -50))
		end
		
		self.Emitter:Finish()
	end
end
		
function EFFECT:Think()
	return false
end

function EFFECT:Render()
end