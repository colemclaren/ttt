ITEM.ID = 8031
ITEM.Rarity = 6
ITEM.Name = "Hollow Knight Mask"
ITEM.Description = "Brave the depths of a forgotten kingdom with this mask."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/hollow/hollow.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.369)+ (a:Right() * 0)+ (a:Up() * -5.281)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end