ITEM.ID = 8522
ITEM.Rarity = 6
ITEM.Name = "Elf #2 Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_elf.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.015)+ (a:Right() * 0.001)+ (a:Up() * 4.144)

	return m, p, a
end