
ITEM.ID = 81

ITEM.Name = "Straw Hat"

ITEM.Description = "Old McDonald had a farm"

ITEM.Model = "models/captainbigbutt/skeyler/hats/strawhat.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.2) + m_IsTerroristModel( ply:GetModel() )
	return model, pos, ang

end

