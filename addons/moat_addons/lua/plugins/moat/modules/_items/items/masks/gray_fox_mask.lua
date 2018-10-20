ITEM.ID = 8028
ITEM.Rarity = 5
ITEM.Name = "Gray Fox Mask"
ITEM.Description = "Make me feel alive again!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/greyfox/greyfox.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -5.26)+ (a:Right() * -0.044)+ (a:Up() * -4.198)

	return m, p, a
end