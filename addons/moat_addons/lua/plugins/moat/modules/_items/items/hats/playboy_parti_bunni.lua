ITEM.ID = 4530
ITEM.Rarity = 4
ITEM.Name = "Playboy Parti Bunni"
ITEM.Description = "Catch me wearing this around the mansion"
ITEM.Collection = "Easter 2019 Collection"
ITEM.Model = "models/moat/mg_hat_easterhat.mdl"
ITEM.Image = "https://cdn.moat.gg/f/aiC1fCyO1oaFhS01bYRGhl20bhP9jn8R.png"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.8)+ (a:Right() * 0)+ (a:Up() * 4.104)

	return m, p, a
end