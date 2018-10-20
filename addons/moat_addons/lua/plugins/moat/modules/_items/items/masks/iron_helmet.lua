ITEM.ID = 8098
ITEM.Rarity = 4
ITEM.Name = "Iron Helmet"
ITEM.Description = "+42 Damage resistance against dragons"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_helmet_iron.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -2.956)+ (a:Right() * -0.043)+ (a:Up() * 1.603)

	return m, p, a
end