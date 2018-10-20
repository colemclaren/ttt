ITEM.ID = 8042
ITEM.Rarity = 7
ITEM.Name = "Ori Mask"
ITEM.Description = "When my child's strength faltered, and the last breath was drawn, my light revived Ori, a new age had dawned."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/ori/ori.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -5.785)+ (a:Right() * 0.154)+ (a:Up() * -4.91)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end