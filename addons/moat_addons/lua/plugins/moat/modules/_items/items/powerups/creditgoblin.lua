ITEM.ID = 603
ITEM.Name = "Credit Goblin"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Description = "%s_ chance to receive 1 credit after a kill"
ITEM.Image = "NEEDSANEWIMAGE"
ITEM.Rarity = 4
ITEM.Collection = "CHANGEMECRATE Collection"
ITEM.Stats = {
	{ min = 30, max = 60 }
}

function ITEM:OnPlayerSpawn(ply, powerup_mods)
	ply.CreditGoblin = self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * powerup_mods[1])
end
