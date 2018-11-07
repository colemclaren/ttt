ITEM.Name = "Diamond Effect"
ITEM.ID = 223
ITEM.Description = "Shine bright"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/gibs/hgibs.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,255,255)
ITEM.EffectSize = 2


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.60000,0.6000,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("models/wireframe")

	local MAngle = Angle(95.48000,180,65.739)
	local MPos = Vector(2.6099,2.6099,7.829)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0.827 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0.829 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.779 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	return model, pos, ang
end

