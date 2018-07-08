
ITEM.ID = 139

ITEM.Name = "Majora's Mask"

ITEM.Description = "It is a colorful mask"

ITEM.Model = "models/lordvipes/majoramask/majoramask.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -9.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

