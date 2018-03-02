function EFFECT:Init(data)		
	local Startpos = data:GetOrigin()
			
		self.Emitter = ParticleEmitter(Startpos)
	
		for i = 1, 10 do
			local p = self.Emitter:Add("particles/flamelet" .. math.random(1, 5), Startpos)
			
			p:SetDieTime(0.3)
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(6, 12))
			p:SetEndSize(1)
			p:SetRoll(math.random(-60, 60))
			p:SetRollDelta(math.random(-60, 60))	
			p:SetVelocity(VectorRand() * 10)
			p:SetCollide(true)
		end
		
		self.Emitter:Finish()
end
		
function EFFECT:Think()
	return false
end

function EFFECT:Render()
end