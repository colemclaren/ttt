
ITEM.ID = 100

ITEM.Name = "Bomberman Helmet"

ITEM.Description = "FOR THE GLORY OF ALLAH!!!"

ITEM.Model = "models/gmod_tower/bombermanhelmet.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

