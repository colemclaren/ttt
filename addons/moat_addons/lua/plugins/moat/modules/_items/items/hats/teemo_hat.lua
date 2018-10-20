ITEM.ID = 8096
ITEM.Rarity = 4
ITEM.Name = "Teemo Hat"
ITEM.Description = "Never underestimate the power of the Scout's code."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_teemo.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.566)+ (a:Right() * 0.143)+ (a:Up() * 4.251)

	return m, p, a
end