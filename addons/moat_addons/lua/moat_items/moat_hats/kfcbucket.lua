
ITEM.ID = 108

ITEM.Name = "KFC Bucket"

ITEM.Description = "Incoming racist joke"

ITEM.Model = "models/gmod_tower/kfcbucket.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -2.6) + (ang:Up() * 0.2) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 25.8)

	return model, pos, ang

end

