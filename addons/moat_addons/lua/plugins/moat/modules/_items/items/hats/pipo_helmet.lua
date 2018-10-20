ITEM.ID = 8006
ITEM.Rarity = 1
ITEM.Name = "Pipo Helmet"
ITEM.Description = "The Peak Point Helmet, also known as Pipo Helmet, is an experimental device made by the developers. This device controls the wearer and increases its intelligence."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/apeescape/apeescape.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -3.877)+ (a:Right() * -0.867)+ (a:Up() * 2.149)

	return m, p, a
end