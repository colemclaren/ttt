ITEM.ID = 8054
ITEM.Rarity = 7
ITEM.Name = "Sharky Hat"
ITEM.Description = "Your friend from the ocean!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/shark/shark.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -2.451)+ (a:Right() * -0.109)+ (a:Up() * 6.517)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end