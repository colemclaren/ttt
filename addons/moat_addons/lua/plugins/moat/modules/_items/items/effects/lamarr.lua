ITEM.Name = "Lamar Effect"
ITEM.ID = 239
ITEM.Description = "Wazzup people"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/nova/w_headcrab.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,204,0)


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.300,0.300,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(173.740,286.429,84.51)
	local MPos = Vector(4.61,-1.61,7.21)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	return model, pos, ang
end

