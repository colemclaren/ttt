ITEM.ID = 8055
ITEM.Rarity = 6
ITEM.Name = "Shovel Knight Helmet"
ITEM.Description = "SHOVEL JUSTICE!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/shovel/shovel.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.488)+ (a:Right() * 0.009)+ (a:Up() * -5.436)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end