
ITEM.ID = 117

ITEM.Name = "Pilgrim Hat"

ITEM.Description = "What is a Mayflower"

ITEM.Model = "models/gmod_tower/pilgrimhat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 1.2) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 16.4)

	return model, pos, ang

end

