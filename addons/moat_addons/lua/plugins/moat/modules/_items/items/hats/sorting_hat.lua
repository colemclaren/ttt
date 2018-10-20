ITEM.ID = 8058
ITEM.Rarity = 7
ITEM.Name = "Sorting Hat"
ITEM.Description = "Hmm, difficult. VERY difficult. Plenty of courage, I see. Not a bad mind, either. There's talent, oh yes. And a thirst to prove yourself. But where to put you?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/sortinghat/sortinghat.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.208)+ (a:Right() * -0.965)+ (a:Up() * 1.495)

	return m, p, a
end