
ITEM.ID = 134

ITEM.Name = "Tomas Helmet"

ITEM.Description = "Hit that"

ITEM.Model = "models/lordvipes/daftpunk/thomas.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -0.6) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

