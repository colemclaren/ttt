ITEM.ID = 8027
ITEM.Rarity = 2
ITEM.Name = "Gas Mask"
ITEM.Description = "This allows whoever is wearing the gas mask to inhale farts without plugging their nose."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/gasmask/gasmask.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -4.534)+ (a:Right() * -0.258)+ (a:Up() * -2.983)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end