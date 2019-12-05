
TALENT.ID = 20
TALENT.Suffix = "Suffering"
TALENT.Name = "Suffering"
TALENT.NameColor = Color( 0, 150, 0 )
TALENT.NameEffect = "glow"
TALENT.Description = "Each hit has a %s_^ chance to infect and damage the target %s^ times for %s^ damage every %s^ seconds"
TALENT.Tier = 3
TALENT.LevelRequired = { min = 25, max = 30 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 }	-- Chance to tesla
TALENT.Modifications[2] = { min = 5, max = 10 }	-- tesla reps
TALENT.Modifications[3] = { min = 3, max = 5 }	-- tesla damage
TALENT.Modifications[4] = { min = 3, max = 6 }	-- tesla delay

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )

	if (chance > math.random() * 100) then
		local tesla_reps = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )
		local tesla_dmg = self.Modifications[3].min + ( ( self.Modifications[3].max - self.Modifications[3].min ) * talent_mods[3] )
		local tesla_delay = self.Modifications[4].min + ( ( self.Modifications[4].max - self.Modifications[4].min ) * talent_mods[4] )

		status.Inflict("Contagion", {
			Time = tesla_delay * tesla_reps,
			Amount = tesla_reps,
			Damage = tesla_dmg,
			Weapon = attacker:GetActiveWeapon(),
			Attacker = attacker,
			Player = victim
		})
	end
end

if (SERVER) then
	local STATUS = status.Create "Contagion"
	function STATUS:Invoke(data)
		self:CreateEffect "Infected":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = STATUS:CreateEffect "Infected"
	EFFECT.Message = "Infected"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/bug.png"
	function EFFECT:Init(data)
		self:CreateTimer(data.Time, data.Amount, self.Callback, data)
	end

	local screams = {
		"vo/npc/male01/pain07.wav",
		"vo/npc/male01/pain08.wav",
		"vo/npc/male01/pain09.wav",
		"vo/npc/male01/no02.wav"
	}

	function EFFECT:Callback(data)
		local vic = data.Player
		if (not IsValid(vic)) then return end
		if (not vic:Alive()) then return end
		if (GetRoundState() ~= ROUND_ACTIVE) then return end

		local dmg = DamageInfo()
		dmg:SetInflictor(data.Weapon)
		dmg:SetAttacker(data.Attacker)
		dmg:SetDamage(data.Damage)
		dmg:SetDamageType(DMG_ACID)

		vic:TakeDamageInfo(dmg)

		vic:EmitSound(screams[math.random(1, #screams)])
	end
end
