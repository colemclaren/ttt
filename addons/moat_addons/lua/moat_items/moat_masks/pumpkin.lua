
ITEM.ID = 84

ITEM.Name = "Scary Pumpkin"

ITEM.Description = "Shine bright like a pumpkin"

ITEM.Model = "models/captainbigbutt/skeyler/hats/pumpkin.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -3) + m_IsTerroristModel( ply:GetModel() )
	return model, pos, ang

end

