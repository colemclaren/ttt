
ITEM.ID = 213

ITEM.Name = "Black Hole Effect"

ITEM.Description = "The center of the universe"

ITEM.Model = "models/effects/vol_light128x128.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Effect Collection"

ITEM.Bone = "ValveBiped.Bip01_Spine4"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	local Size = Vector(0.200,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("models/effects/portalrift_sheet")

	local MAngle = Angle(90,0,277.0)
	local MPos = Vector(23.26,-2,0)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = ((CurTime() * 0.5) * 0 *90)
	model.ModelDrawingAngle.y = ((CurTime() * 0.5) * 2.60 *90)
	model.ModelDrawingAngle.r = ((CurTime() * 0.5) * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	return model, pos, ang
	
end