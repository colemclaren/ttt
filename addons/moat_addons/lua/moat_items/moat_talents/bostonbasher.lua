
TALENT.ID = 69

TALENT.Name = "Boston Basher"

TALENT.NameColor = Color( 255, 0, 0 )

TALENT.Description = "Damage is increased by %s_^, unless you miss. Which makes you hit yourself instead"

TALENT.Tier = 1

TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}

TALENT.Modifications[1] = { min = 15, max = 30 } // Percent damage is increased by

TALENT.Melee = false

TALENT.NotUnique = false

function TALENT:OnWeaponFired(attacker, dmginfo, talent_mods, is_bow, hit_pos)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end

	dmginfo.Callback = function(att, tr, dmginfo)
		if not IsValid(tr.Entity) then
			local dmg = att:GetActiveWeapon().Primary.Damage
			att:TakeDamage(dmg, att, att:GetActiveWeapon())
			att:SendLua([[surface.PlaySound("common/warning.wav")]])
		end
	end
end

function TALENT:ModifyWeapon( weapon, talent_mods )

	if ( weapon.Primary.Damage ) then

		weapon.Primary.Damage = weapon.Primary.Damage * ( 1 + ( ( self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] ) ) / 100 ) )
		
	end

end