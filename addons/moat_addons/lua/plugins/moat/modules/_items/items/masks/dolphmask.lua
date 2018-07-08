ITEM.Name = "Dolph Mask"
ITEM.ID = 661
ITEM.Description = "My horns will pierce any terrorist that gets in my way"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/dolph_mask/dolph_mask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

