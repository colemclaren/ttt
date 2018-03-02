ITEM.Name = "Bloody Butterfly Mask"
ITEM.ID = 650
ITEM.Description = "A very pale butterfly feasts on terrorist souls"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 2
ITEM.Model = "models/splicermasks/butterflymask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.6) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

