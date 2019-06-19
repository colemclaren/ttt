-- Blink
-- This code is copyright (c) 2016-2017 all rights reserved - "Vadim" @ jmwparq@gmail.com
-- (Re)sale of this code and/or products containing part of this code is strictly prohibited
-- Exclusive rights to usage of this product in "Trouble in Terrorist Town" are given to:
-- - The Garry's Mod community
AddCSLuaFile()
SWEP.HoldType = "knife"
SWEP.LimitedStock = true
SWEP.PrintName = "Blink"
if CLIENT then
    SWEP.Slot = 7
    SWEP.ViewModelFOV = 67
    SWEP.DrawCrosshair = false
    SWEP.ViewModelFlip = false

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "Woosh woosh.\n\nPrimary: Hold to target\nSecondary: Abort blink"
    }

    SWEP.Icon = "vgui/ttt/vadim_blink"
end

SWEP.Base = "weapon_tttbase"
SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"
SWEP.Timer = -1
-- settings
local cvf = FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE
local range = CreateConVar("ttt_blink_range", "1500", cvf)
local maxcharge = CreateConVar("ttt_blink_maxcharge", "100", cvf)
local takecharge = CreateConVar("ttt_blink_takecharge", "50", cvf)
local takecap = CreateConVar("ttt_blink_takecap", "0.75", cvf)
local recharge = CreateConVar("ttt_blink_rechargetick", "0.75", cvf)
SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.AutoSpawnable = false
SWEP.NoSights = true
-- content loading
local aim = {Sound("vadim_blink/aim1.mp3"), Sound("vadim_blink/aim2.mp3")}
local tpl = {Sound("vadim_blink/teleport1.mp3"), Sound("vadim_blink/teleport2.mp3")}

local function RagdollDissolveEffect(ply)
    if not IsValid(BLINK_DISSOLVER) then
        BLINK_DISSOLVER = ents.Create("env_entity_dissolver")
        BLINK_DISSOLVER:SetKeyValue("dissolvetype", 3)
        BLINK_DISSOLVER:Spawn()
    end

    if SERVER and IsValid(ply) then
        local rgd = ents.Create("prop_ragdoll")
        if not IsValid(rgd) then return nil end
        rgd:SetPos(ply:GetPos())
        rgd:SetModel(ply:GetModel())
        rgd:SetAngles(ply:GetAngles())
        rgd:Spawn()
        rgd:Activate()
        rgd:SetGravity(0)
        rgd:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
        rgd:SetMaxHealth(100)
        rgd:SetHealth(100)
        rgd.Owner = ply
        rgd:SetOwner(ply)
        rgd:SetColor(Color(255, 255, 255, 100))

        if IsValid(rgd) then
            for i = 0, rgd:GetPhysicsObjectCount() - 1 do
                local phys = rgd:GetPhysicsObjectNum(i)
                phys:Wake()

                if IsValid(phys) then
                    local pos, ang = ply:GetBonePosition(rgd:TranslatePhysBoneToBone(i))
                    phys:EnableGravity(false)

                    if pos and ang then
                        phys:SetPos(pos)
                        phys:SetAngles(ang)
                    end
                end

                phys:EnableMotion(false)

                timer.Simple(0.1, function()
                    phys:Sleep()
                end)
            end
        end

        rgd.IsSafeToRemove = true
        rgd:SetName("DissolveID" .. rgd:EntIndex())
        BLINK_DISSOLVER:Fire("Dissolve", "DissolveID" .. rgd:EntIndex(), 0.01)
    end
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "Attacking")
    self:NetworkVar("Bool", 1, "Blinking")
    self:NetworkVar("Float", 0, "BlinkTime")
    self:NetworkVar("Float", 1, "ChargeUpdate")
    self:NetworkVar("Float", 2, "MaxCharge")
    self:NetworkVar("Float", 3, "ImmunityTime")
    self:NetworkVar("Float", 4, "ChargeUpdateTime")
    self:NetworkVar("Vector", 0, "BlinkPos")
    self:NetworkVar("Vector", 1, "OriginPos")
end

function SWEP:GetCharge()
    return math.min(self:GetChargeUpdate() + 15 * (CurTime() - self:GetChargeUpdateTime()), self:GetMaxCharge())
end

function SWEP:SetCharge(val)
    self:SetChargeUpdate(val)
    self:SetChargeUpdateTime(CurTime())
end

-- chets
function SWEP:Uncloak(ply)
    if (cur_random_round and cur_random_round ~= "Invisible Traitors") then
        ply:SetMaterial("")
        ply:SetRenderMode(RENDERMODE_NORMAL)

        if CLIENT then return end
        ply:Fire("alpha", 255, 0.16)
    end
end

function SWEP:PrimaryAttack()
    if (GetGlobalInt("weapon_vadim_blink", 0) ~= 0) then
        return
    end

    if (self:GetBlinking() or self:GetCharge() < takecharge:GetInt()) then
        return false
    end
    self:SetAttacking(true)
    self:SetBlinkTime(CurTime())
    if (CLIENT and IsValid(self.Ghost)) then
        self.Ghost:SetSequence(self:GetOwner():GetSequence())
    end

    self:EmitSound(aim[math.random(1, 2)])
    return false
end

function SWEP:SecondaryAttack()
    self:SetAttacking(false)
    self:Uncloak(self.Owner)
end

function SWEP:DryFire()
    return false
end

function SWEP:PreDrawViewModel()
    render.SetBlend(0)
end

function SWEP:DrawWorldModel()
    if not IsValid(self.Owner) then
        self:DrawModel()
    end
end

local blinkmod = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = -0.1,
    ["$pp_colour_contrast"] = 1.25,
    ["$pp_colour_colour"] = 0,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

local efade = 0.10

hook.Add("RenderScreenspaceEffects", "BlinkPP", function()
    local wep = LocalPlayer():GetActiveWeapon()

    if wep and IsValid(wep) and wep:GetClass() == "weapon_vadim_blink" and wep:GetAttacking() then
        local iter = math.min(1, 1 - ((wep:GetBlinkTime() + efade) - CurTime()) / efade)
        blinkmod["$pp_colour_addb"] = iter * 0.05
        blinkmod["$pp_colour_brightness"] = iter * -0.15
        blinkmod["$pp_colour_mulb"] = iter
        blinkmod["$pp_colour_contrast"] = 1 + iter * 0.05
        blinkmod["$pp_colour_colour"] = math.max(0.2, 1 * (1 - iter))
        DrawColorModify(blinkmod)
        DrawBloom(1 - iter * 0.2, iter * 8, iter * 4, iter * 8, 2, iter * 0.5, iter * 0.8, iter * 0.8, iter * 0.9)
    end
end)

function SWEP:Initialize()
    hook.Add("FinishMove", self, self.FinishMove)
    self:SetHoldType(self.HoldType)
    self:SetCharge(maxcharge:GetInt())
    self:SetMaxCharge(maxcharge:GetInt())
end

function SWEP:CreateGhost()
    if IsValid(self.Ghost) then
        self.Ghost:Remove()
    end

    if IsValid(self.Owner) then
        self.Ghost = ClientsideModel(self.Owner:GetModel())
        self.Ghost:SetParent(self.Owner)
        self.Ghost:SetNoDraw(true)
    end
end

function SWEP:Deploy()
    self.Owner:GetViewModel():SendViewModelMatchingSequence(12)

    self:SetAttacking(false)
    self:SetBlinking(false)
    return true
end

if (CLIENT) then
    function SWEP:Remove()
        hook.Remove("RenderScreenspaceEffects", "BlinkPP")
    end
end

function SWEP:OnRemove()
	if IsValid(self.Ghost) then
        self.Ghost:Remove()
		self.Ghost = nil
    end
end

function SWEP:OnDrop()
    self.FOV = nil

    self:SetBlinking(false)
    self:SetAttacking(false)
end

-- trace mechanics
function SWEP:Trace()
    local own = self:GetOwner()
    local mins, maxs = own:GetHull()

    local start = own:EyePos()

    local t = {
        start = start,
        endpos = own:EyePos() + own:GetAimVector() * range:GetFloat(),
        mins = mins,
        maxs = maxs,
        mask = MASK_PLAYERSOLID,
        filter = own,
        output = {}
    }

    local tr = util.TraceLine(t)

    local diff = tr.HitPos - t.start
    t.endpos = tr.HitPos
    start = own:GetPos()
    t.start = start

    for i = 100, 0, -1 do
        t.start = start + diff * (i / 100)
        tr = util.TraceHull(t)
        if (not tr.StartSolid) then
            return tr.HitPos, tr.HitNormal
        end
    end
end

function SWEP:Holster()
    return not self:GetAttacking()
end

-- thonkang
function SWEP:Think()
    local own = self:GetOwner()

    -- spooky
    if (not IsValid(self.Ghost) or self.Ghost:GetModel() ~= own:GetModel()) and CLIENT then
        self:CreateGhost()
    end

    -- mechanics
    if (self:GetAttacking() and not own:KeyDown(IN_ATTACK)) then
        if self.FOV then
            own:SetFOV(self.FOV, 0)
        end

        self.FOV = own:GetFOV()
        local pos, norm = self:Trace()
        own:SetFOV(self.FOV * 1.25, 0)
        own:SetFOV(self.FOV, 1)

        if (cur_random_round and cur_random_round ~= "Invisible Traitors") then
            own:DrawShadow(false)
            own:SetRenderMode(RENDERMODE_TRANSALPHA)
            if (SERVER) then
                own:Fire("alpha", 0, 0)
            end
        end

        self:SetBlinkPos(pos)
        self:SetOriginPos(own:GetPos())
        self:SetBlinkTime(CurTime())
        self:SetBlinking(true)
        self:SetAttacking(false)
        self:SetImmunityTime(CurTime() + 2)

        if (SERVER) then
            RagdollDissolveEffect(own)
        else
            local vm = own:GetViewModel()

            if IsValid(vm) then
                vm:SendViewModelMatchingSequence(12)
            end
        end

        local take = math.ceil(takecharge:GetInt() * takecap:GetFloat())

        if self:GetCharge() < self:GetMaxCharge() or self:GetMaxCharge() <= take then
            self:SetMaxCharge(math.max(0, math.floor(self:GetCharge())))
        end

        self:SetCharge(math.max(0, self:GetCharge() - takecharge:GetInt()))

        self:EmitSound(tpl[math.random(1, 2)])
    end
end

function SWEP:FinishMove(ply, mv)
    local own = self:GetOwner()
    if (ply ~= own) then
        return
    end
    if (self:GetBlinking()) then
        local ratio = math.min(1, (CurTime() - self:GetBlinkTime()) / (self:GetBlinkPos():Distance(self:GetOriginPos()) / 5000))

        mv:SetOrigin(self:GetOriginPos() + (self:GetBlinkPos() - self:GetOriginPos()) * ratio)

        if (ratio == 1) then
            self:Uncloak(own)
            self:SetBlinking(false)
            mv:SetVelocity(vector_origin)
        end
    end
end

-- more fanshey
function SWEP:ViewModelDrawn()
    render.SetBlend(1)

    if self:GetAttacking() and IsValid(self.Ghost) then
        local pos, _ = self:Trace()
		if (pos) then
        	self.Ghost:SetPos(pos)
			self.Ghost:SetAngles(self.Owner:GetAngles())
        	self.Ghost:DrawModel()
		end
    end
end

blink = {
    Enable = function(self)
        SetGlobalInt("weapon_vadim_blink", GetGlobalInt("weapon_vadim_blink", 0) - 1)
    end,
    Disable = function(self)
        SetGlobalInt("weapon_vadim_blink", GetGlobalInt("weapon_vadim_blink", 0) + 1)
    end
}

function SWEP:DrawHUD()
    local x = ScrW() / 2.0
    local y = ScrH() / 2.0
    local w, h = 200, 20

    if (GetGlobalInt("weapon_vadim_blink", 0) ~= 0) then
        surface.SetFont("TabLarge")
        surface.SetTextColor(255, 50, 50, 180)
        surface.SetTextPos(x, y - 15)
        surface.DrawText("DISABLED")
        return
    end

    
    y = y + (y / 3)
    local ccvar = maxcharge:GetInt()
    local charge = self:GetCharge() / ccvar
    local chargem = self:GetMaxCharge() / ccvar

    if chargem > 0 then
        surface.SetDrawColor(0, 0, 255, 78)
    else
        surface.SetDrawColor(255, 0, 0, 155)
    end

    surface.DrawOutlinedRect(x - w / 2, y - h, w, h)
    surface.DrawRect(x - w / 2, y - h, w * chargem, h)
    surface.SetDrawColor(0, 75, 255, 100)
    surface.DrawRect(x - w / 2, y - h, w * charge, h)
    surface.SetFont("TabLarge")
    surface.SetTextColor(255, 255, 255, 180)
    surface.SetTextPos((x - w / 2) + 3, y - h - 15)
    surface.DrawText("BLINK CHARGE")
    surface.SetFont("TabLarge")
    surface.SetTextColor(255, 255, 255, 180)
    surface.SetTextPos((x - w / 2) + 3, y)
    surface.DrawText("Firing before charge is refilled will lower max charge.")
    self.BaseClass.DrawHUD(self)
end

hook.Add("EntityTakeDamage", "BlinkFixCrush", function(ent, dmg)
    if IsValid(ent) and ent:IsPlayer() and dmg:IsFallDamage() then
        local wep = ent:GetWeapon "weapon_vadim_blink"
        if (IsValid(wep) and wep:GetImmunityTime() > CurTime()) then
            dmg:ScaleDamage(0)
        end
    end
end)