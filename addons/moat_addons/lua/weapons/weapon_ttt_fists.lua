
AddCSLuaFile()

SWEP.HoldType			= "fist"

if CLIENT then
   SWEP.Slot				= 0

   SWEP.Icon = "vgui/ttt/icon_cbar"   
   SWEP.ViewModelFOV = 54
end

SWEP.PrintName       = "Fists"
SWEP.UseHands			= true
SWEP.Base				= "weapon_tttbase"
SWEP.ViewModel			= "models/weapons/c_arms_cstrike.mdl"
SWEP.WorldModel			= ""
SWEP.Weight			= 5
SWEP.DrawCrosshair		= false
SWEP.ViewModelFlip		= false
SWEP.Primary.Damage = 17.5
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Delay = 0.5
SWEP.Primary.Ammo		= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay = 5
SWEP.PushForce = 1

SWEP.Kind = WEAPON_MELEE
SWEP.WeaponID = AMMO_CROWBAR

SWEP.NoSights = true
SWEP.IsSilent = true 

SWEP.AutoSpawnable = false

SWEP.AllowDelete = false -- never removed for weapon reduction
SWEP.AllowDrop = false

local sound_single = Sound("weapons/slam/throw.wav")
local sound_open = Sound("Flesh.ImpactHard")

function SWEP:PreDrawViewModel( vm, wep, ply )
	vm:SetMaterial( "engine/occlusionproxy" ) -- Hide that view model with hacky material
end

function SWEP:KeyPress(ply, key)
	if key == IN_JUMP then
		local owner = self.Owner
		owner:ViewPunch(4,4,0)
	end
end

if SERVER then
   CreateConVar("ttt_crowbar_unlocks", "1", FCVAR_ARCHIVE)
   CreateConVar("ttt_crowbar_pushforce", "395", FCVAR_NOTIFY)
end

-- only open things that have a name (and are therefore likely to be meant to
-- open) and are the right class. Opening behaviour also differs per class, so
-- return one of the OPEN_ values
local function OpenableEnt(ent)
   local cls = ent:GetClass()
   if ent:GetName() == "" then
      return OPEN_NO
   elseif cls == "prop_door_rotating" then
      return OPEN_ROT
   elseif cls == "func_door" or cls == "func_door_rotating" then
      return OPEN_DOOR
   elseif cls == "func_button" then
      return OPEN_BUT
   elseif cls == "func_movelinear" then
      return OPEN_NOTOGGLE
   else
      return OPEN_NO
   end
end


local function CrowbarCanUnlock(t)
   return not GAMEMODE.crowbar_unlocks or GAMEMODE.crowbar_unlocks[t]
end

-- will open door AND return what it did
function SWEP:OpenEnt(hitEnt)
   -- Get ready for some prototype-quality code, all ye who read this
   if SERVER and GetConVar("ttt_crowbar_unlocks"):GetBool() then
      local openable = OpenableEnt(hitEnt)

      if openable == OPEN_DOOR or openable == OPEN_ROT then
         local unlock = CrowbarCanUnlock(openable)
         if unlock then
            hitEnt:Fire("Unlock", nil, 0)
         end

         if unlock or hitEnt:HasSpawnFlags(256) then
            if openable == OPEN_ROT then
               hitEnt:Fire("OpenAwayFrom", self.Owner, 0)
            end
            hitEnt:Fire("Toggle", nil, 0)
         else
            return OPEN_NO
         end
      elseif openable == OPEN_BUT then
         if CrowbarCanUnlock(openable) then
            hitEnt:Fire("Unlock", nil, 0)
            hitEnt:Fire("Press", nil, 0)
         else
            return OPEN_NO
         end
      elseif openable == OPEN_NOTOGGLE then
         if CrowbarCanUnlock(openable) then
            hitEnt:Fire("Open", nil, 0)
         else
            return OPEN_NO
         end
      end
      return openable
   else
      return OPEN_NO
   end
end

function SWEP:PrimaryAttack()
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   local anim = "fists_right"
   local vm = self.Owner:GetViewModel()
   local owner = self.Owner

   if not IsValid(self.Owner) then return end

   if self.Owner.LagCompensation then -- for some reason not always true
      self.Owner:LagCompensation(true)
   end

   local spos = self.Owner:GetShootPos()
   local sdest = spos + (self.Owner:GetAimVector() * 70)

   local tr_main = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL})
   local hitEnt = tr_main.Entity

   self.Weapon:EmitSound(sound_single)

   if IsValid(hitEnt) or tr_main.HitWorld then
      vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
      owner:ViewPunch( Angle( 1, 1, 0 ) )
      self.Owner:SetAnimation( PLAYER_ATTACK1 )
	  
	  self.Weapon:EmitSound(sound_open)

      if not (CLIENT and (not IsFirstTimePredicted())) then
         local edata = EffectData()
         edata:SetStart(spos)
         edata:SetOrigin(tr_main.HitPos)
         edata:SetNormal(tr_main.Normal)
         edata:SetSurfaceProp(tr_main.SurfaceProps)
         edata:SetHitBox(tr_main.HitBox)
         --edata:SetDamageType(DMG_CLUB)
         edata:SetEntity(hitEnt)

         if hitEnt:IsPlayer() or hitEnt:GetClass() == "prop_ragdoll" then
            util.Effect("BloodImpact", edata)

            -- does not work on players rah
            --util.Decal("Blood", tr_main.HitPos + tr_main.HitNormal, tr_main.HitPos - tr_main.HitNormal)

            -- do a bullet just to make blood decals work sanely
            -- need to disable lagcomp because firebullets does its own
            self.Owner:LagCompensation(false)
            self.Owner:FireBullets({Num=1, Src=spos, Dir=self.Owner:GetAimVector(), Spread=Vector(0,0,0), Tracer=0, Force=1, Damage=0})
         else
            util.Effect("Stunstickimpact", edata)
         end
      end
   else
      vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
      owner:ViewPunch( Angle( 1, 1, 0 ) )
      self.Owner:SetAnimation( PLAYER_ATTACK1 )
   end


   if CLIENT then
      -- used to be some shit here
   else -- SERVER

      -- Do another trace that sees nodraw stuff like func_button
      local tr_all = nil
      tr_all = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner})

      if hitEnt and hitEnt:IsValid() then
         if self:OpenEnt(hitEnt) == OPEN_NO and tr_all.Entity and tr_all.Entity:IsValid() then
            -- See if there's a nodraw thing we should open
            self:OpenEnt(tr_all.Entity)
         end

         local dmg = DamageInfo()
         dmg:SetDamage(self.Primary.Damage)
         dmg:SetAttacker(self.Owner)
         dmg:SetInflictor(self.Weapon)
         dmg:SetDamageForce(self.Owner:GetAimVector() * 1500)
         dmg:SetDamagePosition(self.Owner:GetPos())
         dmg:SetDamageType(DMG_CLUB)

         hitEnt:DispatchTraceAttack(dmg, spos + (self.Owner:GetAimVector() * 3), sdest)

--         self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )         

--         self.Owner:TraceHullAttack(spos, sdest, Vector(-16,-16,-16), Vector(16,16,16), 30, DMG_CLUB, 11, true)
--         self.Owner:FireBullets({Num=1, Src=spos, Dir=self.Owner:GetAimVector(), Spread=Vector(0,0,0), Tracer=0, Force=1, Damage=20})
      
      else
--         if tr_main.HitWorld then
--            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
--         else
--            self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
--         end

         -- See if our nodraw trace got the goods
         if tr_all.Entity and tr_all.Entity:IsValid() then
            self:OpenEnt(tr_all.Entity)
         end
      end
   end

   if self.Owner.LagCompensation then
      self.Owner:LagCompensation(false)
   end
end

function SWEP:SecondaryAttack()
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self.Weapon:SetNextSecondaryFire( CurTime() + 0.1 )
   
   local anim = "fists_left"
   local vm = self.Owner:GetViewModel()
   local owner = self.Owner

   if self.Owner.LagCompensation then
      self.Owner:LagCompensation(true)
   end

   local tr = self.Owner:GetEyeTrace(MASK_SHOT)

   if tr.Hit and IsValid(tr.Entity) and tr.Entity:IsPlayer() and (self.Owner:EyePos() - tr.HitPos):Length() < 100 then
      local ply = tr.Entity
	  
	  vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )
	  owner:ViewPunch( Angle( 2, 2, 0 ) )
      self.Owner:SetAnimation( PLAYER_ATTACK1 )

      if SERVER and (not ply:IsFrozen()) then
         local pushvel = tr.Normal * GetConVar("ttt_crowbar_pushforce"):GetFloat()

         -- limit the upward force to prevent launching
         pushvel.z = math.Clamp(pushvel.z, 50, 100) * self.PushForce

         ply:SetVelocity(ply:GetVelocity() + pushvel)

         ply.was_pushed = {att=self.Owner, t=CurTime()} --, infl=self}
      end

      self.Weapon:EmitSound(sound_single)

      self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
   end
   
   if self.Owner.LagCompensation then
      self.Owner:LagCompensation(false)
   end
end

function SWEP:GetClass()
   return "weapon_ttt_fists"
end

function SWEP:OnDrop()
   self:Remove()
end

function SWEP:Deploy()
   local vm = self.Owner:GetViewModel()
   vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
   return true
end

function SWEP:Holster( wep )
   if ( IsValid( self.Owner ) && CLIENT && self.Owner:IsPlayer() ) then
      local vm = self.Owner:GetViewModel()
      if ( IsValid( vm ) ) then vm:SetMaterial( "" ) end
   end
   return true
end
