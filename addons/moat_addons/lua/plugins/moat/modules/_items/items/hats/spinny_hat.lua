ITEM.ID = 8094
ITEM.Rarity = 3
ITEM.Name = "Spinny Hat"
ITEM.Description = "You can sexually identify as an attack helicopter with this propeller on your head."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_spinny.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.975)
	p = p + (a:Forward() * -3.765)+ (a:Right() * 0.07)+ (a:Up() * 1.862)

	return m, p, a
end