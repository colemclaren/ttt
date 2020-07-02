
TALENT = {}

TALENT.ID = 4
TALENT.Name = "Accurate"
TALENT.NameColor = Color( 150, 0, 0 )
TALENT.Description = "Cone is increased by %s_"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 25 } -- Amount accuracy is increased

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )
	local Mod = self.Modifications[1]
	local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])
	weapon:SetAccuracy((1 - (1 - weapon:GetAccuracy() / 100) * (1 - mult / 100)) * 100)
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 8
TALENT.Name = "Adrenaline Rush"
TALENT.NameColor = Color( 255, 0, 0 )
TALENT.Description = "Damage is increased by %s_^ for %s seconds after killing with this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 15 } -- Percent damage is increased by
TALENT.Modifications[2] = { min = 9, max = 12 }	-- Damage time

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(victim, _, attacker, talent_mods)
	status.Inflict("Adrenaline Rush", {
		Player = attacker,
		Weapon = attacker:GetActiveWeapon(),
		Time = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])),
		Percent = 1 + ((self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / 100)
	})
end


if (SERVER) then
	local STATUS = status.Create "Adrenaline Rush"
	function STATUS:Invoke(data)
		self:CreateEffect "Damaging":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = STATUS:CreateEffect "Damaging"
	EFFECT.Message = "Damaging"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/anchor.png"
	function EFFECT:Init(data)
		local curWeapon = data.Weapon.Primary

		if (not curWeapon.BaseDamage) then
			curWeapon.BaseDamage = curWeapon.Damage
		end

		curWeapon.AdrenalineStacks = (curWeapon.AdrenalineStacks or 0) + 1
		curWeapon.Damage = curWeapon.BaseDamage + (curWeapon.AdrenalineStacks * data.Percent)

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Weapon)) then return end

		local curWeapon = data.Weapon.Primary

		curWeapon.AdrenalineStacks = math.max(curWeapon.AdrenalineStacks - 1, 0)
		curWeapon.Damage = curWeapon.BaseDamage * (data.Percent ^ curWeapon.AdrenalineStacks)
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 29
TALENT.Name = "Armour Piercing"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Detectives and traitors under armor equipment are defenseless to bullets"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 40, max = 60 } -- Percent chance to ignore armour

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (true) then -- if (chance > math.random() * 100) then
		-- Will ignore the armour check later
		victim.ArmourPierced = true
	end
end

m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 69
TALENT.Suffix = "the Boston Basher"
TALENT.Name = "Boston Basher"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Damage is increased by %s_^, unless you miss. Which makes you hit yourself instead, you silly sod"
TALENT.Tier = 1
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 20, max = 40} -- Percent damage is increased by

if (SERVER) then
	util.AddNetworkString "BulletPrediction"
	net.Receive("BulletPrediction", function(_, pl)
		local wep = net.ReadEntity()

		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then
			return
		end

		if (IsValid(wep) and wep.IsWeapon and wep:IsWeapon() and wep.Primary and wep.Primary.Damage) then
			pl:TakeDamage(wep.Primary.Damage, pl, wep)
		end
	end)

	util.AddNetworkString "Talents.BostonBasher"
	function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end

		/*
		dmginfo.Callback = function(att, tr, dmginfo)
			if (tr.AltHitreg) then
				return
			end
			if (not IsValid(tr.Entity)) then
				local dmg = att:GetActiveWeapon().Primary.Damage
				att:TakeDamage(dmg, att, att:GetActiveWeapon())

				net.Start "Talents.BostonBasher"
				net.Send(att)
			end
		end
		*/
	end
end

function TALENT:ModifyWeapon(weapon, talent_mods)
	if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
	if (weapon.Primary.Damage) then
		weapon.Primary.Damage = weapon.Primary.Damage * (1 + ((self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / 100))
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 6
TALENT.Name = "Brutal"
TALENT.NameColor = Color( 255, 0, 0 )
TALENT.Description = "Headshot damage is increased by %s_ when using this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 11, max = 25 } -- Amount headshot is increased

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:ScalePlayerDamage( victim, attacker, dmginfo, hitgroup, talent_mods )
	if ( hitgroup == HITGROUP_HEAD ) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
		dmginfo:ScaleDamage( 1 + ( increase / 100 ) )
	end
end


m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 85
TALENT.Name = "Center Mass"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Torso damage is increased by %s_ when using this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 30 } -- Amount headshot is increased

TALENT.Melee = true
TALENT.NotUnique = true

local da_hitgroups = {
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
	[HITGROUP_HEAD] = true
}

function TALENT:ScalePlayerDamage(victim, attacker, dmginfo, hitgroup, talent_mods)
	if (not da_hitgroups[hitgroup]) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
		dmginfo:ScaleDamage( 1 + ( increase / 100 ) )
	end
end


m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 9969
TALENT.Suffix = "Click"
TALENT.Name = "*click*"
TALENT.NameColor = Color(255, 119, 0)
TALENT.Description = "Damage is increased by %s_^ but you only have 1 bullet per clip"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 1, max = 1}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 25, max = 75}
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Omega Collection"

function TALENT:ModifyWeapon(weapon, talent_mods)
	if (weapon.Primary.ClipSize and weapon.Primary.DefaultClip and weapon.Primary.ClipMax) then
		local original = weapon.Primary.ClipSize

		weapon:SetMagazine(-1)
		weapon.Primary.ClipSize = 1
		weapon.Primary.DefaultClip = original * 3
		weapon.Primary.ClipMax = 1
		weapon:SetClip1(weapon.Primary.ClipSize)

		weapon.ClickClip = true
	end
end

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	dmginfo:ScaleDamage(1 + (increase / 100))
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 1
TALENT.Name = "Close Quarters"
TALENT.NameColor = Color( 0, 255, 255 )
TALENT.Description = "Damage is increased by +%s_^ when closer than %s feet to the target"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 10, max = 20 } -- Amount damage is increased by
TALENT.Modifications[2] = { min = 8, max = 13 } -- Amount of feet

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	local range = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
	local max_dist = range * 50

	if (victim:GetPos():DistToSqr(attacker:GetPos()) <= (max_dist * max_dist)) then
		dmginfo:ScaleDamage(1 + (increase / 100))
	end
end


m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 20
TALENT.Name = "Contagious"
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
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )

	if (chance > math.random() * 100) then
		local tesla_reps = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		local tesla_dmg = self.Modifications[3].min + ( ( self.Modifications[3].max - self.Modifications[3].min ) * math.min(1, talent_mods[3]) )
		local tesla_delay = self.Modifications[4].min + ( ( self.Modifications[4].max - self.Modifications[4].min ) * math.min(1, talent_mods[4]) )

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
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 25
TALENT.Name = "Cough"
TALENT.NameColor = Color(255, 0, 127)
TALENT.Description = "Each hit has a %s_^ chance to make your target cough with a power of %s^"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 25} -- Chance to trigger
TALENT.Modifications[2] = {min = 50, max = 100} -- Cough power

TALENT.Melee = true
TALENT.NotUnique = false

TALENT.Collection = "Omega Collection"

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		local power = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		
		status.Inflict("Cough", {
			Player = victim,
			Power = power,
		})
	end
end

if (SERVER) then
	local STATUS = status.Create "Cough"
	function STATUS:Invoke(data)
		self:CreateEffect "Cough":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = STATUS:CreateEffect "Cough"
	EFFECT.Message = "Coughing"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/user_comment.png"
	function EFFECT:Init(data)
		local amount = math.floor(data.Power / 15) -- 6 times at 100 power, 3 times at 50 power
		self:CreateTimer(1.5, amount, self.Callback, data)
	end

	function EFFECT:Callback(data)
		local vic = data.Player
		if (not IsValid(vic)) then return end
		if (not vic:Alive()) then return end
		
		local power = data.Power
		local angle = vic:GetAngles()
		angle.x = angle.x + (math.Rand(-1, 1) * (power / 12))
		angle.y = angle.y + (math.Rand(-1, 1) * (power / 12))

		vic:SetAngles(angle)
		vic:ScreenShake(power)
		vic:EmitSound("ambient/voices/cough" .. math.random(4) .. ".wav", math.min(300 + power, 511), math.min(100 + (power / 2), 255))
		
		data.Power = power / 1.2
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 28
TALENT.Name = 'Soften'
TALENT.NameColor = Color(100, 90, 100)
TALENT.Description = 'Each hit has a %s_^ chance to make your target take %s_^ more damage for %s^ seconds'
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 35}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 15, max = 30} -- Chance to trigger
TALENT.Modifications[2] = {min = 10, max = 15} -- Percent damage increase
TALENT.Modifications[3] = {min = 1 , max = 5 } -- Duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(vic, att, info, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local percent = (self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))) / 100
		local duration = self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * math.min(1, talent_mods[3]))

		status.Inflict("Debility", {Time = duration, Player = vic, Percent = percent})
	end
end

if (SERVER) then
	local STATUS = status.Create "Debility"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Debility", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Debility":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Debility"
	EFFECT.Message = "Debilitated"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/user_delete.png"
	function EFFECT:Init(data)
		local vic = data.Player
		vic.Soften = 1 + data.Percent

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Player)) then return end

		local vic = data.Player
		vic.Soften = nil
	end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 9968
TALENT.Name = "Deep Fried"
TALENT.NameColor = Color(209, 0, 209)
TALENT.Description = "Each hit has a %s_^ chance to fry the target's screen for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 10} -- percent
TALENT.Modifications[2] = {min = 5, max = 20} -- seconds
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Omega Collection"

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then
		return
	end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		local secs = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		status.Inflict("Deep Fried", {Time = secs, Player = victim})
	end
end

--
-- Deep Fried Status
--

if (SERVER) then
	util.AddNetworkString "Moat.Talents.DeepFried"

	local STATUS = status.Create "Deep Fried"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Deep Fried", data.Player)
		if (effect) then
			return -- effect:AddTime(data.Time)
		else
			self:CreateEffect"Deep Fried":Invoke(data, data.Time, data.Player)
		end
	end

	local STATUS = status.Create "Fried"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Deep Fried", data.Player)
		if (effect) then
			return -- effect:AddTime(data.Time)
		else
			self:CreateEffect"Deep Fried":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Deep Fried"
	EFFECT.Message = "Deep Fried"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/eye.png"
	function EFFECT:Init(data)
		net.Start "Moat.Talents.DeepFried"
			net.WritePlayer(data.Player)
			net.WriteDouble(data.Time)
		net.Broadcast()

		self:CreateTimer(math.floor(data.Time), math.floor(data.Time) * 2, self.Callback, data)
	end

	function EFFECT:Callback(data)
		local victim = data.Player
		if (not IsValid(victim) or not victim:Alive()) then return end

		victim:ScreenShake(50, 100, 0.5, 100)
	end
end

m_AddTalent(TALENT)

TALENT.Tier = 1
TALENT.ID = 9971
TALENT.Name = "Deep Fried XL"
TALENT.NameColor = Color(209, 0, 209)
TALENT.Description = "Each hit has a %s_^ chance to fry the target's screen for %s seconds"
TALENT.LevelRequired = {min = 1, max = 1}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 10}
TALENT.Modifications[2] = {min = 25, max = 50}
TALENT.NotUnique = false
TALENT.Melee = true
TALENT.Collection = "Omega Collection"

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then
		return
	end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		local secs = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		status.Inflict("Deep Fried", {Time = secs, Player = victim})
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 21
TALENT.Name = 'Desperate Times'
TALENT.NameColor = Color(255,99,71)
TALENT.Description = 'Your weapon will do %s_^ more damage if you are under %s health'
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 40} -- Damage last bullet can do
TALENT.Modifications[2] = {min = 25, max = 75} -- Health

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local health_required = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )

	if (attacker and attacker:Health() <= health_required) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
		dmginfo:ScaleDamage(1 + (increase / 100))
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 83
TALENT.Suffix = "the DRAGON"
TALENT.Name = "Dragonborn"
TALENT.NameColor = Color(255, 255, 255)
TALENT.Description = "Players have a %s_^ chance to be thrown with %sx force when shot with this weapon"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5 , max = 15}	-- Chance to push
TALENT.Modifications[2] = {min = 10, max = 100}	-- Force of the push

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
    if (MOAT_ACTIVE_BOSS) then
        return
    end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        local force = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))

        victim:SetVelocity(attacker:GetAimVector() * (100 * force))
        victim.was_pushed = {
            att = attacker,
            t = CurTime() + 5,
            wep = attacker:GetActiveWeapon():GetClass()
        }
    end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 98
TALENT.Name = "Dual"
TALENT.NameEffect = "bounce"
TALENT.NameColor = Color(240, 10, 10)
TALENT.Description = "You have two guns. Your damage is decreased by %s_^"
TALENT.Tier = 1
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.LevelRequired = {min = 0, max = 0}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 20, max = 30}


if (SERVER) then
	util.AddNetworkString "moat_talents.Dual"
end

function TALENT:ModifyWeapon( weapon, talent_mods )

    net.Start "moat_talents.Dual"
        net.WriteUInt(weapon.Weapon:EntIndex(), 32)
    net.Broadcast()

    weapon.Weapon.HoldType = "duel"

	local pri = weapon.Primary
	local mult = (self.Modifications[1].min + (self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1])) / 100

    pri.Damage = pri.Damage * (1 - mult)

	local Mod = self.Modifications[1]
	local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])

	weapon:SetFirerate((1 - (1 - weapon:GetFirerate() / 100) * 0.6) * 100)

    pri.ClipSize = math.ceil(pri.ClipSize * 1.5)
    pri.ClipMax = math.Round(pri.ClipSize * 3)
    pri.DefaultClip = math.ceil(pri.ClipSize)
    pri.Recoil = pri.Recoil * 1.5

	if (pri.Cone) then
		pri.Cone = pri.Cone * 2
	end

	if (pri.ConeX) then
		pri.ConeX = pri.ConeX * 2
	end

	if (pri.ConeY) then
		pri.ConeY = pri.ConeY * 2
    end
	weapon.Weapon.IronSightsPos = nil
	weapon.Weapon.IronSightsAng = nil
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 87
TALENT.Suffix = "the Explosive"
TALENT.Name = "Explosive"
TALENT.NameColor = Color(255, 128, 0)
TALENT.Description = "Every second of firing, this gun will fire %s^ explosive rounds dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 0.84, max = 1.20} -- Chance to trigger
TALENT.Modifications[2] = {min = 13.37, max = 42}	-- Explosion damage

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    if (not gmod.GetGamemode():AllowPVP()) then return end
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))

    if (not IsValid(wep)) then
        return
    end

    if (not wep.Primary or not wep.Primary.Delay) then
        attacker:PrintMessage(HUD_PRINTCENTER, "Your gun does not have valid stats for Explosive.")
        return
    end

    local pellets_per_sec = (wep.Primary.ReverseShotsDamage and wep.Primary.Damage or wep.Primary.NumShots or 1) / wep.Primary.Delay
    chance = chance / pellets_per_sec


    local dmg = self.Modifications[2].min + (self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])

    if (is_bow and hit_pos) then
        if (chance > math.random()) then
            local exp = ents.Create("env_explosion")
            exp:SetOwner(attacker)
            exp:SetPos(hit_pos)
            exp:Spawn()
            exp:SetKeyValue("iMagnitude", tostring(dmg / 2))
            exp:Fire("Explode", 0, 0)
        end
    else
        local cb = dmginfo.Callback
        dmginfo.Callback = function(att, tr, dmginfo)
            if (not tr.AltHitreg and chance > math.random()) then
                local exp = ents.Create("env_explosion")
                exp:SetOwner(attacker)
                exp:SetPos(tr.HitPos)
                exp:Spawn()
                exp:SetKeyValue("iMagnitude", tostring(dmg / 2))
                exp:Fire("Explode", 0, 0)
            end
            if (cb) then
                return cb(att, tr, dmginfo)
            end
        end
    end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 7
TALENT.Suffix = "the Heavy"
TALENT.Name = "Extended Mag"
TALENT.NameColor = Color( 255, 128, 0 )
TALENT.Description = "Max ammo capacity is increased by %s_"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 40 } -- Ammo increased by

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon(weapon, talent_mods)
	if (weapon.Primary.ClipSize and weapon.Primary.DefaultClip and weapon.Primary.ClipMax) then
		local Mod = self.Modifications[1]
		local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])
		local mag = ((1 + weapon:GetMagazine() / 100) * (1 + mult / 100) - 1) * 100
		weapon:SetMagazine(mag)
		if (SERVER and weapon.Primary.Ammo and weapon.Primary.ClipSize and IsValid(weapon:GetOwner())) then
			-- weapon:GetOwner():RemoveAmmo(weapon:GetOwner():GetAmmoCount(weapon.Primary.Ammo), weapon.Primary.Ammo)
			weapon:GetOwner():GiveAmmo(weapon.Primary.ClipSize * 2, weapon.Primary.Ammo, true)
    	end
	end

end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 26
TALENT.Name = 'Fortified'
TALENT.NameColor = Color(200, 200, 200)
TALENT.Description = 'After killing a player, you have a %s_^ chance to receive a %s_^ damage reduction for %s^ seconds'
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 50, max = 80} -- Chance to trigger
TALENT.Modifications[2] = {min = 5,  max = 10} -- Percent damage reduction
TALENT.Modifications[3] = {min = 5,  max = 20} -- Duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local percent = (self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))) / 100
		local duration = self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * math.min(1, talent_mods[3]))

		status.Inflict("Fortified", {Time = duration, Player = att, Percent = percent})
	end
end

if (SERVER) then
	local STATUS = status.Create "Fortified"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Fortified", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Fortified":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Fortified"
	EFFECT.Message = "Fortified"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/shield.png"
	function EFFECT:Init(data)
		local att = data.Player
		att.Fortified = 1 - data.Percent

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Player)) then return end

		local att = data.Player
		att.Fortified = nil
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 86
TALENT.Name = "Fracture"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Limb damage is increased by %s_ when using this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 30 } -- Amount headshot is increased

TALENT.Melee = true
TALENT.NotUnique = true

local da_hitgroups = {
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_HEAD] = true,
	[HITGROUP_GEAR] = true
}

function TALENT:ScalePlayerDamage(victim, attacker, dmginfo, hitgroup, talent_mods)
	if (not da_hitgroups[hitgroup]) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
		dmginfo:ScaleDamage( 1 + ( increase / 100 ) )
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 10
TALENT.Name = "Frost"
TALENT.NameColor = Color( 100, 100, 255 )
TALENT.NameEffect = "frost"
TALENT.Description = "Each hit has a %s_^ chance to freeze the target for %s seconds, slowing their speed by ^%s_ percent, and applying 2 damage every ^%s seconds"
TALENT.Tier = 3
TALENT.LevelRequired = { min = 25, max = 30 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5 , max = 15 }	-- Chance to freeze
TALENT.Modifications[2] = { min = 15, max = 30 }	-- Freeze time
TALENT.Modifications[3] = { min = 25, max = 50 }	-- Frozen Speed time
TALENT.Modifications[4] = { min = 5 , max = 8 }		-- Frozen Damage Delay

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		status.Inflict("Frost", {
			Player = victim,
			Time = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])),
			Speed = (self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * math.min(1, talent_mods[3]))) / 100,
			DamageDelay = self.Modifications[4].min + ((self.Modifications[4].max - self.Modifications[4].min) * math.min(1, talent_mods[4])),
			Weapon = attacker:GetActiveWeapon(),
			Attacker = attacker
		})
	end
end

if (SERVER) then
	local STATUS = status.Create "Frost"
	function STATUS:Invoke(data)
		self:CreateEffect "Frozen":Invoke(data, data.Time, data.Player)
		self:CreateEffect "Freezing":Invoke(data, false)
	end

	local EFFECT = STATUS:CreateEffect "Frozen"
	EFFECT.Message = "Frozen"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/weather_snow.png"
	function EFFECT:Init(data)
		local amt = math.floor(data.Time / data.DamageDelay) * data.DamageDelay
		self.Timer = self:CreateTimer(amt, amt / data.DamageDelay, self.Callback, data)
	end

	function EFFECT:Callback(data)
		local vic = data.Player
		if (not IsValid(vic)) then return end
		if (not vic:Alive()) then return end
		if (GetRoundState() ~= ROUND_ACTIVE) then return end

		local dmg = DamageInfo()
		dmg:SetInflictor(data.Weapon)
		dmg:SetAttacker(data.Attacker)
		dmg:SetDamage(2)
		dmg:SetDamageType(DMG_DIRECT)

		vic:TakeDamageInfo(dmg)
	end


	util.AddNetworkString("FrozenPlayer")
	local frozen_players = 0

	EFFECT = STATUS:CreateEffect "Freezing"
	function EFFECT:Init(data)
		local ply = data.Player
		if (not ply:canBeMoatFrozen()) then return end

		ply.moatFrozen = true
		ply.moatFrozenSpeed = data.Speed
		ply:SetNW2Bool("moatFrozen", true)
		self:CreateEndTimer(data.Time, data)
		
		frozen_players = frozen_players + 1
		net.Start("FrozenPlayer")
			net.WriteUInt(frozen_players, 8)
		net.Broadcast()
	end

	function EFFECT:OnEnd(data)
		local ply = data.Player

		ply.moatFrozen = false
		ply.moatFrozenSpeed = 1
		ply:SetNW2Bool("moatFrozen", false)
		
		frozen_players = frozen_players - 1
		net.Start("FrozenPlayer")
			net.WriteUInt(frozen_players, 8)
		net.Broadcast()
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 3
TALENT.Suffix = "the Inferno"
TALENT.Name = "Inferno"
TALENT.NameColor = Color( 255, 0, 0 )
TALENT.NameEffect = "fire"
TALENT.Description = "Each hit has a %s_^ chance to ignite the target for %s seconds and apply 1 damage every 0.2 seconds"
TALENT.Tier = 3
TALENT.LevelRequired = { min = 25, max = 30 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 }	-- Chance to ignite
TALENT.Modifications[2] = { min = 2, max = 10 }	-- Ignite time

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (MOAT_ACTIVE_BOSS) then return end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		status.Inflict("Inferno", {
			Victim = victim,
			Attacker = dmginfo:GetAttacker(),
			Inflictor = dmginfo:GetInflictor(),
			Time = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		})
	end
end

if (SERVER) then
	local STATUS = status.Create "Inferno"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Inferno", data.Victim)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Inferno":Invoke(data, data.Time, data.Victim)
		end
	end

	local EFFECT = STATUS:CreateEffect "Inferno"
	EFFECT.Message = "On Fire"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/weather_sun.png"
	function EFFECT:Init(data)
		local victim = data.Victim
		local radius = data.Radius or 0

		victim:Ignite(data.Time, radius)
		victim.ignite_info = {att = data.Attacker, infl = data.Inflictor}
		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Victim)) then return end

		local victim = data.Victim

		victim:Extinguish()
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 27
TALENT.Suffix = "Mark"
TALENT.Name = "Mark"
TALENT.NameColor = Color(255, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to allow a heat signature on your target for %s seconds. This enhanced vision is shared with your teammates"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 35}	-- Chance to trigger
TALENT.Modifications[2] = {min = 5, max = 25}	-- Effect duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(vic, att, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local secs = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))

		status.Inflict("Mark", {Time = secs, Player = vic, Attacker = att})
	end
end


if (SERVER) then
	local STATUS = status.Create "Mark"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Mark", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Mark":Invoke(data, false)
		end
	end


	local markColor = {
		[0] = Color(0, 255, 0),	-- Innocent
		[1] = Color(255, 0, 0),	-- Traitor
		[2] = Color(0, 0, 255)	-- Detective
	}

	local EFFECT = STATUS:CreateEffect "Mark"
	function EFFECT:Init(data)
		local att = data.Attacker

		local color = markColor[att:GetRole() or ROLE_INNOCENT]

		net.Start("Moat.Talents.Mark")
		net.WriteEntity(data.Player)
		net.WriteColor(color)
		
		if (att:GetTraitor()) then
			net.Send(GetTraitorFilter())
		elseif (att:GetDetective()) then
			net.Broadcast()
		else
			net.Send(att)
		end

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Attacker)) then return end
		if (not IsValid(data.Player)) then return end

		local att = data.Attacker

		net.Start("Moat.Talents.Mark.End")
		net.WriteEntity(data.Player)
		
		if (att:GetTraitor()) then
			net.Send(GetTraitorFilter())
		elseif (att:GetDetective()) then
			net.Broadcast()
		else
			net.Send(att)
		end
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 154
TALENT.Name = "Dog Lover"
TALENT.NameColor = Color(255, 0, 127)
TALENT.Description = "Each hit has a %s_^ chance to overwehlm the target with pictures of an adorable dog for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 10} -- percent
TALENT.Modifications[2] = {min = 5, max = 10} -- seconds

TALENT.Melee = false
TALENT.NotUnique = false

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		local pic_time = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )

		net.Start("JennyDoggo")
		net.WriteBool(false)
		net.WriteDouble(pic_time)
		net.Send(victim)

		net.Start("JennyDoggo")
		net.WriteBool(true)
		net.Send(attacker)
	end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 10102
TALENT.Suffix = "the Energizing"
TALENT.Name = "Energizing"
TALENT.NameColor = Color(255, 119, 0)
TALENT.Description = "Damage is increased by %s_^ for each consecutive hit, up to a maximum of %s_^"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 8, max = 10}
TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 4, max = 8 } -- Every shot hit increases
TALENT.Modifications[2] = { min = 35, max = 45 } -- Maximum
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Aqua Palm Collection"

function TALENT:ModifyWeapon(weapon, talent_mods)
    weapon:ApplyTracer "laser"
    net.Start "apply_tracer"
        net.WriteUInt(weapon:GetEntityID(), 32)
        net.WriteString "laser"
    net.Broadcast()
end

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end

    local Increase = (self.Modifications[1].min + (self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1])) / 100
    local Maximum = (self.Modifications[2].min + (self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])) / 100

    wep.BaseDamage = wep.BaseDamage or wep.Primary.Damage

    local pellets_per_shot = wep.Primary.ReverseShotsDamage and wep.Primary.Damage or wep.Primary.NumShots or 1

    if (wep.Energizer_PelletsHit and (wep.Energizer_PelletsHit + wep.Energizer_PelletsHitAHR) / pellets_per_shot < 0.5) then
        wep.Primary.Damage = wep.BaseDamage
        wep.EnergizerStacks = 0
    end

    wep.Energizer_PelletsHit = 0
    wep.Energizer_PelletsHitAHR = 0
    local cb = dmginfo.Callback
	dmginfo.Callback = function(att, tr, dmginfo)
        if (IsValid(tr.Entity)) then
            if (tr.AltHitreg) then
                wep.Energizer_PelletsHitAHR = wep.Energizer_PelletsHitAHR + 1
            else
                wep.Energizer_PelletsHit = wep.Energizer_PelletsHit + 1
            end

            if ((wep.Energizer_PelletsHit + wep.Energizer_PelletsHitAHR) / pellets_per_shot >= 0.5) then
                wep.EnergizerStacks = (wep.EnergizerStacks or 0) + 1
                wep.Primary.Damage = wep.BaseDamage * (1 + math.min(Maximum, wep.EnergizerStacks * Increase))
            end
        end
        if (cb) then
            return cb(att, tr, dmginfo)
        end
	end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT = TALENT or MOAT_TALENTS[155]

TALENT.ID = 155
TALENT.Name = "Leech"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to heal %s^ health over %s seconds"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5 , max = 15}	-- Chance to trigger
TALENT.Modifications[2] = {min = 15, max = 40}	-- Amount to heal
TALENT.Modifications[3] = {min = 30, max = 50}	-- Duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, att, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local amt = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])))
		local sec = math.Round(self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * math.min(1, talent_mods[3])))

		status.Inflict("Leech", {Time = sec, Amount = amt, Player = att})
	end
end


if (SERVER) then
	local PREDATORY = status.Create "Leech"
	function PREDATORY:Invoke(data)
		if (MOAT_ACTIVE_BOSS) then
			local amount_already = 0

			for _, eff in pairs(data.Player.ActiveEffects) do
				if (eff.Active and eff.Name == "Leech") then
					amount_already = amount_already + 1
					if (amount_already >= 10) then
						return
					end
				end
			end
		end

		self:CreateEffect "Leech":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = PREDATORY:CreateEffect "Leech"
	EFFECT.Message = "Leeching"
	EFFECT.Color = Color(0, 255, 0)
	EFFECT.Material = "icon16/heart_add.png"
	function EFFECT:Init(data)
		self.HealTimer = self:CreateTimer(data.Time, data.Amount, self.HealCallback, data)
	end

	function EFFECT:HealCallback(data)
		local att = data.Player
		if (not IsValid(att)) then return end
		if (att:Team() == TEAM_SPEC) then return end
		if (GetRoundState() ~= ROUND_ACTIVE) then return end

		att:SetHealth(math.Clamp(att:Health() + 1, 0, att:GetMaxHealth()))
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 24
TALENT.Suffix = "the Feather"
TALENT.Name = "Lightweight"
TALENT.NameColor = Color(175,238,238)
TALENT.Description = "Weight is reduced by %s_^"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = -5, max = -15} -- weight

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )
	local Mod = self.Modifications[1]
	weapon:SetWeightMod(weapon:GetWeightMod() + Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1]))
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 9030
TALENT.Name = "Copycat"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Every kill with this weapon has a %s_^ chance to copy the stats of the weapon from who you killed, it also stacks talents"
TALENT.Tier = 1

TALENT.LevelRequired = {min = 5, max = 10}
-- TALENT.LevelRequired = {min = -5, max = -10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 25, max = 50} -- Percent damage is increased by

TALENT.Melee = false
TALENT.NotUnique = false

if (SERVER) then
	util.AddNetworkString("Switch_wep_primary")
	function _switch_wep_talent(att,vic)
		local orig_wep = att:GetActiveWeapon()
		local new_wep = vic:GetActiveWeapon()
		new_wep.Primary.Ammo = orig_wep.Primary.Ammo


		local new_primary = new_wep.Primary
		new_primary.Ammo = orig_wep.Primary.Ammo

		local active = 0
		-- new_wep.Primary.Damage = orig_wep.Primary.Damage
		orig_wep.Primary = table.Copy(new_primary)
		if istable(new_wep.Talents) then
			local level = new_wep.level
			for k,v in pairs(new_wep.Talents) do
				if v.l <= level then
					v.l = -1
				else
					v.l = 1337
				end
				table.insert(orig_wep.Talents,v)
			end
		end
		for k,v in pairs(orig_wep.Talents) do
			if v.l <= orig_wep.level then
				active = active + 1
			end
		end




		net.Start("Switch_wep_primary")
		net.WriteEntity(orig_wep)
		net.WriteTable(orig_wep.Primary)
		net.WriteEntity(new_wep)
		net.WriteInt(active,8)
		net.Broadcast()
		-- local orig_primary = table.Copy(orig_wep.Primary)
		-- local orig_lvl = orig_wep.level
		-- local orig_talents = table.Copy(orig_wep.Talents)
		-- orig_wep:Remove() -- have to do this + 0.1 timer if they are in the same slot.
		-- timer.Simple(0.1,function()
		-- 	local new_wep = att:Give(new_wep_class)
		-- 	new_wep.Primary = orig_primary
		-- 	new_wep.Talents = orig_talents
		-- 	new_wep.level = orig_lvl
		-- 	net.Start("Switch_wep_primary")
		-- 	net.WriteEntity(new_wep)
		-- 	net.WriteTable(new_wep.Primary)
		-- 	net.Broadcast()
		-- 	timer.Simple(0.3,function()
		-- make new thing about how to do things, but but really i am just wasting time to do some more things...

		-- 		att:SelectWeapon(new_wep_class)		
		-- 	end)
		-- end)
	end
end

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
		if victim:Health() - dmginfo:GetDamage() < 1 then
			-- print(8)
			if (not IsValid(victim:GetActiveWeapon())) then return end
			-- print(9)
			if (not victim:GetActiveWeapon().Primary) then return end
			-- print(10)
			if victim:GetActiveWeapon().Kind ~= WEAPON_HEAVY and victim:GetActiveWeapon().Kind ~= WEAPON_PISTOL then return end
			-- if (victim:GetActiveWeapon().Kind == WEAPON_MELEE) or (victim:GetActiveWeapon().Kind == WEAPON_UNARMED) then return end
			_switch_wep_talent(attacker,victim)
		end
	end
end


m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 19
TALENT.Name = "Assassin"
TALENT.NameColor = Color(50, 50, 255)
TALENT.Description = "Each kill has a %s_^ chance to dissolve the body of the person you killed"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 25}

TALENT.Melee = false
TALENT.NotUnique = true


if (SERVER) then
	util.AddNetworkString("Ass_talent")
	function _ass_talent(vic,att)
		local dissolver = ents.Create("env_entity_dissolver")
		local uid = vic:UniqueID()
		timer.Simple(0.2,function()
			for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
				if (v.uqid and v.uqid == uid and IsValid(v)) then
					v.IsSafeToRemove = true
					if IsValid(vic) then
						vic:SetNW2Bool("body_found", false)
						net.Start("Ass_talent")
						net.WriteString(vic:Nick())
						net.Send(att)
					end

					v:SetName("diss_" .. v:EntIndex())
					dissolver:Spawn()
					dissolver:Activate()
					dissolver:SetKeyValue("dissolvetype", 1)
					dissolver:SetKeyValue("magnitude", 1)
					dissolver:SetPos(v:GetPos())
					dissolver:Fire("Dissolve", v:GetName(), 0)
					dissolver:Fire("Kill", "", 0.1)

					timer.Simple(0.1,function()
						dissolver:Remove()
					end)
				end
			end
		end)
	end
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        _ass_talent(vic,att)
    end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 31
TALENT.Name = "Wildcard: Tier 1"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "When this talent is unlocked, it will morph into a different talent every round"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 100, max = 200}

TALENT.Melee = false
TALENT.NotUnique = false

if (SERVER) then
	util.AddNetworkString("weapon.UpdateTalents")

	wildcard_prep_cache = {}

	hook.Add("TTTBeginRound","ClearWildcard",function()
		timer.Simple(5,function()
			wildcard_prep_cache = {}
		end)
	end)

	local tier = 1
	local id = TALENT.ID
	function wildcard_t1(weapon,talent_mods)
		local talents = table.Copy(MOAT_TALENTS)

		local active = weapon.Talents[tier].l <= weapon.level
		if (not active) then return end


		for k,v in pairs(talents) do 
			if v.Tier ~= tier or v.ID == id or (v.ID == 154) or ((v.Collection or "") == "Omega Collection") then 
				talents[k] = nil 
			end 
		end

		local talent, tk = table.Random(talents)

		local t = {
			e = talent.ID,
			l = weapon.Talents[tier].l,
			m = {}
		}

		for k,v in pairs(talent.Modifications) do
			t.m[k] = math.Round(math.Rand(0, 1), 2)
		end

		local wep = weapon.Weapon
		if GetRoundState() == ROUND_PREP then 
			if wildcard_prep_cache[wep:GetOwner()] and wildcard_prep_cache[wep:GetOwner()][tier] and wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] then
				talent = talents[wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][1]]
				t = wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][2]
			end
			if not wildcard_prep_cache[wep:GetOwner()] then
				wildcard_prep_cache[wep:GetOwner()] = {}
			end
			if not wildcard_prep_cache[wep:GetOwner()][tier] then
				wildcard_prep_cache[wep:GetOwner()][tier] = {}
			end
			wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] = {tk,t}
		else
			if wildcard_prep_cache[wep:GetOwner()] then
				if wildcard_prep_cache[wep:GetOwner()][tier] then
					if wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] then
						talent = talents[wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][1]]
						t = wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][2]
					end
				end
			end
		end


		weapon.Weapon.Talents[tier] = t
		weapon.Weapon.ItemStats.t[tier] = t
		weapon.Weapon.ItemStats.Talents[tier] = talent

		if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
		end


		m_ApplyTalentsToWeapon(weapon.Weapon,t)

		for k,v in pairs(talent) do
			if isfunction(v) then talent[k] = nil end
		end

		timer.Simple(1,function()
			net.Start("weapon.UpdateTalents")
			net.WriteBool(false)
			net.WriteEntity(weapon.Weapon)
			net.WriteInt(tier,8)
			net.WriteTable(talent)
			net.WriteTable(t)
			net.Broadcast()
		end)

		-- PrintTable(talents)

		-- for i = 1, table.Count(talents_chosen) do
		--     local talent_tbl = talents_chosen[i]
		--     dropped_item.t[i] = {}
		--     dropped_item.t[i].e = talent_tbl.ID
		--     dropped_item.t[i].l = math.random(talent_tbl.LevelRequired.min, talent_tbl.LevelRequired.max)
		--     dropped_item.t[i].m = {}

		--     for k, v in ipairs(talent_tbl.Modifications) do
		--         dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
		--     end
		-- end
	end
end

function TALENT:ModifyWeapon( weapon, talent_mods )
    timer.Simple(1,function()
        wildcard_t1(weapon,talent_mods)
    end)
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 32
TALENT.Name = "Wildcard: Tier 2"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "When this talent is unlocked, it will morph into a different talent every round"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 100, max = 200}

TALENT.Melee = false
TALENT.NotUnique = false


if (SERVER) then
	util.AddNetworkString("weapon.UpdateTalents")

	local tier = 2
	local id = TALENT.ID
	function wildcard_t2(weapon,talent_mods)
		local talents_chosen = {}
		local talents = table.Copy(MOAT_TALENTS)

		local active = weapon.Talents[tier].l <= weapon.level
		if (not active) then return end


		for k,v in pairs(talents) do 
			if v.Tier ~= tier or v.ID == id or (v.ID == 154) or ((v.Collection or "") == "Omega Collection") then 
				talents[k] = nil 
			end 
		end

		local talent,tk = table.Random(talents)

		local t = {
			e = talent.ID,
			l = weapon.Talents[tier].l,
			m = {}
		}

		for k,v in pairs(talent.Modifications) do
			t.m[k] = math.Round(math.Rand(0, 1), 2)
		end

		local wep = weapon.Weapon
		if GetRoundState() == ROUND_PREP then 
			if wildcard_prep_cache[wep:GetOwner()] then
				if wildcard_prep_cache[wep:GetOwner()][tier] then
					if wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] then
						talent = talents[wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][1]]
						t = wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][2]
					end
				end
			end
			if not wildcard_prep_cache[wep:GetOwner()] then
				wildcard_prep_cache[wep:GetOwner()] = {}
			end
			if not wildcard_prep_cache[wep:GetOwner()][tier] then
				wildcard_prep_cache[wep:GetOwner()][tier] = {}
			end
			wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] = {tk,t}
		else
			if wildcard_prep_cache[wep:GetOwner()] then
				if wildcard_prep_cache[wep:GetOwner()][tier] then
					if wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] then
						talent = talents[wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][1]]
						t = wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][2]
					end
				end
			end
		end

		weapon.Weapon.Talents[tier] = t
		weapon.Weapon.ItemStats.t[tier] = t
		weapon.Weapon.ItemStats.Talents[tier] = talent

		if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
		end


		m_ApplyTalentsToWeapon(weapon.Weapon,t)

		for k,v in pairs(talent) do
			if isfunction(v) then talent[k] = nil end
		end

		timer.Simple(1,function()
			net.Start("weapon.UpdateTalents")
			net.WriteBool(false)
			net.WriteEntity(weapon.Weapon)
			net.WriteInt(tier,8)
			net.WriteTable(talent)
			net.WriteTable(t)
			net.Broadcast()
		end)

		-- PrintTable(talents)

		-- for i = 1, table.Count(talents_chosen) do
		--     local talent_tbl = talents_chosen[i]
		--     dropped_item.t[i] = {}
		--     dropped_item.t[i].e = talent_tbl.ID
		--     dropped_item.t[i].l = math.random(talent_tbl.LevelRequired.min, talent_tbl.LevelRequired.max)
		--     dropped_item.t[i].m = {}

		--     for k, v in ipairs(talent_tbl.Modifications) do
		--         dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
		--     end
		-- end
	end
end

function TALENT:ModifyWeapon( weapon, talent_mods )
    timer.Simple(1,function()
        wildcard_t2(weapon,talent_mods)
    end)
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 33
TALENT.Name = "Wildcard: Tier 3"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "When this talent is unlocked, it will morph into a different talent every round"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 20, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 100, max = 200}

TALENT.Melee = false
TALENT.NotUnique = false

if (SERVER) then
	util.AddNetworkString("weapon.UpdateTalents")

	local tier = 3
	local id = TALENT.ID
	function wildcard_t3(weapon,talent_mods)
		local talents_chosen = {}
		local talents = table.Copy(MOAT_TALENTS)

		local active = weapon.Talents[tier].l <= weapon.level
		if (not active) then return end


		for k,v in pairs(talents) do 
			if v.Tier ~= tier or v.ID == id or (v.ID == 154) or ((v.Collection or "") == "Omega Collection") then 
				talents[k] = nil 
			end 
		end

		local talent,tk = table.Random(talents)
	
		local t = {
			e = talent.ID,
			l = weapon.Talents[tier].l,
			m = {}
		}

		for k,v in pairs(talent.Modifications) do
			t.m[k] = math.Round(math.Rand(0, 1), 2)
		end

		local wep = weapon.Weapon
		if GetRoundState() == ROUND_PREP then 
			if wildcard_prep_cache[wep:GetOwner()] then
				if wildcard_prep_cache[wep:GetOwner()][tier] then
					if wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] then
						talent = talents[wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][1]]
						t = wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][2]
					end
				end
			end
			if not wildcard_prep_cache[wep:GetOwner()] then
				wildcard_prep_cache[wep:GetOwner()] = {}
			end
			if not wildcard_prep_cache[wep:GetOwner()][tier] then
				wildcard_prep_cache[wep:GetOwner()][tier] = {}
			end
			wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] = {tk,t}
		else
			if wildcard_prep_cache[wep:GetOwner()] then
				if wildcard_prep_cache[wep:GetOwner()][tier] then
					if wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()] then
						talent = talents[wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][1]]
						t = wildcard_prep_cache[wep:GetOwner()][tier][wep:GetClass()][2]
					end
				end
			end
		end

		weapon.Weapon.Talents[tier] = t
		weapon.Weapon.ItemStats.t[tier] = t
		weapon.Weapon.ItemStats.Talents[tier] = talent

		if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
			loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
		end


		m_ApplyTalentsToWeapon(weapon.Weapon,t)

		for k,v in pairs(talent) do
			if isfunction(v) then talent[k] = nil end
		end

		timer.Simple(1,function()
			net.Start("weapon.UpdateTalents")
			net.WriteBool(false)
			net.WriteEntity(weapon.Weapon)
			net.WriteInt(tier,8)
			net.WriteTable(talent)
			net.WriteTable(t)
			net.Broadcast()
		end)

		-- PrintTable(talents)

		-- for i = 1, table.Count(talents_chosen) do
		--     local talent_tbl = talents_chosen[i]
		--     dropped_item.t[i] = {}
		--     dropped_item.t[i].e = talent_tbl.ID
		--     dropped_item.t[i].l = math.random(talent_tbl.LevelRequired.min, talent_tbl.LevelRequired.max)
		--     dropped_item.t[i].m = {}

		--     for k, v in ipairs(talent_tbl.Modifications) do
		--         dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
		--     end
		-- end
	end
end

function TALENT:ModifyWeapon( weapon, talent_mods )
    timer.Simple(1,function()
        wildcard_t3(weapon,talent_mods)
    end)
end
m_AddTalent(TALENT)

TALENT = {}
if (not TALENT) then
    TALENT = {DoThing=true}
end
TALENT.ID = 34
TALENT.Name = "Wild! - Tier 1"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "After a kill, you have a %s_^ chance to add a random Tier 1 talent to your gun with its lowest stats possible"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40, max = 70}

TALENT.Melee = false
TALENT.NotUnique = false

if (SERVER) then
	util.AddNetworkString("weapon.UpdateTalents")

	local tier = 1
	local id = TALENT.ID
	function wild_t1(weapon,talent_mods)
		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
		local talents = table.Copy(MOAT_TALENTS)

		local active = weapon.Talents[tier].l <= weapon.level
		if (not active) then return end


		for k,v in pairs(talents) do 
			if v.Tier ~= tier or v.ID == id or (v.ID == 154) or (v.ID == 31) or ((v.Collection or "") == "Omega Collection") or v.ID == 98 then 
				talents[k] = nil 
			end 
		end

		local talent, tk = table.Random(talents)

		local t = {
			e = talent.ID,
			l = weapon.Talents[tier].l,
			m = {}
		}

		for k,v in pairs(talent.Modifications) do
			t.m[k] = 0
		end
		-- weapon.Weapon.Talents[tier] = t
		-- weapon.Weapon.ItemStats.t[tier] = t
		-- weapon.Weapon.ItemStats.Talents[tier] = talent


		local function dotalent()
			print(weapon)
			table.insert(weapon.Weapon.Talents,t)
			table.insert(weapon.Weapon.ItemStats.t,t)
			table.insert(weapon.Weapon.ItemStats.item.Talents,talent)

			if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
				table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,t)
				-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
				table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t,t)
				-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
				table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,talent)
				-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
			end

			if talent.OnWeaponSwitch then
				talent:OnWeaponSwitch(weapon:GetOwner(), weapon, true, t.m)
			end
			m_ApplyTalentsToWeapon(weapon.Weapon,t)
		end

		if talent.ID == 69 then
			timer.Simple(5, dotalent)
		else
			dotalent()
		end

		for k,v in pairs(talent) do
			if isfunction(v) then talent[k] = nil end
		end

		net.Start("weapon.UpdateTalents")
		net.WriteBool(true)
		net.WriteEntity(weapon.Weapon)
		net.WriteInt(tier,8)
		net.WriteTable(talent)
		net.WriteTable(t)
		net.Broadcast()

	end
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) and GetRoundState() ~= ROUND_PREP then
    	wild_t1(att:GetActiveWeapon(),talent_mods)
    end
end
if (TALENT.DoThing) then
    MOAT_TALENTS[TALENT.ID] = TALENT
    TALENT.DoThing = nil
    TALENT = nil
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 35
TALENT.Name = "Wild! - Tier 2"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "After a kill, you have a %s_^ chance to add a random Tier 2 talent to your gun with its lowest stats possible"
TALENT.Tier = 2
-- TALENT.LevelRequired = {min = -5, max = -10}
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40, max = 65}

TALENT.Melee = false
TALENT.NotUnique = false

if (SERVER) then
	util.AddNetworkString("weapon.UpdateTalents")


	local tier = 2
	local id = TALENT.ID
	function wild_t2(weapon,talent_mods)
		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
		local talents = table.Copy(MOAT_TALENTS)

		local active = weapon.Talents[tier].l <= weapon.level
		if (not active) then return end


		for k,v in pairs(talents) do 
			if v.Tier ~= tier or v.ID == id or (v.ID == 154) or (v.ID == 32) or ((v.Collection or "") == "Omega Collection") then 
				talents[k] = nil 
			end 
		end

		local talent, tk = table.Random(talents)

		local t = {
			e = talent.ID,
			l = weapon.Talents[tier].l,
			m = {}
		}

		for k,v in pairs(talent.Modifications) do
			t.m[k] = 0
		end


		table.insert(weapon.Weapon.Talents,t)
		table.insert(weapon.Weapon.ItemStats.t,t)
		table.insert(weapon.Weapon.ItemStats.item.Talents,talent)
		-- weapon.Weapon.Talents[tier] = t
		-- weapon.Weapon.ItemStats.t[tier] = t
		-- weapon.Weapon.ItemStats.Talents[tier] = talent

		if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
			table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,t)
			-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
			table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t,t)
			-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
			table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,talent)
			-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
		end


		if talent.OnWeaponSwitch then
			talent:OnWeaponSwitch(weapon:GetOwner(), weapon, true, t.m)
		end
		m_ApplyTalentsToWeapon(weapon.Weapon,t)

		for k,v in pairs(talent) do
			if isfunction(v) then talent[k] = nil end
		end

		net.Start("weapon.UpdateTalents")
		net.WriteBool(true)
		net.WriteEntity(weapon.Weapon)
		net.WriteInt(tier,8)
		net.WriteTable(talent)
		net.WriteTable(t)
		net.Broadcast()
		
	end
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) and GetRoundState() ~= ROUND_PREP then
    	wild_t2(att:GetActiveWeapon(),talent_mods)
    end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 36
TALENT.Name = "Wild! - Tier 3"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "After a kill, you have a %s_^ chance to add a random Tier 3 talent to your gun with its lowest stats possible"
TALENT.Tier = 3
-- TALENT.LevelRequired = {min = -5, max = -10}
TALENT.LevelRequired = {min = 20, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40, max = 60}

TALENT.Melee = false
TALENT.NotUnique = false

if (SERVER) then
	util.AddNetworkString("weapon.UpdateTalents")


	local tier = 3
	local id = TALENT.ID
	function wild_t3(weapon,talent_mods)
		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
		local talents = table.Copy(MOAT_TALENTS)

		local active = weapon.Talents[tier].l <= weapon.level
		if (not active) then return end


		for k,v in pairs(talents) do 
			if v.Tier ~= tier or v.ID == id or (v.ID == 154) or (v.ID == 33) or ((v.Collection or "") == "Omega Collection") then 
				talents[k] = nil 
			end 
		end

		local talent, tk = table.Random(talents)

		local t = {
			e = talent.ID,
			l = weapon.Talents[tier].l,
			m = {}
		}

		for k,v in pairs(talent.Modifications) do
			t.m[k] = 0
		end


		table.insert(weapon.Weapon.Talents,t)
		table.insert(weapon.Weapon.ItemStats.t,t)
		table.insert(weapon.Weapon.ItemStats.item.Talents,talent)
		-- weapon.Weapon.Talents[tier] = t
		-- weapon.Weapon.ItemStats.t[tier] = t
		-- weapon.Weapon.ItemStats.Talents[tier] = talent

		if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
			table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,t)
			-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
			table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t,t)
			-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
			table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,talent)
			-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
		end


		if talent.OnWeaponSwitch then
			talent:OnWeaponSwitch(weapon:GetOwner(), weapon, true, t.m)
		end
		m_ApplyTalentsToWeapon(weapon.Weapon,t)

		for k,v in pairs(talent) do
			if isfunction(v) then talent[k] = nil end
		end


		net.Start("weapon.UpdateTalents")
		net.WriteBool(true)
		net.WriteEntity(weapon.Weapon)
		net.WriteInt(tier,8)
		net.WriteTable(talent)
		net.WriteTable(t)
		net.Broadcast()
	end
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) and GetRoundState() ~= ROUND_PREP then
    	wild_t3(att:GetActiveWeapon(),talent_mods)
    end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 22
TALENT.Name = 'Medicality'
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = 'While wielding this weapon, you will gain 1 health every %s second(s)'
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 1, max = 3} -- Seconds

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnWeaponSwitch(ply, wep, isto, talent_mods)
	local timer_speed = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )

	local id = "moat_medicality" .. ply:EntIndex()
	if (isto) then
		timer.Create(id, timer_speed, 0, function()
			if (not IsValid(ply)) then timer.Remove(id) return end
			if (not IsValid(wep)) then timer.Remove(id) return end
			if (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() ~= wep) then timer.Remove(id) return end

			if (ply:Health() < ply:GetMaxHealth()) then
				ply:SetHealth(math.Clamp(ply:Health() + 1, 0, ply:GetMaxHealth()))
			end
		end)
	else
		timer.Remove(id)
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 11
TALENT.Name = 'Meticulous'
TALENT.NameColor = Color(205, 127, 50)
TALENT.Description = "After killing a target with this weapon, the magazine has a %s_^ chance to refill completely"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 30} -- Chance to refill first clip

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(victim, _, attacker, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local plyWep = attacker:GetActiveWeapon()
		local maxClip1 = plyWep:GetMaxClip1()
		plyWep:SetClip1(maxClip1 + 1) -- +1 because otherwise it doesn't fill it all the way.

		net.Start('moatNotifyMeticulous')
			net.WriteInt(maxClip1, 32)
		net.Send(attacker)
	end
end

m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 10103
TALENT.Name = "Paintball"
TALENT.NameColor = Color(255, 119, 0)
TALENT.Description = "Removes all body part multipliers. Increases damage by %s_^"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 8, max = 10}
TALENT.Modifications = {}
TALENT.Modifications[1] = { min = -5, max = 5 } -- Every shot hit increases
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Aqua Palm Collection"

function TALENT:ModifyWeapon(weapon, talent_mods)
    weapon:ApplyTracer "paintball"
    net.Start "apply_tracer"
        net.WriteUInt(weapon:GetEntityID(), 32)
        net.WriteString "paintball"
    net.Broadcast()

    function weapon:ScaleDamage()
    end
    function weapon:GetHeadshotMultiplier()
        return 1
    end

    weapon.Primary.Damage = weapon.Primary.Damage * (1 + (self.Modifications[1].min + (self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1])) / 100)
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 12
TALENT.Suffix = "Provident"
TALENT.Name = 'Provident'
TALENT.NameColor = Color(0, 123, 181)
TALENT.Description = 'Each bullet has a 40_ chance to do %s_^ more damage'
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 15, max = 30} -- Damage last bullet can do

TALENT.Melee = false
TALENT.NotUnique = true

/*
function TALENT:OnPlayerHit(victim, attacker, dmgInfo, talent_mods)
	local plyWep = attacker:GetActiveWeapon()
	local currentClip = plyWep:Clip1()
	if (currentClip == 1) then
		local damageIncrease = (self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / 100
		local damageToAdd = dmgInfo:GetDamage() * damageIncrease
		dmgInfo:AddDamage(damageToAdd)
	end
end*/

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (math.random() < 0.4) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
		dmginfo:ScaleDamage(1 + (increase / 100))
	end
end

m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 102
TALENT.Name = "Power Stone"
TALENT.NameColor = Color(128,0,128)
TALENT.Description = "Each shot has a %s_^ chance to deal double damage"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 1, max = 5}	-- Chance to trigger

TALENT.Melee = true
TALENT.NotUnique = false

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		dmginfo:ScaleDamage(2)
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 88
TALENT.Suffix = "the Zombie"
TALENT.Name = "Predatory"
TALENT.NameColor = Color(0, 255, 128)
TALENT.Description = "Killing a target regenerates %s_^ health over %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 35}
TALENT.Modifications[2] = {min = 10, max = 35}

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local amt = math.Round(self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1])))
    local sec = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])))

    status.Inflict("Predatory", {Time = sec, Amount = amt, Player = att})
end


if (SERVER) then
	local PREDATORY = status.Create "Predatory"
	function PREDATORY:Invoke(data)
		self:CreateEffect "Predatory":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = PREDATORY:CreateEffect "Predatory"
	EFFECT.Message = "Healing"
	EFFECT.Color = Color(221, 101, 101)
	EFFECT.Material = "icon16/heart_add.png"
	function EFFECT:Init(data)
		self.HealTimer = self:CreateTimer(data.Time, data.Amount, self.HealCallback, data)
	end

	function EFFECT:HealCallback(data)
		local att = data.Player
		if (not IsValid(att)) then return end
		if (att:Team() == TEAM_SPEC) then return end
		if (GetRoundState() ~= ROUND_ACTIVE) then return end

		att:SetHealth(math.Clamp(att:Health() + 1, 0, att:GetMaxHealth()))
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 14
TALENT.Name = 'Prepared'
TALENT.NameColor = Color(41, 171, 135)
TALENT.Description = 'Damage is increased by %s_^ when more than %s feet from the target'
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20} -- Percent of damage increased by range
TALENT.Modifications[2] = {min = 25, max = 40} -- Feet Difference

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then return end

	local range = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
	local max_dist = range * 50

	if (victim:GetPos():DistToSqr(attacker:GetPos()) >= (max_dist * max_dist)) then
		local damageIncrease = (self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / 100
		dmginfo:ScaleDamage(1 + damageIncrease)
	end
end


m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 101
TALENT.Name = "Reality Stone"
TALENT.NameColor = Color(255, 50, 50)
TALENT.Description = "You have a %s_^ chance to go transparent for %s seconds after killing someone with this weapon"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20}
TALENT.Modifications[2] = {min = 5, max = 20}
TALENT.Melee = true
TALENT.NotUnique = false

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
	local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))

	if (chanceNum > math.random() * 100) then
		status.Inflict("Invisible", {
			Time = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])),
			Player = att
		})
	end
end


if (SERVER) then
	local STATUS = status.Create "Invisible"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Invisible", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Invisible":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Invisible"
	EFFECT.Message = "Invisible"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/contrast_low.png"
	function EFFECT:Init(data)
		self:CreateEndTimer(data.Time, data)
		local att = data.Player
		if (not IsValid(att)) then return end

		att:SetRenderMode(RENDERMODE_TRANSALPHA)
		att:SetColor(Color(255, 255, 255, 50))
		D3A.Chat.SendToPlayer2(att, Color(0, 255, 0), "You are now transparent for ", Color(255, 0, 0), data.Time or "0", Color(0, 255, 0), " seconds!")
	end

	function EFFECT:OnEnd(data)
		local att = data.Player
		if (not IsValid(att)) then return end

		att:SetRenderMode(RENDERMODE_NORMAL)
		att:SetColor(Color(255, 255, 255, 255))
		D3A.Chat.SendToPlayer2(att, Color(255, 0, 0), "You are no longer transparent!")
	end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 99
TALENT.Name = "Replenish"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255, 122)
TALENT.Description = "Your gun has a %s_^ chance to refill a bullet if you hit someone"
TALENT.Tier = 2
TALENT.Melee = false
TALENT.NotUnique = true
TALENT.LevelRequired = {min = 15, max = 19}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40, max = 80}

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local chance = (self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / (wep.Primary.NumShots or 1)
	local old_callback = dmginfo.Callback

	local has_done = false
	dmginfo.Callback = function(att, tr, dmginfo)
		if (old_callback) then
			old_callback(att, tr, dmginfo)
		end
		
		if (has_done or tr.AltHitreg) then
			return
		end
		if (IsValid(tr.Entity) and tr.Entity:IsPlayer()) then
			has_done = true
			if (chance > math.random() * 100) then
				wep:SetClip1(wep:Clip1() + 1)
			end
		end
	end
end

/*
local function sum(x)
	local s = 0

	for k, v in ipairs(x) do
		s = s + v
	end

	return s
end

local wep_cache = {}
local function weps()
	local weps = {}
	
	wep_cache = wep_cache or weapons.GetList()
	for k, v in ipairs(wep_cache) do
		local wep = weapons.Get(v.ClassName)
		if (not wep) then continue end

		if (v.Base == "weapon_tttbase" and (v.ClassName:StartWith("weapon_ttt_te_") or v.AutoSpawnable)) then
			table.insert(weps, {Damage = v.Primary.Damage, ClipSize = v.Primary.ClipSize, Cone = v.Primary.Cone})
		end
	end

	return weps
end

local function mean(x)
	return (sum(x) / #x)
end

local function median(x)
	table.sort(x)

	return (#x % 2 == 0) and mean({x[#x / 2], x[(#x / 2) - 1]}) or x[((#x + 1) / 2) - 1]
end

local function mode(x)
	table.sort(x)

	local t = {}
	for k, v in ipairs(x) do
		t[v] = (t[v]) and (t[v] + 1) or 1
	end
	
	local max = x[1] or 0
	for k, v in ipairs(x) do
		max = (v > max) and v or max
	end

	return max
end

concommand.Add("r", function(pl, _, args)
	local replenish = {min = args[1], max = args[2]}
	local meticulous = {min = 10, max = 30}
	local sims = args[3] or 1000
	local wpn = weps()

	print("Running " .. sims .. " simulations...")

	

	local t, x = {}, {[1] = {}, [2] = {}, [3] = {}, [4] = {}}
	for kills = 1, 10 do
		for i = 1, sims do
			local w = wpn[math.random(#wpn)]
			local rand = math.random()

			local m = w.ClipSize
			local d = w.Damage

			local s1, s2, n = 0, 0, m
			while (n > 0) do
				s1 = s1 + 1

				if (((replenish.min + ((replenish.max - replenish.min) * rand)) < math.random() * 100)) then
					n = n - 1
				end
			end

			local shots, deaths = 0, 0

			n = m
			while (n > 0) do
				s2 = s2 + 1
				shots = shots + 1

				if ((meticulous.min + ((meticulous.max - meticulous.min) * rand)) < math.random() * 100) then
					n = n - 1
				elseif (deaths < kills and s2 >= math.floor((kills * 100) / )) then
					deaths = deaths + 1
					shots = 0

					n = m
				end
			end

			t[i] = {
				[1] = s1,
				[2] = s2,
				[3] = m,
				[4] = kills
			}

			table.insert(x[1], s1)
			table.insert(x[2], s2)
			table.insert(x[3], m)
			table.insert(x[4], kills)

			if (tonumber(sims) < 1000 and i % 10 == 0 or i % 100 == 0) then
				print(string(kills, ": ", #t, "/", sims))
			end
		end
	end

	local o = {[1] = {}, [2] = {}, [3] = {}, [4] = {}}
	for c = 1, 4 do
		o[c].AVERAGE = mean(x[c])
		o[c].MEDIAN = median(x[c])
		o[c].MODE = mode(x[c])

		print(string("Calulating .. ", c))
	end

	PrintTable {
		Replenish = o[1],
		Meticulous = o[2],
		Clip = o[3]
	}

end)
*/

m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 666
TALENT.Suffix = "the RICK ROSS"
TALENT.Name = "Pear"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(204, 255, 204)
TALENT.NameEffectMods = {Color(255, 204, 153)}
TALENT.Description = "Each shot has a %s_^ chance to shoot a pear projectile dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 20}
TALENT.Modifications[2] = {min = 15, max = 45}
TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    -- if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local num = (wep.Primary and wep.Primary.NumShots) and wep.Primary.NumShots or 1
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * (100 * num)) then
        local ply = dmginfo.Attacker
        if (not IsValid(ply)) then return end

    	local dmg = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
        local Front = ply:GetAimVector()
        local Up = ply:EyeAngles():Up()
        local aimang = Front:Angle()
		local bulspread = vector_origin
		local conex = wep:GetPrimaryCone() or 0.01
		local coney = wep:GetPrimaryConeY() or conex
		local mult = Vector(coney, conex)
        local nlayers = ((wep.Primary and wep.Primary.LayerMults) and #wep.Primary.LayerMults or 1) + 3
        local class = wep:GetClass()

		if (wep.propshot and #wep.propshot > num) then
			for k, v in ipairs(wep.propshot) do
				if (IsValid(v)) then v:Remove() end
			end

			wep.propshot = {}
		end

		for i = 1, num do
        	local x, y = util.SharedRandom(class, -nlayers * 50, nlayers * 50, i) * conex / nlayers, util.SharedRandom(class, -nlayers * 50, nlayers * 50, i + 1) * coney / nlayers
       	 	local rspr = aimang:Right() * x + aimang:Up() * y
    		local dir = Front + rspr + bulspread.x * mult.x * aimang:Right() + bulspread.y * mult.y * aimang:Up()

			local ball = ents.Create "ent_propshot_pear"
			if IsValid(ball) then
    			ball:SetTrailColor(Vector(0.8, 1, 0.8))
				ball:SetPos(ply:GetShootPos() + dir * 10 + Up * 10 * -1)
				ball:SetAngles(Front:Angle())
				ball.Harmless = false
				ball.Damage = dmg
				ball:Spawn()
				ball:Activate()
				ball:SetOwner(ply)

				local Physics = ball:GetPhysicsObject()
				if IsValid(Physics) then
					Physics:ApplyForceCenter(Front:Angle():Forward() * 25000)
				end

				if (not wep.propshot) then wep.propshot = {} end
				table.insert(wep.propshot, ball)
			end
		end
    end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 82
TALENT.Suffix = "the Vulture"
TALENT.Name = "Scavenger"
TALENT.NameColor = Color(178, 102, 255)
TALENT.Description = "Players have a %s_^ chance to receive %s ammo after killing a target"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 20, max = 50}	-- Chance to trigger
TALENT.Modifications[2] = {min = 5 , max = 30}	-- Amount of ammo to give

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        local ammo = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])))
        att:GiveAmmo(ammo, inf:GetPrimaryAmmoType(), true)

        net.Start("Moat.Talents.Notify")
            net.WriteUInt(1, 8)
            net.WriteString("Scavenger activated on kill!")
        net.Send(att)
    end
end

m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 9040
TALENT.Name = "Silenced"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "Every shot is silenced"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 100, max = 200} -- Chance to trigger

TALENT.Melee = false
TALENT.NotUnique = true

if (SERVER) then
	util.AddNetworkString("Talents.Silenced")

	silence_prep_cache = {}
	hook.Add("TTTBeginRound","ClearSilenced",function()
		silence_prep_cache = {}
	end)

	local silencedSound = Sound("weapons/usp/usp1.wav")

	function TALENT:ModifyWeapon(weapon, talent_mods)
		local _weapon = weapon.Weapon

		net.Start("Talents.Silenced")
			net.WriteEntity(_weapon)
		net.Broadcast()

		_weapon.Primary.Sound = silencedSound
		_weapon.Silenced = true
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 990
TALENT.Name = "Snowball"
TALENT.NameColor = Color(100, 255, 255)
TALENT.Description = "Each shot has a %s_^ chance to shoot a snowball projectile dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5 , max = 20}	-- Chance to trigger
TALENT.Modifications[2] = {min = 10, max = 55}	-- Snowball damage

TALENT.Melee = false
TALENT.NotUnique = false

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        local ply = dmginfo.Attacker
        if (not IsValid(ply)) then return end

    	local dmg = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
        local Front = ply:GetAimVector()
        local Up = ply:EyeAngles():Up()

        local ball = ents.Create("ent_snowball");
        if IsValid(ball) then
            ball:SetPos(ply:GetShootPos() + Front * 10 + Up * 10 * -1)
            ball:SetAngles(Front:Angle())
            ball.Harmless = false
            ball.Damage = dmg
            ball:Spawn()
            ball:Activate()
            ball:SetOwner(ply)

            local Physics = ball:GetPhysicsObject()
            if IsValid(Physics) then
                Physics:ApplyForceCenter(Front:Angle():Forward() * 25000)
            end
        end
    end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 100
TALENT.Name = "Space Stone"
TALENT.NameColor = Color(0, 50, 255)
TALENT.Description = "You have a %s_^ chance to have low gravity for %s seconds after killing someone with this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20}	-- Chance to trigger
TALENT.Modifications[2] = {min = 5 , max = 20}	-- Effect duration

TALENT.Melee = true
TALENT.NotUnique = false

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
		status.Inflict("Space Stone", {Time = sec, Player = att})
	end
end

if (SERVER) then
	local STATUS = status.Create "Space Stone"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Low Gravity", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Low Gravity":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Low Gravity"
	EFFECT.Message = "Low Gravity"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/arrow_up.png"
	function EFFECT:Init(data)
		local att = data.Player
		att:SetGravity(0.25)

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Player)) then return end

		local att = data.Player
		att:SetGravity(1)
	end
end

m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 23
TALENT.Suffix = 'the Speedforce'
TALENT.Name = 'Speedforce'
TALENT.NameColor = Color(255,255,0)
TALENT.Description = 'Speed is increased by %s_^ for %s seconds after killing a target'
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 15} -- speed percent
TALENT.Modifications[2] = {min = 5, max = 15} -- seconds

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath( victim, inf, attacker, talent_mods )
	local speed = 1 + ((self.Modifications[1].min + (( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1])))/100)
	local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))

	status.Inflict("Speedforce", {Time = sec, Player = attacker, Speed = speed})
end


if (SERVER) then
	local STATUS = status.Create "Speedforce"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Speedforce", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Speedforce":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Speedforce"
	EFFECT.Message = "Speedforce"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/group_go.png"
	function EFFECT:Init(data)
		local att = data.Player
		att.speedforce = data.Speed
		
		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Player)) then return end
		
		local att = data.Player
		att.speedforce = 1
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 2
TALENT.Name = "Stability"
TALENT.NameColor = Color( 0, 255, 0 )
TALENT.Description = "Kick is reduced by %s_"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = -15, max = -20 } -- Amount kick is reduced

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon(weapon, talent_mods)
	local Mod = self.Modifications[1]
	local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])
	weapon:SetKick(((1 + weapon:GetKick() / 100) * (1 + mult / 100) - 1) * 100)
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 37
TALENT.Suffix = "the Neighborhood"
TALENT.Name = 'Strength In Numbers'
TALENT.NameColor = Color(181, 123, 0)
TALENT.Description = "Damage is increased by %s_^ for every person within %s^ feet, your special teammates add %s_^ instead, up to a maximum of %s_^"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 25}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 2, max = 6} -- Normal damage increase
TALENT.Modifications[2] = {min = 20, max = 40} -- Range
TALENT.Modifications[3] = {min = 6, max = 10} -- Special teammate damage increase
TALENT.Modifications[4] = {min = 20, max = 35} -- Max damage increase

TALENT.Melee = true
TALENT.NotUnique = true

if (SERVER) then
	function TALENT:ScalePlayerDamage(victim, attacker, dmginfo, hitgroup, talent_mods)
		local extraDmg 	= (self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / 100
		local range 	=  self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
		range = range * range

		local bonusDmg 	= (self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * math.min(1, talent_mods[3]))) / 100
		local maxDmg 	=  self.Modifications[4].min + ((self.Modifications[4].max - self.Modifications[4].min) * math.min(1, talent_mods[4]))

		local dmg = 1
		local attPos = attacker:GetPos()
		local isTraitor = attacker:GetTraitor()
		local isDetective = attacker:GetDetective()
		-- It's faster to loop through all players then to find all ents in sphere
		for _, pl in ipairs(player.GetAll()) do
			if (not IsValid(pl)) then continue end
			if (not pl:Alive()) then continue end
			if (attPos:DistToSqr(pl:GetPos()) > range) then continue end
			
			local b = extraDmg
			if (isTraitor and pl:GetTraitor()) then
				b = bonusDmg
			elseif (isDetective and pl:GetDetective()) then
				b = bonusDmg
			end
			
			dmg = dmg + b
		end

		dmg = math.min(dmg, maxDmg)
		dmginfo:ScaleDamage(dmg)
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 5
TALENT.Name = "Sustained"
TALENT.NameColor = Color( 0, 150, 0 )
TALENT.Description = "Killing a target increases your health by %s"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 40 } -- Amount health is increased

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath( victim, inf, attacker, talent_mods )
	local health_to_add = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	attacker:SetHealth(math.Clamp(attacker:Health() + health_to_add, 0, attacker:GetMaxHealth()))
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 9
TALENT.Name = "Tesla"
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

		status.Inflict("Tesla", {
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
	local STATUS = status.Create "Tesla"
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
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 13
TALENT.Suffix = "the Trigger"
TALENT.Name = "Trigger Finger"
TALENT.NameColor = Color( 255, 51, 153 )
TALENT.Description = "Firerate is increased by %s_"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 7.99, max = 25 } -- Amount firerate is increased

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:ModifyWeapon(weapon, talent_mods)
	if (weapon.Primary.Delay) then
		local Mod = self.Modifications[1]
		local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])

		weapon:SetFirerate((1 - (1 - weapon:GetFirerate() / 100) * (1 - mult / 100)) * 100)
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 17
TALENT.Name = "Tug of War"
TALENT.NameColor = Color(200, 200, 200)
TALENT.Description = "Players have a %s_^ chance to be pulled with %sx force when shot with this weapon"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5 , max = 15}	-- Chance to pull
TALENT.Modifications[2] = {min = 10, max = 100}	-- Force of the pull

TALENT.Melee = true
TALENT.NotUnique = true

local angle180 = Angle(0, 180, 0)

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
    if (MOAT_ACTIVE_BOSS) then
        return
    end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        local force = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
        local v = attacker:GetAimVector()
        v:Rotate(angle180)
        victim:SetVelocity(v * (10 * force))
        victim.was_pushed = {
            att = attacker,
            t = CurTime() + 5,
            wep = attacker:GetActiveWeapon():GetClass()
        }
    end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT = TALENT or MOAT_TALENTS[16]

TALENT.ID = 16
TALENT.Name = "Vampiric"
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to steal %s_^ of the damage you deal"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40 , max = 60}	-- Chance to trigger
TALENT.Modifications[2] = {min = 25, max = 75}	-- Amount to heal

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, att, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local pct = (self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))) / 100

		att:SetHealth(math.Clamp(att:Health() + math.min(victim:Health(), dmginfo:GetDamage()) * pct, 0, att:GetMaxHealth()))
	end
end
m_AddTalent(TALENT)

TALENT = {}

TALENT.ID = 81
TALENT.Name = "Visionary"
TALENT.NameColor = Color(255, 255, 0)
TALENT.Description = "After killing a player, you have a %s_^ chance to see players within %s^ feet through walls for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 40}	-- Chance to trigger
TALENT.Modifications[2] = {min = 10, max = 100}	-- Player distance
TALENT.Modifications[3] = {min = 3 , max = 10}	-- Effect duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local feet = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
		local secs = self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * math.min(1, talent_mods[3]))

		status.Inflict("Visionary", {Time = secs, Player = att, Radius = feet})
	end
end


if (SERVER) then
	local STATUS = status.Create "Visionary"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Visionary", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Visionary":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Visionary"
	EFFECT.Message = "Visionary"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/eye.png"
	function EFFECT:Init(data)
		local att = data.Player

		net.Start("Moat.Talents.Visionary")
			net.WriteDouble(data.Radius)
		net.Send(att)

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Player)) then return end
		local att = data.Player

		net.Start("Moat.Talents.Visionary.End")
		net.Send(att)
	end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 610
TALENT.Suffix = "the LOS PANCHOS"
TALENT.Name = "Pepper"
TALENT.NameEffect = "threecolors"
TALENT.NameColor = Color(251,176,59)
TALENT.NameEffectMods = {Color(34,181,115), Color(237,28,36), Color(255,255,255)}
TALENT.Description = "Each shot has a %s_^ chance to shoot a pepper projectile dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 20}
TALENT.Modifications[2] = {min = 15, max = 45}
TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    -- if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local num = (wep.Primary and wep.Primary.NumShots) and wep.Primary.NumShots or 1
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * (100 * num)) then
        local ply = dmginfo.Attacker
        if (not IsValid(ply)) then return end

    	local dmg = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
        local Front = ply:GetAimVector()
        local Up = ply:EyeAngles():Up()
        local aimang = Front:Angle()
		local bulspread = vector_origin
		local conex = wep:GetPrimaryCone() or 0.01
		local coney = wep:GetPrimaryConeY() or conex
		local mult = Vector(coney, conex)
        local nlayers = ((wep.Primary and wep.Primary.LayerMults) and #wep.Primary.LayerMults or 1) + 3
        local class = wep:GetClass()

		if (wep.propshot and #wep.propshot > num) then
			for k, v in ipairs(wep.propshot) do
				if (IsValid(v)) then v:Remove() end
			end

			wep.propshot = {}
		end

		for i = 1, num do
        	local x, y = util.SharedRandom(class, -nlayers * 50, nlayers * 50, i) * conex / nlayers, util.SharedRandom(class, -nlayers * 50, nlayers * 50, i + 1) * coney / nlayers
       	 	local rspr = aimang:Right() * x + aimang:Up() * y
    		local dir = Front + rspr + bulspread.x * mult.x * aimang:Right() + bulspread.y * mult.y * aimang:Up()

			local ball = ents.Create "ent_propshot_pepper"
			if IsValid(ball) then
    			ball:SetTrailColor(Vector(237/255, 28/255, 36/255))
				ball:SetPos(ply:GetShootPos() + dir * 10 + Up * 10 * -1)
				ball:SetAngles(Front:Angle())
				ball.Harmless = false
				ball.Damage = dmg
				ball:Spawn()
				ball:Activate()
				ball:SetOwner(ply)

				local Physics = ball:GetPhysicsObject()
				if IsValid(Physics) then
					Physics:ApplyForceCenter(Front:Angle():Forward() * 25000)
				end

				if (not wep.propshot) then wep.propshot = {} end
				table.insert(wep.propshot, ball)
			end
		end
    end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 613
TALENT.Suffix = "the VINEGOD"
TALENT.Name = "Grapes"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(206,60,250)
TALENT.NameEffectMods = {Color(250,60,60)}
TALENT.Description = "Each shot has a %s_^ chance to shoot a grapes projectile dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 20}
TALENT.Modifications[2] = {min = 15, max = 45}
TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    -- if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local num = (wep.Primary and wep.Primary.NumShots) and wep.Primary.NumShots or 1
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * (100 * num)) then
        local ply = dmginfo.Attacker
        if (not IsValid(ply)) then return end

    	local dmg = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
        local Front = ply:GetAimVector()
        local Up = ply:EyeAngles():Up()
        local aimang = Front:Angle()
		local bulspread = vector_origin
		local conex = wep:GetPrimaryCone() or 0.01
		local coney = wep:GetPrimaryConeY() or conex
		local mult = Vector(coney, conex)
        local nlayers = ((wep.Primary and wep.Primary.LayerMults) and #wep.Primary.LayerMults or 1) + 3
        local class = wep:GetClass()

		if (wep.propshot and #wep.propshot > num) then
			for k, v in ipairs(wep.propshot) do
				if (IsValid(v)) then v:Remove() end
			end

			wep.propshot = {}
		end

		for i = 1, num do
        	local x, y = util.SharedRandom(class, -nlayers * 50, nlayers * 50, i) * conex / nlayers, util.SharedRandom(class, -nlayers * 50, nlayers * 50, i + 1) * coney / nlayers
       	 	local rspr = aimang:Right() * x + aimang:Up() * y
    		local dir = Front + rspr + bulspread.x * mult.x * aimang:Right() + bulspread.y * mult.y * aimang:Up()

			local ball = ents.Create "ent_propshot_grape"
			if IsValid(ball) then
				ball:SetTrailColor(Vector(237/255, 28/255, 36/255))
				ball:SetPos(ply:GetShootPos() + dir * 10 + Up * 10 * -1)
				ball:SetAngles(Front:Angle())
				ball.Harmless = false
				ball.Damage = dmg
				ball:Spawn()
				ball:Activate()
				ball:SetOwner(ply)

				local Physics = ball:GetPhysicsObject()
				if IsValid(Physics) then
					Physics:ApplyForceCenter(Front:Angle():Forward() * 25000)
				end

				if (not wep.propshot) then wep.propshot = {} end
				table.insert(wep.propshot, ball)
			end
		end
    end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 39
TALENT.Name = "Swift"
TALENT.NameColor = Color(102, 255, 255)
TALENT.Description = "Reloading is %s_ faster"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 25, max = 60}

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )
	local Mod = self.Modifications[1]
	local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])
	weapon:SetReloadrate(mult)
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 614
TALENT.Suffix = "the GELADO"
TALENT.Name = "Ice Cream"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(103,182,255)
TALENT.NameEffectMods = {Color(255,141,170)}
TALENT.Description = "Each shot has a %s_^ chance to shoot an ice cream tub projectile dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 20}
TALENT.Modifications[2] = {min = 15, max = 45}
TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    -- if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local num = (wep.Primary and wep.Primary.NumShots) and wep.Primary.NumShots or 1
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * (100 * num)) then
        local ply = dmginfo.Attacker
        if (not IsValid(ply)) then return end

    	local dmg = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))
        local Front = ply:GetAimVector()
        local Up = ply:EyeAngles():Up()
        local aimang = Front:Angle()
		local bulspread = vector_origin
		local conex = wep:GetPrimaryCone() or 0.01
		local coney = wep:GetPrimaryConeY() or conex
		local mult = Vector(coney, conex)
        local nlayers = ((wep.Primary and wep.Primary.LayerMults) and #wep.Primary.LayerMults or 1) + 3
        local class = wep:GetClass()

		if (wep.propshot and #wep.propshot > num) then
			for k, v in ipairs(wep.propshot) do
				if (IsValid(v)) then v:Remove() end
			end

			wep.propshot = {}
		end

		for i = 1, num do
        	local x, y = util.SharedRandom(class, -nlayers * 50, nlayers * 50, i) * conex / nlayers, util.SharedRandom(class, -nlayers * 50, nlayers * 50, i + 1) * coney / nlayers
       	 	local rspr = aimang:Right() * x + aimang:Up() * y
    		local dir = Front + rspr + bulspread.x * mult.x * aimang:Right() + bulspread.y * mult.y * aimang:Up()

			local ball = ents.Create "ent_propshot_icecream"
			if IsValid(ball) then
				ball:SetTrailColor(Vector(237/255, 28/255, 36/255))
				ball:SetPos(ply:GetShootPos() + dir * 10 + Up * 10 * -1)
				ball:SetAngles(Front:Angle())
				ball.Harmless = false
				ball.Damage = dmg
				ball:Spawn()
				ball:Activate()
				ball:SetOwner(ply)

				local Physics = ball:GetPhysicsObject()
				if IsValid(Physics) then
					Physics:ApplyForceCenter(Front:Angle():Forward() * 25000)
				end

				if (not wep.propshot) then wep.propshot = {} end
				table.insert(wep.propshot, ball)
			end
		end
    end
end
m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 40
TALENT.Name = "Mute"
TALENT.NameColor = Color(27, 27, 27)
TALENT.Description = "Each hit has a %s_^ chance to mute the target for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 }	-- Chance to mute
TALENT.Modifications[2] = { min = 4, max = 8 }	-- Mute time

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
	if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	if (chance > math.random() * 100) then
		status.Inflict("Muted", {
			Victim = victim,
			Time = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )
		})
	end
end

if (SERVER) then
	local STATUS = status.Create "Muted"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Muted", data.Victim)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Muted":Invoke(data, data.Time, data.Victim)
		end
	end

	local EFFECT = STATUS:CreateEffect "Muted"
	EFFECT.Message = "Muted"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/sound_mute.png"
	function EFFECT:Init(data)
		local victim = data.Victim

		victim.Talent_Muted = true
		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Victim)) then return end
		local victim = data.Victim

		victim.Talent_Muted = nil
	end
	end

m_AddTalent(TALENT)

TALENT = {}
TALENT.ID = 41
TALENT.Name = "Backstab"
TALENT.NameColor = Color(255, 83, 73)
TALENT.Description = "Damage is increased by %s_ when attacking someone from behind"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 15, max = 30}

TALENT.Melee = true
TALENT.MeleeOnly = true
TALENT.NotUnique = true

-- Ported from https://gist.github.com/sigsegv-mvm/bda5c53af428878af6889635cd787332
local function IsBehindAndFacingTarget(vic, att)
	if (not IsValid(vic) or not IsValid(att)) then return false end

	local wsc_att_to_vic = vic:WorldSpaceCenter() - att:WorldSpaceCenter()
	wsc_att_to_vic.y = 0
	wsc_att_to_vic:Normalize()

	local eye_att = att:GetAimVector()
	eye_att.y = 0
	eye_att:Normalize()

	local eye_vic = vic:GetAimVector()
	eye_vic.y = 0
	eye_vic:Normalize()

	if (wsc_att_to_vic:Dot(eye_vic) <=  0.0) then return false end
	if (wsc_att_to_vic:Dot(eye_att) <=  0.5) then return false end
	if (eye_att:Dot(eye_vic) <= -0.3) then return false end

	return true
end

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (IsBehindAndFacingTarget(victim, attacker)) then
		local increase = 1 + ((self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])) / 100)
		dmginfo:ScaleDamage(increase)
	end
end


m_AddTalent(TALENT)