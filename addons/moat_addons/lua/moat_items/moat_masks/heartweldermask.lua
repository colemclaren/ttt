ITEM.Name = "Heart Welder Mask"
ITEM.ID = 663
ITEM.Description = "You weld broken hearts back together"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/weldingmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Right() * 2.6) + (ang:Up() * -7.6)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

