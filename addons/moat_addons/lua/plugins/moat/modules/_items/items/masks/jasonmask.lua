
ITEM.ID = 103

ITEM.Name = "Jason Mask"

ITEM.Description = "Boo"

ITEM.Model = "models/gmod_tower/halloween_jasonmask.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -6.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

