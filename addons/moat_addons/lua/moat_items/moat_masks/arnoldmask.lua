ITEM.Name = "Arnold Mask"
ITEM.ID = 658
ITEM.Description = "Grrr.. I'm a mean dog"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/arnold_mask/arnold_mask.mdl"
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

