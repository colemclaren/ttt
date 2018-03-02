
ITEM.ID = 109

ITEM.Name = "King Boo's Crown"

ITEM.Description = "Boo, bitch"

ITEM.Model = "models/gmod_tower/king_boos_crown.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 2.8) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), -19.6)
	return model, pos, ang

end

