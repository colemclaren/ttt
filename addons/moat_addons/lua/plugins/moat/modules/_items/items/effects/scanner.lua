ITEM.Name = "QT Effect"
ITEM.ID = 257
ITEM.Description = "I hope this helps you"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/editor/cone_helper.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(0,169,255)
ITEM.EffectSize = 8.6


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.300,0.300,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(264.519,180,97.040)
	local MPos = Vector(4.6100,-1.610,7.219)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.2599 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.7799 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	return model, pos, ang
end



