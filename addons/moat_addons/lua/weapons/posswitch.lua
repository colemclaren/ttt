AddCSLuaFile()
SWEP.Base = "weapon_tttbase"
SWEP.PrintName = "Position Swapper"
if CLIENT then
    SWEP.Slot = 7
    SWEP.Icon = "VGUI/ttt/icon_posswitch"
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
    SWEP.ViewModel = "models/weapons/v_pistol.mdl"
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "Right-click to select a target, left-click to make a swap and reload to deselect your target!"
    }
end

SWEP.Spawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true
SWEP.WeaponID = POSITION_SWITCH

if SERVER then
    --	resource.AddFile("materials/VGUI/ttt/icon_posswitch.vmt")
    --	resource.AddFile("materials/VGUI/ttt/icon_posswitch.vtf")
    function SWEP:SecondaryAttack()
        local owner = self.Owner
        local target = self.Owner:GetEyeTrace().Entity

        if target:IsPlayer() and target:Alive() then
            owner:MoatChat("You've selected " .. target:Nick() .. "")

            return self:SetTargetEnt(target)
        elseif (target:IsPlayer() and not target:Alive()) or (not target:IsPlayer()) then
            owner:MoatChat("No target was found!")

            return "failed"
        end
    end

    function SWEP:SetTargetEnt(ent)
        self.TargetEnt = ent
    end

    function SWEP:GetTargetEnt()
        return self.TargetEnt
    end

    function SWEP:PrimaryAttack()
        local owner = self.Owner
        local target = self.TargetEnt

        if IsValid(target) then
            if (target:Alive()) then
                local selfpos = owner:GetPos()
                local entpos = self.TargetEnt:GetPos()
                owner:SetPos(entpos)
                target:SetPos(selfpos)
                owner:MoatChat("Swapped position with " .. target:Nick() .. ".")
                self:Remove()
            else
                owner:MoatChat("The target is dead!")
            end
        else
            owner:MoatChat("No target is selected: Right-click on a player to select one.")

            return "failed"
        end
    end

    function SWEP:Reload()
        if not self:GetTargetEnt() then
            return "failed"
        else
            self:SetTargetEnt(nil)
            self.Owner:MoatChat("Your target has been deselected")
        end
    end
end