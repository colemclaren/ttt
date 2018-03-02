ITEM.Name = "Brown Horsie Mask"
ITEM.ID = 665
ITEM.Description = "Neihhhh, feed me apples and take me to water"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 0
ITEM.Model = "models/horsie/horsiemask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.2) + (ang:Right() * 0) + (ang:Up() * 0.8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

