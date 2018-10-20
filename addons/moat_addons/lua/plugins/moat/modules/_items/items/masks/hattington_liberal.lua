ITEM.ID = 8101
ITEM.Rarity = 1
ITEM.Name = "Liberal Hattington"
ITEM.Description = "Oh what the f... fart."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)

	return m, p, a
end