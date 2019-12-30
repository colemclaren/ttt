
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
		weapon.Primary.Damage = weapon.Primary.Damage * (1 + ((self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])) / 100))
	end
end