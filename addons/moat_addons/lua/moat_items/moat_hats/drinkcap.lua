
ITEM.ID = 60

ITEM.Name = "Drink Cap"

ITEM.Description = "The server drunk"

ITEM.Model = "models/sam/drinkcap.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.1) + (ang:Up() * 2.5) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end