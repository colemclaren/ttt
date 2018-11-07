ITEM.Name = "Potke Effect"
ITEM.ID = 242
ITEM.Description = "You a sexy motherfucka"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/shadertest/vertexlittextureplusenvmappedbumpmap.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(0,246,255)


function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.150,0.150,0.150)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(86.089,3.130,280.17)
	local MPos = Vector(2.60,-2,6.21)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	return model, pos, ang
end