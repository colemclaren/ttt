
ITEM.Name = "Snowman Effect"
ITEM.ID = 237
ITEM.Description = "Frosty the snowman was jolly good fellow"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/cs_office/snowman_face.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,255,255)


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.4000,0.4000,0.4000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(1.5701,0,264.519)
	local MPos = Vector(7.829,-1,-7.829)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	return model, pos, ang
end


