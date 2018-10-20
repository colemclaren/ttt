ITEM.ID = 8076
ITEM.Rarity = 6
ITEM.Name = "The Stout Shako"
ITEM.Description = "The grand achievement of Victorian military fashion."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_drummer.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.832)+ (a:Right() * 0.044)+ (a:Up() * 8.242)

	return m, p, a
end