ITEM.ID = 8049
ITEM.Rarity = 2
ITEM.Name = "ReDead Mask"
ITEM.Description = "Reeeeeee!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/redead/redead.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.025)
	p = p + (a:Forward() * 0.942)+ (a:Right() * 0.253)+ (a:Up() * -1.381)

	return m, p, a
end