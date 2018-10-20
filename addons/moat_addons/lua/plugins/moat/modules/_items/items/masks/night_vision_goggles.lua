ITEM.ID = 8063
ITEM.Rarity = 6
ITEM.Name = "Night Vision Goggles"
ITEM.Description = "Either this guy is hacking, or he actually managed to turn on the goggles..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/trihelmet/trihelmet.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.437)+ (a:Right() * 0.185)+ (a:Up() * 0.442)

	return m, p, a
end