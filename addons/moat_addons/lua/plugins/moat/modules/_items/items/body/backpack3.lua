ITEM.Name = "Black Tactical Backpack"
ITEM.ID = 573
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/backpack_3.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin( 0 )
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 0.9)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end