
ITEM.ID = 69

ITEM.Name = "Stylish Glasses"

ITEM.Description = "Work those pretty little things gurl"

ITEM.Model = "models/captainbigbutt/skeyler/accessories/glasses02.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -1.2) + (ang:Up() * -1.2) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 7.6)

	return model, pos, ang

end

