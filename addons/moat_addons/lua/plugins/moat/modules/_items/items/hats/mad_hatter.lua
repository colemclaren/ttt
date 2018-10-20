ITEM.ID = 8086
ITEM.Rarity = 5
ITEM.Name = "Mad Hatter Hat"
ITEM.Description = "We're all mad here! or Whats the hatter with me! (get it? it's a pun)"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_madhatter.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.969)+ (a:Right() * 0.068)+ (a:Up() * 5.221)

	return m, p, a
end