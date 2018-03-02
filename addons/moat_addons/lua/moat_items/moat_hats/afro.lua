
ITEM.ID = 54

ITEM.Name = "Afro"

ITEM.Description = "Become a jazzy man with this afro"

ITEM.Model = "models/gmod_tower/afro.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Up() * 2.5) + (ang:Forward() * -4.5) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end