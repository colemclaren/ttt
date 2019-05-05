

-- traitor equipment: c4 bomb



if SERVER then

   AddCSLuaFile( "shared.lua" )

end



SWEP.HoldType			= "slam"

SWEP.PrintName			= "Proximity Mine"

if CLIENT then

   SWEP.Slot				= 6



   SWEP.EquipMenuData = {

      type  = "item_weapon",

      name  = "Proximity Mine",

      desc  = "Explodes when anyone gets close"

   };



   SWEP.Icon = "VGUI/ttt/icon_ttt_proxmine"

end



if SERVER then

   --resource.AddFile("materials/VGUI/ttt/icon_ttt_proxmine.vmt")

end



SWEP.Base = "weapon_tttbase"



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy

SWEP.WeaponID = AMMO_C4

SWEP.LimitedStock = true


SWEP.UseHands			= true

SWEP.ViewModelFlip		= false

SWEP.ViewModelFOV		= 54

SWEP.ViewModel  = Model("models/weapons/cstrike/c_c4.mdl")

SWEP.WorldModel = Model("models/weapons/w_c4.mdl")



SWEP.DrawCrosshair      = false

SWEP.ViewModelFlip      = false

SWEP.Primary.ClipSize       = -1

SWEP.Primary.DefaultClip    = -1

SWEP.Primary.Automatic      = true

SWEP.Primary.Ammo       = "none"

SWEP.Primary.Delay = 5.0



SWEP.Secondary.ClipSize     = -1

SWEP.Secondary.DefaultClip  = -1

SWEP.Secondary.Automatic    = true

SWEP.Secondary.Ammo     = "none"

SWEP.Secondary.Delay = 1.0



SWEP.NoSights = true



local throwsound = Sound( "Weapon_SLAM.SatchelThrow" )



function SWEP:PrimaryAttack()

   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   self:BombStick()

end



function SWEP:SecondaryAttack()

   self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

   self:BombStick()

end



function SWEP:BombStick()

   if SERVER then

      local ply = self.Owner

      if not IsValid(ply) then return end



      if self.Planted then return end



      local ignore = {ply, self.Weapon}

      local spos = ply:GetShootPos()

      local epos = spos + ply:GetAimVector() * 80

      local tr = util.TraceLine({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID})



      if tr.HitWorld then

         local bomb = ents.Create("ttt_proximitymine")

         if IsValid(bomb) then

            bomb:PointAtEntity(ply)



            local tr_ent = util.TraceEntity({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID}, bomb)



            if tr_ent.HitWorld then



               local ang = tr_ent.HitNormal:Angle()

               ang:RotateAroundAxis(ang:Right(), -90)

               ang:RotateAroundAxis(ang:Up(), 180)



               bomb:SetPos(tr_ent.HitPos)

               bomb:SetAngles(ang)

               bomb:SetPlacer(ply)

               --bomb:SetThrower(ply)

               bomb:Spawn()



               --bomb.fingerprints = self.fingerprints

               

               local phys = bomb:GetPhysicsObject()

               if IsValid(phys) then

                  phys:EnableMotion(false)

               end



               bomb.IsOnWall = true



               self:Remove()



               self.Planted = true



            end

         end



         ply:SetAnimation( PLAYER_ATTACK1 )         

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

