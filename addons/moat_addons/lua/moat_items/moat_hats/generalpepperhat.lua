
ITEM.ID = 135

ITEM.Name = "General Pepper"

ITEM.Description = "Commander of the great and kind"

ITEM.Model = "models/lordvipes/generalpepperhat/generalpepperhat.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -4.2) + (ang:Right() * 0.4) +  (ang:Up() * 0.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

