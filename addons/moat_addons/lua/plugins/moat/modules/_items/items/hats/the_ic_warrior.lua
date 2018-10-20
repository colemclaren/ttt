ITEM.ID = 8080
ITEM.Rarity = 9
ITEM.Name = "The IC Warrior"
ITEM.Description = "A haiku for war. To default one's enemies. Honor the IC."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_killerskabuto.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.453)+ (a:Right() * 0.089)+ (a:Up() * 3.924)

	return m, p, a
end