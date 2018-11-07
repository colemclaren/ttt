ITEM.Name = "Gordon Effect"
ITEM.ID = 264
ITEM.Description = "What small body you have there Mr. Freeman"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/editor/playerstart.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.1500,0.1500,0.1500)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(264.519,180,97.0400)
	local MPos = Vector(4.610,-1.610,7.219)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(0,255,0),
	2.7,
	2.7,
	1)
	end


	return model, pos, ang
end


