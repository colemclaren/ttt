ITEM.ID = 8093
ITEM.Rarity = 4
ITEM.Name = "Confined Cranium"
ITEM.Description = "Your thoughts will be trapped for eternity."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_skullcage.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.6)
	p = p + (a:Forward() * -4.078)+ (a:Right() * 0.088)+ (a:Up() * 0.208)

	return m, p, a
end