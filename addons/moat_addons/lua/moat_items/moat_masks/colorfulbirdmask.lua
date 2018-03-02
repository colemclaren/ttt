ITEM.Name = "Colorful Bird Mask"
ITEM.ID = 652
ITEM.Description = "You are a colorful human bird"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/birdmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

