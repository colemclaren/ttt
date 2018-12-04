ITEM.ID = 8504
ITEM.Rarity = 3
ITEM.Name = "Santa Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_santa.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.741)+ (a:Right() * -0.029)+ (a:Up() * 1.508)

	return m, p, a
end