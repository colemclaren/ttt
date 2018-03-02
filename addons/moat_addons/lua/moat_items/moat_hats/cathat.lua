
ITEM.ID = 93

ITEM.Name = "Cat Hat"

ITEM.Description = "This does not give you 9 lives"

ITEM.Model = "models/captainbigbutt/skeyler/hats/cat_hat.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

