
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
	local timer_speed = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	
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
