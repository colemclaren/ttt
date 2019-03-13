local Talent = mi.Talent.Register
------------------------------------
--
-- 	Inventory Item Talents
--	
------------------------------------

--
--		Built by Lua on Feb 10, 2019 at 15:26:50 PST
--

------------------------------------
--
-- Close Quarters by ???
--
------------------------------------

Talent(1, 'Close Quarters', 1)
	:SetDesc 'Damage is increased by +%s_^ when closer than %s feet to the target'
	:SetColor {0, 255, 255}
	:Mod {'1', 5, 10}
	:Mod {'2', 8, 13}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Stability by ???
--
------------------------------------

Talent(2, 'Stability', 2)
	:SetDesc 'Kick is reduced by %s_'
	:SetColor {0, 255, 0}
	:Mod {'1', -15, -20}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Inferno by ???
--
------------------------------------

Talent(3, 'Inferno', 3)
	:SetDesc 'Each hit has a %s_^ chance to ignite the target for %s seconds and apply 1 damage every 0.2 seconds'
	:SetColor {255, 0, 0}
	:SetStyle 'fire'
	:Mod {'1', 5, 10}
	:Mod {'2', 4, 8}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Accurate by ???
--
------------------------------------

Talent(4, 'Accurate', 1)
	:SetDesc 'Accuracy is increased by %s_'
	:SetColor {150, 0, 0}
	:Mod {'1', 15, 25}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Sustained by ???
--
------------------------------------

Talent(5, 'Sustained', 2)
	:SetDesc 'Killing a target increases your health by %s_ if not max health'
	:SetColor {0, 150, 0}
	:Mod {'1', 15, 40}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Brutal by ???
--
------------------------------------

Talent(6, 'Brutal', 1)
	:SetDesc 'Headshot damage is increased by %s_ when using this weapon'
	:SetColor {255, 0, 0}
	:Mod {'1', 11, 25}
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Extended Mag by ???
--
------------------------------------

Talent(7, 'Extended Mag', 2)
	:SetDesc 'Max ammo capacity is increased by %s_'
	:SetColor {255, 128, 0}
	:Mod {'1', 10, 35}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Adrenaline Rush by ???
--
------------------------------------

Talent(8, 'Adrenaline Rush', 1)
	:SetDesc 'Damage is increased by %s_^ for %s seconds after killing with this weapon'
	:SetColor {255, 0, 0}
	:Mod {'1', 5, 15}
	:Mod {'2', 3, 7}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Tesla by ???
--
------------------------------------

Talent(9, 'Tesla', 3)
	:SetDesc 'Each hit has a {chance}% chance to zap the target {reps} times for {dmg} damage every {delay} seconds.'
	:SetColor {0, 255, 255}
	:SetStyle 'electric'
	:Mod {'chance', 5, 10}
	:Mod {'reps', 5, 10}
	:Mod {'dmg', 3, 5}
	:Mod {'delay', 3, 6}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		if (GetRoundState() ~= ROUND_ACTIVE or vic:HasGodMode()) then
			return
		end
		
		local chance = mods['chance']
		if (chance < math.random() * 100) then
			return
		end

		status.Inflict("Tesla", {
			Player = vic,
			Attacker = att,
			Weapon = att:GetActiveWeapon(),
			Damage = mods['dmg'],
			Time = mods['reps'] * mods['delay'],
			Amount = mods['reps']
		})
	end}
	:CanMelee(true)


------------------------------------
--
-- Frost by ???
--
------------------------------------

Talent(10, 'Frost', 3)
	:SetDesc 'Each hit has a %s_^ chance to freeze the target for %s seconds, slowing their speed by ^%s_ percent, and applying 2 damage every ^%s seconds'
	:SetColor {100, 100, 255}
	:SetStyle 'frost'
	:Mod {'1', 5, 10}
	:Mod {'2', 15, 30}
	:Mod {'3', 25, 50}
	:Mod {'4', 5, 8}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Meticulous by ???
--
------------------------------------

Talent(11, 'Meticulous', 2)
	:SetDesc 'After killing a target with this weapon, the magazine has a %s_^ chance to refill completely'
	:SetColor {205, 127, 50}
	:Mod {'1', 10, 30}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Provident by ???
--
------------------------------------

Talent(12, 'Provident', 1)
	:SetDesc 'Each bullet has a 20_ chance to do %s_^ more damage'
	:SetColor {0, 123, 181}
	:Mod {'1', 15, 25}
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}


------------------------------------
--
-- Trigger Finger by ???
--
------------------------------------

Talent(13, 'Trigger Finger', 1)
	:SetDesc 'Firerate is increased by %s_'
	:SetColor {255, 51, 153}
	:Mod {'1', 8, 25.01}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Prepared by ???
--
------------------------------------

Talent(14, 'Prepared', 2)
	:SetDesc 'Damage is increased by %s_^ when more than %s feet from the target'
	:SetColor {41, 171, 135}
	:Mod {'1', 5, 10}
	:Mod {'2', 25, 40}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Vampiric by ???
--
------------------------------------

Talent(16, 'Vampiric', 2)
	:SetDesc 'Each hit has a %s_^ chance to steal %s_^ of the damage you deal'
	:SetColor {0, 255, 0}
	:Mod {'1', 20, 40}
	:Mod {'2', 15, 30}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Tug of War by ???
--
------------------------------------

Talent(17, 'Tug of War', 3)
	:SetDesc 'Players have a %s_^ chance to be pulled with %sx force when shot with this weapon'
	:SetColor {200, 200, 200}
	:Mod {'1', 5, 15}
	:Mod {'2', 10, 100}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Assassin by ???
--
------------------------------------

Talent(19, 'Assassin', 2)
	:SetDesc 'Each kill has a %s_^ chance to dissolve the body of the person you killed'
	:SetColor {50, 50, 255}
	:Mod {'1', 10, 25}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Contagious by ???
--
------------------------------------

Talent(20, 'Contagious', 3)
	:SetDesc 'Each hit has a %s_^ chance to infect and damage the target %s^ times for %s^ damage every %s^ seconds'
	:SetColor {0, 150, 0}
	:SetStyle 'glow'
	:Mod {'1', 5, 10}
	:Mod {'2', 5, 10}
	:Mod {'3', 3, 5}
	:Mod {'4', 3, 6}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Desperate Times by ???
--
------------------------------------

Talent(21, 'Desperate Times', 1)
	:SetDesc 'Your weapon will do %s_^ more damage if you are under %s health'
	:SetColor {255, 99, 71}
	:Mod {'1', 5, 20}
	:Mod {'2', 25, 75}
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Medicality by ???
--
------------------------------------

Talent(22, 'Medicality', 2)
	:SetDesc 'While wielding this weapon, you will gain 1 health every %s second(s)'
	:SetColor {0, 255, 0}
	:Mod {'1', 1, 3}
	:Hook {'OnWeaponSwitch', function(pl, wep, isto, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Speedforce by ???
--
------------------------------------

Talent(23, 'Speedforce', 2)
	:SetDesc 'Speed is increased by %s_^ for %s seconds after killing a target'
	:SetColor {255, 255, 0}
	:Mod {'1', 5, 15}
	:Mod {'2', 5, 15}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Lightweight by ???
--
------------------------------------

Talent(24, 'Lightweight', 1)
	:SetDesc 'Weight is reduced by %s_^'
	:SetColor {175, 238, 238}
	:Mod {'1', -5, -15}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Wildcard: Tier 1 by ???
--
------------------------------------

Talent(31, 'Wildcard: Tier 1', 1, false)
	:SetDesc 'When this talent is unlocked, it will morph into a different talent every round'
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Wildcard: Tier 2 by ???
--
------------------------------------

Talent(32, 'Wildcard: Tier 2', 2, false)
	:SetDesc 'When this talent is unlocked, it will morph into a different talent every round'
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Wildcard: Tier 3 by ???
--
------------------------------------

Talent(33, 'Wildcard: Tier 3', 3, false)
	:SetDesc 'When this talent is unlocked, it will morph into a different talent every round'
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetLevels {20, 30}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- *click* by ???
--
------------------------------------

Talent(9969, '*click*', 2, false)
	:SetDesc 'This gun has one bullet. Damage is increased %s_^'
	:SetColor {255, 119, 0}
	:SetLevels {0, 0}
	:Mod {'1', 25, 75}
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Leech by ???
--
------------------------------------

Talent(155, 'Leech', 3)
	:SetDesc 'Each hit has a %s_^ chance to heal %s^ health over %s seconds'
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:Mod {'1', 5, 15}
	:Mod {'2', 15, 40}
	:Mod {'3', 30, 50}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Dog Lover by ???
--
------------------------------------

Talent(154, 'Dog Lover', 2, false)
	:SetDesc 'Each hit has a %s_^ chance to overwehlm the target with pictures of an adorable dog for %s seconds'
	:SetColor {255, 0, 127}
	:Mod {'1', 5, 10}
	:Mod {'2', 5, 10}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Dragonborn by ???
--
------------------------------------

Talent(83, 'Dragonborn', 3)
	:SetDesc 'Players have a %s_^ chance to be thrown with %sx force when shot with this weapon'
	:SetColor {255, 255, 255}
	:Mod {'1', 5, 15}
	:Mod {'2', 10, 100}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Meme Lover by ???
--
------------------------------------

Talent(9970, 'Meme Lover', 2)
	:SetDesc 'Each hit has a %s_^ chance to overwehlm the target with pictures of a meme for %s seconds'
	:SetColor {255, 0, 127}
	:SetLevels {0, 0}
	:Mod {'1', 5, 10}
	:Mod {'2', 2, 5}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Scavenger by ???
--
------------------------------------

Talent(82, 'Scavenger', 2)
	:SetDesc 'Players have a %s_^ chance to drop %s primary ammo (or until filled) if killed with this weapon'
	:SetColor {178, 102, 255}
	:Mod {'1', 20, 50}
	:Mod {'2', 5, 30}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Silenced by ???
--
------------------------------------

Talent(9040, 'Silenced', 1)
	:SetDesc 'Each round, your weapon has a %s_^ chance to become silenced'
	:SetColor {0, 255, 0}
	:Mod {'1', 100, 200}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Center Mass by ???
--
------------------------------------

Talent(85, 'Center Mass', 1)
	:SetDesc 'Torso damage is increased by %s_ when using this weapon'
	:SetColor {255, 0, 0}
	:Mod {'1', 15, 30}
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Space Stone by ???
--
------------------------------------

Talent(100, 'Space Stone', 1, false)
	:SetDesc 'You have a %s_^ chance to have low gravity for %s seconds after killing someone with this weapon'
	:SetColor {0, 50, 255}
	:Mod {'1', 10, 20}
	:Mod {'2', 5, 20}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Snowball by ???
--
------------------------------------

Talent(990, 'Snowball', 2, false)
	:SetDesc 'Each shot has a %s_^ chance to shoot a snowball projectile dealing %s damage'
	:SetColor {100, 255, 255}
	:Mod {'1', 5, 20}
	:Mod {'2', 10, 55}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


------------------------------------
--
-- Explosive by ???
--
------------------------------------

Talent(87, 'Explosive', 2)
	:SetDesc 'Every quarter second of firing, this gun has a %s_^ chance to fire an explosive round dealing %s damage'
	:SetColor {255, 128, 0}
	:Mod {'1', 21, 40}
	:Mod {'2', 13.37, 42}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


------------------------------------
--
-- Power Stone by ???
--
------------------------------------

Talent(102, 'Power Stone', 3, false)
	:SetDesc 'Each shot has a %s_^ chance to deal double damage'
	:SetColor {128, 0, 128}
	:Mod {'1', 1, 5}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Deep Fried by ???
--
------------------------------------

Talent(9968, 'Deep Fried', 2, false)
	:SetDesc 'Each hit has a %s_^ chance to deep fry your victim\'s vision for %s seconds'
	:SetColor {209, 0, 209}
	:SetLevels {13, 16}
	:Mod {'1', 30, 50}
	:Mod {'2', 0.2, 1}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Fracture by ???
--
------------------------------------

Talent(86, 'Fracture', 1)
	:SetDesc 'Limb damage is increased by %s_ when using this weapon'
	:SetColor {255, 0, 0}
	:Mod {'1', 15, 30}
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Copycat by ???
--
------------------------------------

Talent(9030, 'Copycat', 1, false)
	:SetDesc 'Every kill with this weapon has a %s_^ chance to copy the stats of the weapon from who you killed, it also stacks talents'
	:SetColor {255, 0, 0}
	:SetStyle 'enchanted'
	:Mod {'1', 25, 50}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Predatory by ???
--
------------------------------------

Talent(88, 'Predatory', 2)
	:SetDesc 'Killing a target regenerates %s_^ health over %s seconds'
	:SetColor {0, 255, 128}
	:Mod {'1', 10, 35}
	:Mod {'2', 10, 35}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Visionary by ???
--
------------------------------------

Talent(81, 'Visionary', 2)
	:SetDesc 'After killing a player, you have a %s_^ chance to see players within %s^ feet through walls for %s seconds'
	:SetColor {255, 255, 0}
	:Mod {'1', 10, 40}
	:Mod {'2', 10, 100}
	:Mod {'3', 3, 10}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Reality Stone by ???
--
------------------------------------

Talent(101, 'Reality Stone', 2, false)
	:SetDesc 'You have a %s_^ chance to go transparent for %s seconds after killing someone with this weapon'
	:SetColor {255, 50, 50}
	:Mod {'1', 10, 20}
	:Mod {'2', 5, 20}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}
	:CanMelee(true)


------------------------------------
--
-- Boston Basher by ???
--
------------------------------------

Talent(69, 'Boston Basher', 1, false)
	:SetDesc 'Damage is increased by %s_^, unless you miss. Which makes you hit yourself instead'
	:SetColor {255, 0, 0}
	:SetStyle 'enchanted'
	:Mod {'1', 15, 30}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


