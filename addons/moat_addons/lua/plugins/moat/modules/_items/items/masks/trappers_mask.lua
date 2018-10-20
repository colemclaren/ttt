ITEM.ID = 8062
ITEM.Rarity = 3
ITEM.Name = "Trapper's Mask"
ITEM.Description = "Perfect to cover a bald head and an ugly face!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/trapper/trapper.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * 0.378)+ (a:Right() * 0.243)+ (a:Up() * -0.971)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end