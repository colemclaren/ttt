
ITEM.ID = 124

ITEM.Name = "Star Glasses"

ITEM.Description = "Too good for regular glasses"

ITEM.Model = "models/gmod_tower/starglasses.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -1.4) + (ang:Up() * -0.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

