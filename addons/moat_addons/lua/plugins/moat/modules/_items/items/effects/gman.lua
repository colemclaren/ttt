ITEM.Name = "GMan Effect"
ITEM.ID = 230
ITEM.Description = "Good morning Mr. Freeman"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/perftest/gman.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(124,113,175)



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.1500,0.1500,0.1500)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(92.349,0,280.170)
	local MPos = Vector(3.609,-2.609,7.219)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	return model, pos, ang
end