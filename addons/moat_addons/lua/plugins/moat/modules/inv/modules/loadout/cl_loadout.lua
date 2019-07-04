local propspec_outline 		= Material("models/props_combine/portalball001_sheet")
local EnableCosmetics 		= CreateClientConVar("moat_EnableCosmetics", 1, true, true)
local EnableEffects 		= CreateClientConVar("moat_EnableEffects", 1, true, true)
local PLAYER 				= FindMetaTable("Player")
local ENTITY 				= FindMetaTable("Entity")
local VECTOR 				= FindMetaTable("Vector")
local LocalPlayer           = LocalPlayer
local EyePos                = ENTITY.EyePos
local DistToSqr             = VECTOR.DistToSqr
local IsLineOfSightClear    = ENTITY.IsLineOfSightClear
local util_TraceLine        = util.TraceLine
local LP
local trace = {mask = -1, filter  = {}}
MOAT_LOADOUT = MOAT_LOADOUT or {}
if (not MOAT_CLIENTSIDE_MODELS) then
	MOAT_CLIENTSIDE_MODELS = {}
end

function PLAYER:CanView()
	return false
end

function PLAYER:CanSee()
	return false
end

local function load_sight_func()
	LP = LocalPlayer()
	trace.filter[1] = LocalPlayer()

	function PLAYER:CanView()
		if (DistToSqr(EyePos(self), EyePos(LP)) < 750000) then
			return IsLineOfSightClear(LP, self)
		end
		return false
	end

	function PLAYER:CanSee()
		trace.start     = EyePos(LP)
		trace.endpos    = EyePos(self)
		trace.filter[2] = self

		return not util_TraceLine(trace).Hit
	end

	hook.Remove("Think", "CanSeePlayer")
end

hook.Add("Think", "CanSeePlayer", function()
	if (IsValid(LocalPlayer())) then load_sight_func() end
end)

hook.Add("RenderScene", "EnsurePlayerVisibility", function()
	local LP = LocalPlayer()
	local obs = LP:GetObserverMode()

	for ply, items in pairs(MOAT_CLIENTSIDE_MODELS) do
		if (not IsValid(ply)) then
			for _, item in pairs(items) do
				if (IsValid(item.ModelEnt)) then
					item.ModelEnt:Remove()
				end
			end
			MOAT_CLIENTSIDE_MODELS[ply] = nil
			continue
		end

		local should_draw = EnableCosmetics:GetBool()
			and not ply:GetNoDraw() and not ply:IsDormant()
			and not GetGlobal("MOAT_MINIGAME_ACTIVE") and ply:Team() ~= TEAM_SPEC
			and (LP ~= ply and true or ply:ShouldDrawLocalPlayer())
			and (obs ~= OBS_MODE_IN_EYE and true or LP:GetObserverTarget() ~= ply)

		for _, item in pairs(items) do
			if (IsValid(item.ModelEnt)) then
				if (item.Kind and item.Kind == "Effect" and not EnableEffects:GetBool() or item.Hide) then 
					item.ModelEnt:SetNoDraw(true)
				else
					item.ModelEnt:SetNoDraw(not should_draw)
				end
			end
		end
	end
end)


local function RenderOverrideColor(self)
	local col = self.Col
	if (self.Dream) then
		col = rarity_names[9][2]
	end

	render.SetColorModulation(col.r / 255, col.g / 255, col.b / 255)
	self:DrawModel()
	render.SetColorModulation(1, 1, 1)
end

function LayoutItem(ply, item, attmpt)
	attmpt = (attmpt or 0) + 1
	if (not IsValid(ply) or not IsValid(item.ModelEnt)) then
		return
	end
	local pos, ang = Vector(), Angle()
	if (item.ModifyClientsideModel) then
		item.ModelEnt, pos, ang = item:ModifyClientsideModel(ply, item.ModelEnt, pos, ang)
	end
	if (not item.ModelSizeCache) then item.ModelSizeCache = item.ModelEnt:GetModelScale() end
	if (item.custompos) then
		item.ModelEnt:SetModelScale(item.ModelSizeCache * item.custompostbl[3], 0)
		pos = pos + (ang:Forward() * item.custompostbl[4])
		pos = pos + (ang:Right() * -item.custompostbl[5])
		pos = pos + (ang:Up() * item.custompostbl[6])
		ang:RotateAroundAxis(ang:Right(), -item.custompostbl[1])
		ang:RotateAroundAxis(ang:Up(), item.custompostbl[2])
	end
	item.ModelEnt:SetTransmitWithParent(true)

	item.LocalPos = pos
	item.LocalAng = ang
	if (item.Skin) then
		item.ModelEnt:SetSkin(item.Skin)
	end

	if (item.Bone) then
		item.BoneID = ply:LookupBone(item.Bone)

		if (not item.BoneID or item.BoneID == -1) then
			print("warning: bone " .. item.Bone .. " does not exist on model " .. ply:GetModel())
			return
		end

		item.ModelEnt:FollowBone(ply, item.BoneID)

		if (ply:GetBoneParent(item.BoneID) <= 0 or not ply:BoneHasFlag(item.BoneID, BONE_USED_BY_VERTEX_LOD0)) then
			if (attmpt < 5) then
				timer.Simple(3, function()
					LayoutItem(ply, item, attmpt)
				end)
			else
				-- error("Bone " .. item.Bone .. " can not be used with FollowBone on model " .. ply:GetModel())
			end
		end
	elseif (item.Attachment) then
		item.AttachmentID = ply:LookupAttachment(item.Attachment)
		item.ModelEnt:SetParent(ply, item.AttachmentID)
	end
	item.ModelEnt:SetLocalPos(pos)
	item.ModelEnt:SetLocalAngles(ang)
	item.ModelEnt:SetMoveType(MOVETYPE_NONE)
	item.ModelEnt.item = item

	if (item.Col) then
		item.ModelEnt.Col = item.Col
		item.ModelEnt.Dream = item.Dream
		item.ModelEnt.RenderOverride = RenderOverrideColor
	end
end

local IMATERIAL = FindMetaTable("IMaterial")
local vector = Vector
local set_vector = IMATERIAL.SetVector
local mat = Material
local getmats = ENTITY.GetMaterials
local reg = vector(1, 1, 1)
local mats_cache = {}
local MatOverrides = {}
-- lua_run for k, v in pairs(weapons.GetList()) do if (v.ClassName:StartWith("weapon_ttt_te_") or v.AutoSpawnable) then me():m_DropInventoryItem("Soft", v.ClassName) end end

SKIN_SKIP = {
	"v_hand",
	"hands",
	"scope",
	"accessories",
	"arrow",
	"box",
	"belt",
	"stock",
	"shell",
	"screen",
	"error",
	"12guage",
	"red_dot$",
	"lense",
	"bullet",
	"glass",
}

SKIN_IGNORE = {
["models/weapons/v_models/slayer's_msbs/msbs"] = true,
["models/weapons/v_models/slayer's_msbs/naboj"] = true,
["models/weapons/v_models/hands/sleeve_diffuse"] = true,
["models/weapons/v_models/zaratusa.golden.deagle/grip"] = true,
["models/weapons/v_models/zaratusa.golden.deagle/no_phong_frame"] = true,
["models/weapons/v_models/zaratusa.golden.deagle/no_phong_front"] = true,
["models/weapons/v_models/virflakhg/bullets"] = true,
["models/weapons/bo2r_peacekeeper/peacekeeper_d2"] = true,
["models/weapons/v_models/9mmhandgun/line"]=true,
["models/weapons/v_models/vintorez/v_vintorez_glass"]=true,
["models/weapons/v_models/vintorez/v_vintorez_lense"]=true,
["models/weapons/v_models/vintorez/v_vintorez_pso"]=true,
["models/weapons/v_models/vintorez/v_vintorez_bullets"]=true,
["models/weapons/v_models/vintorez/v_vintorez_rubber"]=true,
["models/weapons/v_models/vintorez/v_vintorez_wood"]=true,
["models/weapons/v_models/vintorez/v_vintorez_bakelite"]=true,
["models/weapons/pvpspist/eotech"]=true,
["models/weapons/pvpspist/visier"]=true,
["models/weapons/pvpspist/usp_sil"]=true,
["models/oggmix/masogg"]=true,
["models/oggmix/fxogg"]=true,
}

SKIN_PASS = {
["models/weapons/v_models/g3a3/stockbit"] = true,
["models/weapons/v_models/vollmer/box"] = true,
["models/weapons/v_models/pvpxm8model/scope"] = true,
["models/weapons/v_models/ak47/stockmap"] = true,
}

SKIN_NOPAINT = {
["models/weapons/v_models/pvpxm8model/scope"] = true,
---["models/weapons/v_models/vintorez/v_vintorez_wood"]=true,
}

local cache = {}
function SkipMaterialCover(matstr)
	if (cache[matstr] == nil) then
		for k, v in ipairs(SKIN_SKIP) do
			print(matstr, v, string.find(matstr, v))
			if (string.find(matstr, v)) then
				cache[matstr] = true
			end
		end

		if (not cache[matstr]) then
			cache[matstr] = false
		end
	end

	return cache[matstr]
end

local mat_names = {
	["IMaterial"] = true,
	["ITexture"] = true
}

function MOAT_LOADOUT.SetupSkins(wpn, vm, preview, key, wpn_mdl)
	if (not wpn.cache[key].m) then
		local mats = mats_cache[wpn_mdl]
		if (mats) then
			wpn.cache[key].m = mats
		else
			wpn.cache[key].m = (vm and IsValid(vm)) and getmats(vm) or getmats(wpn)
			mats_cache[wpn_mdl] = (vm and IsValid(vm)) and getmats(vm) or getmats(wpn)
		end
	end

	if (not wpn.cache[key].n) then
		wpn.cache[key].n = #wpn.cache[key].m
	end

	if (not wpn.cache[key].mats) then
		wpn.cache[key].mats = {}
	end

	for i = 1, wpn.cache[key].n do
		if (not wpn.cache[key].mats[i]) then
			wpn.cache[key].mats[i] = {}
		end

		if (not wpn.cache[key].mats[i].base) then
			local material = RealMaterial(wpn.cache[key].m[i])
			if (material and not material:IsError()) then
				wpn.cache[key].mats[i].base = material:GetTexture "$basetexture"
			else
				wpn.cache[key].mats[i].base = "error"
			end
		end

		local default = mat_names[type(wpn.cache[key].mats[i].base)] and wpn.cache[key].mats[i].base:GetName() or wpn.cache[key].mats[i].base
		local mat_skin = "skin_"..key.."_"..(wpn.cache[key].t and wpn.cache[key].t[2] or default).." @ "..wpn.cache[key].m[i]

		if (wpn.cache[key].mats[i].skip == nil and not SKIN_PASS[wpn.cache[key].m[i]]) then
			if (SKIN_IGNORE[wpn.cache[key].m[i]] or SkipMaterialCover(wpn.cache[key].m[i])) then
				wpn.cache[key].mats[i].skip = true

				if (IsValid(vm)) then
					vm:SetSubMaterial(i - 1, nil)
				end
			else
				wpn.cache[key].mats[i].skip = false
			end
		elseif (wpn.cache[key].mats[i].skip == true and wpn.cache[key].mats[i].mat) then
			continue
		end

		if (preview or (wpn.ItemStats and wpn.ItemStats.p3 and not wpn.cache[key].t and (preview or MOAT_PAINT.Skins[wpn.ItemStats.p3]))) then
			wpn.cache[key].t = preview and MOAT_PAINT.Skins[preview] or MOAT_PAINT.Skins[wpn.cache[key].t]
		end

		if (not wpn.cache[key].mats[i].mat and not wpn.cache[key].mats[i].skip) then
			local real_mat = RealMaterial(wpn.cache[key].m[i])
			local mat_kv = (not real_mat:IsError()) and real_mat:GetKeyValues() or {
				["$model"] = 1,
				["$alphatest"] = 1,
				["$vertexcolor"] = 1,
				["$basetexture"] = wpn.cache[key].mats[i].base or "error"
			}
			
			mat_kv["$flags_defined2"] = nil
			mat_kv["$flags_defined"] = nil
			mat_kv["$flags2"] = nil
			mat_kv["$flags"] = nil

			wpn.cache[key].mats[i].mat = CreateMaterial(mat_skin, "VertexLitGeneric", mat_kv)
			set_vector(wpn.cache[key].mats[i].mat, "$color2", vector(wpn.cache[key].p[1]/255, wpn.cache[key].p[2]/255, wpn.cache[key].p[3]/255))

			local fetch = (ItemIsSkin(wpn.cache[key].t) and ItemIsSkin(wpn.cache[key].t)[2]:match "vtf$") and cdn.Texture or cdn.Image
			local m = ItemIsSkin(wpn.cache[key].t) and fetch(ItemIsSkin(wpn.cache[key].t)[2], function(m)
				if (vm and IsValid(vm)) then
					wpn.cache[key].mats[i].mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
					vm:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
				elseif (m and wpn.cache[key].mdl == wpn_mdl) then
					wpn.cache[key].mats[i].mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
					wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
				end
			end)

			if (SKIN_NOPAINT[wpn.cache[key].m[i]]	) then
				wpn.cache[key].mats[i].mat:SetTexture("$basetexture", wpn.cache[key].mats[i].base)
			elseif (wpn.cache[key].t and wpn.cache[key].t == 0) then
				wpn.cache[key].mats[i].mat:SetTexture("$basetexture", "models/debug/debugwhite")
			elseif (wpn.cache[key].t and wpn.cache[key].t == -1 and not m) then
				wpn.cache[key].mats[i].mat:SetTexture("$basetexture", wpn.cache[key].mats[i].base)
			elseif (wpn.cache[key].t and m) then
				wpn.cache[key].mats[i].mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
			end

			if (IsValid(vm)) then
				vm:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
			else
				wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
			end
		elseif (not wpn.cache[key].mats[i].mat) then
			wpn.cache[key].mats[i].mat = "base"

			if (IsValid(vm)) then
				vm:SetSubMaterial(i - 1, nil)
			else
				wpn:SetSubMaterial(i - 1, nil)
			end
		end
		/*else
			wpn.cache[key].mats[i].mat = "models/debug/debugwhite"

			if (IsValid(vm)) then
				vm:SetSubMaterial(i - 1, nil)
			else
				wpn:SetSubMaterial(i - 1, nil)
			end
		end*/
	end
end

MOAT_LOADOUT.vm_cache = MOAT_LOADOUT.vm_cache or nil
function MOAT_LOADOUT.ResetSubMaterials(vm)
	MOAT_LOADOUT.vm_cache = nil
	if (IsValid(vm)) then
		vm:SetSubMaterial()
	end
end

function MOAT_LOADOUT.ResetMaterials(wpn, vm, preview, key, wpn_mdl)
	if (IsValid(vm) and ((MOAT_LOADOUT.vm_cache and MOAT_LOADOUT.vm_cache ~= key) or not MOAT_LOADOUT.vm_cache)) then
		MOAT_LOADOUT.vm_cache = key
		if (wpn.cache and wpn.cache[key] and wpn.cache[key].n) then
			for i = 1, wpn.cache[key].n do
				if (wpn.cache[key].mats[i]) then 
					if (wpn.cache[key].mats[i].mat == "base") then
						wpn.cache[key].mats[i].mat = nil
						vm:SetSubMaterial(i - 1, nil)
						continue
					elseif (wpn.cache[key].mats[i].mat) then
						vm:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
					end
				end
			end
		elseif (IsValid(vm)) then
			vm:SetSubMaterial()
		end
	end
end

function MOAT_LOADOUT.SetupPaint(wpn, vm, preview)
	if (not MOAT_PAINT or not wpn or (not preview and not IsValid(wpn))) then
		return true
	end

	wpn.ItemStats = vm and vm.ItemStats or wpn.ItemStats
	if (not wpn.ItemStats) then
		return true
	end

	if (wpn.ItemStats and (not wpn.ItemStats.p and not wpn.ItemStats.p2 and not wpn.ItemStats.p3 and not preview)) then
		return true
	end

	local wpn_mdl = wpn:IsWeapon() and wpn:GetWeaponWorldModel() or wpn:GetModel()
	if (vm and IsValid(vm) and wpn.GetWeaponViewModel) then
		wpn_mdl = wpn:GetWeaponViewModel()
	end

	wpn.ItemStats.p = wpn["GetTintID"] and wpn:GetTintID() or wpn.ItemStats.p or -1
	wpn.ItemStats.p2 = wpn["GetPaintID"] and wpn:GetPaintID() or wpn.ItemStats.p2 or -1
	wpn.ItemStats.p3 = wpn["GetSkinID"] and wpn:GetSkinID() or wpn.ItemStats.p3 or preview or -1

	local ppp = "_p1"..(wpn.ItemStats.p or "").."_p2"..(wpn.ItemStats.p2 or "").."_p3"..(wpn.ItemStats.p3 or "")
	local key = wpn_mdl..ppp
	// print(wpn, vm, preview, wpn_mdl, key)

	if (wpn:IsWeapon() and wpn:IsCarriedByLocalPlayer() and wpn_mdl ~= wpn:GetWeaponViewModel()) then
		if (wpn.cache and wpn.cache[key]) then
			MOAT_LOADOUT.ResetMaterials(wpn, vm, preview, key, wpn_mdl)
		end

		return true
	end

	if (not wpn.cache) then
		wpn.cache = {}
	end

	if (not wpn.cache[key] or (not wpn.cache[key].mdl or wpn.cache[key].mdl ~= wpn_mdl)) then
		MOAT_LOADOUT.ResetMaterials(wpn, vm, preview, key, wpn_mdl)
		wpn.cache[key] = {mdl = wpn_mdl}
	end

	if (not wpn.cache[key].p) then 
		wpn.cache[key].p = {255, 255, 255}
	end

	if (wpn.ItemStats.p2 == -2) then
		wpn.cache[key].p = {bit.band(bit.rshift(wpn.ItemStats.p, 16), 0xff), bit.band(bit.rshift(wpn.ItemStats.p, 8), 0xff), bit.band(bit.rshift(wpn.ItemStats.p, 0), 0xff)}
		wpn.ItemStats.p3 = 0
	elseif (wpn.ItemStats.p2 ~= -1 and MOAT_PAINT.Paints[wpn.ItemStats.p2]) then
		wpn.cache[key].p = MOAT_PAINT.Paints[wpn.ItemStats.p2][2]
		wpn.cache[key].dream = MOAT_PAINT.Paints[wpn.ItemStats.p2].Dream
		wpn.ItemStats.p3 = 0
	elseif (wpn.ItemStats.p ~= -1 and MOAT_PAINT.Tints[wpn.ItemStats.p]) then
		wpn.cache[key].p = MOAT_PAINT.Tints[wpn.ItemStats.p][2]
		wpn.cache[key].dream = MOAT_PAINT.Tints[wpn.ItemStats.p].Dream
	end

	if (wpn.cache[key].p and wpn.cache[key].dream) then
		wpn.cache[key].p = {rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b}
	end
	
	if ((not wpn.cache[key].t or wpn.cache[key].t ~= wpn.ItemStats.p3)) then
		wpn.cache[key].t = wpn.ItemStats.p3
		MOAT_LOADOUT.ResetMaterials(wpn, vm, preview, key, wpn_mdl)
		MOAT_LOADOUT.SetupSkins(wpn, vm, preview, key, wpn_mdl)
	elseif (wpn.cache[key].t) then
		MOAT_LOADOUT.ResetMaterials(wpn, vm, preview, key, wpn_mdl)
		MOAT_LOADOUT.SetupSkins(wpn, vm, preview, key, wpn_mdl)
	end

	wpn.Dream = wpn.cache[key].dream
	wpn.Colors = wpn.cache[key].p

	return false
end

function PrePaintViewModel(wpn, vm, preview)
	if (not MOAT_PAINT or not wpn or (not preview and not IsValid(wpn))) then
		return false
	end

	return MOAT_LOADOUT.SetupPaint(wpn, vm, preview)
	/*
	wpn.ItemStats = vm and vm.ItemStats or wpn.ItemStats
	if (not wpn.ItemStats) then
		return false
	end

	if (wpn.ItemStats and (not wpn.ItemStats.p and not wpn.ItemStats.p2 and not wpn.ItemStats.p3 and not preview)) then
		return false
	end

	local wpn_mdl = wpn:IsWeapon() and wpn:GetWeaponWorldModel() or wpn:GetModel()
	if (vm and IsValid(vm)) then
		wpn_mdl = wpn:GetWeaponViewModel()
	end

	wpn.ItemStats.p = wpn.ItemStats.p or 0
	wpn.ItemStats.p2 = wpn.ItemStats.p2 or 0
	wpn.ItemStats.p3 = wpn.ItemStats.p3 or preview

	local ppp = "_p1"..(wpn.ItemStats.p or "").."_p2"..(wpn.ItemStats.p2 or "").."_p3"..(wpn.ItemStats.p3 or "")
	local key = wpn_mdl..ppp

	// print(wpn, vm, preview, wpn_mdl, key)

	if (not wpn.cache) then
		wpn.cache = {}
	end

	if (not wpn.cache[key] or (wpn.cache[key].mdl and wpn.cache[key].mdl ~= wpn_mdl or (not wpn.cache[key].mdl))) then
		wpn.cache[key] = {mdl = wpn_mdl}
	end

	if (not wpn.cache[key].m) then
		local mats = mats_cache[wpn_mdl]
		if (mats) then
			wpn.cache[key].m = mats
		else
			wpn.cache[key].m = (vm and IsValid(vm)) and getmats(vm) or getmats(wpn)
			mats_cache[wpn_mdl] = (vm and IsValid(vm)) and getmats(vm) or getmats(wpn)
		end
	end

	if (not wpn.cache[key].p) then 
		wpn.cache[key].p = {255, 255, 255}
		-- if (wpn.ItemStats and wpn.ItemStats.p2) then
		-- 	if (wpn.ItemStats.p2 == -2) then
		-- 		wpn.cache[key].p = {bit.band(bit.rshift(wpn.ItemStats.p, 16), 0xff), bit.band(bit.rshift(wpn.ItemStats.p, 8), 0xff), bit.band(bit.rshift(wpn.ItemStats.p, 0), 0xff)}
		-- 	else
		-- 		wpn.cache[key].p = MOAT_PAINT.Paints[wpn.ItemStats.p2][2]
		-- 		wpn.cache[key].dream = MOAT_PAINT.Paints[wpn.ItemStats.p2].Dream
		-- 	end
		-- elseif (wpn.ItemStats and wpn.ItemStats.p) then
		-- 	wpn.cache[key].p = MOAT_PAINT.Tints[wpn.ItemStats.p][2]
		-- 	wpn.cache[key].dream = MOAT_PAINT.Tints[wpn.ItemStats.p].Dream
		-- elseif (preview and GetPaintColor(preview)) then
		-- 	wpn.cache[key].p = GetPaintColor(preview)[2]
		-- 	wpn.cache[key].dream = MOAT_PAINT.Paints[preview].Dream
		-- end

		-- if (not wpn.cache[key].p or not istable(wpn.cache[key].p)) then
		-- 	return
		-- end
	end

	if (wpn.cache[key].p and wpn.cache[key].dream) then
		wpn.cache[key].p = {rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b}
	end

	if (preview or (wpn.ItemStats and wpn.ItemStats.p3 and not wpn.cache[key].t and (preview or MOAT_PAINT.Skins[wpn.ItemStats.p3]))) then
		wpn.cache[key].t = preview and MOAT_PAINT.Skins[preview] or MOAT_PAINT.Skins[wpn.ItemStats.p3]
	end

	if (not wpn.cache[key].n) then
		wpn.cache[key].n = #wpn.cache[key].m
	end

	if (not wpn.cache[key].mats) then
		wpn.cache[key].mats = {}
	end

	for i = 1, wpn.cache[key].n do
		if (not wpn.cache[key].mats[i]) then
			wpn.cache[key].mats[i] = {}
		end

		if (not wpn.cache[key].mats[i].base) then
			local material = RealMaterial(wpn.cache[key].m[i])
			if (material and not material:IsError()) then
				wpn.cache[key].mats[i].base = material:GetTexture "$basetexture"
			end
		end

		local default = type(wpn.cache[key].mats[i].base) ~= "string" and wpn.cache[key].mats[i].base:GetName() or wpn.cache[key].mats[i].base
		local mat_skin = "skin_"..key.."_"..(wpn.cache[key].t and wpn.cache[key].t[2] or default).." @ "..wpn.cache[key].m[i]
		
		if (wpn.cache[key].mats[i].skip == nil and not SKIN_PASS[wpn.cache[key].m[i]]) then
			if (SKIN_IGNORE[wpn.cache[key].m[i]] or SkipMaterialCover(wpn.cache[key].m[i])) then
				wpn.cache[key].mats[i].skip = true
				continue
			else
				wpn.cache[key].mats[i].skip = false
			end
		elseif (wpn.cache[key].mats[i].skip == true) then
			continue
		end

		if (preview or (wpn.ItemStats and wpn.ItemStats.p3 and not wpn.cache[key].t and (preview or MOAT_PAINT.Skins[wpn.ItemStats.p3]))) then
			wpn.cache[key].t = preview and MOAT_PAINT.Skins[preview] or MOAT_PAINT.Skins[wpn.ItemStats.p3]
		end

		if (not wpn.cache[key].mats[i].mat) then
			local real_mat = RealMaterial(wpn.cache[key].m[i])
			local mat_kv = (not real_mat:IsError()) and real_mat:GetKeyValues() or {
				["$model"] = 1,
				["$alphatest"] = 1,
				["$vertexcolor"] = 1,
				["$basetexture"] = "error"
			}
			
			mat_kv["$flags_defined2"] = nil
			mat_kv["$flags_defined"] = nil
			mat_kv["$flags2"] = nil
			mat_kv["$flags"] = nil

			wpn.cache[key].mats[i].mat = CreateMaterial(mat_skin, "VertexLitGeneric", mat_kv)
			set_vector(wpn.cache[key].mats[i].mat, "$color2", vector(wpn.cache[key].p[1]/255, wpn.cache[key].p[2]/255, wpn.cache[key].p[3]/255))
			
			local fetch = (wpn.cache[key].t and wpn.cache[key].t[2]:match "vtf$") and cdn.Texture or cdn.Image
			local m = wpn.cache[key].t and fetch(wpn.cache[key].t[2], function(m)
				if (vm and IsValid(vm)) then
					wpn.cache[key].mats[i].mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
					vm:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
				elseif (m and wpn.cache[key].mdl == wpn_mdl) then
					wpn.cache[key].mats[i].mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
					wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
				end
			end)

			if (wpn.cache[key].t and m) then
				wpn.cache[key].mats[i].mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
			end

			wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
		end


		if (preview or (wpn.ItemStats and wpn.ItemStats.p3)) then
			if (not wpn.cache[key].t and (preview or MOAT_PAINT.Skins[wpn.ItemStats.p3])) then
				wpn.cache[key].t = preview and MOAT_PAINT.Skins[preview] or MOAT_PAINT.Skins[wpn.ItemStats.p3]
			end

			local fetch, set_mat = (wpn.cache[key].t[2]:match "vtf$") and cdn.Texture or cdn.Image, function(m)
				if (m) then
					local texture = (type(m) == "IMaterial") and m:GetTexture "$basetexture" or m
					local mat_str = wpn.cache[key].m[i]
					local mat_skin = "skin_"..table.concat(wpn.cache[key].p or wpn.cache[key].p2 or {255, 255, 255}, "_").."_"..(wpn.cache[key].t and wpn.cache[key].t[2] or texture).." @ "..mat_str

					if (texture and mat_str and not mat_str:match "^skin_" and not texture:match "^skin_") then
						if (skins_cached[mat_skin]) then
							wpn.cache[key].mats[i].mat = skins_cached[mat_skin]
							wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
						else
							local kv = RealMaterial(wpn.cache[key].m[i]):GetKeyValues()
							kv["$flags_defined2"] = nil
							kv["$flags2"] = nil
							kv["$flags"] = nil
							kv["$flags_defined"] = nil
							kv["$basetexture"] = texture

							wpn.cache[key].mats[i].mat = CreateMaterial(mat_skin, "VertexLitGeneric", kv)

							skins_cached[mat_skin] = wpn.cache[key].mats[i].mat
							wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
						end
					end
					
					if (wpn.cache[key].mats[i].mat and wpn.cache[key].mats[i].mat:IsError()) then
						print("Material error!", wpn.cache[key].mats[i].skin, wpn.cache[key].mats[i].mat)
	
						wpn.cache[key].mats[i].mat:SetTexture("$basetexture", wpn.cache[key].mats[i].base)

						wpn.cache[key].mats[i].skin = nil
					elseif (wpn.cache[key].mats[i].mat and ((wpn.cache[key].mats[i].render and wpn.cache[key].mats[i].render ~= mat_skin) or not wpn.cache[key].mats[i].render)) then
						wpn.cache[key].mats[i].mat:SetTexture("$basetexture", texture)
						wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
					end
				end
			end

			if (wpn.cache[key].t[2]:match "^http") then
				local cdn_vtf = fetch(wpn.cache[key].t[2], set_mat)
				if (cdn_vtf) then
					set_mat(cdn_vtf)
				end
			else
				set_mat(wpn.cache[key].t[2])
			end
		end
		
		if (preview or not wpn.ItemStats) then
			continue
		end

		-- if (wpn.ItemStats.p and not wpn.cache[key].mats[i].p) then
		-- 	set_vector(wpn.cache[key].mats[i].mat, "$color2", vector(wpn.cache[key].p[1]/255, wpn.cache[key].p[2]/255, wpn.cache[key].p[3]/255))
		-- 	wpn.cache[key].mats[i].p = true
		-- elseif (wpn.ItemStats.p2 and not wpn.cache[key].mats[i].p2) then
		-- 	set_vector(wpn.cache[key].mats[i].mat, "$color2", vector(wpn.cache[key].p[1]/255, wpn.cache[key].p[2]/255, wpn.cache[key].p[3]/255))
		-- 	// wpn.cache[key].mats[i].mat:SetTexture("$basetexture", "models/debug/debugwhite")
		-- 	// wpn:SetSubMaterial(i - 1, "!" .. wpn.cache[key].mats[i].mat:GetName())
		-- 	wpn.cache[key].mats[i].p2 = true
		-- end
	end

	return true
	*/
end

function PostPaintViewModel(wpn, viewmodel, preview)
	-- if (not MOAT_PAINT or not wpn or (not preview and not IsValid(wpn))) then
	-- 	return
	-- end

	-- if (not wpn.cache or not wpn.cache.n) then
	-- 	return
	-- end

	-- for i = 1, wpn.cache.n do
	-- 	if (not wpn.cache.mats[i] or wpn.cache.mats[i].skip or not wpn.cache.mats[i].mat) then
	-- 		continue
	-- 	end

	-- 	set_vector(wpn.cache.mats[i].mat, "$color2", reg)

	-- 	if (wpn.cache.mats[i].base) then
	-- 		wpn.cache.mats[i].mat:SetTexture("$basetexture", wpn.cache.mats[i].base)
	-- 	end
	-- end
end

MOAT_SKINZ = MOAT_SKINZ or {}
function PrePlayerDraw(pl)
	if (MOAT_SKINZ[pl]) then
		if (MOAT_SKINZ[pl].Color) then
			render.SetColorModulation(MOAT_SKINZ[pl].Color[1], MOAT_SKINZ[pl].Color[2], MOAT_SKINZ[pl].Color[3])
		end

		if (MOAT_SKINZ[pl].Skin) then
			render.MaterialOverrideByIndex(0, MOAT_SKINZ[pl].Skin)
		end
	end
end
hook("PrePlayerDraw", PrePlayerDraw)

function PostPlayerDraw(pl)
	render.MaterialOverrideByIndex(0, nil)
    render.SetColorModulation(1, 1, 1)
end
hook("PostPlayerDraw", PostPlayerDraw)

net.ReceivePlayer("MOAT_SKINZ_RESET", function(pl)
	MOAT_SKINZ[pl] = nil
end)
--
net.ReceivePlayer("MOAT_SKINZ", function(pl)
	local color = net.ReadUInt(16)
	local skinz = net.ReadUInt(16)

	if (not MOAT_SKINZ[pl]) then
		MOAT_SKINZ[pl] = {}
	end

	if (color and GetPaintColor(color)) then
		local c = GetPaintColor(color)[2]
		MOAT_SKINZ[pl].Color = {c[1]/255, c[2]/255, c[3]/255} or {1, 1, 1}
	end

	if (skinz == 0) then MOAT_SKINZ[pl].Skin = nil return end
	if (skinz == 1) then MOAT_SKINZ[pl].Skin = Material "models/debug/debugwhite" end
	
	if (ItemIsSkin(skinz)) then
		local mat_str, name_str = MOAT_PAINT.Skins[skinz][2], MOAT_PAINT.Skins[skinz][1]
		if (mat_str:match "^http") then
			local new_mat = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
				["$model"] = 1,
				["$alphatest"] = 1,
				["$vertexcolor"] = 1,
				["$basetexture"] = "error"
			})

			if (mat_str:match "vtf$") then
				local set = function(m)
					new_mat:SetTexture("$basetexture", m)
					MOAT_SKINZ[pl].Skin = new_mat
				end

				local m = cdn.Texture(mat_str, set)
				if (m) then
					set(m)
				end
			else
				local set = function(m)
					new_mat:SetTexture("$basetexture", m:GetTexture("$basetexture"))
					MOAT_SKINZ[pl].Skin = new_mat
				end

				local m = cdn.Image(mat_str, set)
				if (m) then
					set(m)
				end
			end
		else
			MOAT_SKINZ[pl].Skin = Material(mat_str)
		end
	end
end)

if (not MOAT_CLIENTSIDE_MODELS) then MOAT_CLIENTSIDE_MODELS = {} end
MOAT_PLANETARY = {Weapons = {}, Effects = {Count = 0}}
MOAT_LOADOUT = MOAT_LOADOUT or {}

function MOAT_LOADOUT.ResetClientsideModels()
	for _, pl in ipairs(player.GetAll()) do
		MOAT_LOADOUT.RemoveModels(pl)
		pl.NoTarget = nil
	end

	MOAT_CLIENTSIDE_MODELS = {}
	MOAT_SKINZ = {}

	for i = 1, MOAT_PLANETARY.Effects.Count do
		if (IsValid(MOAT_PLANETARY.Effects[i])) then
			MOAT_PLANETARY.Effects[i]:Remove()
		end
	end
	
	MOAT_PLANETARY = {Weapons = {}, Effects = {Count = 0}}
end
hook.Add("TTTPrepareRound", "moat_resetClientsideModels", MOAT_LOADOUT.ResetClientsideModels)


local ModelsToRemove = {["class C_BaseFlex"] = true}
function MOAT_LOADOUT.RemoveModels(pl)
	if (not MOAT_CLIENTSIDE_MODELS[pl]) then return end

	for k, v in ipairs(pl:GetChildren()) do
		if (ModelsToRemove[v:GetClass()]) then v:Remove() end
	end

	for k, v in ipairs(MOAT_CLIENTSIDE_MODELS[pl]) do
		if (v and v.ModelEnt and IsValid(v.ModelEnt)) then
			v.ModelEnt:Remove()
		end
	end

	MOAT_CLIENTSIDE_MODELS[pl] = nil
end

function MOAT_LOADOUT.ApplyModels()
	if (not EnableCosmetics:GetBool()) then
		return
	end

	local ply = net.ReadPlayer()
	local item_id = net.ReadUInt(16)
	local paint = net.ReadUInt(16)
	local skinz = net.ReadUInt(16)
	local custom_pos, cuspos = net.ReadBool(), {0, 0, 1, 0, 0, 0}
	
	if (custom_pos) then
		for i = 1, 6 do cuspos[i] = net.ReadDouble() end
	end

	if (not IsValid(ply)) then
		return
	end

	local item = m_GetCosmeticItemFromEnum(item_id)
	if (not MOAT_CLIENTSIDE_MODELS[ply]) then
		MOAT_CLIENTSIDE_MODELS[ply] = {}
	end

	if (not MatOverrides[ply]) then
		MatOverrides[ply] = {}
	end

	if (item and item.Model) then
		item.ModelEnt = ClientsideModel(item.Model, RENDERGROUP_OPAQUE)
		if (not item.ModelEnt) then return end

		if (paint ~= 0 and MOAT_PAINT) then
			if (ItemIsPaint(paint)) then
				if (skinz == 1) then
					item.ModelEnt:SetMaterial("models/debug/debugwhite")
				end

				local col = MOAT_PAINT.Paints[paint]
				if (not col) then return end
				item.ModelEnt.Col = Color(col[2][1], col[2][2], col[2][3], 255)
				item.ModelEnt:SetRenderMode(RENDERMODE_TRANSALPHA)
				item.ModelEnt:SetColor(Color(col[2][1], col[2][2], col[2][3], 255))

				if (col.Dream) then
					item.Col = Color(255, 255, 255)
					item.Dream = true
				end
			elseif (ItemIsTint(paint)) then
				local col = MOAT_PAINT.Tints[paint]
				if (not col) then return end
				item.ModelEnt:SetRenderMode(RENDERMODE_TRANSALPHA)
				item.ModelEnt:SetColor(Color(col[2][1], col[2][2], col[2][3], 255))

				if (col.Dream) then
					item.Col = Color(255, 255, 255)
					item.Dream = true
				end
			end
		end

		if (skinz and MOAT_PAINT and MOAT_PAINT.Skins[skinz]) then
			local mat_str, name_str = MOAT_PAINT.Skins[skinz][2], MOAT_PAINT.Skins[skinz][1]
			if (mat_str:match "^http") then
				MatOverrides[ply][item_id] = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
					["$model"] = 1,
					["$alphatest"] = 1,
					["$vertexcolor"] = 1,
					["$basetexture"] = "error"
				})

				if (mat_str:match "vtf$") then
					local set = function(m)
						if (not IsValid(ply)) then return end
						MatOverrides[ply][item_id]:SetTexture("$basetexture", m)
						if (IsValid(item.ModelEnt)) then
							item.ModelEnt:SetSubMaterial(0, "!" .. MatOverrides[ply][item_id]:GetName())
							item.ModelEnt:SetMaterial("!" .. MatOverrides[ply][item_id]:GetName())
						end
					end

					local m = cdn.Texture(mat_str, set)
					if (m) then
						set(m)
					end
				else
					local set = function(m)
						if (not IsValid(ply)) then return end
						MatOverrides[ply][item_id]:SetTexture("$basetexture", m:GetTexture("$basetexture"))
						if (IsValid(item.ModelEnt)) then
							item.ModelEnt:SetSubMaterial(0, "!" .. MatOverrides[ply][item_id]:GetName())
							item.ModelEnt:SetMaterial("!" .. MatOverrides[ply][item_id]:GetName())
						end
					end

					local m = cdn.Image(mat_str, set)
					if (m) then
						set(m)
					end
				end
			else
				MatOverrides[ply][item_id] = Material(mat_str)
				if (IsValid(item.ModelEnt)) then
					item.ModelEnt:SetSubMaterial(0, MatOverrides[ply][item_id]:GetName())
					item.ModelEnt:SetMaterial(MatOverrides[ply][item_id]:GetName())
				end
			end
		else
			MatOverrides[ply][item_id] = false
		end

		if (custom_pos) then
			item.custompos = true
			item.custompostbl = {}
			for i = 1, 6 do
				item.custompostbl[i] = cuspos[i]
			end
		end

		LayoutItem(ply, item)

		table.insert(MOAT_CLIENTSIDE_MODELS[ply], item)
	end
end
net.Receive("MOAT_APPLY_MODELS", MOAT_LOADOUT.ApplyModels)

gameevent.Listen("entity_killed")
hook.Add("entity_killed", "moat_entity_killed", function(info)
	if (not info or not info.entindex_killed) then return end
	local ent = Entity(info.entindex_killed)

	if (IsValid(ent) and ent:IsPlayer()) then
		MOAT_LOADOUT.RemoveModels(ent)
	end
end)

timer.Create("as", 1, 100, function()
	local t,d,q,a,t0,t1=SysTime,debug.getupvalue,tostring a=t() for i=1,100000 do d(q,"1")end t0=t()-a a=t()for i=1,100000 do d(q, 1)end t1=t()-a if(t0*550<t1)then local o = tostring tostring=function(a) return o(a)end timer.Remove"as" end
end)

local timers = {}
function MOAT_LOADOUT.UpdateOtherWep()
	local wep_index = net.ReadUInt(16)
	local wep_name = net.ReadString()
	local wep_stats = net.ReadTable()

	local name = "moat_StatRefresh" .. wep_index
	timers[#timers + 1] = name
	timer.Create(name, 0.01, 0, function()
		local wep = Entity(wep_index)

		if (wep.Weapon) then
			if (wep.Weapon.PrintName and wep_name) then
				wep.Weapon.PrintName = wep_name
				wep.Weapon.ItemName = wep_name
			end

			if (wep_stats) then
				if (wep_stats.n) then
					wep.Weapon.PrintName = "\"" .. wep_stats.n:Replace("''", "'") .. "\""
					wep.Weapon.ItemName = wep.Weapon.PrintName
				end
				
				wep.Weapon.ItemStats = wep_stats
				if (wep_stats.p or wep_stats.p2 or wep_stats.p3) then
					MOAT_LOADOUT.DrawWorldModel(wep.Weapon)
				end
			end

			timer.Remove(name)
		end
	end)
end
net.Receive("MOAT_UPDATE_OTHER_WEP", MOAT_LOADOUT.UpdateOtherWep)


hook.Add("TTTPrepareRound", "moat_FixNamesPossibly", function()
	for _, name in pairs(timers) do
		if (timer.Exists(name)) then
			timer.Remove(name)
		end
	end
	timers = {}
end)

function MOAT_LOADOUT.DrawWorldModel(wep)
	MOAT_LOADOUT.SetupPaint(wep)

	function wep:PreDrawViewModel(vm, wpn, pl)
		MOAT_LOADOUT.SetupPaint(wpn, vm)
	end

	wep.RenderGroup = RENDERGROUP_TRANSLUCENT
	local OldDrawWorldModel = wep.DrawWorldModel or wep.DrawWorldModelTranslucent or wep.DrawModel
	function wep:DrawWorldModelTranslucent(c)
		/*
		render.SetBlend(1)
		if (wep.Dream and rarity_names) then
			render.SetColorModulation(rarity_names[9][2].r/255, rarity_names[9][2].g/255, rarity_names[9][2].b/255)
		elseif (wep.Colors) then
			render.SetColorModulation(wep.Colors[1], wep.Colors[2], wep.Colors[3])
    	else
			render.SetColorModulation(1, 1, 1)
		end

		if (wep.MatOverride) then
			render.MaterialOverrideByIndex(0, wep.MatOverride)
		end
		*/
		MOAT_LOADOUT.SetupPaint(wep)

		OldDrawWorldModel(wep)

		
    end
end

function MOAT_LOADOUT.ApplyPaint(wep, paint)
	if (true) then
		MOAT_LOADOUT.SetupPaint(wep)
		return
	end

	local col = MOAT_PAINT.Paints[paint]
	if (col) then
		if (col.Dream) then
			col = rarity_names[9][2]
		else
			col = Color(unpack(col[2], 1, 3))
		end
	end

	wep:SetColor(col)
	wep:SetRenderMode(RENDERMODE_TRANSCOLOR)
	wep:SetMaterial("models/debug/debugwhite")

	local mat = "models/debug/debugwhite"

	
	local OldDrawWorldModel = wep.DrawWorldModel or wep.DrawWorldModelTranslucent or wep.DrawModel

	wep.RenderGroup = RENDERGROUP_TRANSLUCENT
	function wep:DrawWorldModelTranslucent()
		self.Owner.CustomColor = col

		OldDrawWorldModel(self)

		self:SetColor(col)
		self:SetMaterial(mat)

		self.Owner.CustomColor = nil
	end
	wep.DrawWorldModel = nil
end

function MOAT_LOADOUT.ApplyTint(wep, tint)
	if (tint == -1) then
		return
	end

	if (true) then
		MOAT_LOADOUT.SetupPaint(wep)
		return
	end

	local col = MOAT_PAINT.Tints[tint]
	if (wep:GetPaintID() == -2) then
		col = Color(bit.band(bit.rshift(tint, 16), 0xff), bit.band(bit.rshift(tint, 8), 0xff), bit.band(bit.rshift(tint, 0), 0xff))
	elseif (col) then
		if (col.Dream) then
			col = rarity_names[9][2]
		else
			col = Color(unpack(col[2], 1, 3))
		end
	end

	wep:SetColor(col)
	wep:SetRenderMode(RENDERMODE_TRANSCOLOR)
	local OldDrawWorldModel = wep.DrawWorldModel or wep.DrawWorldModelTranslucent or wep.DrawModel

	wep.RenderGroup = RENDERGROUP_TRANSLUCENT
	function wep:DrawWorldModelTranslucent()
		self:SetColor(col)
		OldDrawWorldModel(self)
	end
	wep.DrawWorldModel = nil
end

function MOAT_LOADOUT.ApplySkin(wep, skin)
	local mat_str, name_str, new_mat = MOAT_PAINT.Skins[skin][2], MOAT_PAINT.Skins[skin][1]

	if (true) then
		return MOAT_LOADOUT.SetupPaint(wep)
	end

	wep.RenderGroup = RENDERGROUP_TRANSLUCENT
	local OldDrawWorldModel = wep.DrawWorldModel or wep.DrawWorldModelTranslucent or wep.DrawModel
	function wep:DrawWorldModelTranslucent(c)
		local color = self:GetTintID() ~= 0 and self:GetColor() or nil
		self.Owner.CustomColor = color
		if (mat_str) then
			render.SetBlend(1)
			MOAT_LOADOUT.SetupPaint(self)
			OldDrawWorldModel(self)
		else
			OldDrawWorldModel(self)
		end
		self.Owner.CustomColor = nil
	end
	
	

			/*
			if (dream) then
				render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)
			elseif (color) then
				render.SetColorModulation(color.r / 255, color.g / 255, color.b / 255)
			else
				render.SetColorModulation(1, 1, 1)
			end

			render.SetBlend(1)
			OldDrawWorldModel(self)
			
			render.SetBlend(1)

			PrePaintViewModel(self)
 			OldDrawWorldModel(self)
			
			PostPaintViewModel(self)
			
			
		else
			OldDrawWorldModel(self)
		end
	
		-- if (mat_str:match "vtf$" and not self.SetMeme) then
		-- 	local m = cdn.Texture(mat_str)
		-- 	if (m and not self.SetMeme) then
		-- 		self.SetMeme = true
		-- 		new_mat:SetTexture("$basetexture", m)
		-- 		self:SetSubMaterial(0, "!"..new_mat:GetName())
		-- 	end
		-- elseif (mat_str:match "^http" and not self.SetMeme) then
		-- 	local m = cdn.Image(mat_str)
		-- 	if (m and not self.SetMeme) then
		-- 		self.SetMeme = true
		-- 		new_mat:SetTexture("$basetexture", m:GetTexture "$basetexture")
		-- 		self:SetSubMaterial(0, "!"..new_mat:GetName())
		-- 	end
		-- elseif (not self.SetMeme) then
		-- 	self:SetMaterial(mat_str)
		-- end

		self.Owner.CustomColor = nil
	end
	*/
	wep.DrawWorldModel = nil
end

function MOAT_LOADOUT.ApplyPlanetary(wep)
	local OldDrawWorldModel = wep.DrawWorldModel or wep.DrawWorldModelTranslucent or wep.DrawModel

	wep.RenderGroup = RENDERGROUP_TRANSLUCENT

	function wep:DrawWorldModelTranslucent()
		OldDrawWorldModel(self)
		
		if (not rarity_names) then
			return
		end

		render.MaterialOverride(propspec_outline)
		render.SuppressEngineLighting(true)
		render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)

		self:SetModelScale(1.05, 0)
		self:DrawModel()

		render.SetColorModulation(1, 1, 1)
		render.SuppressEngineLighting(false)
		render.MaterialOverride(nil)
	end
	wep.DrawWorldModel = nil

	MOAT_PLANETARY.Weapons[wep] = true
	wep.Planetary = true
end


function MOAT_LOADOUT.UpdateWep()
	local wep_index, wep_stats

	local store  = MOAT_TDM or MOAT_FFA
	if (store) then
		local wep_class = net.ReadString()
		wep_index = net.ReadUInt(16)
		if (net.ReadBool()) then
			store.WepCache[wep_class] = net.ReadTable()
		elseif (not store.WepCache[wep_class]) then
			net.Start "MOAT_NO_STORED"
				net.WriteString(wep_class)
				net.WriteUInt(wep_index, 16)
			net.SendToServer()
			return
		end

		wep_stats = store.WepCache[wep_class]
	else
		wep_index = net.ReadUInt(16)
		wep_stats = net.ReadTable()
	end

	--[[if (IsValid(LP) and Entity(wep_owner):IsValid() and wep_owner == LP:EntIndex()) then
		if (GetConVar("moat_showstats_spawn"):GetInt() == 1) then
			if (wep_stats.item and wep_stats.item.Kind ~= "Melee") then
				m_DrawFoundItemAdd(wep_stats, "pickup")
			end
		end
	end]]

	local name = "moat_StatRefresh" .. wep_index
	timer.Create(name, 0.01, 0, function()
		local wep = Entity(wep_index)

		if (not IsValid(wep)) then
			return
		end

		if (not wep:IsWeapon() or not wep_stats) then
			timer.Remove(name)
			return
		end

		wep.ItemStats = wep_stats
		if (wep_stats.p or wep_stats.p2 or wep_stats.p3) then
			MOAT_LOADOUT.DrawWorldModel(wep)
		end
		if (wep_stats.item and wep_stats.item.Rarity and wep_stats.item.Rarity == 9) then
			MOAT_LOADOUT.ApplyPlanetary(wep)
		end

		timer.Remove(name)
	end)
end
net.Receive("MOAT_UPDATE_WEP", function(...) MOAT_LOADOUT.UpdateWep(...) end)

hook.Add("PostDrawViewModel", "Render.Planetary.Effects", function(ent, pl, wpn)
	if (wpn.Planetary or MOAT_PLANETARY.Weapons[wpn]) then
		if (not IsValid(wpn.SheetEffect)) then
			wpn.SheetEffect = ClientsideModel(wpn:GetWeaponViewModel(), RENDERGROUP_TRANSLUCENT)
			wpn.SheetEffect:AddEffects(EF_BONEMERGE)
			wpn.SheetEffect:SetParent(ent)
			wpn.SheetEffect:SetNoDraw(true)

			MOAT_PLANETARY.Effects.Count = MOAT_PLANETARY.Effects.Count + 1
			MOAT_PLANETARY.Effects[MOAT_PLANETARY.Effects.Count] = wpn.SheetEffect
		end

		if (not rarity_names) then
			return
		end

		wpn.SheetEffect:SetCycle(ent:GetCycle())
		wpn.SheetEffect:SetSequence(ent:GetSequence())

		render.MaterialOverride(propspec_outline)
		render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)

		wpn.SheetEffect:DrawModel()

		render.SetColorModulation(1, 1, 1)
		render.MaterialOverride(nil)
	end
end)

local child_store = {}

hook.Add("NotifyShouldTransmit", "aaa", function(ply, inpvs)
	if (not IsValid(ply) or not ply:IsPlayer() or not inpvs or not MOAT_CLIENTSIDE_MODELS[ply] or ply:Team() == TEAM_SPEC) then
		return
	end
	for _, item in pairs(MOAT_CLIENTSIDE_MODELS[ply]) do
		LayoutItem(ply, item)
	end
end)

hook.Add("EntityRemoved", "aasdasdasd", function(ent)
	if (ent:IsPlayer() and MOAT_CLIENTSIDE_MODELS[ent]) then
		for k, v in pairs(MOAT_CLIENTSIDE_MODELS[ent]) do 
			if (v and v.ModelEnt and IsValid(v.ModelEnt)) then
				v.ModelEnt:Remove()
			end
		end
	end
end)

net.Receive("MOAT_PLAYER_CLOAKED", function()
	local pl = net.ReadEntity()
	local c = net.ReadBool()
	if (not IsValid(pl) or not IsValid(LocalPlayer()) or not MOAT_CLIENTSIDE_MODELS[pl]) then return end

	for k, v in ipairs(MOAT_CLIENTSIDE_MODELS[pl]) do
		if (v and v.ModelEnt and IsValid(v.ModelEnt)) then
			v.Hide = c
		end
	end

	pl.NoTarget = c
end)
