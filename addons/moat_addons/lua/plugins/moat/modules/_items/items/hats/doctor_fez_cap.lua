ITEM.ID = 8020
ITEM.Rarity = 2
ITEM.Name = "Doctor Fez Cap"
ITEM.Description = "A fez is another name for a condom. Kind of like a fez but for your other head."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/doctorfez/doctorfez.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.025)
	p = p + (a:Forward() * -3.492)+ (a:Right() * -0.428)+ (a:Up() * 3.722)
	a:RotateAroundAxis(a:Forward(), -17.1)


	return m, p, a
end