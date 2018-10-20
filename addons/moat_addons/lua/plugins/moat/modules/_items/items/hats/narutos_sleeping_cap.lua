ITEM.ID = 8088
ITEM.Rarity = 4
ITEM.Name = "Naruto's Sleeping Cap"
ITEM.Description = "A Shinobi's life is not measured by how they lived but rather what they managed to accomplish before their death."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_narutosleeping.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.982)+ (a:Right() * 0.045)+ (a:Up() * 3.56)

	return m, p, a
end