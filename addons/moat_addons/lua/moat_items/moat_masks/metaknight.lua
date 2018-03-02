
ITEM.ID = 113

ITEM.Name = "Metaknight Mask"

ITEM.Description = "Where the fuck is Kirby"

ITEM.Model = "models/gmod_tower/metaknight_mask.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -4.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

