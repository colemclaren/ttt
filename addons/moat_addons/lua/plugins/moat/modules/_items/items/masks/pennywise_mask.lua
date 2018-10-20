ITEM.ID = 8043
ITEM.Rarity = 4
ITEM.Name = "Pennywise Mask"
ITEM.Description = "You'll float too."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/pennywise/pennywise.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.206)+ (a:Right() * -0.004)+ (a:Up() * -2.71)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end