ITEM.ID = 8089
ITEM.Rarity = 5
ITEM.Name = "King Neptune's Crown"
ITEM.Description = "I win!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_neptune.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -3.981)+ (a:Right() * 0.046)+ (a:Up() * 8.859)

	return m, p, a
end