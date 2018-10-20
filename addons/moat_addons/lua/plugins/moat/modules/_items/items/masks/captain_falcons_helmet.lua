ITEM.ID = 8023
ITEM.Rarity = 6
ITEM.Name = "Captain Falcon's Helmet"
ITEM.Description = "FALCOOOOON PUNCH!!!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/falcon/falcon.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -5.152)+ (a:Right() * -0.002)+ (a:Up() * 0.055)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end