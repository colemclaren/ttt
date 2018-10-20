ITEM.ID = 8029
ITEM.Rarity = 1
ITEM.Name = "Hannibal Mask"
ITEM.Description = "Clarice..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/hannibal/hannibal.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -3.679)+ (a:Right() * -0.002)+ (a:Up() * -0.31)

	return m, p, a
end