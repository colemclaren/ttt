ITEM.ID = 8083
ITEM.Rarity = 3
ITEM.Name = "Smore Chef"
ITEM.Description = "Warning! This cozy comfy smores like hat is not edible while shooting terrorists!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_law.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.035)+ (a:Right() * 0.136)+ (a:Up() * 6.665)

	return m, p, a
end