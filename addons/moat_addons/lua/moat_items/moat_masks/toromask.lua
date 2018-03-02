
ITEM.ID = 128

ITEM.Name = "Toro Mask"

ITEM.Description = ":3"

ITEM.Model = "models/gmod_tower/toromask.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -4.6) + (ang:Up() * -0.8) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 10.6)

	return model, pos, ang

end

