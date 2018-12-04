ITEM.ID = 8506
ITEM.Rarity = 3
ITEM.Name = "Holday Star Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_stars.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.524)+ (a:Right() * -0.035)+ (a:Up() * 1.509)

	return m, p, a
end