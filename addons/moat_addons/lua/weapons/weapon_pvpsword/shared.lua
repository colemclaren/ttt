--[[SWEP Info]]--


/*
SWEP.Gun = ("weapon_pvpsword") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "GMod Tower Tribute"
SWEP.Author				= "Babel Industries"
SWEP.Base				= "tfa_sword_advanced_base"

SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ("Slice and dice like a ninja. Dash forward and unleash your fury.")
SWEP.PrintName				= "Sword"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= false		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 50			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon

--[[Worldmodel Variables]]--

SWEP.HoldType 				= "melee2"		-- how others view you carrying the weapon
SWEP.BlockHoldType 				= "magic"		-- how others view you carrying the weapon, while blocking
--[[
Options:
normal - Pistol Idle / Weaponless, hands at sides
melee - One Handed Melee
melee2 - Two Handed Melee
fist - Fists Raised
knife - Knife/Dagger style melee.  Kind of hunched.
smg - SMG or Rifle with grip
ar2 - Rifle
pistol - One handed pistol
rpg - Used for RPGs or sometimes snipers.  AFAIK has no reload anim.
physgun - Used for physgun.  Kind of like SLAM, but holding a grip.
grenade - Used for nades, kind of similar to melee but more of a throwing animation.
shotgun - Used for shotugns, and really that's it.
crossbow -Similar to shotgun, but aimed.  Used for crossbows.
slam - Holding an explosive or other rectangular object with two hands
passive -- SMG idle, like you can see with some HL2 citizens
magic - One hand to temple, the other reaching out.  Can be used to mimic blocking a melee, if you're OK with the temple-hand-thing.
duel- dual pistols
revolver - 2 handed pistol
--]]
SWEP.WorldModel				= "models/weapons/w_pvp_swd.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true --Draw the world model?
SWEP.Spawnable				= true --Can it be spawned by a user?
SWEP.AdminSpawnable			= true --Can it be spawned by an admin?

SWEP.Offset = {
        Pos = {
        Up = -1.4,
        Right = 1,
        Forward = 2.8,
        },
        Ang = {
        Up = 00,
        Right = -2,
        Forward = 185,
        },
		Scale = 1
}
--[[Viewmodel Variables]]--

SWEP.UseHands = true --Uses c_hands?  If you port a model directly from HL2, CS:S, etc. then set to false
SWEP.ViewModelFOV			= 70 --This controls the viewmodel FOV.  The larger, the smaller it appears.  Decrease if you can see something you shouldn't.
SWEP.ViewModelFlip			= false --Flip the viewmodel?  Usually gonna be yes for CS:S ports.
SWEP.ViewModel				= "models/weapons/v_pvp_swd.mdl"	-- Weapon view model

--[[Shooting/Attacking Vars]]--

SWEP.Primary.Damage		= 70	-- Base damage per bullet
SWEP.Primary.RPM			= 125			-- This is in Rounds Per Minute
SWEP.Primary.KickUp				= 0.4		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false.  In the case of our sword, if you can hold and keep swinging.
SWEP.FiresUnderwater = true  --Can you swing your sword underwater?

--[[ Block Procedural Animation Variables]]--

SWEP.IronSightsPos = Vector(0, 0, 0)--Blocking Position.
SWEP.IronSightsAng = Vector(0, 0, 0)--Blocking Angle.

SWEP.RunSightsPos = Vector(0, 0, -1	)--Blocking Position.
SWEP.RunSightsAng = Vector(0, 0, 0)--Blocking Angle.

--[[Begin Slashing Variables]]--

SWEP.Slash = 1
SWEP.Sequences={}--Swinging Sequences
SWEP.Sequences[1]={
	name="midslash1",--Sequence name, can be found in HLMV
	holdtype="melee2",--Holdtype (thirdperson type of weapon, usually gonna be melee for a one handed or melee2 for a two handed)
	startt=10/60,--swing start in seconds, from the sequence start
	endt=20/60,--swing end in seconds, from the sequence start
	pitch=5, --This is a component of the slash's arc.  Pitch is added last, and changes based on the time of the trace.
	yaw=35, --This is a component of the slash's arc.  Yaw is added second, and changes based on the time of the trace.
	roll=-90,--This is a component of the slash's arc.  Roll is added first, and remains static.
	dir=-1,--Left to right = -1, right to left =1.  Base this off if the roll were 0. 
	up = true
}
SWEP.Sequences[2]={
	name="midslash2",
	holdtype="melee2",
	startt=10/60,
	endt=20/60,
	pitch=5,
	yaw=45,
	roll=10,
	dir=-1,
	up = true
}
SWEP.Sequences[3]={
	name="stab_miss",
	holdtype="melee2",
	startt=10/60,
	endt=20/60,
	pitch=5,
	yaw=45,
	roll=-5,
	dir=-1,
	up = true
}

SWEP.SlashRandom = Angle(5,0,10) --This is a random angle for the overall slash, added onto the sequence angle
SWEP.SlashJitter = Angle(1,1,1) --This is jitter for each point of the slash

SWEP.HitRange=90 -- Blade Length.  Set slightly longer to compensate for animation.
SWEP.AmmoType="TFMSwordHitGenericSlash" --Ammotype.  You can set a damage type in a custom ammo, which you can create in autorun.  Then set it to that custom ammotype here.
SWEP.SlashPrecision = 15 --The number of traces per slash
SWEP.SlashDecals = 10 --The number of decals per slash.  May slightly vary
SWEP.SlashSounds = 1 --The number of sounds per slash.  May slightly vary. 

--[[Blocking Variables]]--

SWEP.BlockSequences={}--Sequences for blocking
--
SWEP.BlockSequences[1]={
	name="midslash1", --Sequence name, can be found in HLMV
	recoverytime=0.3, --Recovery Time (Added onto sequence time, if enabled)
	recoverysequence=false  --Automatically add recovery time based on sequence length
}
SWEP.BlockSequences[2]={
	name="midslash2",
	recoverytime=0.3,
	recoverysequence=false
}
SWEP.BlockSequences[3]={
	name="stab_miss",
	recoverytime=0.3,
	recoverysequence=false
}

SWEP.NinjaMode=false --Can block bullets/everything
SWEP.DrawTime=0.2--Time you can't swing after drawing
SWEP.BlockAngle=360--Think of the player's view direction as being the middle of a sector, with the sector's angle being this
SWEP.BlockProceduralAnimTime=0.15--Change how slow or quickly the player moves their sword to block

--[[Sounds]]--

SWEP.Primary.Sound = ("Weapon_Sword.Swing") --Change this to your swing sound
SWEP.Primary.Sound_Impact_Flesh= ("Weapon_Sword.Flesh") --Change this to your flesh hit sound
SWEP.Primary.Sound_Impact_Generic = ("Weapon_Sword.Hit") --Change this to your generic hit sound
SWEP.Primary.Sound_Impact_Metal = ("SWEP.SwordClash") --Change this to your metal hit
SWEP.Primary.Sound_Pitch_Low = 97 --Percentage of pitch out of 100, lowe end.  Up to 255.
SWEP.Primary.Sound_Pitch_High = 100 --Percentage of pitch out of 100  Up to 255.
SWEP.Primary.Sound_World_Glass_Enabled = true --Override for glass?
SWEP.Primary.Sound_Glass_Enabled = true --Override for glass?
SWEP.Primary.Sound_Glass=Sound("impacts/glass_impact.wav")

SWEP.BlockMaximum = 0.98
SWEP.BlockMinimum = 0.98*/


AddCSLuaFile()

SWEP.HoldType			= "melee2"
SWEP.PrintName			= "Sword"
if CLIENT then
   SWEP.Slot				= 0

   SWEP.Icon = "vgui/ttt/icon_cbar"   
   SWEP.ViewModelFOV = 70
end

SWEP.UseHands			= true
SWEP.Base				= "weapon_tttbase"
SWEP.ViewModel				= "models/weapons/v_pvp_swd.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pvp_swd.mdl"	-- Weapon world model
SWEP.Weight			= 5
SWEP.DrawCrosshair		= false
SWEP.ViewModelFlip		= false
SWEP.Primary.Damage = 20
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

SWEP.Kind = WEAPON_MELEE
SWEP.WeaponID = AMMO_CROWBAR
SWEP.PushForce = 1

SWEP.InLoadoutFor = { nil }

SWEP.NoSights = true
SWEP.IsSilent = true

SWEP.AutoSpawnable = false

SWEP.AllowDelete = false -- never removed for weapon reduction
SWEP.AllowDrop = false

local sound_single = Sound("Weapon_Crowbar.Single")
local sound_open = Sound("DoorHandles.Unlocked3")

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
      self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )

      if not (CLIENT and (not IsFirstTimePredicted())) then
         local edata = EffectData()
         edata:SetStart(spos)
         edata:SetOrigin(tr_main.HitPos)
         edata:SetNormal(tr_main.Normal)

         --edata:SetSurfaceProp(tr_main.MatType)
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
            util.Effect("Impact", edata)
         end
      end
   else
      self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
   end


   if CLIENT then
      -- used to be some shit here
   else -- SERVER

      -- Do another trace that sees nodraw stuff like func_button
      local tr_all = nil
      tr_all = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner})
      
      self.Owner:SetAnimation( PLAYER_ATTACK1 )

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

   if self.Owner.LagCompensation then
      self.Owner:LagCompensation(true)
   end

   local tr = self.Owner:GetEyeTrace(MASK_SHOT)

   if tr.Hit and IsValid(tr.Entity) and tr.Entity:IsPlayer() and (self.Owner:EyePos() - tr.HitPos):Length() < 100 then
      local ply = tr.Entity

      if SERVER and (not ply:IsFrozen()) then
         local pushvel = tr.Normal * GetConVar("ttt_crowbar_pushforce"):GetFloat()

         -- limit the upward force to prevent launching
         pushvel.z = math.Clamp(pushvel.z, 50, 100) * self.PushForce

         ply:SetVelocity(ply:GetVelocity() + pushvel)
         self.Owner:SetAnimation( PLAYER_ATTACK1 )

         ply.was_pushed = {att=self.Owner, t=CurTime(), wep=self:GetClass()} --, infl=self}
      end

      self.Weapon:EmitSound(sound_single)      
      self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )

      self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
   end
   
   if self.Owner.LagCompensation then
      self.Owner:LagCompensation(false)
   end
end

function SWEP:GetClass()
	return "weapon_smartpen"
end

function SWEP:OnDrop()
	self:Remove()
end
