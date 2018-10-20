ITEM.ID = 8036
ITEM.Rarity = 5
ITEM.Name = "Mega Man Helmet"
ITEM.Description = "Watch out for the spikes blocks."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/megaman/megaman.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -11.287)+ (a:Right() * -0.006)+ (a:Up() * -1.14)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end