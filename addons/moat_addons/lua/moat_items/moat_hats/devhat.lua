
ITEM.ID = 90

ITEM.Name = "Developer Hat"

ITEM.Description = "This is an exclusive hat given to people that have created content for MG"

ITEM.Model = "models/captainbigbutt/skeyler/hats/devhat.mdl"

ITEM.Rarity = 8

ITEM.Collection = "Dev Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

