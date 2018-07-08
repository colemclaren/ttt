
ITEM.ID = 98

ITEM.Name = "Baseball Cap"

ITEM.Description = "Never forget the GMod Tower games. May they rest in peace"

ITEM.Model = "models/gmod_tower/baseballcap.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * 1.2) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), -20)
	ang:RotateAroundAxis(ang:Up(), 180)

	return model, pos, ang

end

