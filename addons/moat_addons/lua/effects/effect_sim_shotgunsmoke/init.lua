/*---------------------------------------------------------
	EFFECT:Init(data)
---------------------------------------------------------*/
function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then return end
	self.WeaponEnt 		= data:GetEntity()
	self.Attachment 		= data:GetAttachment()
	
	self.Position 		= self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.Forward 		= data:GetNormal()
	self.Angle 			= self.Forward:Angle()
	self.Right 			= self.Angle:Right()
	self.Up 			= self.Angle:Up()
	if not IsValid(data:GetEntity()) or not IsValid(self.WeaponEnt:GetOwner()) then return end
	local AddVel 		= self.WeaponEnt:GetOwner():GetVelocity()
	
	local emitter 		= ParticleEmitter(self.Position)
		for i = 1, 32 do
		
			local particle = emitter:Add("effects/yellowflare", self.Position)
				if not IsValid(data:GetEntity()) or not IsValid(self.WeaponEnt:GetOwner()) then return end
				particle:SetVelocity(((self.Forward + VectorRand() * 0.5) * math.Rand(150, 300)))
				particle:SetDieTime(math.Rand(0.5, 2))
				particle:SetStartAlpha(255)
				particle:SetStartSize(2)
				particle:SetEndSize(2)
				particle:SetRoll(0)
				particle:SetGravity(Vector(0, 0, -50))
				particle:SetCollide(true)
				particle:SetBounce(0.8)
				particle:SetAirResistance(375)
				particle:SetStartLength(0.2)
				particle:SetEndLength(0)
				particle:SetVelocityScale(true)
				particle:SetCollide(true)
		end

		local particle = emitter:Add("effects/yellowflare", self.Position + 8 * self.Forward)
			if not IsValid(data:GetEntity()) or not IsValid(self.WeaponEnt:GetOwner()) then return end
			particle:SetVelocity(self.Forward + 1.1 * AddVel)
			particle:SetAirResistance(160)

			particle:SetDieTime(0.25)

			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)

			particle:SetStartSize(30)
			particle:SetEndSize(40)

			particle:SetRoll(math.Rand(180, 480))
			particle:SetRollDelta(math.Rand(-1, 1))

			particle:SetColor(255, 255, 255)	

	emitter:Finish()
end

/*---------------------------------------------------------
	EFFECT:Think()
---------------------------------------------------------*/
function EFFECT:Think()

	return false
end

/*---------------------------------------------------------
	EFFECT:Render()
---------------------------------------------------------*/
function EFFECT:Render()
end
