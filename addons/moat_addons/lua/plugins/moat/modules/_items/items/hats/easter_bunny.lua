ITEM.ID = 4538
ITEM.Rarity = 9
ITEM.Name = "The Easter Bunny"
ITEM.Description = "Holy cowww"
ITEM.Collection = "Easter 2019 Collection"
ITEM.Model = "models/custom_prop/moatgaming/eastbunny/eastbunny.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -3.732)+ (a:Right() * 0.001)+ (a:Up() * -0.3)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end