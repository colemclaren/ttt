ITEM.ID = 8026
ITEM.Rarity = 7
ITEM.Name = "Galactus Helmet"
ITEM.Description = "Behold... The Power Cosmic itself!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/galactus/galactus.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.3)
	p = p + (a:Forward() * -5.157)+ (a:Right() * -0.125)+ (a:Up() * -5.757)

	return m, p, a
end