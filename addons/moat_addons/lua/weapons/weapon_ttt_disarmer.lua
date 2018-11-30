

AddCSLuaFile()



SWEP.HoldType = "ar2"

SWEP.PrintName = "Disarmer"

if CLIENT then

   SWEP.Slot = 6



   SWEP.ViewModelFOV  = 54

   SWEP.ViewModelFlip = false



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = [[Those damn traitors with their

guns! Let me just disarm them all.



2 Bullets, each bullet makes the target

drop all weapons. Use wisely]]

   };





   SWEP.Icon = "vgui/ttt/icon_cust_disarm.png"

end



SWEP.Base = "weapon_tttbase"

SWEP.Primary.Recoil	= 10

SWEP.Primary.Damage = 1

SWEP.Primary.Delay = 1.0

SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 2

SWEP.Primary.Automatic = false

SWEP.Primary.DefaultClip = 2

SWEP.Primary.ClipMax = 2



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_DETECTIVE} -- only traitors can buy

SWEP.LimitedStock = true -- only buyable once

SWEP.WeaponID = AMMO_DISARMER



-- if I run out of ammo types, this weapon is one I could move to a custom ammo

-- handling strategy, because you never need to pick up ammo for it

SWEP.Primary.Ammo = "AR2AltFire"



SWEP.UseHands			= true

SWEP.ViewModel = "models/weapons/c_irifle.mdl"

SWEP.WorldModel   = "models/weapons/w_IRifle.mdl"



SWEP.Primary.Sound = Sound( "weapons/grenade_launcher1.wav" )



SWEP.Tracer = "AR2Tracer"

// Don't want people IDing the body at all, so we just create a "ghost" corspe





function Disarm(att, path, dmginfo)

   local ent = path.Entity

   if not IsValid(ent) then return end

   if not ent:IsPlayer() then return end

   local i = 1

   ent:EmitSound(Sound("ambient/energy/zap"..math.random(1,9)..".wav"))

   for k,v in pairs(ent:GetWeapons()) do

      if table.HasValue({"weapon_ttt_unarmed","weapon_zm_improvised","weapon_zm_carry", "weapon_zombie"},v:GetClass()) then continue end

      WEPS.DropNotifiedWeapon(ent, v, false)

      ent:EmitSound(Sound("ambient/energy/zap"..math.random(1,9)..".wav"))

      i = i+1

   end

   local edata = EffectData()



   edata:SetEntity(ent)

   edata:SetMagnitude(i)

   edata:SetScale(i)





   util.Effect("TeslaHitBoxes", edata)

   if SERVER then

      local eyeang = ent:EyeAngles()



      local j = 180

      eyeang.pitch = math.Clamp(eyeang.pitch + math.Rand(-j, j), -90, 90)

      eyeang.yaw = math.Clamp(eyeang.yaw + math.Rand(-j, j), -90, 90)

      ent:SetEyeAngles(eyeang)



   end



end



function SWEP:ShootFlare()

   local cone = self.Primary.Cone

   local bullet = {}

   bullet.Num       = 1

   bullet.Src       = self.Owner:GetShootPos()

   bullet.Dir       = self.Owner:GetAimVector()

   bullet.Spread    = Vector( cone, cone, 0 )

   bullet.Tracer    = 1

   bullet.Force     = 2

   bullet.Damage    = 0

   bullet.TracerName = self.Tracer

   bullet.Callback = Disarm



   self.Owner:FireBullets( bullet )

end



function SWEP:PrimaryAttack()

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )



   if not self:CanPrimaryAttack() then return end



   self:EmitSound( self.Primary.Sound )



   self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )



   self:ShootFlare()



   self:TakePrimaryAmmo( 1 )



   if IsValid(self.Owner) then

      self.Owner:SetAnimation( PLAYER_ATTACK1 )



      self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )

   end



   if ( (game.SinglePlayer() && SERVER) || CLIENT ) then

      self:SetNetworkedFloat( "LastShootTime", CurTime() )

   end

end



function SWEP:SecondaryAttack()

end



SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK_SILENCED

SWEP.ReloadAnim = ACT_VM_RELOAD_SILENCED



function SWEP:Deploy()

   self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)

   return true

end

