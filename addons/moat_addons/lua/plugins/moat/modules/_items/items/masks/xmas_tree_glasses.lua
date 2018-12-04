ITEM.ID = 8514
ITEM.Rarity = 5
ITEM.Name = "Xmas Tree Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_xmastree.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -1.427)+ (a:Right() * 0.001)+ (a:Up() * 2.779)

	return m, p, a
end