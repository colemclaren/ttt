-- Remote Sticky Bomb
RSB = RSB or {}

if SERVER then
    AddCSLuaFile()
end

SWEP.HoldType = "slam"
SWEP.PrintName = "RSB Defuser"

if CLIENT then
    SWEP.Slot = 7

    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "RSB Defuser",
        desc = "A defuser for the Remote Sticky Bomb"
    }

    SWEP.Icon = "vgui/ttt/icon_rsb.vmt"
end

SWEP.Author = "Marcuz"
SWEP.Base = "weapon_tttbase"
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_defuser.mdl"
SWEP.Kind = WEAPON_EQUIP2

if (true) then
    SWEP.CanBuy = {ROLE_DETECTIVE}
else
    SWEP.CanBuy = {}
end

SWEP.WeaponID = AMMO_DEFUSER
SWEP.UseHands = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 5.0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1.0
SWEP.LimitedStock = true
SWEP.ply = nil
SWEP.AllowDrop = true
SWEP.NoSights = true
local defuse = Sound("c4.disarmfinish")

function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

    if SERVER then
        local ply = self.Owner
        if not IsValid(ply) then return end
        local ignore = {ply, self}
        local spos = ply:GetShootPos()
        local epos = spos + ply:GetAimVector() * 100

        local tr = util.TraceLine({
            start = spos,
            endpos = epos,
            filter = ignore,
            mask = MASK_SOLID
        })

        if tr.HitNonWorld then
            local target = tr.Entity

            if target:IsPlayer() then
                if IsValid(target) and IsValid(target.attachedRSB) then
                    CustomMsg(ply, "You've successfully defused a RSB!", Color(0, 255, 0))
                    CustomMsg(target.attachedRSB.Owner, "Your RSB was defused!", Color(255, 0, 0))
                    net.Start("BombBar")
                    net.WriteBit(false)
                    net.Send(target.attachedRSB.Owner)
                    target.attachedRSB.Planted = false
                    target.attachedRSB.arming = false
                    target.attachedRSB.armedandready = false
                    target.attachedRSB.target = nil
                    target.attachedRSB:Remove()
                    self:Remove()
                    sound.Play(defuse, target:GetPos())
                else
                    CustomMsg(ply, "This player has no RSB attached to them!", Color(255, 0, 0))
                end
            end
        end
    end
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    local ply = self.Owner
end

function SWEP:Think()
    local ply = self.Owner
end

function SWEP:DefuseRSB()
    if SERVER then end
end

if CLIENT then
    function SWEP:Initialize()
        self:AddHUDHelp("defuser_help", nil, true)

        return self.BaseClass.Initialize(self)
    end

    function SWEP:DrawWorldModel()
        if not IsValid(self.Owner) then
            self:DrawModel()
        end
    end
end

function SWEP:Deploy()
    if SERVER and IsValid(self.Owner) then
        self.Owner:DrawViewModel(false)
    end

    return true
end

function SWEP:Reload()
    return false
end

if CLIENT then
    local hudtxt = {
        {
            text = "Right click on a player to defuse an RSB",
            font = "TabLarge",
            xalign = TEXT_ALIGN_RIGHT
        }
    }

    function SWEP:DrawHUD()
        local x = ScrW() - 80
        hudtxt[1].pos = {x, ScrH() - 40}
        draw.TextShadow(hudtxt[1], 2)
    end
end