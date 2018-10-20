ITEM.ID = 8081
ITEM.Rarity = 5
ITEM.Name = "Krusty Krab Hat"
ITEM.Description = "I'm ready! I'm ready! I'm ready!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_krustykrab.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.5)
	p = p + (a:Forward() * -3.779)+ (a:Right() * 0.091)+ (a:Up() * 9.58)

	return m, p, a
end