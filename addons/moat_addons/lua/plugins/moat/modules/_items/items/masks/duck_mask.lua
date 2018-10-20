ITEM.ID = 8001
ITEM.Rarity = 7
ITEM.Name = "Duck Mask"
ITEM.Description = "The name is supposed to be Fuck Mask, but it was auto-corrected to Duck Mask?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/duck/duck.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.025)
	p = p + (a:Forward() * -6.317)+ (a:Right() * -0.03)+ (a:Up() * -5.161)
	a:RotateAroundAxis(a:Right(), 0.1)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end