ITEM.ID = 8010
ITEM.Rarity = 3
ITEM.Name = "Billy Mask"
ITEM.Description = "The prettiest boy in all the land."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/billy/billy.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.454)+ (a:Right() * 0.008)+ (a:Up() * -5.909)

	return m, p, a
end