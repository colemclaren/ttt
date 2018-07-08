
ITEM.ID = 99

ITEM.Name = "Batman Mask"

ITEM.Description = "Where the fuck is Rachel"

ITEM.Model = "models/gmod_tower/batmanmask.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.2) + (ang:Up() * -0.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

