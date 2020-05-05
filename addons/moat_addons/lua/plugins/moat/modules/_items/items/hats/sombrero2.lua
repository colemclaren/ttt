ITEM.ID = 3396
ITEM.Name = "Mexican Sombrero"
ITEM.Description = "A special hat in the annual celebration of Cinco de Mayo."
ITEM.Model = "models/gmod_tower/sombrero.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )
	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 12.6)

	return model, pos, ang
end

