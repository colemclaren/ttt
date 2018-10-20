ITEM.ID = 8087
ITEM.Rarity = 7
ITEM.Name = "Towering Pillar of Hats"
ITEM.Description = "A-ha-ha! You are as PRESUMPTUOUS as you are POOR and IRISH. Tarnish notte the majesty of my TOWER of HATS."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_multi.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.275)
	p = p + (a:Forward() * -3.901)+ (a:Right() * 0.059)+ (a:Up() * 3.53)

	return m, p, a
end