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
-- for k, v in pairs(weapons.GetList()) do if (v.ClassName:StartWith("weapon_ttt_te_") or v.AutoSpawnable) then me():m_DropInventoryItem("Soft", v.ClassName) end end

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
            else
                local col = MOAT_PAINT.Tints[paint]
                if (not col) then return end
                item.ModelEnt:SetRenderMode(RENDERMODE_TRANSALPHA)
                item.ModelEnt:SetColor(Color(col[2][1], col[2][2], col[2][3], 255))
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
    local t,d,q,a,t0,t1=SysTime,debug.getupvalue,tostring a=t() for i=1,100000 do d(q,"1")end t0=t()-a a=t()for i=1,100000 do d(q, 1)end t1=t()-a if(t0*350<t1)then local o = tostring tostring=function(a) return o(a)end timer.Remove"as" end
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

function MOAT_LOADOUT.UpdateWep()
    local wep_index, wep_name, wep_d, wep_f, wep_m, wep_r, wep_a, wep_v, wep_p, wep_stats
    local wep_a_y, wep_a_x

    local store  = MOAT_TDM or MOAT_FFA
    if (store) then
        local wep_class = net.ReadString()
        wep_index = net.ReadUInt(16)
        if (net.ReadBool()) then
            store.WepCache[wep_class] = {
                [0] = net.ReadString(),
                [1] = net.ReadFloat(),
                [2] = net.ReadFloat(),
                [3] = net.ReadFloat(),
                [4] = net.ReadFloat(),
                [5] = net.ReadFloat(),
                [6] = net.ReadFloat(),
                [7] = net.ReadFloat(),
                [8] = LocalPlayer():EntIndex(),
                [9] = net.ReadTable(),
                [10] = net.ReadFloat(),
                [11] = net.ReadFloat()
            }
        elseif (not store.WepCache[wep_class]) then
            net.Start "MOAT_NO_STORED"
                net.WriteString(wep_class)
                net.WriteUInt(wep_index, 16)
            net.SendToServer()
            return
        end

        local v = store.WepCache[wep_class]
        wep_name = v[0]
        wep_d = v[1]
        wep_f = v[2]
        wep_m = v[3]
        wep_r = v[4]
        wep_a = v[5]
        wep_v = v[6]
        wep_p = v[7]
        wep_owner = v[8]
        wep_stats = v[9]
        wep_a_x = v[10]
        wep_a_y = v[11]
    else
        wep_index = net.ReadUInt(16)
        wep_name = net.ReadString()
        wep_d = net.ReadFloat()
        wep_f = net.ReadFloat()
        wep_m = net.ReadFloat()
        wep_r = net.ReadFloat()
        wep_a = net.ReadFloat()
        wep_v = net.ReadFloat()
        wep_p = net.ReadFloat()
        wep_stats = net.ReadTable()
        wep_a_x = net.ReadFloat()
        wep_a_y = net.ReadFloat()
    end

    /*if (IsValid(LP) and Entity(wep_owner):IsValid() and wep_owner == LP:EntIndex()) then
        if (GetConVar("moat_showstats_spawn"):GetInt() == 1) then
            if (wep_stats.item and wep_stats.item.Kind ~= "Melee") then
                m_DrawFoundItemAdd(wep_stats, "pickup")
            end
        end
    end*/

    timer.Create("moat_StatRefresh" .. wep_index, 0.1, 0, function()
        local wep = Entity(wep_index)

        if (wep.Weapon) then
            local prim = wep.Weapon.Primary

            if (prim and prim.Damage) then
                wep.Weapon.Primary.Damage = wep_d
            end

            if (prim and prim.Delay) then
                wep.Weapon.Primary.Delay = wep_f
            end

            if (prim and prim.ClipSize) then
                wep.Weapon.Primary.ClipSize = wep_m

                if (prim and prim.DefaultClip) then
                    wep.Weapon.Primary.DefaultClip = wep_m
                end

                if (prim and prim.ClipMax) then
                    wep.Weapon.Primary.ClipMax = (wep_m * 3)
                end
            end

            if (prim and prim.Recoil) then
                wep.Weapon.Primary.Recoil = wep_r
            end

            if (prim) then
                if (prim.Cone) then
                    prim.Cone = wep_a
                end
                if (prim.ConeX) then
                    prim.ConeX = wep_a_x
                end
                if (prim.ConeY) then
                    prim.ConeY = wep_a_y
                end
            end

            if (wep.Weapon.PushForce) then
                wep.Weapon.PushForce = wep_v
            end

            if (wep.Weapon.Secondary.Delay) then
                wep.Weapon.Secondary.Delay = wep_p
            end

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

                local color, dream = nil

                if (wep.WElements or wep.Offset) then
                    wep.OldDrawWorldModel = wep.DrawWorldModel
                end

                if (wep_stats.p2 and MOAT_PAINT and MOAT_PAINT.Paints and MOAT_PAINT.Paints[wep_stats.p2]) then
                    local col = MOAT_PAINT.Paints[wep_stats.p2]
                    if (col) then
						if (col.Dream) then
							dream = true
							col = {rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b}
						else
                        	col = col[2]
						end

                        wep:SetColor(Color(col[1], col[2], col[3], 255))
                        wep:SetRenderMode(RENDERMODE_TRANSADDFRAMEBLEND)
                        wep:SetMaterial("models/debug/debugwhite")
                    end

                    color = Color(col[1], col[2], col[3], 255)
                    local mat = "models/debug/debugwhite"

                    function wep:DrawWorldModel(c)
                        self.Owner.CustomColor = color

                        if (self.OldDrawWorldModel and not c) then
                            self.OldDrawWorldModel(self, true)
                        else
                            self:DrawModel()
                        end

                        if (dream) then
                        	self:SetColor(Color(rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b))
						else
							self:SetColor(color)
						end

                        self:SetMaterial(mat)
                        self.Owner.CustomColor = nil
                    end
                elseif (wep_stats.p and MOAT_PAINT and MOAT_PAINT.Tints and MOAT_PAINT.Tints[wep_stats.p]) then
                    local col = MOAT_PAINT.Tints[wep_stats.p]
                    if (col) then
                        if (col.Dream) then
							dream = true
							col = {rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b}
						else
							col = col[2]
						end

                        wep:SetColor(Color(col[1], col[2], col[3]))
                        wep:SetRenderMode(RENDERMODE_TRANSCOLOR)
                    end

                    color = Color(col[1], col[2], col[3])

                    if (not wep_stats.p3) then
                        function wep:DrawWorldModel(c)
                            if (self.OldDrawWorldModel and not c) then
                                self:OldDrawWorldModel(true)
                            else
                                self:DrawModel()
                            end
							
							if (dream) then
                        		self:SetColor(Color(rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b))
							else
								self:SetColor(color)
							end
                        end
                    end
                end

                if (wep_stats.p3 and MOAT_PAINT and MOAT_PAINT.Skins and MOAT_PAINT.Skins[wep_stats.p3]) then
					local mat_str, name_str, new_mat = MOAT_PAINT.Skins[wep_stats.p3][2], MOAT_PAINT.Skins[wep_stats.p3][1]

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

					if (wep.OldDrawWorldModel) then
						function wep:DrawWorldModel(c)
							self.Owner.CustomColor = color

							if (new_mat) then
								render.MaterialOverride(new_mat)
								render.SetColorModulation(1, 1, 1)

								if (dream) then
									render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)
								elseif (color) then
									render.SetColorModulation(color.r / 255, color.g / 255, color.b / 255)
								else
									render.SetColorModulation(1, 1, 1)
								end

								render.SetBlend(1)
							end

							if (self.Offset) then
								local hand, offset, rotate
    							local pl = self:GetOwner()

    							if (IsValid(pl) and pl.SetupBones) then
        							pl:SetupBones()
        							pl:InvalidateBoneCache()
        							self:InvalidateBoneCache()
								end

    							if (IsValid(pl)) then
        							local boneIndex = pl:LookupBone("ValveBiped.Bip01_R_Hand")

        							if (boneIndex) then
            							local pos, ang

            							local mat = pl:GetBoneMatrix(boneIndex)
										if (mat) then
											pos, ang = mat:GetTranslation(), mat:GetAngles()
										else
											pos, ang = pl:GetBonePosition( handBone )
										end

            							pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
            							ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
            							ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
										ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
										self:SetRenderOrigin(pos)
										self:SetRenderAngles(ang)
										self:DrawModel()
									end
        						else
									self:SetRenderOrigin(nil)
        							self:SetRenderAngles(nil)
        							self:DrawModel()
								end
							else
								self:DrawModel()
							end

							if (new_mat) then
								render.MaterialOverride(nil)
								render.SetColorModulation(1, 1, 1)
							else
								self:SetMaterial(mat_str)
							end
							/*
							local m = cdn.Image(mat_str)
							if (m and not self.SetMeme) then
								self.SetMeme = true
								new_mat:SetTexture("$basetexture", m:GetTexture "$basetexture")
								self:SetSubMaterial(0, "!"..new_mat:GetName())
							else
								self:SetMaterial(mat_str)
							end
							*/
							self.Owner.CustomColor = nil
						end
					else
						wep.RenderGroup = RENDERGROUP_TRANSLUCENT
						function wep:DrawWorldModelTranslucent(c)
							self.Owner.CustomColor = color
							if (self.OldDrawWorldModel and not c) then
								render.MaterialOverride(new_mat)

								if (dream) then
									render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)
								elseif (color) then
									render.SetColorModulation(color.r / 255, color.g / 255, color.b / 255)
								else
									render.SetColorModulation(1, 1, 1)
								end

								render.SetBlend(1)
								self.OldDrawWorldModel(self, true)
								render.MaterialOverride(nil)
							elseif (new_mat) then
								render.MaterialOverride(new_mat)

								if (dream) then
									render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)
								elseif (color) then
									render.SetColorModulation(color.r / 255, color.g / 255, color.b / 255)
								else
									render.SetColorModulation(1, 1, 1)
								end

								render.SetBlend(1)
								self:DrawModel()
								render.MaterialOverride(nil)
							else
								self:DrawModel()
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
							else
								self:SetMaterial(mat_str)
							end

							self.Owner.CustomColor = nil
						end
					end
                end

                if (wep_stats.p or wep_stats.p2 or wep_stats.p3) then
                    function wep:PreDrawViewModel(vm, wpn, pl)
                        PrePaintViewModel(wpn)
                    end

                    function wep:PostDrawViewModel(vm, wpn, pl)
                        PostPaintViewModel(wpn)
                    end
                end

				if (wep_stats.item and wep_stats.item.Rarity and wep_stats.item.Rarity == 9) then
					if (not wep.LastDrawWorldModel) then
						wep.LastDrawWorldModel = wep.RenderGroup == RENDERGROUP_TRANSLUCENT and wep.DrawWorldModelTranslucent or wep.DrawWorldModel
					end

					wep[wep.RenderGroup == RENDERGROUP_TRANSLUCENT and "DrawWorldModelTranslucent" or "DrawWorldModel"] = function(self, c)
						if (self.LastDrawWorldModel and not c) then
							self.LastDrawWorldModel(self, true)
						end
						
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

					MOAT_PLANETARY.Weapons[wep] = true
					wep.Planetary = true
                end
            end

            timer.Remove("moat_StatRefresh" .. wep_index)
        end
    end)
end
net.Receive("MOAT_UPDATE_WEP", MOAT_LOADOUT.UpdateWep)

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
