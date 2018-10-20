ITEM.ID = 8103
ITEM.Rarity = 1
ITEM.Name = "Cold Hattington"
ITEM.Description = "Good try, but try gooder."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 2

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)

	return m, p, a
end