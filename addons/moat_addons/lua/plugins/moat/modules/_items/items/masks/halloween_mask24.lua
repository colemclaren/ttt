ITEM.ID = 5117
ITEM.Name = "TF2 Engineer Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_engi_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())

	return model, pos, ang
end

