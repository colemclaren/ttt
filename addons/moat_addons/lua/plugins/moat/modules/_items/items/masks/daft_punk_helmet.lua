ITEM.ID = 8014
ITEM.Rarity = 7
ITEM.Name = "Daft Punk Helmet"
ITEM.Description = "She's up all night to the sun, I'm up all night to get some, She's up all night for good fun, I'm up all night to get lucky"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/daft/daft.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -4.608)+ (a:Right() * 0.006)+ (a:Up() * -4.951)

	return m, p, a
end