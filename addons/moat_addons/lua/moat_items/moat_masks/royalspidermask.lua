ITEM.Name = "Royal Spider Mask"
ITEM.ID = 654
ITEM.Description = "The itsy bitsy spider crawled up the royal kingdom"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/spidermask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0) + (ang:Up() * -1.8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

