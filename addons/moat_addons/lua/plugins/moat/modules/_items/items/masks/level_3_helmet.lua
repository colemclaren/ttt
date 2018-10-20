ITEM.ID = 8033
ITEM.Rarity = 6
ITEM.Name = "Level 3 Helmet"
ITEM.Description = "Bite the bullet"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/lvl3/lvl3.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.479)+ (a:Right() * -0.001)+ (a:Up() * -1.422)
	a:RotateAroundAxis(a:Up(), 90)
	a:RotateAroundAxis(a:Forward(), 7.1)


	return m, p, a
end