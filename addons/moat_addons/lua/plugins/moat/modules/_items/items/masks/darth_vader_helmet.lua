ITEM.ID = 8016
ITEM.Rarity = 5
ITEM.Name = "Darth Vader Helmet"
ITEM.Description = "Give yourself to the Dark Side. It is the only way you can save your friends. Yes, your thoughts betray you. Your feelings for them are strong."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/darthvader/darthvader.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -4.859)+ (a:Right() * 0.003)+ (a:Up() * -1.382)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end