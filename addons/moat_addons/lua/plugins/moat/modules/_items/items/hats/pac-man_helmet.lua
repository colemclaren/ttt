ITEM.ID = 8090
ITEM.Rarity = 6
ITEM.Name = "Pac-Man Helmet"
ITEM.Description = "Waka Waka Waka Waka..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_packman.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -7.723)+ (a:Right() * 0.064)+ (a:Up() * 0.957)

	return m, p, a
end