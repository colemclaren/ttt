ITEM.ID = 5122
ITEM.Name = "Dallas Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_dallas.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())

	return model, pos, ang
end

