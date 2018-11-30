AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 6
   SWEP.Icon = "vgui/ttt/icon_jihad"
   SWEP.IconLetter = "I"
end

-- Always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"
SWEP.PrintName = "Jihad Bomb"
-- Standard GMod values
SWEP.HoldType = "slam"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 5
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

-- Model properties
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = Model( "models/weapons/cstrike/c_c4.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_c4.mdl" )

-- TTT config values

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_EQUIP1

-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_EQUIP1/2, then this gun can
-- be spawned as a random weapon.
SWEP.AutoSpawnable = false

-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
SWEP.AmmoEnt = "none"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.
SWEP.CanBuy = { ROLE_TRAITOR }

-- InLoadoutFor is a table of ROLE_* entries that specifies which roles should
-- receive this weapon as soon as the round starts. In this case, none.
SWEP.InLoadoutFor = { nil }

-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = true

-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = false

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = true

-- Precache custom sounds
function SWEP:Precache()
   util.PrecacheSound( "siege/big_explosion.wav" )
   util.PrecacheSound( "siege/jihad.wav" )
   util.PrecacheSound( "vo/npc/male01/overhere01.wav" )
end

-- Reload does nothing
function SWEP:Reload()
end

-- Particle effects / Begin attack
function SWEP:PrimaryAttack()
   self:SetNextPrimaryFire( CurTime() + 2 )

   self.AllowDrop = false

   local effectdata = EffectData()
   effectdata:SetOrigin( self.Owner:GetPos() )
   effectdata:SetNormal( self.Owner:GetPos() )
   effectdata:SetMagnitude( 8 )
   effectdata:SetScale( 1 )
   effectdata:SetRadius( 78 )
   util.Effect( "Sparks", effectdata )
   self.BaseClass.ShootEffects( self )

   timer.Simple( 2, function() self.AllowDrop = true end)

   -- The rest is done on the server
   if ( SERVER ) then
      timer.Simple( 2, function() if IsValid(self) then self:Explode() end end )
      self.Owner:EmitSound( "siege/jihad.wav" )
   end
end

function SWEP:SecondaryAttack() 
    self:SetNextSecondaryFire(CurTime() + 1)

    local TauntSound = Sound( "vo/npc/male01/overhere01.wav" )
    // The rest is only done on the server
    if (SERVER) then
      self.Owner:EmitSound(TauntSound)
   end
end

-- Explosion properties
function SWEP:Explode()
	if (not IsValid(self.Owner)) then
		self:Remove()
		return
	end

   local ent = ents.Create( "env_explosion" )
   ent:SetPos( self.Owner:GetPos() )
   ent:SetOwner( self.Owner )
   ent:SetKeyValue( "iMagnitude", "200" )
   ent:Spawn()
   ent:Fire( "Explode", 0, 0 )
   ent:EmitSound( "siege/big_explosion.wav", 500, 500 )

   self.Owner:Kill()
   
   self:Remove()
end

-- Equipment menu information is only needed on the client
if CLIENT then
   -- Text shown in the equip menu
   SWEP.EquipMenuData = {
      type = "Weapon",
      desc = "Sacrifice yourself to Allah.\n\nYour 72 virgins await."
   }
else
   hook.Add("PlayerSwitchWeapon", "moat_PreventJihadSwitch", function(ply, old, new)
      if (IsValid(old) and old:IsValid() and old:GetClass() == "weapon_ttt_jihad" and not old.AllowDrop) then
         return true
      end
   end)
end
