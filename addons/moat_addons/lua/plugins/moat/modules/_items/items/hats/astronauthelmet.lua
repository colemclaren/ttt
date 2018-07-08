
ITEM.ID = 56

ITEM.Name = "Astronaut Helmet"

ITEM.Description = "Instantly become a space god with this helmet"

ITEM.Model = "models/astronauthelmet/astronauthelmet.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3) + (ang:Up() * -5) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end