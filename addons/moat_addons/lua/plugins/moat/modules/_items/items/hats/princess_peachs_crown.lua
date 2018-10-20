ITEM.ID = 8044
ITEM.Rarity = 5
ITEM.Name = "Princess Peach's Crown"
ITEM.Description = "I am in another castle!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/princess/princess.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.454)+ (a:Right() * 0.845)+ (a:Up() * 5.339)

	return m, p, a
end