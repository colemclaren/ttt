ITEM.ID = 4531
ITEM.Rarity = 5
ITEM.Name = "Pot Head"
ITEM.Description = "Don't forget to water your flowers"
ITEM.Collection = "Easter 2019 Collection"
ITEM.Model = "models/moat/mg_hat_easterflowers.mdl"
ITEM.Image = "https://cdn.moat.gg/f/7e81543cab4cc40c0414fe1ff9d17d75.png"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.801)+ (a:Right() * 0)+ (a:Up() * 5.267)

	return m, p, a
end