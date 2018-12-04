ITEM.ID = 8503
ITEM.Rarity = 4
ITEM.Name = "Reindeer Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_reindeer.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.738)+ (a:Right() * -0.023)+ (a:Up() * 0.752)

	return m, p, a
end