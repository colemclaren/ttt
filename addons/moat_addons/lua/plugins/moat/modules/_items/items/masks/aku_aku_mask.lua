ITEM.ID = 8002
ITEM.Rarity = 6
ITEM.Name = "Aku Aku Mask"
ITEM.Description = "A floating mask from the Crash Bandicoot game series. He aids Crash & co. in some way."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/aku/aku.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.3)
	p = p + (a:Forward() * -5.52)+ (a:Right() * 0.001)+ (a:Up() * -0.621)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end