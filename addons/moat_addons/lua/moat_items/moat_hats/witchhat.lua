
ITEM.ID = 130

ITEM.Name = "Witch Hat"

ITEM.Description = "Mwahahaha"

ITEM.Model = "models/gmod_tower/witchhat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 1.4) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 22.6)

	return model, pos, ang

end

