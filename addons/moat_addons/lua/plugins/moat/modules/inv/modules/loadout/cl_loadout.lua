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
			and not MOAT_MINIGAME_OCCURING and ply:Team() ~= TEAM_SPEC
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
-- lua_run for k, v in pairs(weapons.GetList()) do if (v.ClassName:StartWith("weapon_ttt_te_") or v.AutoSpawnable) then me():m_DropInventoryItem("Soft", v.ClassName) end end

SKIN_IGNORE = {}
SKIN_IGNORE["models/weapons/v_models/slayer's_msbs/msbs"] = true
SKIN_IGNORE["models/weapons/v_models/slayer's_msbs/naboj"] = true
SKIN_IGNORE["models/weapons/v_models/hands/sleeve_diffuse"] = true
SKIN_IGNORE["models/weapons/v_models/zaratusa.golden.deagle/grip"] = true
SKIN_IGNORE["models/weapons/v_models/zaratusa.golden.deagle/no_phong_frame"] = true
SKIN_IGNORE["models/weapons/v_models/zaratusa.golden.deagle/no_phong_front"] = true
SKIN_IGNORE["models/weapons/v_models/virflakhg/bullets"] = true
SKIN_IGNORE["models/weapons/bo2r_peacekeeper/peacekeeper_d2"] = true

SKIN_PASS = {}
SKIN_PASS["models/weapons/v_models/g3a3/stockbit"] = true
SKIN_PASS["models/weapons/v_models/vollmer/box"] = true
SKIN_PASS["models/weapons/v_models/pvpxm8model/scope"] = true
SKIN_PASS["models/weapons/v_models/ak47/stockmap"] = true

function PrePaintViewModel(wpn, preview)
	if (not MOAT_PAINT or not wpn or (not preview and not wpn.ItemStats)) then
		return
	end

	if (wpn.ItemStats and (not wpn.ItemStats.p and not wpn.ItemStats.p2 and not wpn.ItemStats.p3 and not preview)) then
		return
	end

	if (not wpn.cache) then
		wpn.cache = {}
	end

	if (preview and not wpn.cache.m) then
		wpn.cache.m = getmats(wpn)
	end

	if (not wpn.cache.m) then
		local vm = wpn:GetWeaponViewModel()

		if (mats_cache[vm]) then 
			wpn.cache.m = mats_cache[vm]
		else
			local mdl = ClientsideModel(vm, RENDERGROUP_OPAQUE)
			if (not mdl) then
				return
			end

			mdl:SetNoDraw(true)
			mats_cache[vm] = getmats(mdl)
			mdl:Remove()
			wpn.cache.m = mats_cache[vm]
		end
	end

	if (not wpn.cache.p and not preview) then 
		wpn.cache.p = 255
		if (wpn.ItemStats.p2) then
			wpn.cache.p = MOAT_PAINT.Paints[wpn.ItemStats.p2][2]
			wpn.cache.dream = MOAT_PAINT.Paints[wpn.ItemStats.p2].Dream
		elseif (wpn.ItemStats.p) then
			wpn.cache.p = MOAT_PAINT.Tints[wpn.ItemStats.p][2]
			wpn.cache.dream = MOAT_PAINT.Tints[wpn.ItemStats.p].Dream
		end

		if (not wpn.cache.p or not istable(wpn.cache.p)) then
			return
		end
	end

	if (wpn.cache.p and wpn.cache.dream) then
		wpn.cache.p = {rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b}
	end

	if (not wpn.cache.n) then
		wpn.cache.n = #wpn.cache.m
	end

	if (not wpn.cache.mats) then
		wpn.cache.mats = {}
	end

	for i = 1, wpn.cache.n do
		if (not wpn.cache.mats[i]) then
			wpn.cache.mats[i] = {}
		end
	
		if (not wpn.cache.mats[i].mat) then
			wpn.cache.mats[i].mat = mat(wpn.cache.m[i])
		end

		if (wpn.cache.mats[i].skip == nil and not SKIN_PASS[wpn.cache.m[i]]) then 
			if ((wpn.cache.m[i]:find("hand") and not wpn.cache.m[i]:EndsWith("eu_handgun") and not wpn.cache.m[i]:StartWith("models/weapons/v_models/9mmhandgun")) or 
			wpn.cache.m[i]:find("scope") or 
			wpn.cache.m[i]:find("accessories") or 
			wpn.cache.m[i]:find("arrow") or 
			wpn.cache.m[i]:find("box") or 
			wpn.cache.m[i]:find("belt") or 
			wpn.cache.m[i]:find("stock") or 
			wpn.cache.m[i]:find("shell") or 
			wpn.cache.m[i]:find("screen") or 
			wpn.cache.m[i]:find("error") or 
			wpn.cache.m[i]:find("12gauge") or
			wpn.cache.m[i] == "models/weapons/v_models/9mmhandgun/line" or
			wpn.cache.m[i]:EndsWith("red_dot") or SKIN_IGNORE[wpn.cache.m[i]]) then
				wpn.cache.mats[i].skip = true
				continue
			else
				wpn.cache.mats[i].skip = false
			end
		elseif (wpn.cache.mats[i].skip == true) then
			continue
		end

		if (not wpn.cache.mats[i].texture) then
			wpn.cache.mats[i].texture = wpn.cache.mats[i].mat:GetTexture("$basetexture")
		end

		if (preview or (wpn.ItemStats and wpn.ItemStats.p3)) then
			if (not wpn.cache.t and (preview or MOAT_PAINT.Skins[wpn.ItemStats.p3])) then
				wpn.cache.t = preview and MOAT_PAINT.Skins[preview] or MOAT_PAINT.Skins[wpn.ItemStats.p3]
			end

			if (wpn.cache.t[2]:match "^http") then
				if (wpn.cache.t[2]:match "vtf$") then
					local cdn_vtf = cdn.Texture(wpn.cache.t[2], function(m)
						if (m) then
							wpn.cache.mats[i].mat:SetTexture("$basetexture", m)
						end
					end)

					if (cdn_vtf) then
						wpn.cache.mats[i].mat:SetTexture("$basetexture", cdn_vtf)
					end
				else
					local cdn_mat = cdn.Image(wpn.cache.t[2], function(m)
						if (m) then
							wpn.cache.mats[i].mat:SetTexture("$basetexture", m:GetTexture "$basetexture")
						end
					end)

					if (cdn_mat) then
						wpn.cache.mats[i].mat:SetTexture("$basetexture", cdn_mat:GetTexture "$basetexture")
					end
				end
			else
				wpn.cache.mats[i].mat:SetTexture("$basetexture", wpn.cache.t[2])
			end
		end
		
		if (preview or not wpn.ItemStats) then
			return
		end

		if (wpn.ItemStats.p2) then
			wpn.cache.mats[i].mat:SetTexture("$basetexture", "models/debug/debugwhite")

			set_vector(wpn.cache.mats[i].mat, "$color2", vector(wpn.cache.p[1]/255, wpn.cache.p[2]/255, wpn.cache.p[3]/255))
		elseif (wpn.ItemStats.p) then
			set_vector(wpn.cache.mats[i].mat, "$color2", vector(wpn.cache.p[1]/255, wpn.cache.p[2]/255, wpn.cache.p[3]/255))
		end
	end
end

function PostPaintViewModel(wpn, preview)
	if (not wpn or (not preview and not wpn.ItemStats)) then
		return
	end

	if (not wpn.cache or not wpn.cache.n) then
		return
	end

	for i = 1, wpn.cache.n do
		if (not wpn.cache.mats[i] or wpn.cache.mats[i].skip or not wpn.cache.mats[i].mat) then
			continue
		end

		set_vector(wpn.cache.mats[i].mat, "$color2", reg)

		if (wpn.cache.mats[i].texture) then
			wpn.cache.mats[i].mat:SetTexture("$basetexture", wpn.cache.mats[i].texture)
		end
	end
end

if (not MOAT_CLIENTSIDE_MODELS) then MOAT_CLIENTSIDE_MODELS = {} end
MOAT_PLANETARY = {Weapons = {}, Effects = {Count = 0}}
MOAT_LOADOUT = {}

function MOAT_LOADOUT.ResetClientsideModels()
	for _, pl in ipairs(player.GetAll()) do
		MOAT_LOADOUT.RemoveModels(pl)
		pl.NoTarget = nil
	end

	MOAT_CLIENTSIDE_MODELS = {}

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

	local ply = Entity(net.ReadUInt(16))
	if (not IsValid(ply)) then return end

	local item_id = net.ReadUInt(16)
	local paint = net.ReadUInt(32)
	local custom_pos = net.ReadBool()

	local cuspos = {0, 0, 1, 0, 0, 0}

	if (custom_pos) then
		for i = 1, 6 do
			cuspos[i] = net.ReadDouble()
		end
	end

	local item = m_GetCosmeticItemFromEnum(item_id)

	if (not MOAT_CLIENTSIDE_MODELS[ply]) then
		MOAT_CLIENTSIDE_MODELS[ply] = {}
	end

	if (item and item.Model) then
		item.ModelEnt = ClientsideModel(item.Model, RENDERGROUP_OPAQUE)
		if (not item.ModelEnt) then return end

		if (paint ~= 0 and MOAT_PAINT) then
			if (ItemIsPaint(paint)) then
				item.ModelEnt:SetMaterial("models/debug/debugwhite")
				local col = MOAT_PAINT.Paints[paint]
				if (not col) then return end
				item.ModelEnt.Col = Color(col[2][1], col[2][2], col[2][3], 255)
				item.ModelEnt:SetRenderMode(RENDERMODE_TRANSALPHA)
				item.ModelEnt:SetColor(Color(col[2][1], col[2][2], col[2][3], 255))

				if (col.Dream) then
					item.Col = Color(255, 255, 255)
					item.Dream = true
				end
			else
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

function MOAT_LOADOUT.UpdateOtherWep()
	local wep_index = net.ReadUInt(16)
	local wep_name = net.ReadString()
	local wep_stats = net.ReadTable()

	timer.Create("moat_StatRefresh" .. wep_index, 0.1, 0, function()
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
			end

			timer.Remove("moat_StatRefresh" .. wep_index)
		end
	end)
end
net.Receive("MOAT_UPDATE_OTHER_WEP", MOAT_LOADOUT.UpdateOtherWep)

local timers = {}

hook.Add("TTTEndRound", "moat_FixNamesPossibly", function()
	for _, name in pairs(timers) do
		if (timer.Exists(name)) then
			timer.Remove(name)
		end
	end
	timers = {}
end)

function MOAT_LOADOUT.ApplyPaint(wep, paint)
	local col = MOAT_PAINT.Paints[paint]
	if (col) then
		if (col.Dream) then
			col = rarity_names[9][2]
		else
			col = Color(unpack(col[2], 1, 3))
		end

		wep:SetColor(col)
		wep:SetRenderMode(RENDERMODE_TRANSADDFRAMEBLEND)
		wep:SetMaterial("models/debug/debugwhite")
	end

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
	local col = MOAT_PAINT.Tints[tint]
	if (col) then
		if (col.Dream) then
			col = rarity_names[9][2]
		else
			col = Color(unpack(col[2], 1, 3))
		end

		wep:SetColor(col)
		wep:SetRenderMode(RENDERMODE_TRANSCOLOR)
	end

	local OldDrawWorldModel = wep.DrawWorldModel or wep.DrawWorldModelTranslucent or wep.DrawModel

	wep.RenderGroup = RENDERGROUP_TRANSLUCENT
	function wep:DrawWorldModelTranslucent()
		OldDrawWorldModel(self)
		
		self:SetColor(col)
	end
	wep.DrawWorldModel = nil
end

function MOAT_LOADOUT.ApplySkin(wep, skin)
	local mat_str, name_str, new_mat = MOAT_PAINT.Skins[skin][2], MOAT_PAINT.Skins[skin][1]

	if (mat_str:match "^http") then
		new_mat = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
			["$model"] = 1,
			["$alphatest"] = 1,
			["$vertexcolor"] = 1,
			["$basetexture"] = "error"
		})

		if (mat_str:match "vtf$") then
			local function set(m)
				new_mat:SetTexture("$basetexture", m)
			end

			local m = cdn.Texture(mat_str, set)
			if (m) then
				set(m)
			end
		else
			local function set(m)
				new_mat:SetTexture("$basetexture", m:GetTexture("$basetexture"))
			end

			local m = cdn.Image(mat_str, set)
			if (m) then
				set(m)
			end
		end
	else
		wep:SetMaterial(mat_str)
	end

	wep.RenderGroup = RENDERGROUP_TRANSLUCENT
	
	local OldDrawWorldModel = wep.DrawWorldModel or wep.DrawWorldModelTranslucent or wep.DrawModel

	function wep:DrawWorldModelTranslucent(c)
		self.Owner.CustomColor = color
		if (new_mat) then
			render.MaterialOverride(new_mat)

			if (dream) then
				render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)
			elseif (color) then
				render.SetColorModulation(color.r / 255, color.g / 255, color.b / 255)
			else
				render.SetColorModulation(1, 1, 1)
			end

			render.SetBlend(1)
			OldDrawWorldModel(self)
			render.MaterialOverride(nil)
		else
			OldDrawWorldModel(self)
		end

		if (mat_str:match "vtf$" and not self.SetMeme) then
			local m = cdn.Texture(mat_str)
			if (m and not self.SetMeme) then
				self.SetMeme = true
				new_mat:SetTexture("$basetexture", m)
				self:SetSubMaterial(0, "!"..new_mat:GetName())
			end
		elseif (mat_str:match "^http" and not self.SetMeme) then
			local m = cdn.Image(mat_str)
			if (m and not self.SetMeme) then
				self.SetMeme = true
				new_mat:SetTexture("$basetexture", m:GetTexture "$basetexture")
				self:SetSubMaterial(0, "!"..new_mat:GetName())
			end
		elseif (not self.SetMeme) then
			self:SetMaterial(mat_str)
		end

		self.Owner.CustomColor = nil
	end
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
	timer.Create(name, 0.1, 0, function()
		local wep = Entity(wep_index)

		if (not IsValid(wep)) then
			return
		end

		if (not wep:IsWeapon() or not wep_stats) then
			timer.Remove(name)
			return
		end

		wep.ItemStats = wep_stats

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
