ITEM.Name = "Gray Vintage Glasses"
ITEM.ID = 514
ITEM.Description = "Vintage - Black and White - Gray. It all adds up"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 5 )
	if (moat_TerroristModels[ply:GetModel()]) then

		model:SetModelScale( 1.15, 0 )
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)

	else

		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)

	end
	
	return model, pos, ang
end

