function EFFECT:Init(data)
	self.Entity = data:GetEntity()

	if (IsValid(self.Entity)) then
		self.Emitter = ParticleEmitter(self.Entity:GetPos())
	end
end

EFFECT.NextPuff = 0

function EFFECT:Think()
	if (self.NextPuff < CurTime() and (LocalPlayer() and LocalPlayer():Team() ~= TEAM_SPEC)) then
		for k = 0, 8 do
			timer.Simple(k / 8, function()
				if (not IsValid(self.Entity)) then return end
				local beat = self.Emitter:Add("effects/easter/puff" .. math.random(1, 4), self.Entity:GetPos() + Vector(0, 0, 8) + VectorRand() * 4)

				if (beat) then
					beat:SetLifeTime(0)
					beat:SetDieTime(math.random(0.5, 1) * self.Entity:GetModelScale() * 2)
					beat:SetStartAlpha(255)
					beat:SetEndAlpha(0)
					beat:SetStartSize(2)
					beat:SetEndSize(math.random(2, 12 * self.Entity:GetModelScale() * 2))
					beat:SetGravity(Vector(math.cos((k / 8) * 180) * 45, math.sin((k / 8) * 180) * 45, 45))
					beat:SetColor(255, 100, 0)
				end
			end)
		end

		self.NextPuff = CurTime() + 1
	end

	return IsValid(self.Entity)
end

function EFFECT:Render()
end
