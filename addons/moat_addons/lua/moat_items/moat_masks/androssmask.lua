
ITEM.ID = 77

ITEM.Name = "Andross Mask"

ITEM.Description = "I've been waiting for you, Star Fox. You know that I control the galaxy. It's foolish to come against me. You will die just like your father"

ITEM.Model = "models/gmod_tower/androssmask.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -1) + (ang:Up() * -2.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

