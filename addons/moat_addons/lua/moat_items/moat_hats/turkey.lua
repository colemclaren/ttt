
ITEM.ID = 129

ITEM.Name = "Turkey"

ITEM.Description = "Stick this hot thing on your head"

ITEM.Model = "models/gmod_tower/turkey.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 1.6) + m_IsTerroristModel( ply:GetModel() )
	return model, pos, ang

end

