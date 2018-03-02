
ITEM.ID = 106

ITEM.Name = "Headcrab"

ITEM.Description = "You will be eaten alive"

ITEM.Model = "models/gmod_tower/headcrabhat.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.7, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 3.4) + m_IsTerroristModel( ply:GetModel() )
	return model, pos, ang

end

