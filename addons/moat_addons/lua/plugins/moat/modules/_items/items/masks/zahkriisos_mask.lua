ITEM.ID = 8067
ITEM.Rarity = 5
ITEM.Name = "Zahkriisos' Mask"
ITEM.Description = "The dragon mask acquired from the remains of Zahkriisos, one of four named Dragon Priests on Solstheim."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/zhariisos/zhariisos.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.111)+ (a:Up() * -3.485)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end