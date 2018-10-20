ITEM.ID = 8066
ITEM.Rarity = 6
ITEM.Name = "Zer0's Mask"
ITEM.Description = "Your eyes deceive you, an illusion fools you all."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/zero/zero.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.427)+ (a:Up() * -5.324)

	return m, p, a
end