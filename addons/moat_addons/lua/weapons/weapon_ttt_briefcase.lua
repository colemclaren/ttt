if SERVER then

   AddCSLuaFile( "weapon_ttt_briefcase.lua" )

--   resource.AddFile("materials/vgui/ttt/exho_briefcase.png")

end



SWEP.HoldType = "normal"


SWEP.PrintName = "Briefcase"


if CLIENT then

   SWEP.Slot = 6



   SWEP.ViewModelFOV = 0



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = [[The briefcase can dispense ammo when used. Similar to a Health Station.]]

   };



   SWEP.Icon = "vgui/ttt/exho_briefcase.png"

end



SWEP.Base = "weapon_tttbase"



SWEP.ViewModel          = "models/weapons/v_crowbar.mdl"

SWEP.WorldModel         = "models/weapons/w_suitcase_passenger.mdl"



SWEP.DrawCrosshair      = false

SWEP.Primary.ClipSize       = -1

SWEP.Primary.DefaultClip    = -1

SWEP.Primary.Automatic      = true

SWEP.Primary.Ammo       = "none"

SWEP.Primary.Delay = 1.0



SWEP.Secondary.ClipSize     = -1

SWEP.Secondary.DefaultClip  = -1

SWEP.Secondary.Automatic    = true

SWEP.Secondary.Ammo     = "none"

SWEP.Secondary.Delay = 1.0



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE} 

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



-- ye olde droppe code

function SWEP:HealthDrop()

   if SERVER then

      local ply = self.Owner

      if not IsValid(ply) then return end



      if self.Planted then return end



      local vsrc = ply:GetShootPos()

      local vang = ply:GetAimVector()

      local vvel = ply:GetVelocity()

      

      local vthrow = vvel + vang * 150



      local case = ents.Create("ttt_briefcase")

      if IsValid(case) then

        case:SetPos(vsrc + vang * 10)

        case:Spawn()

		case:SetPlacer(ply)



        case:PhysWake()

        local phys = case:GetPhysicsObject()

        if IsValid(phys) then

            phys:SetVelocity(vthrow)

        end   

        self:Remove()



        self.Planted = true

      end

   end



   self.Weapon:EmitSound(throwsound)

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

		self:AddHUDHelp(

			"Click to drop the briefcase.",

			false

		)

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



