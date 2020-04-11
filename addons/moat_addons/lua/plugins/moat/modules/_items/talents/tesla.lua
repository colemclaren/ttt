
TALENT.ID = 9
TALENT.Name = "Electricity"
TALENT.NameColor = Color( 0, 255, 255 )
TALENT.NameEffect = "electric"
TALENT.Description = "Each hit has a %s_^ chance to zap the target %s^ times for %s^ damage every %s^ seconds"
TALENT.Tier = 3
TALENT.LevelRequired = { min = 25, max = 30 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 }	-- Chance to tesla
TALENT.Modifications[2] = { min = 5, max = 10 }	-- tesla reps
TALENT.Modifications[3] = { min = 3, max = 5 }	-- tesla damage
TALENT.Modifications[4] = { min = 3, max = 6 }	-- tesla delay

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		local tesla_reps = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		local tesla_dmg = self.Modifications[3].min + ( ( self.Modifications[3].max - self.Modifications[3].min ) * math.min(1, talent_mods[3]) )
		local tesla_delay = self.Modifications[4].min + ( ( self.Modifications[4].max - self.Modifications[4].min ) * math.min(1, talent_mods[4]) )

		status.Inflict("Electricity", {
			Player = victim,
			Attacker = attacker,
			Weapon = attacker:GetActiveWeapon(),
			Damage = tesla_dmg,
			Time = tesla_reps * tesla_delay,
			Amount = tesla_reps
		})
	end
end


if (SERVER) then
	local STATUS = status.Create "Electricity"
	function STATUS:Invoke(data)
		self:CreateEffect "Electrified":Invoke(data, data.Time, data.Player)
		self:CreateEffect "Zapped":Invoke(data, false)
	end

	local EFFECT = STATUS:CreateEffect "Electrified"
	EFFECT.Message = "Electrified"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/lightning.png"
	function EFFECT:Init(data)
		self:CreateTimer(data.Time, data.Amount, self.Callback, data)
	end

	function EFFECT:Callback(data)
		local vic = data.Player
		if (not IsValid(vic)) then return end
		if (not vic:Alive()) then return end
		if (GetRoundState() ~= ROUND_ACTIVE) then return end

		local dmg = DamageInfo()
		dmg:SetInflictor(data.Weapon)
		dmg:SetAttacker(data.Attacker)
		dmg:SetDamage(data.Damage)
		dmg:SetDamageType(DMG_SHOCK)

		vic:TakeDamageInfo(dmg)

		local n = math.random(11)
		vic:EmitSound("ambient/energy/newspark" .. (n < 10 and "0" or "") .. n .. ".wav")
	end

	local EFFECT = STATUS:CreateEffect "Zapped"
	function EFFECT:Init(data)
		self:CreateTimer(data.Time, data.Amount, self.Callback, data)
	end

	function EFFECT:Callback(data)
		local vic = data.Player
		if (not IsValid(vic)) then return end
		if (not vic:Alive()) then return end
		if (GetRoundState() ~= ROUND_ACTIVE) then return end

		local effectdata = EffectData()
		effectdata:SetEntity(vic)
		effectdata:SetRadius(10)
		effectdata:SetMagnitude(10)
		effectdata:SetScale(3)
		util.Effect("TeslaHitBoxes", effectdata)

		vic:ScreenShake(50, 100, 0.5, 100)
	end
end