ITEM.ID = 8035
ITEM.Rarity = 6
ITEM.Name = "Marshmello's Helmet"
ITEM.Description = "I heard you keeping it 'Mello' Eh Eh no okay..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/marshmello/marshmello.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -4.226)+ (a:Right() * 0.023)+ (a:Up() * -5.588)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end