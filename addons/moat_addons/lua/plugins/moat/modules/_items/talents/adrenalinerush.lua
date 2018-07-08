
TALENT.ID = 8

TALENT.Name = "Adrenaline Rush"

TALENT.NameColor = Color( 255, 0, 0 )

TALENT.Description = "Damage is increased by %s_^ for %s seconds after killing with this weapon"

TALENT.Tier = 1

TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}

TALENT.Modifications[1] = { min = 5, max = 15 } // Percent damage is increased by

TALENT.Modifications[2] = { min = 3, max = 7 } // Damage time

TALENT.Melee = true

TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )
	if (GetRoundState() == ROUND_ACTIVE and not MOAT_ACTIVE_BOSS and (victim:Health() - dmginfo:GetDamage() <= 0) ) then

		local wep = dmginfo:GetAttacker():GetActiveWeapon()

		local weptbl = wep:GetTable()

		if ( weptbl.Primary.Damage ) then

			if ( not weptbl.StoredDamage ) then

				weptbl.StoredDamage = weptbl.Primary.Damage

			end

			weptbl.StoredDamage = weptbl.Primary.Damage

			weptbl.Primary.Damage = weptbl.Primary.Damage * ( 1 + ( ( self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] ) ) / 100 ) )

			local damage_time = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )

			timer.Simple( damage_time, function()

				if ( wep:IsValid() ) then
					
					local tbl = wep:GetTable()

					if ( tbl and tbl.StoredDamage ) then
						
						tbl.Primary.Damage = tbl.StoredDamage

					end

				end

			end )

		end

	end

end