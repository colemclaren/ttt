ITEM.ID = 8017
ITEM.Rarity = 4
ITEM.Name = "Demon Shank Mask"
ITEM.Description = "Raised from the depths of hell, to die, again and again"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/demonshank/demonshank.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -4.646)+ (a:Right() * 0.009)+ (a:Up() * -3.553)

	return m, p, a
end