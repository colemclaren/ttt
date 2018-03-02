
ITEM.ID = 59

ITEM.Name = "Cat Ears"

ITEM.Description = "You look so cute with these cat ears on, omfg"

ITEM.Model = "models/gmod_tower/catears.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.5) + (ang:Up() * 2.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end