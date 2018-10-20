ITEM.ID = 8013
ITEM.Rarity = 3
ITEM.Name = "Crusaders Helment"
ITEM.Description = "Join for Glory so all will remember you as a soldier of Moat"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/crusaders/crusaders.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -4.982)+ (a:Right() * 0.003)+ (a:Up() * -4.512)

	return m, p, a
end