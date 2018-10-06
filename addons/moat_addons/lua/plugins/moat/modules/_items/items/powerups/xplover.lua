
ITEM.ID = 604

ITEM.Name = "Experience Lover"

ITEM.NameColor = Color( 255, 0, 255 )

ITEM.Description = "Gain %s_ more weapon XP after a rightfull kill when using this powerup"

ITEM.Image = "https://cdn.moat.gg/f/mxwUSGlgZEJ8UhjgcTEW6N2tXu2Y.png" 

ITEM.Rarity = 5

ITEM.Collection = "Crimson Collection"

ITEM.Stats = {

	{ min = 25, max = 75 }

}

function ITEM:OnPlayerSpawn( ply, powerup_mods )

	local xp_multi = 1 + ( ( self.Stats[1].min + ( ( self.Stats[1].max - self.Stats[1].min ) * powerup_mods[1] ) ) / 100 )

	ply.ExtraXP = xp_multi

end