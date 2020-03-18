--
--		Built by Lua on Feb 13, 2020 at 22:24:12 PST
--
------------------------------------
--
-- Bompton by ???
--
------------------------------------

Talent(1, 'Bompton', 1)
	:SetColor {0, 255, 255}
	:SetDesc 'Damage is increased by +%s_^ when closer than %s feet to the target.'
	:Mod {'1', 10, 20}
	:Mod {'2', 8, 13}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Stability by ???
--
------------------------------------

Talent(2, 'Stability', 2)
	:SetColor {0, 255, 0}
	:SetDesc 'Kick is reduced by %s_.'
	:Mod {'1', -15, -20}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Phoenix by ???
--
------------------------------------

Talent(3, 'Phoenix', 3)
	:SetColor {255, 0, 0}
	:SetStyle 'fire'
	:SetDesc 'Each hit has a %s_^ chance to ignite the target for %s seconds and apply 1 damage every 0.2 seconds.'
	:Mod {'1', 5, 10}
	:Mod {'2', 2, 10}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Accuracy by ???
--
------------------------------------

Talent(4, 'Accuracy', 1)
	:SetColor {150, 0, 0}
	:SetDesc 'Cone is increased by %s_.'
	:Mod {'1', 15, 25}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Sustained by ???
--
------------------------------------

Talent(5, 'Sustained', 2)
	:SetColor {0, 150, 0}
	:SetDesc 'Killing a target increases your health by %s.'
	:Mod {'1', 15, 40}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Brutality by ???
--
------------------------------------

Talent(6, 'Brutality', 1)
	:SetColor {255, 0, 0}
	:SetDesc 'Headshot damage is increased by %s_ when using this weapon.'
	:Mod {'1', 11, 25}
	:CanMelee (true)
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}


------------------------------------
--
-- Heavy by ???
--
------------------------------------

Talent(7, 'Heavy', 2)
	:SetColor {255, 128, 0}
	:SetDesc 'Max ammo capacity is increased by %s_.'
	:Mod {'1', 15, 40}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Steroids by ???
--
------------------------------------

Talent(8, 'Steroids', 1)
	:SetColor {255, 0, 0}
	:SetDesc 'Damage is increased by %s_^ for %s seconds after killing with this weapon.'
	:Mod {'1', 5, 15}
	:Mod {'2', 9, 12}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Electricity by ???
--
------------------------------------

Talent(9, 'Electricity', 3)
	:SetColor {0, 255, 255}
	:SetStyle 'electric'
	:SetDesc 'Each hit has a %s_^ chance to zap the target %s^ times for %s^ damage every %s^ seconds.'
	:Mod {'1', 5, 10}
	:Mod {'2', 5, 10}
	:Mod {'3', 3, 5}
	:Mod {'4', 3, 6}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Frost by ???
--
------------------------------------

Talent(10, 'Frost', 3)
	:SetColor {100, 100, 255}
	:SetStyle 'frost'
	:SetDesc 'Each hit has a %s_^ chance to freeze the target for %s seconds, slowing their speed by ^%s_ percent, and applying 2 damage every ^%s seconds.'
	:Mod {'1', 5, 15}
	:Mod {'2', 15, 30}
	:Mod {'3', 25, 50}
	:Mod {'4', 5, 8}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Meticulous by ???
--
------------------------------------

Talent(11, 'Meticulous', 2)
	:SetColor {205, 127, 50}
	:SetDesc 'After killing a target with this weapon, the magazine has a %s_^ chance to refill completely.'
	:Mod {'1', 10, 30}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Power by ???
--
------------------------------------

Talent(12, 'Power', 1)
	:SetColor {0, 123, 181}
	:SetDesc 'Each bullet has a 40_ chance to do %s_^ more damage.'
	:Mod {'1', 15, 30}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Trigger by ???
--
------------------------------------

Talent(13, 'Trigger', 1)
	:SetColor {255, 51, 153}
	:SetDesc 'Firerate is increased by %s_.'
	:Mod {'1', 7.99, 25}
	:CanMelee (true)
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Prepared by ???
--
------------------------------------

Talent(14, 'Prepared', 2)
	:SetColor {41, 171, 135}
	:SetDesc 'Damage is increased by %s_^ when more than %s feet from the target.'
	:Mod {'1', 10, 20}
	:Mod {'2', 25, 40}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Vampiric by ???
--
------------------------------------

Talent(16, 'Vampiric', 2)
	:SetColor {0, 255, 0}
	:SetDesc 'Each hit has a %s_^ chance to steal %s_^ of the damage you deal.'
	:Mod {'1', 40, 60}
	:Mod {'2', 25, 75}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Newton by ???
--
------------------------------------

Talent(17, 'Newton', 3)
	:SetColor {200, 200, 200}
	:SetDesc 'Players have a %s_^ chance to be pulled with %sx force when shot with this weapon.'
	:Mod {'1', 5, 15}
	:Mod {'2', 10, 100}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Assassin by ???
--
------------------------------------

Talent(19, 'Assassin', 2)
	:SetColor {50, 50, 255}
	:SetDesc 'Each kill has a %s_^ chance to dissolve the body of the person you killed.'
	:Mod {'1', 10, 25}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Contagious by ???
--
------------------------------------

Talent(20, 'Contagious', 3)
	:SetColor {0, 150, 0}
	:SetStyle 'glow'
	:SetDesc 'Each hit has a %s_^ chance to infect and damage the target %s^ times for %s^ damage every %s^ seconds.'
	:Mod {'1', 5, 10}
	:Mod {'2', 5, 10}
	:Mod {'3', 3, 5}
	:Mod {'4', 3, 6}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Despair by ???
--
------------------------------------

Talent(21, 'Despair', 1)
	:SetColor {255, 99, 71}
	:SetDesc 'Your weapon will do %s_^ more damage if you are under %s health.'
	:Mod {'1', 10, 40}
	:Mod {'2', 25, 75}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Medicality by ???
--
------------------------------------

Talent(22, 'Medicality', 2)
	:SetColor {0, 255, 0}
	:SetDesc 'While wielding this weapon, you will gain 1 health every %s second(s).'
	:Mod {'1', 1, 3}
	:CanMelee (true)
	:Hook {'OnWeaponSwitch', function(pl, wep, isto, mods)
		
	end}


------------------------------------
--
-- Speedforce by ???
--
------------------------------------

Talent(23, 'Speedforce', 2)
	:SetColor {255, 255, 0}
	:SetDesc 'Speed is increased by %s_^ for %s seconds after killing a target.'
	:Mod {'1', 5, 15}
	:Mod {'2', 5, 15}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Feather by ???
--
------------------------------------

Talent(24, 'Feather', 1)
	:SetColor {175, 238, 238}
	:SetDesc 'Weight is reduced by %s_^.'
	:Mod {'1', -5, -15}
	:CanMelee (true)
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Cough by ???
--
------------------------------------

Talent(25, 'Cough', 2, false)
	:SetColor {255, 0, 127}
	:SetDesc 'Each hit has a %s_^ chance to make your target cough with a power of %s^.'
	:Mod {'1', 10, 25}
	:Mod {'2', 50, 100}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Fortification by ???
--
------------------------------------

Talent(26, 'Fortification', 2)
	:SetColor {200, 200, 200}
	:SetDesc 'After killing a player, you have a %s_^ chance to receive a %s_^ damage reduction for %s^ seconds.'
	:Mod {'1', 50, 80}
	:Mod {'2', 5, 10}
	:Mod {'3', 5, 20}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Infra-Sight by ???
--
------------------------------------

Talent(27, 'Infra-Sight', 2)
	:SetColor {255, 255, 0}
	:SetDesc 'Each hit has a %s_^ chance to allow a heat signature on your target for %s seconds. This enhanced vision is shared with your teammates.'
	:Mod {'1', 10, 35}
	:Mod {'2', 5, 25}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Debility by ???
--
------------------------------------

Talent(28, 'Debility', 3)
	:SetColor {100, 90, 100}
	:SetDesc 'Each hit has a %s_^ chance to make your target take %s_^ more damage for %s^ seconds.'
	:SetLevels (25, 35)
	:Mod {'1', 15, 30}
	:Mod {'2', 10, 15}
	:Mod {'3', 1, 5}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Penetration by ???
--
------------------------------------

Talent(29, 'Penetration', 1)
	:SetColor {255, 0, 0}
	:SetDesc 'Detectives and traitors under armor equipment are defenseless to bullets.'
	:Mod {'1', 40, 60}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Wildcard: Tier 1 by ???
--
------------------------------------

Talent(31, 'Wildcard: Tier 1', 1, false)
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetDesc 'When this talent is unlocked, it will morph into a different talent every round.'
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Wildcard: Tier 2 by ???
--
------------------------------------

Talent(32, 'Wildcard: Tier 2', 2, false)
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetDesc 'When this talent is unlocked, it will morph into a different talent every round.'
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Wildcard: Tier 3 by ???
--
------------------------------------

Talent(33, 'Wildcard: Tier 3', 3, false)
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetDesc 'When this talent is unlocked, it will morph into a different talent every round.'
	:SetLevels (20, 30)
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Wild! - Tier 1 by ???
--
------------------------------------

Talent(34, 'Wild! - Tier 1', 1, false)
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetDesc 'After a kill, you have a %s_^ chance to add a random Tier 1 talent to your gun with its lowest stats possible.'
	:SetLevels (-5, -10)
	:Mod {'1', 40, 70}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Wild! - Tier 2 by ???
--
------------------------------------

Talent(35, 'Wild! - Tier 2', 2, false)
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetDesc 'After a kill, you have a %s_^ chance to add a random Tier 2 talent to your gun with its lowest stats possible.'
	:SetLevels (-15, -20)
	:Mod {'1', 40, 65}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Wild! - Tier 3 by ???
--
------------------------------------

Talent(36, 'Wild! - Tier 3', 3, false)
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetDesc 'After a kill, you have a %s_^ chance to add a random Tier 3 talent to your gun with its lowest stats possible.'
	:SetLevels (-20, -30)
	:Mod {'1', 40, 60}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Neighborhood by ???
--
------------------------------------

Talent(37, 'Neighborhood', 2)
	:SetColor {181, 123, 0}
	:SetDesc 'Damage is increased by %s_^ for every person within %s^ feet, your special teammates add %s_^ instead, up to a maximum of %s_^.'
	:SetLevels (15, 25)
	:Mod {'1', 2, 6}
	:Mod {'2', 20, 40}
	:Mod {'3', 6, 10}
	:Mod {'4', 20, 35}
	:CanMelee (true)
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}


------------------------------------
--
-- Boston Basher by ???
--
------------------------------------

Talent(69, 'Boston Basher', 1, false)
	:SetColor {255, 0, 0}
	:SetStyle 'enchanted'
	:SetDesc 'Damage is increased by %s_^, unless you miss. Which makes you hit yourself instead, you silly sod.'
	:Mod {'1', 20, 40}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


------------------------------------
--
-- Visionary by ???
--
------------------------------------

Talent(81, 'Visionary', 2)
	:SetColor {255, 255, 0}
	:SetDesc 'After killing a player, you have a %s_^ chance to see players within %s^ feet through walls for %s seconds.'
	:Mod {'1', 10, 40}
	:Mod {'2', 10, 100}
	:Mod {'3', 3, 10}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Vulture by ???
--
------------------------------------

Talent(82, 'Vulture', 2)
	:SetColor {178, 102, 255}
	:SetDesc 'Players have a %s_^ chance to receive %s ammo after killing a target.'
	:Mod {'1', 20, 50}
	:Mod {'2', 5, 30}
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- DRAGON by ???
--
------------------------------------

Talent(83, 'DRAGON', 3)
	:SetColor {255, 255, 255}
	:SetDesc 'Players have a %s_^ chance to be thrown with %sx force when shot with this weapon.'
	:Mod {'1', 5, 15}
	:Mod {'2', 10, 100}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Focus by ???
--
------------------------------------

Talent(85, 'Focus', 1)
	:SetColor {255, 0, 0}
	:SetDesc 'Torso damage is increased by %s_ when using this weapon.'
	:Mod {'1', 15, 30}
	:CanMelee (true)
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}


------------------------------------
--
-- Fracture by ???
--
------------------------------------

Talent(86, 'Fracture', 1)
	:SetColor {255, 0, 0}
	:SetDesc 'Limb damage is increased by %s_ when using this weapon.'
	:Mod {'1', 15, 30}
	:CanMelee (true)
	:Hook {'ScalePlayerDamage', function(vic, att, info, hit, mods)
		
	end}


------------------------------------
--
-- BOOM by ???
--
------------------------------------

Talent(87, 'BOOM', 2)
	:SetColor {255, 128, 0}
	:SetDesc 'Every second of firing, this gun will fire %s^ explosive rounds dealing %s damage.'
	:Mod {'1', 0.84, 1.2}
	:Mod {'2', 13.37, 42}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


------------------------------------
--
-- Zombie by ???
--
------------------------------------

Talent(88, 'Zombie', 2)
	:SetColor {0, 255, 128}
	:SetDesc 'Killing a target regenerates %s_^ health over %s seconds.'
	:Mod {'1', 10, 35}
	:Mod {'2', 10, 35}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Twins by ???
--
------------------------------------

Talent(98, 'Twins', 1, false)
	:SetColor {240, 10, 10}
	:SetStyle 'bounce'
	:SetDesc 'You have two guns. Your damage is decreased by %s_^.'
	:SetLevels (0, 0)
	:Mod {'1', 20, 30}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Refilling by ???
--
------------------------------------

Talent(99, 'Refilling', 2)
	:SetColor {0, 255, 122}
	:SetStyle 'enchanted'
	:SetDesc 'Your gun has a %s_^ chance to refill a bullet if you hit someone.'
	:SetLevels (15, 19)
	:Mod {'1', 40, 80}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


------------------------------------
--
-- Space by ???
--
------------------------------------

Talent(100, 'Space', 1, false)
	:SetColor {0, 50, 255}
	:SetDesc 'You have a %s_^ chance to have low gravity for %s seconds after killing someone with this weapon.'
	:Mod {'1', 10, 20}
	:Mod {'2', 5, 20}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Reality by ???
--
------------------------------------

Talent(101, 'Reality', 2, false)
	:SetColor {255, 50, 50}
	:SetDesc 'You have a %s_^ chance to go transparent for %s seconds after killing someone with this weapon.'
	:Mod {'1', 10, 20}
	:Mod {'2', 5, 20}
	:CanMelee (true)
	:Hook {'OnPlayerDeath', function(vic, inf, att, mods)
		
	end}


------------------------------------
--
-- Power Stone by ???
--
------------------------------------

Talent(102, 'Power Stone', 3, false)
	:SetColor {128, 0, 128}
	:SetDesc 'Each shot has a %s_^ chance to deal double damage.'
	:Mod {'1', 1, 5}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Juan by ???
--
------------------------------------

Talent(9969, 'Juan', 2, false)
	:SetColor {255, 119, 0}
	:SetDesc 'Damage is increased by %s_^ but you only have 1 bullet per clip.'
	:SetLevels (1, 1)
	:Mod {'1', 25, 75}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Lich by ???
--
------------------------------------

Talent(155, 'Lich', 3)
	:SetColor {0, 255, 0}
	:SetStyle 'enchanted'
	:SetDesc 'Each hit has a %s_^ chance to heal %s^ health over %s seconds.'
	:Mod {'1', 5, 15}
	:Mod {'2', 15, 40}
	:Mod {'3', 30, 50}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Dog Lover by ???
--
------------------------------------

Talent(154, 'Dog Lover', 2, false)
	:SetColor {255, 0, 127}
	:SetDesc 'Each hit has a %s_^ chance to overwehlm the target with pictures of an adorable dog for %s seconds.'
	:Mod {'1', 5, 10}
	:Mod {'2', 5, 10}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- PEW by ???
--
------------------------------------

Talent(10102, 'PEW', 1, false)
	:SetColor {255, 119, 0}
	:SetDesc 'Damage is increased by %s_^ for each consecutive hit, up to a maximum of %s_^.'
	:SetLevels (8, 10)
	:Mod {'1', 4, 8}
	:Mod {'2', 35, 45}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


------------------------------------
--
-- LSD by ???
--
------------------------------------

Talent(9968, 'LSD', 2, false)
	:SetColor {209, 0, 209}
	:SetDesc 'Each hit has a %s_^ chance to fry the target\'s screen for %s seconds.'
	:Mod {'1', 5, 10}
	:Mod {'2', 5, 20}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- Copycat by ???
--
------------------------------------

Talent(9030, 'Copycat', 1, false)
	:SetColor {255, 0, 0}
	:SetStyle 'enchanted'
	:SetDesc 'Every kill with this weapon has a %s_^ chance to copy the stats of the weapon from who you killed, it also stacks talents.'
	:Mod {'1', 25, 50}
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


------------------------------------
--
-- PAINTBALLS by ???
--
------------------------------------

Talent(10103, 'PAINTBALLS', 1, false)
	:SetColor {255, 119, 0}
	:SetDesc 'Removes all body part multipliers. Increases damage by %s_^.'
	:SetLevels (8, 10)
	:Mod {'1', -5, 5}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- SNOWBALLS by ???
--
------------------------------------

Talent(990, 'SNOWBALLS', 2, false)
	:SetColor {100, 255, 255}
	:SetDesc 'Each shot has a %s_^ chance to shoot a snowball projectile dealing %s damage.'
	:Mod {'1', 5, 20}
	:Mod {'2', 10, 55}
	:Hook {'OnWeaponFired', function(att, wep, dmginfo, mods, is_bow, hit_pos)
		
	end}


------------------------------------
--
-- Depression by ???
--
------------------------------------

Talent(9040, 'Depression', 1)
	:SetColor {0, 255, 0}
	:SetDesc 'Every shot is silenced.'
	:Mod {'1', 100, 200}
	:Hook {'ModifyWeapon', function(wep, mods)
		
	end}


------------------------------------
--
-- Acid Test by ???
--
------------------------------------

Talent(9971, 'Acid Test', 1, false)
	:SetColor {209, 0, 209}
	:SetDesc 'Each hit has a %s_^ chance to fry the target\'s screen for %s seconds.'
	:SetLevels (1, 1)
	:Mod {'1', 25, 50}
	:CanMelee (true)
	:Hook {'OnPlayerHit', function(vic, att, dmginfo, mods)
		
	end}


