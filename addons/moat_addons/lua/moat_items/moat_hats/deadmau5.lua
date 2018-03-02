
ITEM.ID = 91

ITEM.Name = "Deadmau5"

ITEM.Description = "A musicly talented deceased rodent"

ITEM.Model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

