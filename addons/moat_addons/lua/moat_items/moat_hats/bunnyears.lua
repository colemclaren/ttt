
ITEM.ID = 95

ITEM.Name = "Bunny Ears"

ITEM.Description = "Hello there Mr Bunny"

ITEM.Model = "models/captainbigbutt/skeyler/hats/bunny_ears.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel( ply:GetModel() )
	return model, pos, ang

end

