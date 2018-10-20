ITEM.ID = 8105
ITEM.Rarity = 2
ITEM.Name = "Anxious Hattington"
ITEM.Description = "Oh no! This isn't going to be good. Clench your butt! AHHHHHHHH"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 4

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)

	return m, p, a
end