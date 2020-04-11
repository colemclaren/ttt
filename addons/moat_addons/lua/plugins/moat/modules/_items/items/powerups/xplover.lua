
ITEM.ID = 604

ITEM.Name = "Experience Lover"

ITEM.NameColor = Color( 255, 0, 255 )

ITEM.Description = "Gain %s_ more weapon XP after a rightfull kill when using this powerup"

ITEM.Image = "https://cdn.moat.gg/f/1114672223ae94d7d0ea360abf9924e0.png" 

ITEM.Rarity = 5

ITEM.Collection = "Crimson Collection"

ITEM.Stats = {

	{ min = 25, max = 75 }

}

function ITEM:OnPlayerSpawn( ply, powerup_mods )

	local xp_multi = 1 + ( ( self.Stats[1].min + ( ( self.Stats[1].max - self.Stats[1].min ) * math.min(1, powerup_mods[1]) ) ) / 100 )

	ply.ExtraXP = xp_multi

end