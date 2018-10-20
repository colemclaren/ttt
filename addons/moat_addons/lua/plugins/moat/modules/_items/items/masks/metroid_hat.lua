ITEM.ID = 8037
ITEM.Rarity = 3
ITEM.Name = "Metroid Hat"
ITEM.Description = "I first battled the Metroids on planet Zebes. It was there that I foiled the plans of the Space Pirate leader, Mother Brain, to use the creatures to attack galactic civilization."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/metroid/metroid.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -7.034)+ (a:Right() * -0.001)+ (a:Up() * 7.255)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end