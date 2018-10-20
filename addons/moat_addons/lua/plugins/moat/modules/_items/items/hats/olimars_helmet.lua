ITEM.ID = 8041
ITEM.Rarity = 3
ITEM.Name = "Olimar's Helmet"
ITEM.Description = "Though it does no longer work, this helmet was said to track down Traitors in 2001."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/olimar/olimar.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -3.685)+ (a:Right() * 1.373)+ (a:Up() * -6.748)

	return m, p, a
end