
ITEM.ID = 116

ITEM.Name = "Party Hat"

ITEM.Description = "Raise the ruff"

ITEM.Model = "models/gmod_tower/partyhat.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3) + (ang:Right() * 1.2) +  (ang:Up() * 2.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

