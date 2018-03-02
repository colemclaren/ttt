
ITEM.ID = 2096

ITEM.Name = "USA 3D Glasses"

ITEM.Description = "The most practical way to get your head in the game"

ITEM.Model = "models/gmod_tower/3dglasses.mdl"

ITEM.Rarity = 8

ITEM.Collection = "Independence Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -1) + (ang:Up() * -0.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

