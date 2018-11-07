ITEM.Name = "Turtle Effect"
ITEM.ID = 266
ITEM.Description = "Awww it's a turtle"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_tides/vending_turtle.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(122,230,86)


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(0,341.2200,264.519)
	local MPos = Vector(5.2199,-1,-7.829)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	return model, pos, ang
end

