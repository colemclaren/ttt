--- Author informations ---
ENT.Author = "Zaratusa"
ENT.Contact = "http://steamcommunity.com/profiles/76561198032479768"

ENT.Type = "anim"

ENT.CanHavePrints = true
ENT.CanUseKey = true
ENT.Avoidable = true

ENT.BeepSound = Sound("weapons/c4/c4_beep1.wav")
ENT.PreExplosionSound = Sound("weapons/c4/c4_beep1.wav")
ENT.ExplosionSound = Sound("Weapon_SLAM.SatchelDetonate")

ENT.BlastRadius = 200
ENT.BlastDamage = 1000

AccessorFunc(ENT, "Placer", "Placer") -- using Placer instead of Owner, so everyone can damage the SLAM

-- function for better legibility
function ENT:IsActive()
	return self:GetDefusable()
end

-- function for defuser
function ENT:Defusable()
	return self:GetDefusable()
end

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Defusable") -- same as active on C4, just for defuser compatibility
end

function ENT:OnTakeDamage(dmginfo)
	if (IsValid(self)) then
		-- it can still explode, even if defused
		self:SetHealth(self:Health() - dmginfo:GetDamage())
		if (self:Health() <= 0) then
			-- the attacker should get the kill
			local attacker = dmginfo:GetAttacker()
			if (IsValid(attacker)) then
				self:SetPlacer(attacker)
			end
			self:StartExplode(false)
		end
	end
end

function ENT:StartExplode(checkActive)
	if (!self.Exploding) then
		self:EmitSound(self.PreExplosionSound)
		timer.Simple(0.15, function() if (IsValid(self)) then self:Explode(checkActive) end end)
	end
end

function ENT:Explode(checkActive)
	if (IsValid(self) and !self.Exploding) then
		if (checkActive and !self:IsActive()) then return end
		self.Exploding = true
		local pos = self:GetPos()
		local radius = self.BlastRadius
		local damage = self.BlastDamage

		self:EmitSound(self.ExplosionSound, 60, math.random(125, 150))

		util.BlastDamage(self, self:GetPlacer(), pos, radius, damage)

		local effect = EffectData()
		effect:SetStart(pos)
		effect:SetOrigin(pos)
		effect:SetScale(radius)
		effect:SetRadius(radius)
		effect:SetMagnitude(damage)
		util.Effect("Explosion", effect, true, true)

		self:Remove()
	end
end
