
ITEM.ID = 73

ITEM.Name = "Bear Hat"

ITEM.Description = "Now you will always have your teddy bear with you, in a hat form"

ITEM.Model = "models/captainbigbutt/skeyler/hats/bear_hat.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * 3.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

