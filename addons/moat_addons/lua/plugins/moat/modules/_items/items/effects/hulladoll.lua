ITEM.Name = "Huladoll Effect"
ITEM.ID = 236
ITEM.Description = "That's racist to my culture sir"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/huladoll.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(17,241,84)



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(100.1699,360,280.1700)
	local MPos = Vector(5.219,-2.6099,-7.8299)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	return model, pos, ang
end
