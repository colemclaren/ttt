-- Blink
-- This code is copyright (c) 2016-2017 all rights reserved - "Vadim" @ jmwparq@gmail.com
-- (Re)sale of this code and/or products containing part of this code is strictly prohibited
-- Exclusive rights to usage of this product in "Trouble in Terrorist Town" are given to:
-- - The Garry's Mod community
AddCSLuaFile()
SWEP.HoldType = "knife"
SWEP.LimitedStock = true

if CLIENT then
    SWEP.PrintName = "Blink"
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
SWEP.Charge = 0
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
SWEP.Active = -1
SWEP.Ghost = nil
SWEP.BlinkInfo = false
SWEP.MaxCharge = 100
SWEP.Charge = 100
-- content loading
local aim = {Sound("vadim_blink/aim1.mp3"), Sound("vadim_blink/aim2.mp3")}
local tpl = {Sound("vadim_blink/teleport1.mp3"), Sound("vadim_blink/teleport2.mp3")}
local inv = Material("models/effects/vol_light001")
local vis = Material("")

if SERVER then
    function RagdollDissolveEffect(ply)
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

            rgd:SetName("DissolveID" .. rgd:EntIndex())
            BLINK_DISSOLVER:Fire("Dissolve", "DissolveID" .. rgd:EntIndex(), 0.01)
        end
    end
end

-- chets
function SWEP:Uncloak(ply)
    timer.Simple(0.75, function()
        if IsValid(ply) then
            ply.BlinkImmunity = nil
        end
    end)

    if (cur_random_round and cur_random_round ~= "Invisible Traitors") then
        ply:SetMaterial("")
        ply:SetRenderMode(RENDERMODE_NORMAL)
        
        if CLIENT then return end
        ply:Fire("alpha", 255, 0.16)
    end
end

function SWEP:PrimaryAttack()
    return false
end

function SWEP:SecondaryAttack()
    self.Active = -2
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

function SWEP:Initialize()
    if CLIENT then
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
        hook.Remove("RenderScreenspaceEffects", "BlinkPP")

        hook.Add("RenderScreenspaceEffects", "BlinkPP", function()
            local wep = LocalPlayer():GetActiveWeapon()

            if wep and IsValid(wep) and wep.Active and wep.Active > 0 then
                local iter = math.min(1, 1 - ((wep.Active + efade) - CurTime()) / efade)
                blinkmod["$pp_colour_addb"] = iter * 0.05
                blinkmod["$pp_colour_brightness"] = iter * -0.15
                blinkmod["$pp_colour_mulb"] = iter
                blinkmod["$pp_colour_contrast"] = 1 + iter * 0.05
                blinkmod["$pp_colour_colour"] = math.max(0.2, 1 * (1 - iter))
                DrawColorModify(blinkmod)
                DrawBloom(1 - iter * 0.2, iter * 8, iter * 4, iter * 8, 2, iter * 0.5, iter * 0.8, iter * 0.8, iter * 0.9)
            end
        end)
    end

    self:SetHoldType(self.HoldType)
    self.Charge = maxcharge:GetInt()
    self.MaxCharge = maxcharge:GetInt()
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
    self.BlinkInfo = false

    if IsValid(self.Last) then
        self:Uncloak(self.Last)
    end

    return true
end

if (CLIENT) then 
    function SWEP:Remove()
        hook.Remove("RenderScreenspaceEffects", "BlinkPP")
    end
end

function SWEP:Holster()
    self.Active = -1
    self.BlinkInfo = false

    if IsValid(self.Last) then
        self:Uncloak(self.Last)
    end

    return true
end

function SWEP:OnDrop()
    self.Active = -1
    self.BlinkInfo = false
    self.FOV = nil

    if IsValid(self.Last) then
        self:Uncloak(self.Last)
    end

    return true
end

-- trace mechanics
function SWEP:Trace()
    local own = self.Owner
    local phys = own:GetPhysicsObject()
    local size = Vector(34, 34, 74)

    local tr0 = util.TraceHull({
        start = own:EyePos() + own:GetAimVector(),
        endpos = own:EyePos() + own:GetAimVector() * range:GetFloat(),
        mins = size / -4,
        maxs = size / 4,
        mask = MASK_ALL,
        filter = own
    })

    local final = tr0.HitPos - Vector(0, 0, size.z / 2)
    local ledge = final + Vector(0, 0, size.z)

    local tr1 = util.TraceLine({
        start = ledge,
        endpos = ledge + own:GetAimVector() * size.y * 2,
        mask = MASK_ALL,
        filter = own
    })

    if not tr1.Hit then
        local tr2 = util.TraceLine({
            start = tr1.HitPos,
            endpos = tr1.HitPos - Vector(0, 0, size.z),
            mask = MASK_ALL,
            filter = own
        })

        if tr2.Hit then
            final = tr2.HitPos + Vector(0, 0, 8)
        end
    end
    -- go look for a ledge ya bugger

    return final, tr0.HitNormal
end

local test = CurTime()

-- thonkang
function SWEP:Think()
    local own = self.Owner

    if self.Last ~= self.Owner then
        self.Last = self.Owner
    end

    -- spooky
    if (not IsValid(self.Ghost) or self.Ghost:GetModel() ~= own:GetModel()) and CLIENT then
        self:CreateGhost()
    end

    -- mechanics
    if own:KeyDown(IN_ATTACK) and self.Charge > 0 then
        if self.Active == -1 then
            self.Active = CurTime()

            if CLIENT then
                self.Ghost:SetSequence(own:GetSequence())
            end

            self:EmitSound(aim[math.random(1, 2)])
        end
    elseif self.Active > 0 then
        self.Active = -1
        own.BlinkImmunity = CurTime() + 2
        local label = "Recharge" .. self:EntIndex()

        if timer.Exists(label) then
            timer.Destroy(label)
        end

        timer.Create(label, 0.02, 0, function()
            if not IsValid(self) then
                timer.Remove(label)

                return
            end

            if self.Charge < self.MaxCharge then
                self.Charge = math.min(self.MaxCharge, self.Charge + 0.2)
            else
                timer.Remove(label)
            end
        end)

        timer.Start(label)

        if SERVER then
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
                own:Fire("alpha", 0, 0)
            end
            self.BlinkInfo = {pos, CurTime() + 2}
            RagdollDissolveEffect(own)
        else
            local vm = own:GetViewModel()

            if IsValid(vm) then
                vm:SendViewModelMatchingSequence(12)
            end
        end

        if SERVER or IsFirstTimePredicted() then
            local take = math.ceil(takecharge:GetInt() * takecap:GetFloat())

            if self.Charge < self.MaxCharge or self.MaxCharge <= take then
                self.MaxCharge = math.max(0, math.floor(self.MaxCharge - take))
            end

            self.Charge = math.max(0, self.Charge - takecharge:GetInt())
        end

        self:EmitSound(tpl[math.random(1, 2)])
    elseif self.Active == -2 then
        self.Active = -1
    end

    if self.BlinkInfo then
        if CurTime() >= self.BlinkInfo[2] then
            self:Uncloak(own)
            self.BlinkInfo = false

            return
        end

        if own:GetPos():Distance(self.BlinkInfo[1]) <= 28 then
            self:Uncloak(own)
            own:SetVelocity(-own:GetVelocity() * 0.95)
            own:ViewPunch(Angle(2, 0, 0))
            self.BlinkInfo = false

            return
        end

        own:SetVelocity((self.BlinkInfo[1] - own:GetPos()):GetNormalized() * 3182 - own:GetVelocity())
        --print( self.Charge )
    end
end

-- more fanshey
function SWEP:ViewModelDrawn()
    render.SetBlend(1)

    if self.Active > 0 then
        local pos, _ = self:Trace()
        self.Ghost:SetPos(pos)
        self.Ghost:SetAngles(self.Owner:GetAngles())
        self.Ghost:DrawModel()
    end
end

function SWEP:DrawHUD()
    local x = ScrW() / 2.0
    local y = ScrH() / 2.0
    y = y + (y / 3)
    local ccvar = maxcharge:GetInt()
    local charge = self.Charge / ccvar
    local chargem = self.MaxCharge / ccvar
    local w, h = 200, 20

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

hook.Remove("EntityTakeDamage", "BlinkFixCrush")

hook.Add("EntityTakeDamage", "BlinkFixCrush", function(ent, dmg)
    if IsValid(ent) and ent:IsPlayer() and ent.BlinkImmunity and dmg:IsFallDamage() then
        dmg:ScaleDamage(0)
    end
end)