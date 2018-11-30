if SERVER then
    AddCSLuaFile("shared.lua")
    --  resource.AddFile( "materials/VGUI/ttt/icon_homingpigeon.png" )
    util.AddNetworkString("DropPigeon")
    util.AddNetworkString("RemovePigeon")
    util.AddNetworkString("SendTargetPigeon")
    --  resource.AddWorkshop("620936792")
end

SWEP.HoldType = "grenade"
SWEP.PrintName = "Homing Pigeon"
if CLIENT then
    SWEP.Slot = 6
    SWEP.ViewModelFlip = false

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "A flying pigeon that seeks out a target."
    }

    SWEP.Icon = "VGUI/ttt/icon_homingpigeon.png"
end

SWEP.Base = "weapon_tttbase"
SWEP.ViewModel = "models/weapons/v_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
SWEP.DrawCrosshair = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
SWEP.LimitedStock = true

if SERVER then
    net.Receive("SendTargetPigeon", function(len, ply)
		local wep = ply:GetActiveWeapon()
        if IsValid(wep) and wep:GetClass() == "weapon_ttt_homingpigeon" then
            local TargetPly = net.ReadEntity()
            local wep = net.ReadEntity()

            if (IsValid(wep) and IsValid(TargetPly)) then
                local Pigeon = ents.Create("ttt_pigeon")
                if not IsValid(Pigeon) then return end
                Pigeon:SetPos(ply:GetShootPos() + ply:GetAimVector() * 5)
                Pigeon:SetAngles((TargetPly:GetShootPos() - ply:GetShootPos()):Angle())
                Pigeon.Target = TargetPly
                Pigeon:Spawn()
                Pigeon:SetOwner(ply)
                wep:Remove()
                ply:StripWeapon("weapon_ttt_homingpigeon")
                wep:SetNextPrimaryFire(CurTime() + wep.Primary.Delay)
            end
        end
    end)

    function SWEP:PrimaryAttack()
        return
    end
end

function SWEP:SecondaryAttack()
    return
end

function SWEP:Equip()
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:OnRemove()
    if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
        RunConsoleCommand("lastinv")
    end

    if SERVER then end
end

function SWEP:Deploy()
    return true
end

function SWEP:Holster()
    return true
end

if CLIENT then
    function SWEP:PrimaryAttack()
        if not self:CanPrimaryAttack() then return end
        local TargetPly = self.Owner:GetEyeTrace().Entity

        if IsValid(TargetPly) and TargetPly:IsPlayer() and TargetPly:IsTerror() then
            net.Start("SendTargetPigeon")
            net.WriteEntity(TargetPly)
            net.WriteEntity(self)
            net.SendToServer()
        else
            self:SetNextPrimaryFire(CurTime() + 0.1)
        end
    end

    net.Receive("RemovePigeon", function()
        local Ent = net.ReadEntity()
        if not IsValid(Ent) then return end
        RemovePigeonModel(Ent)
    end)
end

function RemovePigeonModel(Ent)
    if (CLIENT) then
        local VM = LocalPlayer():GetViewModel()

        if (IsValid(VM) and VM.GetBoneCount and VM:GetBoneCount() and VM:GetBoneCount() > 0) then
            local I = 0

            while (I <= VM:GetBoneCount()) do
                VM:ManipulateBoneScale(I, Vector(1, 1, 1))
                I = I + 1
            end
        end
    end

    if (not IsValid(Ent)) then return end

    if (Ent.PigeonModel and IsValid(Ent.PigeonModel)) then
        Ent.PigeonModel:Remove()
        Ent.PigeonModel = nil
    end

    if (Ent.Pigeon and IsValid(Ent.Pigeon)) then
        Ent.Pigeon:Remove()
    end
end