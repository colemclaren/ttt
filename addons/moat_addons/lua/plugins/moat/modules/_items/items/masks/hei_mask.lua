ITEM.ID = 8075
ITEM.Rarity = 4
ITEM.Name = "Hei Mask"
ITEM.Description = "Bearing the sins of the children of earth, the moon begins to consume it's light. What's Darker than Black?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_darkerthenblack.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 1.361)+ (a:Up() * 0.001)

	return m, p, a
end