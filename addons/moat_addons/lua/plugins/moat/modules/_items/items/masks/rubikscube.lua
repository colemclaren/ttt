
ITEM.ID = 118

ITEM.Name = "Rubiks Cube"

ITEM.Description = "You can't solve this one"

ITEM.Model = "models/gmod_tower/rubikscube.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.6, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

