
ITEM.ID = 127

ITEM.Name = "Top Hat"

ITEM.Description = "If only you had a suit"

ITEM.Model = "models/gmod_tower/tophat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 0.6) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 10.6)

	return model, pos, ang

end

