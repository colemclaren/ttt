
ITEM.ID = 122

ITEM.Name = "Snowboard Goggles"

ITEM.Description = "We don't need snow to wear these"

ITEM.Model = "models/gmod_tower/snowboardgoggles.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.8) + (ang:Up() * -0.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

