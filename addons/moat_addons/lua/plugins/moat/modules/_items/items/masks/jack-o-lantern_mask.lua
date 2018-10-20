ITEM.ID = 8046
ITEM.Rarity = 4
ITEM.Name = "Jack-o-Lantern Mask"
ITEM.Description = "The pumpkin king comes to freight tonight..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/pumpkin/pumpkin.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -5.234)+ (a:Right() * -0.005)+ (a:Up() * -5.159)
	a:RotateAroundAxis(a:Up(), 93.9)


	return m, p, a
end