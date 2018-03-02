
ITEM.ID = 104

ITEM.Name = "Nightmare Hat"

ITEM.Description = "Jack is on your head.."

ITEM.Model = "models/gmod_tower/halloween_nightmarehat.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -4.2) + (ang:Up() * 1.6) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

