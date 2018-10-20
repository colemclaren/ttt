ITEM.ID = 8079
ITEM.Rarity = 6
ITEM.Name = "The Goofy Goober"
ITEM.Description = "I'm a goofy goober, ROCK! You're a goofy goober, ROCK! We're all goofy goobers, ROCK! Goofy goofy goober goober!, ROCK!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_goofygoober.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.733)+ (a:Right() * 0.01)+ (a:Up() * -0.255)

	return m, p, a
end