ITEM.ID = 8100
ITEM.Rarity = 9
ITEM.Name = "The #1 Hat"
ITEM.Description = "Hey man, that's Smitty Werben Man Jensen's hat, give it back! He was #1!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/sterling/mg_hat_number1.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.558)+ (a:Right() * -0.002)+ (a:Up() * 0.848)

	return m, p, a
end