function EFFECT:Init(data)		
	local Startpos = data:GetOrigin()
			
		self.Emitter1 = ParticleEmitter(Startpos)
	
		for i = 1, 300 do
			local p = self.Emitter1:Add("particles/flamelet" .. math.random(1, 5), self:GetPos() + VectorRand() * 2)		
			p:SetDieTime(math.Rand(0.4, 0.6))
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(10, 24))
			p:SetEndSize(math.Rand(10, 15))
			p:SetRoll(math.random(-10, 10))
			p:SetRollDelta(math.random(-10, 10))	
			p:SetVelocity((Startpos - self:GetPos() + VectorRand() * 2):GetNormal() * math.random(70, 270))
			
			timer.Simple(0.2, function()
				if p then p:SetVelocity(Vector(0, 0, 0)) end
			end)
		end
		
		self.Emitter1:Finish()		
		
end
	
function EFFECT:Think()
	return false
end

function EFFECT:Render()
end