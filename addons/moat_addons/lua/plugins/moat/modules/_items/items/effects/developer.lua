ITEM.Name = "Developer Effect"
ITEM.ID = 222
ITEM.Description = "Time for the dev to get sxy"
ITEM.Rarity = 8
ITEM.Collection = "Dev Collection"
ITEM.Model = "models/props_c17/tools_wrench01a.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(250,255,0)

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.8000, 0.5, 0.5)
	local mat = Matrix()
	local CT = CurTime()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("models/gibs/metalgibs/metal_gibs")

	local MAngle = Angle(236.35000,277.04002,360)
	local MPos = Vector(10.22000,-1,-8.220)

	pos = pos + ang:Forward() * MPos.x + ang:Up() * MPos.z + ang:Right() * MPos.y
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = CT * 0 * 90
	model.ModelDrawingAngle.y = CT * 1.129 * 90
	model.ModelDrawingAngle.r = CT * 1.039 * 90

	ang:RotateAroundAxis(ang:Forward(), model.ModelDrawingAngle.p)
	ang:RotateAroundAxis(ang:Up(), model.ModelDrawingAngle.y)
	ang:RotateAroundAxis(ang:Right(), model.ModelDrawingAngle.r)

	return model, pos, ang
end





