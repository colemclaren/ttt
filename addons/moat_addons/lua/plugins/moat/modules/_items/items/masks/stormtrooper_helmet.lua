ITEM.ID = 8064
ITEM.Rarity = 7
ITEM.Name = "Stormtrooper Helmet"
ITEM.Description = "You can go about your business."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/trooperhelmet/trooperhelmet.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.786)+ (a:Right() * 0.008)+ (a:Up() * -5.99)

	return m, p, a
end