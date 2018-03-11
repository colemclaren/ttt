
ITEM.ID = 26

ITEM.Name = "Marathon Runner"

ITEM.NameColor = Color( 85, 85, 255 )

ITEM.Description = "Movement speed is increased by +%s_ when using this power-up"

ITEM.Image = "moat_inv/smithrunicon.png" 

ITEM.Rarity = 3

ITEM.Collection = "Alpha Collection"

ITEM.Stats = {

	{ min = 5, max = 15 }

}

function ITEM:OnPlayerSpawn( ply, powerup_mods )

	ply:SetNWFloat("marathon_runner", (self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * powerup_mods[1])) / 100 )

end

hook.Add("PlayerDeath", "MarathonRunner", function(pl)
	pl:SetNWFloat("marathon_runner", 0)
end)