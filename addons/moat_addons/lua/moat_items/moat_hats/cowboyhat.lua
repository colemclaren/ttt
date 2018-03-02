
ITEM.ID = 92

ITEM.Name = "Cowboy Hat"

ITEM.Description = "It's hiiiigh nooon"

ITEM.Model = "models/captainbigbutt/skeyler/hats/cowboyhat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.7, 0)
	pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 3.2) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 13.2)

	return model, pos, ang

end

