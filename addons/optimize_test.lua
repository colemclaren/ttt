moat_TerroristModels = {}
moat_TerroristModels["models/player/arctic.mdl"] = ""
moat_TerroristModels["models/player/guerilla.mdl"] = ""
moat_TerroristModels["models/player/leet.mdl"] = ""
moat_TerroristModels["models/player/phoenix.mdl"] = ""

function m_IsTerroristModel(mdl)
    local pos = Vector(0, 0, 0)

    if (moat_TerroristModels[mdl]) then
        pos = Vector(0, 0, 2)
    end

    return pos
end

HAT_TABLE = {
	[1] = {
		Attachment	=	"eyes",
		AttachmentID	=	1,
		Collection	=	"Pumpkin Collection",
		Description	=	"An exclusive face mask from the Pumpkin Event",
		ID	=	5101,
		Kind	=	"Mask",
		Model	=	"models/player/holiday/facemasks/evil_clown.mdl",
		ModifyClientsideModel	= function(self, ply, model, pos, ang)
			model:SetModelScale(1.225, 0)
			pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())

			return model, pos, ang
		end,
		Name	=	"Evil Clown Facemask",
		Rarity	=	8,
		custompos	=	true,
		custompostbl = {
				[1]	=	0,
				[2]	=	0,
				[3]	=	1,
				[4]	=	0,
				[5]	=	0,
				[6]	=	0
		}},
	[2] = {
		Attachment	=	"eyes",
		AttachmentID	=	1,
		Collection	=	"Cosmetic Collection",
		Description	=	"Become the ultimate hipster",
		ID	=	137,
		Kind	=	"Hat",
		Model	=	"models/lordvipes/klonoahat/klonoahat.mdl",
		ModifyClientsideModel	=	function(self, ply, model, pos, ang )

			model:SetModelScale(0.77, 0)
			pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel( ply:GetModel() )

			return model, pos, ang
		end,
		Name	=	"Klonoa Hat",
		Rarity	=	1,
		custompos	=	true,
		custompostbl = {
				[1]	=	0,
				[2]	=	0,
				[3]	=	1,
				[4]	=	0,
				[5]	=	0,
				[6]	=	0
		}},
	[3] = {
		Bone	=	"ValveBiped.Bip01_Spine2",
		BoneID	=	3,
		Collection	=	"Urban Style Collection",
		Description	=	"I wonder what you're carrying inside? Perhaps a secret charm for increased luck..",
		ID	=	584,
		Kind	=	"Body",
		Model	=	"models/modified/backpack_1.mdl",
		ModifyClientsideModel	= function(self, ply, model, pos, ang)
			model:SetSkin( 0 )
			model:SetModelScale(1, 0)
			pos = pos + (ang:Right() * -3) + (ang:Up() * 0) + (ang:Forward() * 0)
			ang:RotateAroundAxis(ang:Up(), 90)
			ang:RotateAroundAxis(ang:Right(), 0)
			ang:RotateAroundAxis(ang:Forward(), 90)
			
			return model, pos, ang
		end,
		Name	=	"Red Backpack",
		Rarity	=	4,
		Skin	=	0,
		custompos	=	true,
		custompostbl = {
				[1]	=	0,
				[2]	=	0,
				[3]	=	1,
				[4]	=	0,
				[5]	=	0,
				[6]	=	0
		}},
	[4] = {
		Bone	=	"ValveBiped.Bip01_Head1",
		BoneID	=	6,
		Collection	=	"Sugar Daddy Collection",
		Description	=	"A special item given as a thanks to the sugar daddies of MG",
		ID	=	212,
		Kind	=	"Effect",
		Model	=	"models/props/cs_assault/money.mdl",
		ModifyClientsideModel	=	function(self, ply, model, pos, ang)
			local Size = Vector( 0.600,0.600,2.849 )
	
			local mat = Matrix()
	
			mat:Scale(Size)
			model:EnableMatrix( "RenderMultiply", mat )
			model:SetMaterial( "" )

			local MAngle = Angle(95.480,180,65.739)
			local MPos = Vector(2.609,0,-7.829)

			pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
			ang:RotateAroundAxis(ang:Forward(), MAngle.p)
			ang:RotateAroundAxis(ang:Up(), MAngle.y)
			ang:RotateAroundAxis(ang:Right(), MAngle.r)

			model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
			model.ModelDrawingAngle.p = (CurTime() * 0 *90)
			model.ModelDrawingAngle.y = (CurTime() * 0.610 *90)
			model.ModelDrawingAngle.r = (CurTime() * 0 *90)

			ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
			ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
			ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

			/*if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
				halo.Add( {model}, Color(148,192,72), 10, 10, 1)
			end*/

			return model, pos, ang
		end,
		Name	=	"Dola Effect",
		Rarity	=	8,
		}
}

local PLAYER = FindMetaTable("Player")

function PLAYER:RenderModel(v)
    if (not v.Kind or (v.Kind and (v.Kind == "Effect" and (false)))) then return end
    local pos = Vector()
    local ang = Angle()

    if (v.Attachment) then
        if (not v.AttachmentID) then v.AttachmentID = self:LookupAttachment(v.Attachment) end
        if (not v.AttachmentID) then return end
        local attach = self:GetAttachment(v.AttachmentID)
        if (not attach) then return end
        pos = attach.Pos
        ang = attach.Ang
    else
        if (not v.BoneID) then v.BoneID = self:LookupBone(v.Bone) end
        if (not v.BoneID) then return end
        pos, ang = self:GetBonePosition(v.BoneID)
    end

    v.ModelEnt, pos, ang = v:ModifyClientsideModel(self, v.ModelEnt, pos, ang)
        
    if (not v.ModelSizeCache) then v.ModelSizeCache = v.ModelEnt:GetModelScale() end

    if (v.custompos) then
        v.ModelEnt:SetModelScale(v.ModelSizeCache * v.custompostbl[3], 0)
        pos = pos + (ang:Forward() * v.custompostbl[4])
        pos = pos + (ang:Right() * -v.custompostbl[5])
        pos = pos + (ang:Up() * v.custompostbl[6])
        ang:RotateAroundAxis(ang:Right(), -v.custompostbl[1])
        ang:RotateAroundAxis(ang:Up(), v.custompostbl[2])
    end

    v.ModelEnt:SetPos(pos)
    v.ModelEnt:SetAngles(ang)
    v.ModelEnt:SetRenderOrigin(pos)
    v.ModelEnt:SetRenderAngles(ang)
    v.ModelEnt:SetupBones()
    v.ModelEnt:DrawModel()
    v.ModelEnt:SetRenderOrigin()
    v.ModelEnt:SetRenderAngles()
end

function MOAT_LOADOUT.DrawClientsideModels(ply)
    --if (MOAT_MINIGAME_OCCURING or ply:Team() == TEAM_SPEC or not MOAT_CLIENTSIDE_MODELS[ply] or (GetConVar("moat_EnableCosmetics"):GetInt() == 0) or (not ply.PlayerVisible)) then return end
    if (not IsValid(ply) or ply == LocalPlayer()) then return end
    
    if (HAT_TABLE[ply][1]) then ply:RenderModel(HAT_TABLE[ply][1]) end
    if (HAT_TABLE[ply][2]) then ply:RenderModel(HAT_TABLE[ply][2]) end
    if (HAT_TABLE[ply][3]) then ply:RenderModel(HAT_TABLE[ply][3]) end
    if (HAT_TABLE[ply][4]) then ply:RenderModel(HAT_TABLE[ply][4]) end
end
hook.Add("PostPlayerDraw", "moat_DrawClientsideModels", MOAT_LOADOUT.DrawClientsideModels)

concommand.Add("moop", function()

	for k, v in pairs(player.GetAll()) do
		HAT_TABLE[v] = {HAT_TABLE[1], HAT_TABLE[2], HAT_TABLE[3], HAT_TABLE[4]}

		for i = 1, 4 do
			HAT_TABLE[v][i].ModelEnt = ClientsideModel(item.Model, RENDERGROUP_OPAQUE)
        	HAT_TABLE[v][i].ModelEnt:SetNoDraw(true)
		end
    end
end)