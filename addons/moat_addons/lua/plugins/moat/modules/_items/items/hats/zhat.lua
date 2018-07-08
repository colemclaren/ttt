
ITEM.ID = 78

ITEM.Name = "Gangsta Hat"

ITEM.Description = "sup fam"

ITEM.Model = "models/captainbigbutt/skeyler/hats/zhat.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.68) + (ang:Right() * -0.013) +  (ang:Up() * 1.693) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

