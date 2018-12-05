ITEM.ID = 8532
ITEM.Rarity = 3
ITEM.Name = "Santa's Trash"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/custom_prop/moatgaming/trashbag/trashbag.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -3.711)+ (a:Right() * -0.119)+ (a:Up() * -8.322)
	a:RotateAroundAxis(a:Up(), 180)


	return m, p, a
end