ITEM.ID = 8039
ITEM.Rarity = 3
ITEM.Name = "Monstro Head"
ITEM.Description = "Biblethump had a baby, and it's pretty weird looking."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/monstro/monstro.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.76)
	p = p + (a:Forward() * -4.334)+ (a:Right() * -0.005)+ (a:Up() * -5.066)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end