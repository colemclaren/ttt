function EFFECT:Init(data)
	self.Pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Pos)
end

function EFFECT:Think()
	for k = 0, 24 do
		local beat = self.Emitter:Add("effects/easter/puff" .. math.random(1, 4), self.Pos + Vector(0, 0, 2 * k) + VectorRand() * 16)

		if (beat) then
			beat:SetLifeTime(0)
			beat:SetDieTime(2)
			beat:SetStartAlpha(255)
			beat:SetEndAlpha(0)
			beat:SetStartSize(2)
			beat:SetEndSize(32)
			beat:SetGravity(Vector(0, 0, 20))
			beat:SetColor(150, 25, 150)
			local a = math.rad((k / 48) * -360)
			beat:SetVelocity(Vector(math.cos(a) * 64, math.sin(a) * 64, 32))
			beat:SetAngles(Angle(math.random(360), math.random(360), 0))
		end
	end

	return false
end

function EFFECT:Render()
end
