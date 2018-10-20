ITEM.ID = 8069
ITEM.Rarity = 6
ITEM.Name = "Pimp Hat"
ITEM.Description = "25% off. Everything must go. Maybe even you."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_fedora.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -3.92)+ (a:Right() * 0.018)+ (a:Up() * 2.601)
	a:RotateAroundAxis(a:Up(), 180)


	return m, p, a
end