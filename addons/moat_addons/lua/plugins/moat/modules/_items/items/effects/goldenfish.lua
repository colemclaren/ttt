ITEM.Name = "Koi Effect"
ITEM.ID = 231
ITEM.Description = "Just keep swimming, just keep swimming swimming swimming"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_inferno/goldfish.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(241,17,17)


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(0,350.609,269.220)
	local MPos = Vector(7.8299,-2.6099,-10.430)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	return model, pos, ang
end

