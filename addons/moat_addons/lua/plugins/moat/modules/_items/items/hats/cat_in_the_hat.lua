ITEM.ID = 8521
ITEM.Rarity = 6
ITEM.Name = "Cat in the Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_catinthehat.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.325)
	p = p + (a:Forward() * -2.714)+ (a:Right() * 0)+ (a:Up() * 8.254)

	return m, p, a
end