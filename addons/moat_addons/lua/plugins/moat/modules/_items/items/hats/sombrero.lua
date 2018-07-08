
ITEM.ID = 123

ITEM.Name = "Sombrero"

ITEM.Description = "Arriba"

ITEM.Model = "models/gmod_tower/sombrero.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 12.6)

	return model, pos, ang

end

