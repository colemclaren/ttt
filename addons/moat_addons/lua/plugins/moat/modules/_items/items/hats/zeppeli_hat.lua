ITEM.ID = 8072
ITEM.Rarity = 6
ITEM.Name = "Zeppeli Hat"
ITEM.Description = "What is Courage? Courage is owning your fear!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_checkered_top.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.2)
	p = p + (a:Forward() * -3.877)+ (a:Right() * 0.036)+ (a:Up() * 3.853)

	return m, p, a
end
