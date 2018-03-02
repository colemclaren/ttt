
ITEM.ID = 114

ITEM.Name = "Midna Hat"

ITEM.Description = "EPIC"

ITEM.Model = "models/gmod_tower/midnahat.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -1.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

