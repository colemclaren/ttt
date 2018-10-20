ITEM.ID = 8059
ITEM.Rarity = 7
ITEM.Name = "Spawn Mask"
ITEM.Description = "You sent me to Hell. I'm here to return the favor."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/spawn/spawn.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -5.296)+ (a:Right() * 2.1)+ (a:Up() * -93.192)
	a:RotateAroundAxis(a:Up(), -90)


	return m, p, a
end