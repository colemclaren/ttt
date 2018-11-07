ITEM.Name = "Horse Effect"
ITEM.ID = 234
ITEM.Description = "Neighhhh"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_phx/games/chess/white_knight.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,231,159)
ITEM.EffectSize = 3.7


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.2000,0.2000,0.2000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(0,0,269.649)
	local MPos = Vector(3.2200,-2.6099,-7.8299)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.2593 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	return model, pos, ang
end

