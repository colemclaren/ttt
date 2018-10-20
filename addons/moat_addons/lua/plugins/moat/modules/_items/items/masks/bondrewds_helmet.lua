ITEM.ID = 8011
ITEM.Rarity = 6
ITEM.Name = "Bondrewd's Helmet"
ITEM.Description = "World's best dad"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bondrewd/bondrewd.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -2.268)+ (a:Right() * -2.339)+ (a:Up() * 0.071)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end