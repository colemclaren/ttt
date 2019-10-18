
ITEM.ID = 602

ITEM.Name = "Hard Hat"

ITEM.NameColor = Color(0, 255, 255)

ITEM.Description = "Headshot damage is reduced by %s_ when using this power-up"

ITEM.Image = "https://cdn.moat.gg/f/ddaebffd6d2f4cdf354479e029426159.png" 

ITEM.Rarity = 6

ITEM.Collection = "Crimson Collection"

ITEM.Stats = {
	{min = -15, max = -38}
}

function ITEM:ScalePlayerDamage(ply, hitgroup, dmginfo, powerup_mods)
	if ( hitgroup == HITGROUP_HEAD ) then
		local decrease = 1 + ( ( self.Stats[1].min + ( ( self.Stats[1].max - self.Stats[1].min ) * powerup_mods[1] ) ) / 100 )
		dmginfo:ScaleDamage(decrease)
	end
end