
TALENT.ID = 22

TALENT.Name = 'Medicality'

TALENT.NameColor = Color(0, 255, 0)

TALENT.Description = 'While weilding this weapon, you will gain 1 health every %s second(s)'

TALENT.Tier = 2

TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}

TALENT.Modifications[1] = {min = 1, max = 3} -- Seconds

TALENT.Melee = false

TALENT.NotUnique = true

function TALENT:OnWeaponSwitch(ply, wep, isto, talent_mods)
	local timer_speed = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )

	if (isto) then
		timer.Create("moat_medicality" .. ply:EntIndex(), timer_speed, 0, function()
			if ((not wep:IsValid()) or (wep:IsValid() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon() ~= wep)) then timer.Remove("moat_medicality" .. ply:EntIndex()) return end

			if (ply:Health() < ply:GetMaxHealth()) then
				local hp = math.Clamp(ply:Health() + 1, 0, ply:GetMaxHealth())
				ply:SetHealth(hp)
			end
		end)
	else
		timer.Remove("moat_medicality" .. ply:EntIndex())
	end
end