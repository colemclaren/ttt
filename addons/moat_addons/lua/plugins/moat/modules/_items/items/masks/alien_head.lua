ITEM.ID = 8004
ITEM.Rarity = 4
ITEM.Name = "Alien Head"
ITEM.Description = "The head of a person from outerspace. It was generally peace loving and wise, but it only came to Earth because we've got velcro and it loved that shit. Save velcro!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/alien/alien.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -6.061)+ (a:Right() * 0.031)+ (a:Up() * -3.541)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end