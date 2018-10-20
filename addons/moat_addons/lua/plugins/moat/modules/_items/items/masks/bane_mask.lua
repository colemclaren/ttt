ITEM.ID = 8008
ITEM.Rarity = 5
ITEM.Name = "Bane Mask"
ITEM.Description = "ass batman villian that uses a super steroid called 'Venom' to destroy anything with brute strength."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bane/bane.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.861)+ (a:Up() * -1.637)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end