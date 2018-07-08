ITEM.Name = "Combine Ball Effect"
ITEM.ID = 219
ITEM.Description = "Stop right there civilian scum"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/effects/combineball.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.3000,0.3000,0.3000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(84.5199,173.7400,97.04000)
	local MPos = Vector(5.2199,-0.6100,-8.2200)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 10 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	return model, pos, ang
end




