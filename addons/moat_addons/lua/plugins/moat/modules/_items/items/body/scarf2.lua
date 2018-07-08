ITEM.Name = "Black Scarf"
ITEM.ID = 578
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
