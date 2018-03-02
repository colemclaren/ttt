
ITEM.ID = 140

ITEM.Name = "Makar's Mask"

ITEM.Description = "That's a very nice leaf you have there"

ITEM.Model = "models/lordvipes/makarmask/makarmask.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(2.2, 0)
	pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -9.6) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), -16)

	return model, pos, ang

end

