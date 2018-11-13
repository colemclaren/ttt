
ITEM.ID = 23

ITEM.Name = "Ammo Hoarder"

ITEM.NameColor = Color( 255, 102, 0 )

ITEM.Description = "Begin the round with +%s_ more ammo in your reserves"

ITEM.Image = "https://cdn.moat.gg/f/ZePO1Nu9RtO96p0OI2rPdYkjtaOo.png" 

ITEM.Rarity = 4

ITEM.Collection = "Alpha Collection"

ITEM.Stats = {

	{ min = 45, max = 125 }

}

function ITEM:OnBeginRound(ply, powerup_mods)
	timer.Simple(3, function()
		if (not IsValid(ply)) then return end

		for k, v in ipairs(ply:GetWeapons()) do
			local ammo_type, max_clip = v:GetPrimaryAmmoType(), v:GetMaxClip1()
			local ammo_to_give = math.Clamp(((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * powerup_mods[1])) / 100) * (max_clip * 2), 0, max_clip * 2)
			ply:GiveAmmo(ammo_to_give, ammo_type)
		end
	end)
end