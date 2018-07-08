ITEM.ID = 5104
ITEM.Name = "Gold Bunny Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_bunny_gold.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())

	return model, pos, ang
end

