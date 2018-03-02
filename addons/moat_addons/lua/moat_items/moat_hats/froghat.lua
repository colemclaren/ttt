
ITEM.ID = 88

ITEM.Name = "Frog Hat"

ITEM.Description = "Ribbit ribbit bitch"

ITEM.Model = "models/captainbigbutt/skeyler/hats/frog_hat.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.6, 0)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

