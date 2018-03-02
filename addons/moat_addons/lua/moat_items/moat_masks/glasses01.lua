ITEM.Name = "Black Vintage Glasses"
ITEM.ID = 509
ITEM.Description = "Like the Gray Vintage Glasses, but darker"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )

	if (moat_TerroristModels[ply:GetModel()]) then

		model:SetModelScale( 1.15, 0 )
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)

	else

		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)

	end

	
	return model, pos, ang
end

