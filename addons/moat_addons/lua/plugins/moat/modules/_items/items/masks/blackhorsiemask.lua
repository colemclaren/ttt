ITEM.Name = "Stallion Mask"
ITEM.ID = 666
ITEM.Description = "You are a beautiful horse"
ITEM.Rarity = 7
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/horsie/horsiemask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.2) + (ang:Right() * 0) + (ang:Up() * 0.8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

