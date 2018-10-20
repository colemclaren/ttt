ITEM.ID = 8060
ITEM.Rarity = 5
ITEM.Name = "Straw Hat"
ITEM.Description = "Welcome to the rice fields, mutha fucka."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/strawhat/strawhat.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.161)+ (a:Right() * -1.299)+ (a:Up() * 0.491)

	return m, p, a
end