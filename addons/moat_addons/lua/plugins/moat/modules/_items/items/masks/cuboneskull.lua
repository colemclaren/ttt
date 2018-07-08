
ITEM.ID = 133

ITEM.Name = "Cubone Skull"

ITEM.Description = "I choose you"

ITEM.Model = "models/lordvipes/cuboneskull/cuboneskull.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.3, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Up() * -6.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

