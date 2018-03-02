
ITEM.ID = 82

ITEM.Name = "Star Headband"

ITEM.Description = "You are amazing"

ITEM.Model = "models/captainbigbutt/skeyler/hats/starband.mdl"

ITEM.Rarity = 1

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

