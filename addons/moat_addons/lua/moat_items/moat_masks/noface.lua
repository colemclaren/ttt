
ITEM.ID = 115

ITEM.Name = "No Face Mask"

ITEM.Description = "Where did your face go?"

ITEM.Model = "models/gmod_tower/noface.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -0.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

