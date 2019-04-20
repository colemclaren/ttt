ITEM.ID = 4532
ITEM.Rarity = 3
ITEM.Name = "Hatching Noob"
ITEM.Description = "I like to hide in my shell some times"
ITEM.Collection = "Easter 2019 Collection"
ITEM.Model = "models/custom_prop/moatgaming/eastegg/eastegg.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -3.8)+ (a:Right() * -1.007)+ (a:Up() * -9.757)

	return m, p, a
end