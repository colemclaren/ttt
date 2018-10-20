ITEM.ID = 8021
ITEM.Rarity = 4
ITEM.Name = "Crocodile Dundee Hat"
ITEM.Description = "That's not a knife. [draws a large Bowie knife] That's a knife."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/dundee/dundee.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.746)+ (a:Right() * 0.874)+ (a:Up() * 0.029)
	a:RotateAroundAxis(a:Up(), 90)
	a:RotateAroundAxis(a:Forward(), -9.6)


	return m, p, a
end