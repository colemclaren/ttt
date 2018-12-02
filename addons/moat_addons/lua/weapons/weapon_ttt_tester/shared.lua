

if SERVER then

   AddCSLuaFile( "shared.lua" )

end



SWEP.HoldType = "normal"


SWEP.PrintName = "Portable Tester"


if CLIENT then

   SWEP.Slot = 6



   SWEP.ViewModelFOV = 0



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = "A portable tester to test people."

   };



   SWEP.Icon = "vgui/ttt/icon_cust_porttester.png"

end



SWEP.Base = "weapon_tttbase"



SWEP.ViewModel          = "models/weapons/v_crowbar.mdl"

SWEP.WorldModel         = "models/props/cs_office/microwave.mdl"



SWEP.DrawCrosshair      = false

SWEP.Primary.ClipSize       = 1

SWEP.Primary.DefaultClip    = 1

SWEP.Primary.Automatic      = true

SWEP.Primary.Ammo       = "none"

SWEP.Primary.Delay = 1.0



SWEP.Secondary.ClipSize     = -1

SWEP.Secondary.DefaultClip  = -1

SWEP.Secondary.Automatic    = true

SWEP.Secondary.Ammo     = "none"

SWEP.Secondary.Delay = 1.0



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_DETECTIVE}

SWEP.LimitedStock = true



SWEP.AllowDrop = false



SWEP.NoSights = true



function SWEP:OnDrop()

   self:Remove()

end



function SWEP:PrimaryAttack()

   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   self:HealthDrop()

end

function SWEP:SecondaryAttack()

   self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

   self:HealthDrop()

end



local throwsound = Sound( "Weapon_SLAM.SatchelThrow" )



function SWEP:HealthDrop()

   if SERVER then

      local ply = self.Owner

      if not IsValid(ply) then return end



      if self.Planted then return end



      local vsrc = ply:GetShootPos()

      local vang = ply:GetAimVector()

      local vvel = ply:GetVelocity()

      

      local vthrow = vvel + vang * 200

      self:EmitSound(throwsound)

      local health = ents.Create("ttt_ttester")

      if IsValid(health) then

         health:SetPos(vsrc + vang * 10)

         health:Spawn()



         health:SetPlacer(ply)



         health:PhysWake()

         local phys = health:GetPhysicsObject()

         if IsValid(phys) then

            phys:SetVelocity(vthrow)

         end   

         self:Remove()



         self.Planted = true

      end

   end



   

end





function SWEP:Reload()

   return false

end



function SWEP:OnRemove()

   if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then

      RunConsoleCommand("lastinv")

   end

end



if CLIENT then

   function SWEP:Initialize()

      self:AddHUDHelp("MOUSE1 to drop the Tester", nil, false)



      return self.BaseClass.Initialize(self)

   end

end



function SWEP:Deploy()

   if SERVER and IsValid(self.Owner) then

      self.Owner:DrawViewModel(false)

   end

   return true

end



function SWEP:DrawWorldModel()

end



function SWEP:DrawWorldModelTranslucent()

end



