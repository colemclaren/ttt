ITEM.ID = 8095
ITEM.Rarity = 1
ITEM.Name = "Floral Giggle"
ITEM.Description = "My goodness! Don't you just love flower tracking on a warm sunny day?!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_sun.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.759)+ (a:Right() * 0.098)+ (a:Up() * 4.55)

	return m, p, a
end