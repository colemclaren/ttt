ITEM.ID = 8513
ITEM.Rarity = 7
ITEM.Name = "Merry Xmas Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_xmas.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -1.135)+ (a:Right() * 0.002)+ (a:Up() * 2.996)

	return m, p, a
end