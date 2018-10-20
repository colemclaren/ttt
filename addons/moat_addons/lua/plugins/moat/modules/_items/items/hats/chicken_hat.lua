ITEM.ID = 8073
ITEM.Rarity = 6
ITEM.Name = "Chicken Hat"
ITEM.Description = "The paramount of stealth."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_chicken.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.2)
	p = p + (a:Forward() * -4.189)+ (a:Right() * 0.065)+ (a:Up() * 2.904)

	return m, p, a
end