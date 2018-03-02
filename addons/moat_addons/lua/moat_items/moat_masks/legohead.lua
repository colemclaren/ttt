
ITEM.ID = 110

ITEM.Name = "Lego Head"

ITEM.Description = "Everything is awesome"

ITEM.Model = "models/gmod_tower/legohead.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

