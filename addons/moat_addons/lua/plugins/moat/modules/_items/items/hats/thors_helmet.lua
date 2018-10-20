ITEM.ID = 8061
ITEM.Rarity = 7
ITEM.Name = "Thor's Helmet"
ITEM.Description = "The god of Thunder. Can drink anyone under the table. Not a deity to fuck with."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/thundergod/thundergod.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -3.531)+ (a:Right() * -2.098)+ (a:Up() * -88.611)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end