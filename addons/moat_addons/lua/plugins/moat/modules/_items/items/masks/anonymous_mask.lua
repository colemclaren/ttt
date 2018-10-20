ITEM.ID = 8005
ITEM.Rarity = 2
ITEM.Name = "Anonymous Mask"
ITEM.Description = "KNOWLEDGE IS EXPENSIVE. WE ARE IDENTIFIED. WE ARE FEW. WE DO FORGIVE. WE DO FORGET. DO NOT EXPECT US."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/anonymous/anonymous.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -4.595)+ (a:Right() * 0.047)+ (a:Up() * -3.804)

	return m, p, a
end