-- Custom weapon base, used to derive from CS one, still very similar

AddCSLuaFile()

---- TTT SPECIAL EQUIPMENT FIELDS

-- This must be set to one of the WEAPON_ types in TTT weapons for weapon
-- carrying limits to work properly. See /gamemode/shared.lua for all possible
-- weapon categories.
SWEP.Kind = WEAPON_NONE

-- If CanBuy is a table that contains ROLE_TRAITOR and/or ROLE_DETECTIVE, those
-- players are allowed to purchase it and it will appear in their Equipment Menu
-- for that purpose. If CanBuy is nil this weapon cannot be bought.
--   Example: SWEP.CanBuy = { ROLE_TRAITOR }
-- (just setting to nil here to document its existence, don't make this buyable)
SWEP.CanBuy = nil

if CLIENT then
   -- If this is a buyable weapon (ie. CanBuy is not nil) EquipMenuData must be
   -- a table containing some information to show in the Equipment Menu. See
   -- default equipment weapons for real-world examples.
   SWEP.EquipMenuData = nil

   -- Example data:
   -- SWEP.EquipMenuData = {
   --
   ---- Type tells players if it's a weapon or item
   --     type = "Weapon",
   --
   ---- Desc is the description in the menu. Needs manual linebreaks (via \n).
   --     desc = "Text."
   -- };

   -- This sets the icon shown for the weapon in the DNA sampler, search window,
   -- equipment menu (if buyable), etc.
   SWEP.Icon = "vgui/ttt/icon_nades" -- most generic icon I guess

   -- You can make your own weapon icon using the template in:
   --   /garrysmod/gamemodes/terrortown/template/

   -- Open one of TTT's icons with VTFEdit to see what kind of settings to use
   -- when exporting to VTF. Once you have a VTF and VMT, you can
   -- resource.AddFile("materials/vgui/...") them here. GIVE YOUR ICON A UNIQUE
   -- FILENAME, or it WILL be overwritten by other servers! Gmod does not check
   -- if the files are different, it only looks at the name. I recommend you
   -- create your own directory so that this does not happen,
   -- eg. /materials/vgui/ttt/mycoolserver/mygun.vmt
end

---- MISC TTT-SPECIFIC BEHAVIOUR CONFIGURATION

-- ALL weapons in TTT must have weapon_tttbase as their SWEP.Base. It provides
-- some functions that TTT expects, and you will get errors without them.
-- Of course this is weapon_tttbase itself, so I comment this out here.
--  SWEP.Base = "weapon_tttbase"

-- If true AND SWEP.Kind is not WEAPON_EQUIP, then this gun can be spawned as
-- random weapon by a ttt_random_weapon entity.
SWEP.AutoSpawnable = false

-- Set to true if weapon can be manually dropped by players (with Q)
SWEP.AllowDrop = true

-- Set to true if weapon kills silently (no death scream)
SWEP.IsSilent = false

-- If this weapon should be given to players upon spawning, set a table of the
-- roles this should happen for here
--  SWEP.InLoadoutFor = { ROLE_TRAITOR, ROLE_DETECTIVE, ROLE_INNOCENT }

-- DO NOT set SWEP.WeaponID. Only the standard TTT weapons can have it. Custom
-- SWEPs do not need it for anything.
--  SWEP.WeaponID = nil

---- YE OLDE SWEP STUFF

if CLIENT then
   SWEP.DrawCrosshair   = false
   SWEP.ViewModelFOV    = 82
   SWEP.ViewModelFlip   = true
   SWEP.CSMuzzleFlashes = true
end

SWEP.Base = "weapon_base"
SWEP.Category           = "TTT"
SWEP.Spawnable          = false

SWEP.IsGrenade = false

SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

SWEP.Primary.Sound          = Sound( "Weapon_Pistol.Empty" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 1
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.15

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"
SWEP.Primary.ClipMax        = -1

SWEP.Secondary.ClipSize     = 1
SWEP.Secondary.DefaultClip  = 1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.ClipMax      = -1

SWEP.HeadshotMultiplier = 2.7

SWEP.StoredAmmo = 0
SWEP.IsDropped = false

SWEP.DeploySpeed = 1.4

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.fingerprints = {}

local sparkle = CLIENT and CreateConVar("ttt_crazy_sparks", "0", FCVAR_ARCHIVE)

-- crosshair
if CLIENT then
  local function CreateNewConVar(name, default, flags, noinherit)
    local old_cv = CreateConVar(name, default, flags)
    local new_cv = CreateConVar(name.."_mg", noinherit and default or "", flags, "Real default value is from "..name)
    if (new_cv:GetString() == "") then
      new_cv:SetString(noinherit and default or old_cv:GetString())
    end
    return new_cv
  end
   local sights_opacity = CreateNewConVar("ttt_ironsights_crosshair_opacity", "1", FCVAR_ARCHIVE)
   local crosshair_brightness = CreateNewConVar("ttt_crosshair_brightness", "1.0", FCVAR_ARCHIVE)
   local crosshair_size = CreateNewConVar("ttt_crosshair_size", "1.5", FCVAR_ARCHIVE, true)
   local disable_crosshair = CreateNewConVar("ttt_disable_crosshair", "0", FCVAR_ARCHIVE)

   local enable_color_crosshair = CreateNewConVar("ttt_crosshair_color_enable", "0", FCVAR_ARCHIVE)
   local crosshair_color_r = CreateNewConVar("ttt_crosshair_color_r", "30", FCVAR_ARCHIVE)
   local crosshair_color_g = CreateNewConVar("ttt_crosshair_color_g", "160", FCVAR_ARCHIVE)
   local crosshair_color_b = CreateNewConVar("ttt_crosshair_color_b", "160", FCVAR_ARCHIVE)

   local enable_gap_crosshair = CreateNewConVar("ttt_crosshair_gap_enable", "0", FCVAR_ARCHIVE, true)
   local crosshair_gap = CreateNewConVar("ttt_crosshair_gap", "0", FCVAR_ARCHIVE, true)

   local crosshair_opacity = CreateNewConVar("ttt_crosshair_opacity", "1", FCVAR_ARCHIVE)
   local crosshair_static = CreateNewConVar("ttt_crosshair_static", "0", FCVAR_ARCHIVE, true)
   local crosshair_weaponscale = CreateNewConVar("ttt_crosshair_weaponscale", "1", FCVAR_ARCHIVE, true)
   local crosshair_thickness = CreateNewConVar("ttt_crosshair_thickness", "1", FCVAR_ARCHIVE)
   local crosshair_outlinethickness = CreateNewConVar("ttt_crosshair_outlinethickness", "0", FCVAR_ARCHIVE)
   local enable_dot_crosshair = CreateNewConVar("ttt_crosshair_dot", "0", FCVAR_ARCHIVE)

   function SWEP:DrawHUD()
      if self.HUDHelp then
         self:DrawHelp()
      end

      local client = LocalPlayer()
      if disable_crosshair:GetBool() or (not IsValid(client)) then return end

      local sights = (not self.NoSights) and self:GetIronsights()

      local x = math.floor(ScrW() / 2)
      local y = math.floor(ScrH() / 2)
      local scalex = crosshair_weaponscale:GetBool() and self:GetPrimaryCone() or 0
      local scaley = crosshair_weaponscale:GetBool() and self:GetPrimaryConeY() or 0

      local timescale = 1
      if not crosshair_static:GetBool() then
         local LastShootTime = self:LastShootTime()
         timescale = 2 - math.Clamp((CurTime() - LastShootTime) * 5, 0.0, 1.0)
      end

      local size_float = crosshair_size:GetFloat()

      if (size_float % 1 == 0) then
         size_float = size_float + 0.01
      end

      local alpha = sights and sights_opacity:GetFloat() or crosshair_opacity:GetFloat()
      local bright = crosshair_brightness:GetFloat() or 1
      local gapx = enable_gap_crosshair:GetBool() and (timescale * crosshair_gap:GetFloat())
      local gapy = gapx
      local thickness = math.Round(crosshair_thickness:GetFloat() - 1) * 2 + 1
      local outline = math.Round(crosshair_outlinethickness:GetFloat())
      local fov = client:GetFOV()
      -- 1.5 is because of size_float
      local lengthx = math.max(8, math.deg(scalex) * 3 / 4 / fov * ScrW() / 1.5) * timescale * size_float
      if (not gap) then
        gapx = lengthx / 4
        lengthx = gapx * 3
      else
        lengthx = lengthx * 3 / 4 + gapx
      end
      lengthx, gapx = math.Round(lengthx), math.Round(gapx)

      local lengthy = math.max(8, math.deg(scaley) * 3 / 4 / fov * ScrW() / 1.5) * timescale * size_float
      if (not gapy) then
        gapy = lengthy / 4
        lengthy = gapy * 3
      else
        lengthy = lengthy * 3 / 4 + gapy
      end
      lengthy, gapy = math.Round(lengthy), math.Round(gapy)


      local offset = thickness / 2


      if outline > 0 then
        surface.SetDrawColor(0, 0, 0, 255 * alpha)

        -- x
        surface.DrawRect(x - lengthx - 1 - outline, y - offset - outline, lengthx - gapx + outline * 2, thickness + outline * 2)
        surface.DrawRect(x + gapx - outline, y - offset - outline, lengthx - gapx + outline * 2, thickness + outline * 2)

        -- y
        surface.DrawRect(x - offset - outline, y - lengthy - 1 - outline, thickness + outline * 2, lengthy - gapy + outline * 2)
        surface.DrawRect(x - offset - outline, y + gapy - outline, thickness + outline * 2, lengthy - gapy + outline * 2)
      end

      if enable_color_crosshair:GetBool() then
         surface.SetDrawColor(crosshair_color_r:GetInt() * bright, crosshair_color_g:GetInt() * bright, crosshair_color_b:GetInt() * bright, 255 * alpha)
      else
        -- somehow it seems this can be called before my player metatable
        -- additions have loaded
         if client.IsTraitor and client:IsTraitor() then
            surface.SetDrawColor(255 * bright, 50 * bright, 50 * bright, 255 * alpha)
         else
            surface.SetDrawColor(0, 255 * bright, 0, 255 * alpha)
         end
      end

      if enable_dot_crosshair:GetBool() then
        surface.DrawRect( x - thickness / 2, y - thickness / 2, thickness, thickness ) -- draw crosshair dot
      end


      -- x
      surface.DrawRect( x - lengthx - 1, y - offset, lengthx - gapx, thickness )
      surface.DrawRect( x + gapx, y - offset, lengthx - gapx, thickness )

      -- y
      surface.DrawRect( x - offset, y - lengthy - 1, thickness, lengthy - gapy )
      surface.DrawRect( x - offset, y + gapy, thickness, lengthy - gapy )
   end

   local GetPTranslation = LANG.GetParamTranslation

   -- Many non-gun weapons benefit from some help
   local help_spec = {text = "", font = "TabLarge", xalign = TEXT_ALIGN_CENTER}
   function SWEP:DrawHelp()
      local data = self.HUDHelp

      local translate = data.translatable
      local primary   = data.primary
      local secondary = data.secondary

      if translate then
         primary   = primary   and GetPTranslation(primary,   data.translate_params)
         secondary = secondary and GetPTranslation(secondary, data.translate_params)
      end

      help_spec.pos  = {ScrW() / 2.0, ScrH() - 300}
      help_spec.text = secondary or primary
      draw.TextShadow(help_spec, 2)

      -- if no secondary exists, primary is drawn at the bottom and no top line
      -- is drawn
      if secondary then
         help_spec.pos[2] = ScrH() - 60
         help_spec.text = primary
         draw.TextShadow(help_spec, 2)
      end
   end

   -- mousebuttons are enough for most weapons
   local default_key_params = {
      primaryfire   = Key("+attack",  "LEFT MOUSE"),
      secondaryfire = Key("+attack2", "RIGHT MOUSE"),
      usekey        = Key("+use",     "USE")
   };

   function SWEP:AddHUDHelp(primary_text, secondary_text, translate, extra_params)
      extra_params = extra_params or {}

      self.HUDHelp = {
         primary = primary_text,
         secondary = secondary_text,
         translatable = translate,
         translate_params = table.Merge(extra_params, default_key_params)
      };
   end
end

-- Shooting functions largely copied from weapon_cs_base
function SWEP:PrimaryAttack(worldsnd)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if (not self:CanPrimaryAttack()) then
		return
	end
	
	if (self.ReloadTime and self.ReloadTime > CurTime()) then
		return
	end

	if (not worldsnd) then
		self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel)
	elseif (SERVER) then
		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
	end

	self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone(), self:GetPrimaryConeY())
	self:TakePrimaryAmmo(1)

	if (not IsValid(self.Owner) or not self.Owner.ViewPunch) then
		return
	end

	--todo: fucking redo this stupid shit viewpunch
	self.Owner:ViewPunch(Angle(util.SharedRandom(self:GetClass(),-0.2,-0.1,0) * self.Primary.Recoil, util.SharedRandom(self:GetClass(),-0.1,0.1,1) * self.Primary.Recoil, 0))
end

function SWEP:DryFire(setnext)
   if CLIENT and LocalPlayer() == self.Owner then
      self:EmitSound( "Weapon_Pistol.Empty" )
   end

   setnext(self, CurTime() + 0.2)

   self:Reload()
end

function SWEP:CanPrimaryAttack()
   if not IsValid(self.Owner) then return end

   if self:Clip1() <= 0 then
      self:DryFire(self.SetNextPrimaryFire)
      return false
   end
   return true
end

function SWEP:CanSecondaryAttack()
   if not IsValid(self.Owner) then return end

   if self:Clip2() <= 0 then
      self:DryFire(self.SetNextSecondaryFire)
      return false
   end
   return true
end

local function Sparklies(attacker, tr, dmginfo)
   if tr.HitWorld and tr.MatType == MAT_METAL then
      local eff = EffectData()
      eff:SetOrigin(tr.HitPos)
      eff:SetNormal(tr.HitNormal)
      util.Effect("cball_bounce", eff)
   end
end

function SWEP:ShootBullet( dmg, recoil, numbul, conex, coney )

   self:SendWeaponAnim(self.PrimaryAnim)

   self.Owner:MuzzleFlash()
   self.Owner:SetAnimation( PLAYER_ATTACK1 )

   if not IsFirstTimePredicted() then return end

   local sights = self:GetIronsights()

   numbul  = numbul or 1
   conex   = conex   or 0.01
   coney   = coney or conex

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self.Owner:GetShootPos()
   bullet.Dir    = self.Owner:GetAimVector()
   bullet.Spread = Vector( conex, coney, 0 )
   bullet.Tracer = 4
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = 10
   bullet.Damage = dmg
   if CLIENT and sparkle:GetBool() then
      bullet.Callback = Sparklies
   end

   self.Owner:FireBullets( bullet )

   -- Owner can die after firebullets
   if (not IsValid(self.Owner)) or (not self.Owner:Alive()) or self.Owner:IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 0.6) or recoil

      local eyeang = self.Owner:EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self.Owner:SetEyeAngles( eyeang )
   end

	if (self.Shots) then
		self.Shots = self.Shots + 1
	end
end

function SWEP:GetPrimaryCone()
   local cone = self.Primary.ConeX or self.Primary.Cone or 0.2
   -- 10% accuracy bonus when sighting
   return self:GetIronsights() and (cone * 0.85) or cone
end

function SWEP:GetPrimaryConeY()
   local cone = self.Primary.ConeY or self.Primary.Cone or 0.2
   -- 10% accuracy bonus when sighting
   return self:GetIronsights() and (cone * 0.85) or cone
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   if (self.Primary.Ammo == "Buckshot") then
      return self:GetShotgunHeadshotMultiplier(victim, dmginfo)
   end

   return self.HeadshotMultiplier
end

function SWEP:GetShotgunHeadshotMultiplier(victim, dmginfo)
   return 1 -- disabled headshot damage for shotgun
   /*
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 3 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 140)

   -- decay from 3.1 to 1 slowly as distance increases
   return 1 + math.max(0, (2.1 - 0.002 * (d ^ 1.25)))*/
end

function SWEP:IsEquipment()
   return WEPS.IsEquipment(self)
end

function SWEP:DrawWeaponSelection() end

function SWEP:SecondaryAttack()
   if self.NoSights or (not self.IronSightsPos) then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:Deploy()
   self:SetIronsights(false)
   return true
end

function SWEP:Reload()
	if (self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
		return false
	end

	if (self.ReloadLength) then
		self.ReloadTime = CurTime() + self.ReloadLength
	end

   	self:DefaultReload(self.ReloadAnim)
   	self:SetIronsights(false)

	return true
end


function SWEP:OnRestore()
   self.NextSecondaryAttack = 0
   self:SetIronsights( false )
end

function SWEP:Ammo1()
   return IsValid(self.Owner) and self.Owner:GetAmmoCount(self.Primary.Ammo) or false
end

-- The OnDrop() hook is useless for this as it happens AFTER the drop. OwnerChange
-- does not occur when a drop happens for some reason. Hence this thing.
function SWEP:PreDrop()
   if SERVER and IsValid(self.Owner) and self.Primary.Ammo != "none" then
      local ammo = self:Ammo1()

      -- Do not drop ammo if we have another gun that uses this type
      for _, w in pairs(self.Owner:GetWeapons()) do
         if IsValid(w) and w != self and w:GetPrimaryAmmoType() == self:GetPrimaryAmmoType() then
            ammo = 0
         end
      end

      self.StoredAmmo = ammo

      if ammo > 0 then
         self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
      end
   end
end

function SWEP:DampenDrop()
   -- For some reason gmod drops guns on death at a speed of 400 units, which
   -- catapults them away from the body. Here we want people to actually be able
   -- to find a given corpse's weapon, so we override the velocity here and call
   -- this when dropping guns on death.
   local phys = self:GetPhysicsObject()
   if IsValid(phys) then
      phys:SetVelocityInstantaneous(Vector(0,0,-75) + phys:GetVelocity() * 0.001)
      phys:AddAngleVelocity(phys:GetAngleVelocity() * -0.99)
   end
end

local SF_WEAPON_START_CONSTRAINED = 1

-- Picked up by player. Transfer of stored ammo and such.
function SWEP:Equip(newowner)
   if SERVER then
      if self:IsOnFire() then
         self:Extinguish()
      end

      self.fingerprints = self.fingerprints or {}

      if not table.HasValue(self.fingerprints, newowner) then
         table.insert(self.fingerprints, newowner)
      end

      if self:HasSpawnFlags(SF_WEAPON_START_CONSTRAINED) then
         -- If this weapon started constrained, unset that spawnflag, or the
         -- weapon will be re-constrained and float
         local flags = self:GetSpawnFlags()
         local newflags = bit.band(flags, bit.bnot(SF_WEAPON_START_CONSTRAINED))
         self:SetKeyValue("spawnflags", newflags)
      end
   end

   if SERVER and IsValid(newowner) and self.StoredAmmo > 0 and self.Primary.Ammo != "none" then
      local ammo = newowner:GetAmmoCount(self.Primary.Ammo)
      local given = math.min(self.StoredAmmo, self.Primary.ClipMax - ammo)

      newowner:GiveAmmo( given, self.Primary.Ammo)
      self.StoredAmmo = 0
   end
end

-- We were bought as special equipment, some weapons will want to do something
-- extra for their buyer
function SWEP:WasBought(buyer)
end

-- Dummy functions that will be replaced when SetupDataTables runs. These are
-- here for when that does not happen (due to e.g. stacking base classes)
function SWEP:SetIronsights(b)
   self:SetIronsightsPredicted(b)
   self:SetIronsightsTime(CurTime())
   if CLIENT then
      self:CalcViewModel()
   end
end
function SWEP:GetIronsights()
   return self:GetIronsightsPredicted()
end

--- Dummy functions that will be replaced when SetupDataTables runs. These are
--- here for when that does not happen (due to e.g. stacking base classes)
function SWEP:GetIronsightsTime() return -1 end
function SWEP:SetIronsightsTime() end
function SWEP:GetIronsightsPredicted() return false end
function SWEP:SetIronsightsPredicted() end

-- Set up ironsights dt bool. Weapons using their own DT vars will have to make
-- sure they call this.
function SWEP:SetupDataTables()
   -- Put it in the last slot, least likely to interfere with derived weapon's
   -- own stuff.
   self:NetworkVar("Bool", 3, "IronsightsPredicted")
   self:NetworkVar("Float", 3, "IronsightsTime")
end

function SWEP:Initialize()
   if CLIENT and self:Clip1() == -1 then
      self:SetClip1(self.Primary.DefaultClip)
   elseif SERVER then
      self.fingerprints = {}

      self:SetIronsights(false)
   end

   self:SetDeploySpeed(self.DeploySpeed)

   -- compat for gmod update
   if self.SetHoldType then
      self:SetHoldType(self.HoldType or "pistol")
   end
end

function SWEP:CalcViewModel()
   if (not CLIENT) or (not IsFirstTimePredicted()) then return end
   self.bIron = self:GetIronsights()
   self.fIronTime = self:GetIronsightsTime()
   self.fCurrentTime = CurTime()
   self.fCurrentSysTime = SysTime()
end

function SWEP:Think()
   self:CalcViewModel()
end

function SWEP:DyingShot()
   local fired = false
   if self:GetIronsights() then
      self:SetIronsights(false)

      if self:GetNextPrimaryFire() > CurTime() then
         return fired
      end

      -- Owner should still be alive here
      if IsValid(self.Owner) then
         local punch = self.Primary.Recoil or 5

         -- Punch view to disorient aim before firing dying shot
         local eyeang = self.Owner:EyeAngles()
         eyeang.pitch = eyeang.pitch - math.Rand(-punch, punch)
         eyeang.yaw = eyeang.yaw - math.Rand(-punch, punch)
         self.Owner:SetEyeAngles( eyeang )

         MsgN(self.Owner:Nick() .. " fired his DYING SHOT")

         self.Owner.dying_wep = self

         self:PrimaryAttack(true)

         fired = true
      end
   end

   return fired
end

local ttt_lowered = CreateConVar("ttt_ironsights_lowered", "1", FCVAR_ARCHIVE)
local host_timescale = GetConVar("host_timescale")

local LOWER_POS = Vector(0, 0, -2)

local IRONSIGHT_TIME = 0.25
function SWEP:GetViewModelPosition( pos, ang )
   if not self.IronSightsPos or self.bIron == nil then return pos, ang end

   local bIron = self.bIron
   local time = self.fCurrentTime + (SysTime() - self.fCurrentSysTime) * game.GetTimeScale() * host_timescale:GetFloat()

   if bIron then
      self.SwayScale = 0.3
      self.BobScale = 0.1
   else
      self.SwayScale = 1.0
      self.BobScale = 1.0
   end

   local fIronTime = self.fIronTime
   if (not bIron) and fIronTime < time - IRONSIGHT_TIME then
      return pos, ang
   end

   local mul = 1.0

   if fIronTime > time - IRONSIGHT_TIME then

      mul = math.Clamp( (time - fIronTime) / IRONSIGHT_TIME, 0, 1 )

      if not bIron then mul = 1 - mul end
   end

   local offset = self.IronSightsPos + (ttt_lowered:GetBool() and LOWER_POS or vector_origin)

   if self.IronSightsAng then
      ang = ang * 1
      ang:RotateAroundAxis( ang:Right(),    self.IronSightsAng.x * mul )
      ang:RotateAroundAxis( ang:Up(),       self.IronSightsAng.y * mul )
      ang:RotateAroundAxis( ang:Forward(),  self.IronSightsAng.z * mul )
   end

   pos = pos + offset.x * ang:Right() * mul
   pos = pos + offset.y * ang:Forward() * mul
   pos = pos + offset.z * ang:Up() * mul

   return pos, ang
end
