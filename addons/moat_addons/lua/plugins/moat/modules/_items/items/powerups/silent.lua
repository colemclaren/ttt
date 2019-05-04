ITEM.ID = 1501
ITEM.Name = "Silent"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Description = "Your footsteps are muffled and killing someone has a %s_ chance to muffle their screams"
ITEM.Image = "NEEDSANEWIMAGE"
ITEM.Rarity = 4
ITEM.Collection = "CHANGEMECRATE Collection"
ITEM.Stats = {
	{ min = 50, max = 90 }
}

function ITEM:OnPlayerSpawn(ply, powerup_mods)
	ply.SilentPower = self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * powerup_mods[1])
end
