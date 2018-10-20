ITEM.ID = 8099
ITEM.Rarity = 3
ITEM.Name = "Steampunk Tophat"
ITEM.Description = "OMG YOU GUYS it has come to my attention that SOMEONE on the internet is saying that my fictional 19th century zombies are NOT SCIENTIFICALLY SOUND. Naturally, I am crushed. To think, IF ONLY I’d consulted with a zombologist or two before sitting down to write, I could’ve avoided ALL THIS EMBARRASSMENT."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/sterling/mg_hat_punk.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.35)
	p = p + (a:Forward() * -3.161)+ (a:Right() * 0.133)+ (a:Up() * 7.737)

	return m, p, a
end