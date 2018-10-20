ITEM.ID = 8097
ITEM.Rarity = 6
ITEM.Name = "Umbrella Hat"
ITEM.Description = "You can stand under my umbrella, ella, ella, eh, eh, eh..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_unbrella.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -4.134)+ (a:Right() * 0.177)+ (a:Up() * 5.8)
	a:RotateAroundAxis(a:Right(), 11.1)


	return m, p, a
end