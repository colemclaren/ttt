ITEM.ID = 8045
ITEM.Rarity = 5
ITEM.Name = "Psycho Mask"
ITEM.Description = "Strip the flesh, Salt the wound."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/psycho/psycho.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.987)+ (a:Right() * -0.002)+ (a:Up() * -5.456)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end