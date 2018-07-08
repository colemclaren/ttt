ITEM.Name = "Royal Cat Mask"
ITEM.ID = 657
ITEM.Description = "Don't touch me, I'm fabulous"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/catmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0.6) + (ang:Up() * -4.6)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

