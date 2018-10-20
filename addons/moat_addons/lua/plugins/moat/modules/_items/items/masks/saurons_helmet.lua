ITEM.ID = 8052
ITEM.Rarity = 5
ITEM.Name = "Sauron's Helmet"
ITEM.Description = "Kneel before the witch king!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/sauron/sauron.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -3.261)+ (a:Right() * -0.597)+ (a:Up() * -3.087)

	return m, p, a
end