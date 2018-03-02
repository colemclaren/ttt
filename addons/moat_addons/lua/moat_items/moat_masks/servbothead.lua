
ITEM.ID = 77

ITEM.Name = "Servbot Head"

ITEM.Description = "Smile"

ITEM.Model = "models/lordvipes/servbothead/servbothead.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -2.6) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

