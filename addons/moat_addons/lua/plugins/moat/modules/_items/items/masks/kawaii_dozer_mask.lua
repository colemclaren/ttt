ITEM.ID = 8057
ITEM.Rarity = 6
ITEM.Name = "Kawaii Dozer Mask"
ITEM.Description = "SENPAI NOTICED ME"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/skullgirl/skullgirl.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.467)+ (a:Up() * -3.063)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end