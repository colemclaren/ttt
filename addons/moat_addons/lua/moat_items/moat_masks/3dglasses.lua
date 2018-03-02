
ITEM.ID = 96

ITEM.Name = "3D Glasses"

ITEM.Description = "The most practical way to get your head in the game"

ITEM.Model = "models/gmod_tower/3dglasses.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -1) + (ang:Up() * -0.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

