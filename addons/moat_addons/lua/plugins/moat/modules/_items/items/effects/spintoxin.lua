ITEM.Name = "Toxin Effect"
ITEM.ID = 260
ITEM.Description = "You're toxic"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/cs_office/trash_can_p6.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(161,255,0)
ITEM.EffectSize = 2


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("phoenix_storms/pack2/interior_sides")

	local MAngle = Angle(0,0,0)
	local MPos = Vector(7.8299,0,-0.03999)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.0399 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	return model, pos, ang
end

