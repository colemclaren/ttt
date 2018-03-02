
ITEM.ID = 136

ITEM.Name = "Keaton Mask"

ITEM.Description = "What did the fox say"

ITEM.Model = "models/lordvipes/keatonmask/keatonmask.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -5.6) + (ang:Up() * -0.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

