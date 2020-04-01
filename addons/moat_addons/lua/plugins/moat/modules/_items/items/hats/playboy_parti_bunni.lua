ITEM.ID = 4530
ITEM.Rarity = 4
ITEM.Name = "Playboy Parti Bunni"
ITEM.Description = "Catch me wearing this around the mansion"
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/moat/mg_hat_easterhat.mdl"
ITEM.Image = "https://cdn.moat.gg/f/8cd435b47a8606ad6f0112eeb870085f.png"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.8)+ (a:Right() * 0)+ (a:Up() * 4.104)

	return m, p, a
end