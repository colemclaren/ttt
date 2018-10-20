ITEM.ID = 8038
ITEM.Rarity = 5
ITEM.Name = "Miraak's Mask"
ITEM.Description = "That name sounds familiar, but I just can't put my finger on it.."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/miraak/miraak.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.986)+ (a:Right() * -0.002)+ (a:Up() * -3.053)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end