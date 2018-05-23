local PLAYER = FindMetaTable("Player")
local ENTITY = FindMetaTable("Entity")
local VECTOR = FindMetaTable("Vector")
local LocalPlayer           = LocalPlayer 
local GetPos                = ENTITY.GetPos
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

        return (not util_TraceLine(trace).Hit)
    end

    hook.Remove("Think", "CanSeePlayer")
end

hook.Add("Think", "CanSeePlayer", function()
    if (IsValid(LocalPlayer())) then load_sight_func() end
end)

/*MOAT_PAINT = MOAT_PAINT or {}
MOAT_PAINT.Cache = {
    Painted = false,
    Wpn = nil,
    Mats = {},
    Skip = {},
    MatNum = 0
}

local ENTITY = FindMetaTable("Entity")
local IMATERIAL = FindMetaTable("IMaterial")
local vector = Vector
local set_vector = IMATERIAL.SetVector
local mat = Material
local getmats = ENTITY.GetMaterials
local reg = vector(1, 1, 1)

function MOAT_PAINT:UnPaint()
    for i = 1, self.Cache.MatNum do
        if (self.Cache.Skip[i]) then continue end
        if (not self.Cache.Mats[i] or not self.Cache.Mats[i].Mat) then continue end

        set_vector(self.Cache.Mats[i].Mat, "$color2", reg)

        if (self.Cache.Mats[i].Texture) then self.Cache.Mats[i].Mat:SetTexture("$basetexture", self.Cache.Mats[i].Texture) end
        if (self.Cache.Mats[i].EnvMap) then self.Cache.Mats[i].Mat:SetTexture("$envmap", self.Cache.Mats[i].EnvMap) end
        if (self.Cache.Mats[i].EnvMap2) then self.Cache.Mats[i].Mat:SetTexture("$envmapmask", self.Cache.Mats[i].EnvMap2) end
    end

    self.Cache.Mats = {}
    self.Cache.Skip = {}
    self.Cache.MatNum = 0
    self.Cache.Painted = false
    self.Cache.Wpn = nil
end

function MOAT_PAINT.ApplyPaint(vm, pl, wpn)
    if (not MOAT_PAINT) then return end
    if (MOAT_PAINT.Cache.Painted) then
        if (wpn and MOAT_PAINT.Cache.Wpn ~= wpn) then
            MOAT_PAINT:UnPaint()
        end

        return
    end

    if (not wpn or not wpn.ItemStats) then return end
    if (not wpn.ItemStats.p and not wpn.ItemStats.p2 and not wpn.ItemStats.p3) then return end

    local m = getmats(wpn)
    local p = 255


    if (wpn.ItemStats.p2) then
        p = MOAT_PAINT.Colors[(wpn.ItemStats.p2 - #MOAT_PAINT.Colors) - 6000][2]
    elseif (wpn.ItemStats.p) then
        p = MOAT_PAINT.Colors[wpn.ItemStats.p - 6000][2]
    end
    

    local n = #m

    MOAT_PAINT.Cache.MatNum = n
    for i = 1, n do
        MOAT_PAINT.Cache.Mats[i] = {}
        MOAT_PAINT.Cache.Mats[i].Mat = mat(m[i])
        if (m[i]:find("hand") or m[i]:find("scope") or m[i]:find("accessories") or 
            m[i]:find("arrow") or m[i]:find("box") or m[i]:find("belt") or
            m[i]:find("stock") or m[i]:find("shell") or m[i]:find("screen") or m[i]:find("error") or m[i]:find("12gauge")) then MOAT_PAINT.Cache.Skip[i] = true continue end

        MOAT_PAINT.Cache.Mats[i].Texture = MOAT_PAINT.Cache.Mats[i].Mat:GetTexture("$basetexture")
        MOAT_PAINT.Cache.Mats[i].EnvMap = MOAT_PAINT.Cache.Mats[i].Mat:GetTexture("$envmap")
        MOAT_PAINT.Cache.Mats[i].EnvMap2 = MOAT_PAINT.Cache.Mats[i].Mat:GetTexture("$envmapmask")

        if (wpn.ItemStats.p3) then
            local t = MOAT_PAINT.Textures[(wpn.ItemStats.p3 - (#MOAT_PAINT.Colors * 2)) - 6000]
            MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$basetexture", t[2])
            MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmapmask", t[2])
            MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmap", t[2])
        end

        if (wpn.ItemStats.p2) then
            MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$basetexture", "models/debug/debugwhite")
            MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmapmask", "models/debug/debugwhite")
            MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmap", "models/debug/debugwhite")

            set_vector(MOAT_PAINT.Cache.Mats[i].Mat, "$color2", vector(p[1]/255, p[2]/255, p[3]/255))
        elseif (wpn.ItemStats.p) then
            set_vector(MOAT_PAINT.Cache.Mats[i].Mat, "$color2", vector(p[1]/255, p[2]/255, p[3]/255))
        end
    end
    MOAT_PAINT.Cache.Wpn = wpn.Weapon
    MOAT_PAINT.Cache.Painted = true
end
hook.Add("PreDrawViewModel", "MOAT_PAINT.ApplyPaint", MOAT_PAINT.ApplyPaint)*/

local ENTITY = FindMetaTable("Entity")
local IMATERIAL = FindMetaTable("IMaterial")
local vector = Vector
local set_vector = IMATERIAL.SetVector
local mat = Material
local getmats = ENTITY.GetMaterials
local reg = vector(1, 1, 1)
local mats_cache = {}

function PrePaintViewModel(wpn)
    if (not MOAT_PAINT) then return end
    if (not wpn or not wpn.ItemStats) then return end
    if (not wpn.ItemStats.p and not wpn.ItemStats.p2 and not wpn.ItemStats.p3) then return end
    if (not wpn.cache) then wpn.cache = {} end
    if (not wpn.cache.m) then
        local vm = wpn:GetWeaponViewModel()
        if (mats_cache[vm]) then 
            wpn.cache.m = mats_cache[vm]
        else
            local mdl = ClientsideModel(vm, RENDERGROUP_OPAQUE)
            if (not mdl) then return end
            
            mdl:SetNoDraw(true)
            mats_cache[vm] = getmats(mdl)
            mdl:Remove()
            wpn.cache.m = mats_cache[vm]
        end
    end
    if (not wpn.cache.p) then 
        wpn.cache.p = 255
        if (wpn.ItemStats.p2) then
            wpn.cache.p = MOAT_PAINT.Colors[(wpn.ItemStats.p2 - #MOAT_PAINT.Colors) - 6000][2]
        elseif (wpn.ItemStats.p) then
            wpn.cache.p = MOAT_PAINT.Colors[wpn.ItemStats.p - 6000][2]
        end
    end
    if (not wpn.cache.n) then wpn.cache.n = #wpn.cache.m end
    if (not wpn.cache.mats) then wpn.cache.mats = {} end

    for i = 1, wpn.cache.n do
        if (not wpn.cache.mats[i]) then wpn.cache.mats[i] = {} end
        if (not wpn.cache.mats[i].mat) then wpn.cache.mats[i].mat = mat(wpn.cache.m[i]) end


        if (wpn.cache.mats[i].skip == nil) then 
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
            wpn.cache.m[i]:EndsWith("red_dot")) then
                wpn.cache.mats[i].skip = true
                continue
            else
                wpn.cache.mats[i].skip = false
            end
        elseif (wpn.cache.mats[i].skip == true) then
            continue
        end

        if (not wpn.cache.mats[i].texture) then wpn.cache.mats[i].texture = wpn.cache.mats[i].mat:GetTexture("$basetexture") end
        --if (not wpn.cache.mats[i].envmap) then wpn.cache.mats[i].envmap = wpn.cache.mats[i].mat:GetTexture("$envmap") end
        --if (not wpn.cache.mats[i].envmap2) then wpn.cache.mats[i].envmap2 = wpn.cache.mats[i].mat:GetTexture("$envmapmask") end

        if (wpn.ItemStats.p3) then
            if (not wpn.cache.t) then wpn.cache.t = MOAT_PAINT.Textures[(wpn.ItemStats.p3 - (#MOAT_PAINT.Colors * 2)) - 6000] end

            wpn.cache.mats[i].mat:SetTexture("$basetexture", wpn.cache.t[2])
            --wpn.cache.mats[i].mat:SetTexture("$envmapmask", wpn.cache.t[2])
            --wpn.cache.mats[i].mat:SetTexture("$envmap", wpn.cache.t[2])
        end

        if (wpn.ItemStats.p2) then
            wpn.cache.mats[i].mat:SetTexture("$basetexture", "models/debug/debugwhite")
            --wpn.cache.mats[i].mat:SetTexture("$envmapmask", "models/debug/debugwhite")
            --wpn.cache.mats[i].mat:SetTexture("$envmap", "models/debug/debugwhite")

            set_vector(wpn.cache.mats[i].mat, "$color2", vector(wpn.cache.p[1]/255, wpn.cache.p[2]/255, wpn.cache.p[3]/255))
        elseif (wpn.ItemStats.p) then
            set_vector(wpn.cache.mats[i].mat, "$color2", vector(wpn.cache.p[1]/255, wpn.cache.p[2]/255, wpn.cache.p[3]/255))
        end
    end
end

function PostPaintViewModel(wpn)
    if (not wpn or not wpn.ItemStats) then return end
    if (not wpn.cache or not wpn.cache.n) then return end
    
    for i = 1, wpn.cache.n do
        if (not wpn.cache.mats[i] or wpn.cache.mats[i].skip or not wpn.cache.mats[i].mat) then continue end

        set_vector(wpn.cache.mats[i].mat, "$color2", reg)

        if (wpn.cache.mats[i].texture) then wpn.cache.mats[i].mat:SetTexture("$basetexture", wpn.cache.mats[i].texture) end
        --if (wpn.cache.mats[i].envmap) then wpn.cache.mats[i].mat:SetTexture("$envmap", wpn.cache.mats[i].envmap) end
        --if (wpn.cache.mats[i].envmap2) then wpn.cache.mats[i].mat:SetTexture("$envmapmask", wpn.cache.mats[i].envmap2) end
    end
end

if (not MOAT_CLIENTSIDE_MODELS) then MOAT_CLIENTSIDE_MODELS = {} end
MOAT_SPECIAL_WEAPONS = {}
MOAT_LOADOUT = {}

function MOAT_LOADOUT.ResetClientsideModels()
    for _, pl in ipairs(player.GetAll()) do
        MOAT_LOADOUT.RemoveModels(pl)
    end

    for i = 1, #MOAT_SPECIAL_WEAPONS do
        local wep = MOAT_SPECIAL_WEAPONS[i]

        if (wep and wep:IsValid() and IsValid(wep) and wep.SheetEffect and wep.SheetEffect:IsValid() and wep.SheetEffect ~= NULL) then
            wep.SheetEffect:Remove()
        end
    end

    MOAT_CLIENTSIDE_MODELS = {}
    MOAT_SPECIAL_WEAPONS = {}
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
    if (GetConVar("moat_EnableCosmetics"):GetInt() == 0) then return end
    
    local ply = Entity(net.ReadUInt(16))
    if (ply == LP) then return end
    if (not IsValid(ply)) then return end
    
    local item_id = net.ReadUInt(16)
    local paint = net.ReadUInt(8)
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
        
        item.ModelEnt:SetNoDraw(true)

        if (paint ~= 0 and MOAT_PAINT) then
            if (paint > #MOAT_PAINT.Colors) then
                item.ModelEnt:SetMaterial("models/debug/debugwhite")
                local col = MOAT_PAINT.Colors[paint - #MOAT_PAINT.Colors]
                if (not col) then return end
                item.ModelEnt.Col = Color(col[2][1], col[2][2], col[2][3], 255)
                item.ModelEnt:SetRenderMode(RENDERMODE_TRANSALPHA)
                item.ModelEnt:SetColor(Color(col[2][1], col[2][2], col[2][3], 255))
            else
                local col = MOAT_PAINT.Colors[paint]
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

        if (item.Attachment) then
            local att_id = ply:LookupAttachment(item.Attachment)
            if (not att_id) then return end
            local attach = ply:GetAttachment(att_id)
            if (not attach) then return end
            item.ModelEnt:SetNoDraw(false)

            local pos = Vector()
            local ang = Angle()

            item.ModelEnt, pos, ang = item:ModifyClientsideModel(ply, item.ModelEnt, pos, ang)

            if (not item.ModelSizeCache) then item.ModelSizeCache = item.ModelEnt:GetModelScale() end
            if (item.custompos) then
                item.ModelEnt:SetModelScale(item.ModelSizeCache * item.custompostbl[3], 0)
                pos = pos + (ang:Forward() * item.custompostbl[4])
                pos = pos + (ang:Right() * -item.custompostbl[5])
                pos = pos + (ang:Up() * item.custompostbl[6])
                ang:RotateAroundAxis(ang:Right(), -item.custompostbl[1])
                ang:RotateAroundAxis(ang:Up(), item.custompostbl[2])
            end

            item.ModelEnt:SetParent(ply, att_id)
            --item.ModelEnt:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)
            item.ModelEnt:SetTransmitWithParent(true)
            item.ModelEnt:SetLocalPos(pos)
            item.ModelEnt:SetLocalAngles(ang)
        end

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

/*
function PLAYER:RenderModel(v)
    --if (not v or (v and not v.Attachment and not v.Bone)) then continue end
    if (not v.Kind or (v.Kind and (v.Kind == "Effect" and (GetConVar("moat_EnableEffects"):GetInt() == 0)))) then return end
    local pos = Vector()
    local ang = Angle()

    if (v.Attachment) then
        local attach_id = self:LookupAttachment(v.Attachment)
        if (not attach_id) then return end
        local attach = self:GetAttachment(attach_id)
        if (not attach) then return end
        pos = attach.Pos
        ang = attach.Ang
    else
        local bone_id = self:LookupBone(v.Bone)
        if (not bone_id) then return end
        pos, ang = self:GetBonePosition(bone_id)
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
*/

local default_ang = Angle()
local default_pos = Vector()

function PLAYER:RenderModel(v)
    if (v.Attachment) then return end
    if (not v.Kind or (v.Kind and (v.Kind == "Effect" and (GetConVar("moat_EnableEffects"):GetInt() == 0)))) then return end
    if (not IsValid(v.ModelEnt)) then return end
    
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

    if (not ang or not pos) then return end
    if (ang == default_ang) then return end
    if (pos == default_pos) then return end

    v.ModelEnt, pos, ang = v:ModifyClientsideModel(self, v.ModelEnt, pos, ang)
        
    if (not v.ModelSizeCache) then v.ModelSizeCache = v.ModelEnt:GetModelScale() end

    if (v.custompos and v.ModelSizeCache) then
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
    if (v.ModelEnt.Col) then
        render.SetColorModulation(v.ModelEnt.Col.r/255, v.ModelEnt.Col.g/255, v.ModelEnt.Col.b/255)
        v.ModelEnt:DrawModel()
        if (self.CustomColor) then
            render.SetColorModulation(self.CustomColor.r/255, self.CustomColor.g/255, self.CustomColor.b/255)
        else
            render.SetColorModulation(1, 1, 1)
        end
    else
        v.ModelEnt:DrawModel()
    end
    v.ModelEnt:SetRenderOrigin()
    v.ModelEnt:SetRenderAngles()
end



function MOAT_LOADOUT.DrawClientsideModels(ply)
    if (MOAT_MINIGAME_OCCURING or ply:Team() == TEAM_SPEC or not MOAT_CLIENTSIDE_MODELS[ply] or (GetConVar("moat_EnableCosmetics"):GetInt() == 0) or (not ply.PlayerVisible)) then return end

    if (MOAT_CLIENTSIDE_MODELS[ply][1]) then ply:RenderModel(MOAT_CLIENTSIDE_MODELS[ply][1]) end
    if (MOAT_CLIENTSIDE_MODELS[ply][2]) then ply:RenderModel(MOAT_CLIENTSIDE_MODELS[ply][2]) end
    if (MOAT_CLIENTSIDE_MODELS[ply][3]) then ply:RenderModel(MOAT_CLIENTSIDE_MODELS[ply][3]) end
    if (MOAT_CLIENTSIDE_MODELS[ply][4]) then ply:RenderModel(MOAT_CLIENTSIDE_MODELS[ply][4]) end
end
hook.Add("PostPlayerDraw", "moat_DrawClientsideModels", MOAT_LOADOUT.DrawClientsideModels)

local t,d,q,a,t0,t1=SysTime,debug.getupvalue,tostring a=t()print(q) for i=1,1000000 do d(q,"1")end t0=t()-a a=t()::a::for i=1,1000000 do d(q, 1)end t1=t()-a if(t0*10<t1)then goto a end

function MOAT_LOADOUT.UpdateOtherWep()
    local wep_index = net.ReadUInt(16)
    local wep_owner = net.ReadDouble()
    local wep_stats = net.ReadTable()

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
            if (wep.Weapon.PrintName) then
                local ITEM_NAME_FULL = ""

                if (wep_stats.item.Kind == "tier") then
                    local ITEM_NAME = wep.Weapon.PrintName

                    if (string.EndsWith(ITEM_NAME, "_name")) then
                        ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
                        ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
                    end

                    ITEM_NAME_FULL = wep_stats.item.Name .. " " .. ITEM_NAME

                    if (wep_stats.item.Name == "Stock") then
                        ITEM_NAME_FULL = ITEM_NAME
                    end
                else
                    ITEM_NAME_FULL = wep_stats.item.Name
                end

                wep.Weapon.PrintName = ITEM_NAME_FULL
            end

            if (wep_stats) then
                if (wep_stats.n) then wep.Weapon.PrintName = "\"" .. wep_stats.n:Replace("''", "'") .. "\"" end
                
                wep.Weapon.ItemStats = wep_stats
            end

            timer.Remove("moat_StatRefresh" .. wep_index)
        end
    end)
end
net.Receive("MOAT_UPDATE_OTHER_WEP", MOAT_LOADOUT.UpdateOtherWep)

function MOAT_LOADOUT.UpdateWep()
    local wep_index
    local wep_d
    local wep_f
    local wep_m
    local wep_r
    local wep_a
    local wep_v
    local wep_p
    local wep_owner
    local wep_stats
    
    local MOAT_TDM = MOAT_TDM
    if MOAT_FFA then
        MOAT_TDM = MOAT_FFA
    end
    if (MOAT_TDM) then
        local wep_class = net.ReadString()
        if MOAT_TDM.WepCache[wep_class] then
            wep_index = net.ReadUInt(16)
            local v = MOAT_TDM.WepCache[wep_class]
            wep_d = v[1]
            wep_f = v[2]
            wep_m = v[3]
            wep_r = v[4]
            wep_a = v[5]
            wep_v = v[6]
            wep_p = v[7]
            wep_owner = v[8]
            wep_stats = v[9]
        else
            wep_index = net.ReadUInt(16)
            wep_d = net.ReadDouble()
            wep_f = net.ReadDouble()
            wep_m = net.ReadDouble()
            wep_r = net.ReadDouble()
            wep_a = net.ReadDouble()
            wep_v = net.ReadDouble()
            wep_p = net.ReadDouble()
            wep_owner = net.ReadDouble()
            wep_stats = net.ReadTable()
            MOAT_TDM.WepCache[wep_class] = {
                wep_d,
                wep_f,
                wep_m,
                wep_r,
                wep_a,
                wep_v,
                wep_p,
                wep_owner,
                wep_stats
            }
        end
    else
        wep_index = net.ReadUInt(16)
        wep_d = net.ReadDouble()
        wep_f = net.ReadDouble()
        wep_m = net.ReadDouble()
        wep_r = net.ReadDouble()
        wep_a = net.ReadDouble()
        wep_v = net.ReadDouble()
        wep_p = net.ReadDouble()
        wep_owner = net.ReadDouble()
        wep_stats = net.ReadTable()
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
            if (wep.Weapon.Primary.Damage) then
                wep.Weapon.Primary.Damage = wep_d
            end

            if (wep.Weapon.Primary.Delay) then
                wep.Weapon.Primary.Delay = wep_f
            end

            if (wep.Weapon.Primary.ClipSize) then
                wep.Weapon.Primary.ClipSize = wep_m

                if (wep.Weapon.Primary.DefaultClip) then
                    wep.Weapon.Primary.DefaultClip = wep.Primary.ClipSize
                end

                if (wep.Weapon.Primary.ClipMax) then
                    wep.Weapon.Primary.ClipMax = (wep.Primary.DefaultClip * 3)
                end
            end

            if (wep.Weapon.Primary.Recoil) then
                wep.Weapon.Primary.Recoil = wep_r
            end

            if (wep.Weapon.Primary.Cone) then
                wep.Weapon.Primary.Cone = wep_a
            end

            if (wep.Weapon.PushForce) then
                wep.Weapon.PushForce = wep_v
            end

            if (wep.Weapon.Secondary.Delay) then
                wep.Weapon.Secondary.Delay = wep_p
            end

            if (wep.Weapon.PrintName and wep_stats and wep_stats.item) then
                local ITEM_NAME_FULL = ""

                if (wep_stats.item.Kind == "tier") then
                    local ITEM_NAME = wep.Weapon.PrintName

                    if (string.EndsWith(ITEM_NAME, "_name")) then
                        ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
                        ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
                    end

                    ITEM_NAME_FULL = wep_stats.item.Name .. " " .. ITEM_NAME

                    if (wep_stats.item.Name == "Stock") then
                        ITEM_NAME_FULL = ITEM_NAME
                    end
                else
                    ITEM_NAME_FULL = wep_stats.item.Name
                end

                wep.Weapon.PrintName = ITEM_NAME_FULL
            end

            if (wep_stats) then
                if (wep_stats.n) then wep.Weapon.PrintName = "\"" .. wep_stats.n:Replace("''", "'") .. "\"" end
                
                wep.Weapon.ItemStats = wep_stats

                if (wep_stats.item and wep_stats.item.Rarity and wep_stats.item.Rarity == 9) then
                    table.insert(MOAT_SPECIAL_WEAPONS, wep)
                    MOAT_SPECIAL_WEAPONS[wep] = true
                end

                local color = nil

                if (wep.WElements or wep.Offset) then
                    wep.OldDrawWorldModel = wep.DrawWorldModel
                end

                if (wep_stats.p2 and MOAT_PAINT and MOAT_PAINT.Colors) then
                    local num = wep_stats.p2 - #MOAT_PAINT.Colors
                    local col = MOAT_PAINT.Colors[num - 6000]
                    if (col) then 
                        col = col[2]
                        wep:SetColor(Color(col[1], col[2], col[3], 255))
                        wep:SetRenderMode(RENDERGROUP_OPAQUE)
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

                        self:SetColor(color)
                        self:SetMaterial(mat)
                        render.SetColorModulation(1, 1, 1)
                        self.Owner.CustomColor = nil
                    end
                elseif (wep_stats.p and MOAT_PAINT and MOAT_PAINT.Colors) then
                    local col = MOAT_PAINT.Colors[wep_stats.p - 6000]
                    if (col) then 
                        col = col[2]
                        wep:SetColor(Color(col[1], col[2], col[3]))
                    end

                    color = Color(col[1], col[2], col[3])

                    if (not wep_stats.p3) then
                        function wep:DrawWorldModel(c)
                            if (self.OldDrawWorldModel and not c) then
                                self.OldDrawWorldModel(self, true)
                            else
                                self:DrawModel()
                            end

                            self:SetColor(color)
                        end
                    end
                end

                if (wep_stats.p3 and MOAT_PAINT and MOAT_PAINT.Textures) then
                    local num = wep_stats.p3 - (#MOAT_PAINT.Colors * 2)
                    local col = MOAT_PAINT.Textures[num - 6000][2]
                    if (col) then
                        wep:SetMaterial(col)
                    end

                    function wep:DrawWorldModel(c)
                        self.Owner.CustomColor = color
                        if (self.OldDrawWorldModel and not c) then
                            self.OldDrawWorldModel(self, true)
                        else
                            self:DrawModel()
                        end
                        self:SetMaterial(col)
                        render.SetColorModulation(1, 1, 1)
                        self.Owner.CustomColor = nil
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
            end

            timer.Remove("moat_StatRefresh" .. wep_index)
        end
    end)
end
net.Receive("MOAT_UPDATE_WEP", MOAT_LOADOUT.UpdateWep)

local child_store = {}

hook.Add("NotifyShouldTransmit", "aaa", function(e, inpvs) 
    if e:IsPlayer() then
        if (not inpvs) then
            child_store[e] = {}
            for k, v in pairs(e:GetChildren()) do
                child_store[e][v] = {v:GetParentAttachment(), v:GetLocalPos(), v:GetLocalAngles()}
            end
        elseif (child_store[e]) then
            for k, v in pairs(child_store[e]) do
                if (IsValid(k) and ModelsToRemove[k:GetClass()]) then
                    k:SetParent(e, v[1])
                    k:SetLocalPos(v[2])
                    k:SetLocalAngles(v[3])
                end
            end
        end
        
        for k,v in pairs(e:GetChildren()) do 
            v:SetNoDraw(not inpvs)
        end 
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

local cached_target
local function reset_visibility(e, how)
    for i, v in pairs(e:GetChildren()) do
        if ModelsToRemove[v:GetClass()] then
            v:SetNoDraw(how)
        end
    end
end
hook.Add("Think", "asasd", function()
    if LP:GetObserverMode() == OBS_MODE_IN_EYE then
        local target = LP:GetObserverTarget()

        if target == cached_target then
            return
        end
        
        if IsValid(cached_target) then
            reset_visibility(cached_target, cached_target:IsDormant())
        end
        if IsValid(target) then
            cached_target = target
            reset_visibility(target, true)
        else
            cached_target = nil
        end

    elseif IsValid(cached_target) then
        reset_visibility(cached_target, cached_target:IsDormant())
        cached_target = nil
    end
end)

net.Receive("MOAT_PLAYER_CLOAKED", function()
    local pl = net.ReadEntity()
    local c = net.ReadBool()

    if (not IsValid(pl)) then return end
    if (not IsValid(LocalPlayer())) then return end

    for i, v in pairs(pl:GetChildren()) do
        if ModelsToRemove[v:GetClass()] then
            if (c) then
                v:SetRenderMode(RENDERMODE_TRANSALPHA)
                v:SetColor(Color(255, 255, 255, 0))
            else
                v:SetRenderMode(RENDERMODE_NORMAL)
                v:SetColor(Color(255, 255, 255, 0))
            end
        end
    end
end)

/*

[ERROR] addons/a_server_addons/lua/autorun/client/moat_loadoutclient.lua:498: attempt to index local 'e' (a nil value)
  1. reset_visibility - addons/a_server_addons/lua/autorun/client/moat_loadoutclient.lua:498
   2. v - addons/a_server_addons/lua/autorun/client/moat_loadoutclient.lua:517
    3. unknown - lua/includes/modules/hook.lua:84
*/