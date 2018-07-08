
ITEM.ID = 121

ITEM.Name = "Seuss Hat"

ITEM.Description = "Thing 1 and Thing 2 are not a thing here"

ITEM.Model = "models/gmod_tower/seusshat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

