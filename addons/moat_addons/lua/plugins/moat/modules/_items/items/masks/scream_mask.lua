ITEM.ID = 8053
ITEM.Rarity = 4
ITEM.Name = "Scream Mask"
ITEM.Description = "You're not going to pee alone any more. If you pee, I pee. Is that clear?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/scream/scream.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.517)+ (a:Up() * -3.868)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end