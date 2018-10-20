ITEM.ID = 8022
ITEM.Rarity = 4
ITEM.Name = "Evil Plant Head"
ITEM.Description = "The cutest little horrific flower baby!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/evilplant/evilplant.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -6.648)+ (a:Right() * -0.004)+ (a:Up() * -4.964)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end