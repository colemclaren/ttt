
ITEM.ID = 71

ITEM.Name = "Grandma Glasses"

ITEM.Description = "I hope these are big enough for you"

ITEM.Model = "models/captainbigbutt/skeyler/accessories/glasses04.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -1.4) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 7.6)

	return model, pos, ang

end
