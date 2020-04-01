ITEM.ID = 4532
ITEM.Rarity = 3
ITEM.Name = "Hatching Noob"
ITEM.Description = "I like to hide in my shell some times"
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/custom_prop/moatgaming/eastegg/eastegg.mdl"
ITEM.Image = "https://cdn.moat.gg/f/24e1b504b09d4c6625e51cd2f7140b3b.png"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -3.8)+ (a:Right() * -1.007)+ (a:Up() * -9.757)

	return m, p, a
end