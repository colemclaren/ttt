ITEM.Name = "Robot Effect"
ITEM.ID = 218
ITEM.Description = "Boop beep bop boop"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/perftest/loader.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.0299,0.0299,0.0299)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(84.519,0,275.4800)
	local MPos = Vector(5.219,-2.609,-5.219)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(255,204,0),
	1,
	1,
	1)
	end


	return model, pos, ang
end


-- this one is my favo