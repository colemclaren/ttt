ITEM.ID = 8025
ITEM.Rarity = 2
ITEM.Name = "Foolish Topper"
ITEM.Description = "You must have sucked someone to get this... (kirby joke lol)"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/foolish/foolish.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -6.627)+ (a:Right() * 0.328)+ (a:Up() * 2.637)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end