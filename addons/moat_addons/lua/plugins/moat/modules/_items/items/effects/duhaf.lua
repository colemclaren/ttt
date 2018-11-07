ITEM.Name = "Duhaf Effect"
ITEM.ID = 227
ITEM.Description = "What the duhaf"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/gibs/strider_gib3.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(0,255,63)
ITEM.EffectSize = 3.7


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.200,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("phoenix_storms/wire/pcb_green")

	local MAngle = Angle(0,101.7399,78.260)
	local MPos = Vector(10.430,0.6100,0)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	return model, pos, ang
end
