ITEM.ID = 8034
ITEM.Rarity = 5
ITEM.Name = "Magneto's Helmet"
ITEM.Description = "Mankind has always feared what it doesn't understand"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/magneto/magneto.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -4.701)+ (a:Right() * -0.002)+ (a:Up() * -1.711)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end