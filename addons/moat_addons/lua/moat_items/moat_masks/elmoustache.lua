
ITEM.ID = 72

ITEM.Name = "El Mustache"

ITEM.Description = "You sir are the most handsome and dashing man in all of the server"

ITEM.Model = "models/captainbigbutt/skeyler/accessories/mustache.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -2.4) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 7.6)

	return model, pos, ang

end