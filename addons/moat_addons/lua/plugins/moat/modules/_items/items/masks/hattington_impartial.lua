ITEM.ID = 8104
ITEM.Rarity = 2
ITEM.Name = "Impartial Hattington"
ITEM.Description = "I was going tell you how much you suck. Turns out you don't!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 3

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)

	return m, p, a
end