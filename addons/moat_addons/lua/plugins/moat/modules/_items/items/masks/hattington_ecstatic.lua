ITEM.ID = 8106
ITEM.Rarity = 2
ITEM.Name = "Ecstatic Hattington"
ITEM.Description = "Give yourself a round of applause. You're not banned!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 5

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)

	return m, p, a
end