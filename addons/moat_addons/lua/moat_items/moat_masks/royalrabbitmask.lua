ITEM.Name = "Royal Rabbit Mask"
ITEM.ID = 653
ITEM.Description = "Hop hop hop... here comes the royal easter bunny"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/rabbitmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.8) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

