
ITEM.ID = 119

ITEM.Name = "Samus Helmet"

ITEM.Description = "It's a girl"

ITEM.Model = "models/gmod_tower/samushelmet.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -2.05) + (ang:Up() * -1.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

