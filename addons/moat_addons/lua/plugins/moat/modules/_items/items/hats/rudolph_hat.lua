ITEM.ID = 8539
ITEM.Rarity = 7
ITEM.Name = "Rudolph Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_rudolph.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.825)
	p = p + (a:Forward() * -2.738)+ (a:Right() * -0.167)+ (a:Up() * 2.144)

	return m, p, a
end