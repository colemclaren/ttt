
ITEM.ID = 85

ITEM.Name = "Monocle"

ITEM.Description = "You probably think you're smart now. That's incorrect"

ITEM.Model = "models/captainbigbutt/skeyler/accessories/monocle.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -2.8) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 22.4)
	ang:RotateAroundAxis(ang:Up(),-9)
	ang:RotateAroundAxis(ang:Forward(), 153.8)

	return model, pos, ang

end

