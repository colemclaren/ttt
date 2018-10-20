ITEM.ID = 8051
ITEM.Rarity = 3
ITEM.Name = "Saiyan Scouter"
ITEM.Description = "Something, something, power level, something, 9000..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/saiyanvisor/saiyanvisor.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.051)+ (a:Right() * 0.689)+ (a:Up() * 0.917)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end