ITEM.ID = 8091
ITEM.Rarity = 6
ITEM.Name = "Top Hat of Bling Bling"
ITEM.Description = "For those times when a plain old top hat made out of solid gold just won't do."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_robloxmoney.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.667)+ (a:Right() * 0.1)+ (a:Up() * 5.519)

	return m, p, a
end