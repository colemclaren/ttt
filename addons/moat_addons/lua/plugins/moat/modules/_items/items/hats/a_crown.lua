ITEM.ID = 8074
ITEM.Rarity = 5
ITEM.Name = "A Crown"
ITEM.Description = "The eastern-american pronounciation of the word 'crayons', but in hat form."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_crown.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.35)
	p = p + (a:Forward() * -3.575)+ (a:Right() * 0.102)+ (a:Up() * 3.485)

	return m, p, a
end