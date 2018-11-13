ITEM.ID = 601

ITEM.Name = "Flame Retardant"

ITEM.NameColor = Color( 255, 60, 0 )

ITEM.Description = "Fire and explosion damage is reduced by %s_ when using this powerup"

ITEM.Image = "https://cdn.moat.gg/f/ezgf9NEOa6OgmYSzzi6wDWxaxJZb.png" 

ITEM.Rarity = 3

ITEM.Collection = "Crimson Collection"

ITEM.Stats = {
	{min = -35, max = -75}
}

local dmg_prot = {
	[DMG_BURN] = true,
	[DMG_BLAST] = true
}

function ITEM:OnDamageTaken(ply, dmginfo, powerup_mods)
	if (dmg_prot[dmginfo:GetDamageType()]) then
		local damage_scale = 1 + ((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * powerup_mods[1])) / 100 )
		dmginfo:ScaleDamage(damage_scale)
	end
end