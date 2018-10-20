ITEM.ID = 8085
ITEM.Rarity = 6
ITEM.Name = "Philosophy Bulb"
ITEM.Description = "Basically gives you a headache with pictures."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_lightb.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -3.602)+ (a:Right() * 0.092)+ (a:Up() * 2.62)

	return m, p, a
end