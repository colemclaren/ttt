ITEM.ID = 8056
ITEM.Rarity = 6
ITEM.Name = "Shredder Helmet"
ITEM.Description = "TEENAGE MUTANT NINJA TURTLES"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/shredder/shredder.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -4.59)+ (a:Right() * 0.03)+ (a:Up() * 0.677)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end