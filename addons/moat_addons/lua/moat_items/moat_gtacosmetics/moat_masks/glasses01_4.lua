ITEM.Name = "Bronze Vintage Glasses"
ITEM.ID = 513
ITEM.Description = "Bronze. The Shiny Brown"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 4 )
	if (moat_TerroristModels[ply:GetModel()]) then

		model:SetModelScale( 1.15, 0 )
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)

	else

		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)

	end
	
	return model, pos, ang
end

