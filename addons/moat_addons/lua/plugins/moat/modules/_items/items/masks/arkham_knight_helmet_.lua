ITEM.ID = 8007
ITEM.Rarity = 5
ITEM.Name = "Arkham Knight Helmet "
ITEM.Description = "The damn straight best super hero ever."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/arkham/arkham.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -5.484)+ (a:Right() * 0.001)+ (a:Up() * 0.106)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end