ITEM.ID = 8533
ITEM.Rarity = 6
ITEM.Name = "Elf #1 Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_elf2.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.73)+ (a:Right() * -0.135)+ (a:Up() * 1.204)

	return m, p, a
end