
ITEM.ID = 80

ITEM.Name = "Sun Hat"

ITEM.Description = "It has flowers and protects you from the sun"

ITEM.Model = "models/captainbigbutt/skeyler/hats/sunhat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -5) + (ang:Up() * 0.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

