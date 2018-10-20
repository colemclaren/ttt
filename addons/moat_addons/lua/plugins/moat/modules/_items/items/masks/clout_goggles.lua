ITEM.ID = 8068
ITEM.Rarity = 7
ITEM.Name = "Clout Goggles"
ITEM.Description = "A pair of iconic glasses that should be treasured and only worn by the best of people."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_clout_goggles.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -1.075)+ (a:Right() * 0.002)+ (a:Up() * 0.793)

	return m, p, a
end