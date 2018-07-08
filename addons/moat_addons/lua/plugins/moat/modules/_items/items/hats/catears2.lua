
ITEM.ID = 94

ITEM.Name = "Large Cat Ears"

ITEM.Description = "What big ears you have you majestic beast"

ITEM.Model = "models/captainbigbutt/skeyler/hats/cat_ears.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * -0.2) +  (ang:Up() * -5.8) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

