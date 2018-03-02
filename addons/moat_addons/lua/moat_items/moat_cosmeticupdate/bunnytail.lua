
ITEM.ID = 76

ITEM.Name = "Kliener Glasses"

ITEM.Description = "Don't stop the knowledge from making you look good you beautiful animal"

ITEM.Model = "models/captainbigbutt/skeyler/accessories/duck_tube.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(SCALE, 0)
	pos = pos + (ang:Forward() * X) + (ang:Right() * -Y) +  (ang:Up() * Z) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), -PITCH)
	ang:RotateAroundAxis(ang:Up(), YAW)
	ang:RotateAroundAxis(ang:Forward(), ROLL)

	return model, pos, ang

end

