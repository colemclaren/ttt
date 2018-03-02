
ITEM.ID = 70

ITEM.Name = "Shutter Glasses"

ITEM.Description = "The party is just getting started"

ITEM.Model = "models/captainbigbutt/skeyler/accessories/glasses03.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -0.8) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 7.6)

	return model, pos, ang

end