ITEM.ID = 8082
ITEM.Rarity = 4
ITEM.Name = "Kung Lao's Hat"
ITEM.Description = "I will not be so passive in your demise."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_kunglao.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -4.054)+ (a:Right() * 0.119)+ (a:Up() * 4.079)

	return m, p, a
end