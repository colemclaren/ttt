

AddCSLuaFile()



SWEP.HoldType = "pistol"

SWEP.PrintName = "Freeze Gun"

if CLIENT then

   SWEP.Slot = 6



   SWEP.ViewModelFOV  = 54

   SWEP.ViewModelFlip = false



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = [[I have a freezing issue! Oh cool! A gun that can freeze people! It can only freeze alive subjects, don't use on corpses!]]

   };





   SWEP.Icon = "vgui/ttt/icon_cust_freezer.png"

end



SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"
SWEP.Primary.Recoil	= 4

SWEP.Primary.Damage = 7

SWEP.Primary.Delay = 1.0

SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 1

SWEP.Primary.Automatic = false

SWEP.Primary.DefaultClip = 1

SWEP.Primary.ClipMax = 1



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy

SWEP.LimitedStock = true -- only buyable once

SWEP.WeaponID = AMMO_FREEZE



-- if I run out of ammo types, this weapon is one I could move to a custom ammo

-- handling strategy, because you never need to pick up ammo for it

SWEP.Primary.Ammo = "AR2AltFire"



SWEP.UseHands			= true

SWEP.ViewModel       = "models/weapons/cstrike/c_pist_usp.mdl"

SWEP.WorldModel         = "models/weapons/w_pist_usp_silencer.mdl"



SWEP.Primary.Sound = Sound( "ambient/machines/thumper_dust.wav" )

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.7027,
	}
}


SWEP.Tracer = "AR2Tracer"

// Don't want people IDing the body at all, so we just create a "ghost" corspe

local function CreateCorpse(ply)

   if not IsValid(ply) then return end

   if not SERVER then return end

   local rag = ply.server_ragdoll

   if not IsValid(rag) then return nil end



   rag.player_ragdoll = false



   if IsValid(ply) then

      rag:SetDTEntity(CORPSE.dti.ENT_PLAYER, false)

   end



   rag:SetNW2String("nick", false)

   if rag and IsValid(rag) then

      local bones = rag:GetPhysicsObjectCount()

      if bones < 2 then return end

               

      for bone = 1, bones-1 do

               

         local const = constraint.Weld( rag, rag, 0, bone, forcelimit )

                  

      end

   end



   rag:SetMaterial("models/debug/debugwhite")

   rag:SetColor(Color(41, 128, 185))

   rag:EmitSound(Sound("physics/glass/glass_impact_bullet"..math.random(1,3)..".wav"))

   rag:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

   timer.Simple( 1, function() if IsValid( rag ) then rag:CollisionRulesChanged() end end )

   return rag

end



function FreezeP(att, path, dmginfo)

   local ent = path.Entity

   if not IsValid(ent) then return end

   if not ent:IsPlayer() then return end

   

   timer.Simple(0.01,function() 

      local pos = nil

      

      CreateCorpse(ent)



   end)

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

   bullet.Damage    = 10000

   bullet.TracerName = self.Tracer

   bullet.Callback = FreezeP



   self.Owner:FireBullets( bullet )

end



function SWEP:PrimaryAttack()

   if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

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

function SWEP:Deploy()
	if (BaseClass.Deploy(self)) then
		self:PlayAnimation("DrawAnim", "draw", self.DeploySpeed)
	end

	return true
end