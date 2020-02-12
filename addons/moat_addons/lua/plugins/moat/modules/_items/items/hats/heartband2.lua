
ITEM.ID = 6572

ITEM.Name = "Heartband"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Description = "Wear this if you have no friends and want people to love you"

ITEM.Model = "models/captainbigbutt/skeyler/hats/heartband.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Valentine Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

