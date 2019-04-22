
ITEM.ID = 25

ITEM.Name = "Health Bloom"

ITEM.NameColor = Color( 0, 204, 0 )

ITEM.Description = "Health is increased by +%s when using this power-up"

ITEM.Image = "https://moat.gg/assets/img/smithhealicon.png" 

ITEM.Rarity = 4

ITEM.Collection = "Alpha Collection"

ITEM.Stats = {

	{ min = 5, max = 25 }

}

function ITEM:OnPlayerSpawn( ply, powerup_mods )

	local new_health = ply.MaxHealth + self.Stats[1].min + (self.Stats[1].max - self.Stats[1].min) * powerup_mods[1]

	ply:SetMaxHealth( new_health )

	ply:SetHealth( new_health )

	ply.MaxHealth = new_health

end