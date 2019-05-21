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
SWEP.ReloadSpeed = 1
SWEP.ActiveDelay = 0
SWEP.SoundQueue = {Count = 0}
SWEP.PopSoundQueue = {Count = 0}
SWEP.SoundActive = false

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
	-- draw.SimpleText("PING: " .. LocalPlayer():Ping() .. " MS", "WinHuge", 50, 50, Color(0, 255, 0))
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

      local offset, length, gap = thickness / 2, math.max(lengthy, lengthx), math.max(gapx, gapy)


      if outline > 0 then
        surface.SetDrawColor(0, 0, 0, 255 * alpha)

        -- x
		surface.DrawRect(x - length - 1 - outline, y - offset - outline, length - gap + outline * 2, thickness + outline * 2)
		surface.DrawRect(x - offset - outline, y - length - 1 - outline, thickness + outline * 2, length - gap + outline * 2)

		surface.DrawRect(x + gap - outline, y - offset - outline, length - gap + outline * 2, thickness + outline * 2)
		surface.DrawRect(x - offset - outline, y + gap - outline, thickness + outline * 2, length - gap + outline * 2)
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
	  surface.DrawRect( x - length - 1, y - offset, length - gap, thickness )
	  surface.DrawRect( x - offset, y - length - 1, thickness, length - gap )

	  surface.DrawRect( x + gap, y - offset, length - gap, thickness )
	  surface.DrawRect( x - offset, y + gap, thickness, length - gap )
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

function SWEP:ShootBullet(dmg, recoil, numbul, conex, coney)
    if (self.Primary.ReverseShotsDamage) then
        dmg, numbul = numbul, dmg
    end

	self:ShootAnimation()

    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    if (not IsFirstTimePredicted() and self:LastShootTime() == CurTime()) then
		return
	end

	self:SetLastShootTime(CurTime())

    local sights = self:GetIronsights()
    numbul = numbul or 1
    conex = conex or 0.01
    coney = coney or conex

    if (self.Primary and self.Primary.Ammo == "Buckshot") then
        local layers = self.Primary.Layers

        if (not layers) then
            layers = {}
            self.Primary.Layers = layers
        end

        local bullets = layers[numbul]

        if (not bullets) then
            bullets = {}
            layers[numbul] = bullets
            local LayerMults = self.Primary.LayerMults or {1}

            for LayerNum, mult in ipairs(LayerMults) do
                local LayerBullets = math.floor(numbul * mult)

                if (#LayerMults == LayerNum) then
                    LayerBullets = numbul
                end

                numbul = numbul - LayerBullets

                for i = 0, LayerBullets - 1 do
                    local v = Vector(0, (LayerNum / #LayerMults) ^ 2)
                    v:Rotate(Angle(0, i / LayerBullets * 360))
                    table.insert(bullets, v)
                end
            end
        end

        local aimvec = self.Owner:GetAimVector()
        local mult = Vector(coney, conex)
        local aimang = aimvec:Angle()

        if (self.Primary.RealCone) then
            aimvec = aimvec + util.SharedRandom(self:GetClass(), -conex, conex, 0) * aimang:Right()
            aimvec = aimvec + aimang:Up() * util.SharedRandom(self:GetClass(), -coney, coney, 1)
            mult = self.Primary.RealCone
        end

        local bullet = {}
        bullet.Num = 1
        bullet.Src = self.Owner:GetShootPos()
        bullet.Spread = vector_origin
        bullet.Tracer = self.Tracer or 4
        bullet.TracerName = self.Tracer or "Tracer"
        bullet.Force = 10
        bullet.Damage = dmg

        if CLIENT and sparkle:GetBool() then
            bullet.Callback = Sparklies
        end

        local randn = 2
        local nlayers = (self.Primary.LayerMults and #self.Primary.LayerMults or 1) + 3
        local class = self:GetClass()

        for _, bulspread in pairs(bullets) do
            local x, y = util.SharedRandom(class, -1, 1, randn) * conex / nlayers, util.SharedRandom(class, -1, 1, randn + 1) * coney / nlayers
            randn = randn + 2
            local rspr = aimang:Right() * x + aimang:Up() * y
            bullet.Dir = aimvec + rspr + bulspread.x * mult.x * aimang:Right() + bulspread.y * mult.y * aimang:Up()
            self.Owner:FireBullets(bullet)
        end
    else
        local bullet = {}
        bullet.Num = numbul
        bullet.Src = self.Owner:GetShootPos()
        bullet.Dir = self.Owner:GetAimVector()
        bullet.Spread = Vector(conex, coney, 0)
        bullet.Tracer = self.Tracer or 4
        bullet.TracerName = self.Tracer or "Tracer"
        bullet.Force = 10
        bullet.Damage = dmg

        if CLIENT and sparkle:GetBool() then
            bullet.Callback = Sparklies
        end

        self.Owner:FireBullets(bullet)
    end

    -- Owner can die after firebullets
    if (not IsValid(self.Owner)) or (not self.Owner:Alive()) or self.Owner:IsNPC() then return end

    if ((game.SinglePlayer() and SERVER) or ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then
        -- reduce recoil if ironsighting
        recoil = sights and (recoil * 0.6) or recoil
        local eyeang = self.Owner:EyeAngles()
        eyeang.pitch = eyeang.pitch - recoil
        self.Owner:SetEyeAngles(eyeang)
    end

    if (self.Shots) then
        self.Shots = self.Shots + 1
    end
end

function SWEP:ShootAnimation()
	if (self.PrimaryAnim and type(self.PrimaryAnim) == "number") then
		self:SendWeaponAnim(self.PrimaryAnim)
	else
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end

	if (self:Clip1() == 1 and self.LastShot) then
		self:LastShot()
	elseif (isstring(self.PrimaryAnim)) then
		return self:PlayAnimation("ShootAnim", self.PrimaryAnim, 1, 0)
	elseif (istable(self.PrimaryAnim)) then
		return self:PlayAnimation("ShootAnim", self.PrimaryAnim[
			math.ceil(
				util.SharedRandom(self:GetClass(), 0, #self.PrimaryAnim, 0)
			)
		], 1, 0)
	end

	return
end

-- Shooting functions largely copied from weapon_cs_base
function SWEP:PrimaryAttack(worldsnd)
	if (not self:CanPrimaryAttack()) then
		return
	end

	// self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetReloadTimer(CurTime() + self.Primary.Delay)

	// self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	if (not worldsnd) then
		self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel)
	elseif (SERVER) then
		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
	end

	self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone(), self:GetPrimaryConeY())
	self:TakePrimaryAmmo(1)

	if (not IsValid(self.Owner)) then
		return
	end

	if (self.ViewPunch) then
		self:ViewPunch(worldsnd)
	elseif (self.Owner.ViewPunch) then
		self.Owner:ViewPunch(Angle(util.SharedRandom(self:GetClass(),-0.2,-0.1,0) * self.Primary.Recoil, util.SharedRandom(self:GetClass(),-0.1,0.1,1) * self.Primary.Recoil, 0))
	end
end

function SWEP:SecondaryAttack()
	if (not self:CanSecondaryAttack()) then
		return
	end

   	if (self.NoSights or (not self.IronSightsPos)) then
		return
	end

   	self:SetIronsights(not self:GetIronsights())

	if (self.Secondary.Sound) then
      	self:EmitSound(self.Secondary.Sound)
  	end

	self:SetNextSecondaryFire(CurTime() + .3)
end

function SWEP:DryFire(setnext)
   	if (CLIENT and LocalPlayer() == self.Owner) then
      	self:EmitSound(self.Primary and self.Primary.EmptySound or "Weapon_Pistol.Empty")
   	end

   setnext(self, CurTime() + 0.2)

   self:Reload()
end

function SWEP:CanPrimaryAttack()
   	if (not IsValid(self.Owner)) then
   		return
	end

	if (self:IsBusy() or (self:IsReloading() and not self:CanPredictReload())) then
		return false
	end

   	if (self:Clip1() <= 0) then
    	self:DryFire(self.SetNextPrimaryFire)

		return false
   	end
   	
	return true
end

function SWEP:CanSecondaryAttack()
   	if (not IsValid(self.Owner)) then
   		return
	end

	if (self:IsBusy() or self:IsReloading()) then
		return false
	end

   	if (not self.IronSightsPos and self:Clip2() <= 0) then
    	self:DryFire(self.SetNextSecondaryFire)
      	
		return false
   	end
   	
	return true
end

function SWEP:TakePrimaryAmmo(num)
	if (self:Clip1() <= 0) then
		if (self:Ammo1() <= 0) then
			return
		end

		self.Owner:RemoveAmmo(num, self:GetPrimaryAmmoType())

		return
	end

	self:SetClip1(self:Clip1() - num)
end

local function Sparklies(attacker, tr, dmginfo)
   if tr.HitWorld and tr.MatType == MAT_METAL then
      local eff = EffectData()
      eff:SetOrigin(tr.HitPos)
      eff:SetNormal(tr.HitNormal)
      util.Effect("cball_bounce", eff)
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

function SWEP:Deploy()
  	self:SetIronsights(false)
	self.ActiveDelay = 0
	self:SetReloading(false)
	self:SetReloadTimer(0)
	
	self.ReloadStart = nil
	self.SoundActive = false
	self.SoundQueue = {Count = 0}
	self.PopSoundQueue = {Count = 0}

   	return true
end

function SWEP:Holster(wep)
	if (self.SoundActive) then
		self:StopSound(self.SoundActive)
	end

	self:SetIronsights(false)
	self.ActiveDelay = 0
	self:SetReloading(false)
	self:SetReloadTimer(0)

	self.SoundStart = nil
	self.SoundActive = false

	self.SoundQueue = {Count = 0}
	self.PopSoundQueue = {Count = 0}

	return true	
end

function SWEP:SoundQueueThink(CurrentTime)
	/*
	// local CT = CurTime()
	local Count = #self.SoundQueue
	for i = 1, Count do
		if (self.SoundQueue[i].When2Play < CurTime()) then
			continue
		elseif (IsValid(self.SoundQueue[i].Entity) and (not self.SoundQueue[i].Time or (self.SoundQueue[i].Time and self.SoundQueue[i].Time == CurTime()))) then
			self.SoundQueue[i].Entity:EmitSound(self.SoundQueue[i].Sound)
			self.SoundQueue[i].Entity.SoundActive = self.SoundQueue[i].Sound

			if (not self.SoundQueue[i].Time) then
				self.SoundQueue[i].Time = CurTime()
			end

			continue
		else
			-- table.remove(self.SoundQueue, i)

			continue
		end
	end
	*/
end

function SWEP:QueueSound(snd, delay, ent, cb)
	/*
	local SoundData = {
		Callback = (type(ent) == "function") and ent or cb,
		When2Play = CurTime() + delay,
		Entity = self,
		Sound = snd,
	}

	return table.insert(self.SoundQueue, SoundData)
	*/
end

function SWEP:ReloadThink()
   	if (not self:GetReloading()) then
		return false
	end

	local Clip, Ammo = self:Clip1(), self:Ammo1()
	if (Ammo <= 0 or (Clip > 0 and self.ReloadBullets and self.Owner:KeyDown(IN_ATTACK) and not self.Owner:KeyDown(IN_RELOAD))) then
		return self:AfterReload()
	end

	if (self:HasReloadFinished()) then
		local Reloaded = self:PrimaryReload(self.ReloadBullets)

		if (self.ReloadBullets and Reloaded) then
			return self:PerformReload()
		end

		return self:AfterReload()
	end

	return true		
end

function SWEP:CanPredictReload()
	local ReloadTimer, CurrentTime = self:GetReloadTimer(), CurTime()

	return ((ReloadTimer < (CurrentTime + ((ReloadTimer - CurrentTime) / 2))) and (not self.ReloadBullets))
end

function SWEP:HasReloadFinished()
	return (self:GetReloadTimer() <= CurTime())
end

function SWEP:IsReloading()
	return (self:GetReloading() or (self:GetReloadTimer() > CurTime()))
end

function SWEP:IsBusy()
	return (self.ActiveDelay and self.ActiveDelay > CurTime())
end

function SWEP:Clip1Reloaded(bullets)
	local Clip, Ammo = self:Clip1(), self:Ammo1()
	bullets = bullets or self.ReloadBullets or math.Clamp(Ammo, 0, math.max(self:GetMaxClip1() - Clip, 0)) or 0
	bullets = (Ammo <= 0 or (Clip + bullets) > self:GetMaxClip1()) and Clip or Clip + bullets

	return (Clip == bullets) and 0 or bullets, Clip, Ammo
end

function SWEP:PrimaryReload(bullets)
	local Reloaded, Clip, Ammo = self:Clip1Reloaded(bullets)
	
	if (Ammo <= 0 or Clip >= self:GetMaxClip1() or Reloaded == 0) then
		return false
	end

	self.Owner:RemoveAmmo(Reloaded - Clip, self:GetPrimaryAmmoType())
	self:SetClip1(Reloaded)

	return true
end

function SWEP:DoingReload(reload, time)
	time = (time and isnumber(time)) and time or 0

	if (reload) then
		self:SetReloading(true)
		self:SetIronsights(false)
		self:SetReloadTimer(CurTime() + (time + (self.ReloadDelay or 0)))
		self:SetNextPrimaryFire(CurTime() + (time + (self.ReloadDelay or 0)))
	else
		self:SetReloading(false)

		if (self.ShotgunReload) then
			self:SetReloadTimer(CurTime() + (time + (self.ReloadDelay or 0)))
		end

		self:SetNextPrimaryFire(CurTime() + (time + (self.ReloadDelay or 0)))
	end
end

function SWEP:ReloadAnimation(Clip, Ammo, CurrentTime)
	if (self.ReloadBullets and self.ReloadAnim.StartReload) then
		return "StartReload"
	elseif (Clip ~= 0 and self.ReloadAnim["Reload" .. Clip] and (self.ReloadAnim["Reload" .. Clip].Check and self.ReloadAnim["Reload" .. Clip].Check(Clip) or not self.ReloadAnim["Reload" .. Clip].Check)) then
		return ("Reload" .. Clip)
	end

	return (Clip == 0) and "ReloadEmpty" or "DefaultReload"
end

function SWEP:PlayAnimation(string_name, sequence, speed, cycle, ent)
	cycle = (cycle and cycle > 0) and cycle
	ent = ent or self

	if (ent == self) then
		local SoundList = self.Sounds and self.Sounds[sequence]
		if (self.ReloadAnim and self.ReloadAnim[string_name] and self.ReloadAnim[string_name].Sounds) then
			SoundList = self.ReloadAnim[string_name].Sounds
		end

		if (SoundList) then
			local CurrentTime = CurTime()

			self.SoundQueue = table.Copy(SoundList)
			self.SoundStart = CurrentTime

			for i = 1, #self.SoundQueue do
				local Delay = self.SoundQueue[i].Delay
				if (self.ReloadSpeed) then
					Delay = Delay / self.ReloadSpeed
				end

				timer.Simple(Delay, function()
					if (not IsValid(self)) then
						return
					end

					if (not self.SoundStart or self.SoundStart ~= CurrentTime) then
						return
					end

					self:EmitSound(self.SoundQueue[i].Sound)
					self.SoundActive = self.SoundQueue[i].Sound
				end)
			end
		end

		/*
		if (SoundList) then
			for i = 1, #SoundList do
				local Delay, Sound = SoundList[i].Delay or SoundList[i].Time, SoundList[i].Sound or SoundList[i].Snd

				if (not Delay) then 
					Delay = (type(SoundList[i][1]) == "number") and SoundList[i][1] or SoundList[i][2]
				end

				if (not Sound) then
					Sound = (type(SoundList[i][2]) == "string") and SoundList[i][2] or SoundList[i][1]
				end

				if (Delay and self.ReloadSpeed) then
					Delay = Delay / self.ReloadSpeed
				end

				self:QueueSound(Sound, Delay)
			end
		end
		*/

		local vm = self.Owner:GetViewModel()
		if (IsValid(vm)) then
			return self:PlayAnimation(key, sequence, speed, cycle, vm)
		end

		return ent:SequenceDuration()
	end
	
	ent:ResetSequenceInfo()
	ent:SendViewModelMatchingSequence(isstring(sequence) and ent:LookupSequence(sequence) or sequence)
	ent:SetCycle(cycle or 0)
	ent:SetPlaybackRate(speed or 1)

	return ent:SequenceDuration()
end

function SWEP:Reload()
	if (self:Clip1() >= self:GetMaxClip1() or self:Ammo1() <= 0) then
		return false
	end

	if (self:IsReloading()) then
		return false
	end

	local CurrentTime, Ammo, Clip = CurTime(), self:Ammo1(), self:Clip1()
	if (type(self.ReloadAnim) == "table") then
		local ReloadDataKey = self:ReloadAnimation(Clip, Ammo, CurrentTime)
		local ReloadData = self.ReloadAnim[ReloadDataKey] or self.ReloadAnim["DefaultReload"]
		local AnimationName = ReloadData.Animation or ReloadData.Anim or ReloadData.Name
		local AnimationLength = ReloadData.ReloadTime or ReloadData.Time

		if (not ReloadData or not AnimationName) then
			return false
		end

		if (self.ShotgunReload) then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		elseif (ReloadData.Act) then
			self:SendWeaponAnim(ReloadData.Act)
		end

		if (AnimationLength) then
			self:DoingReload(true, AnimationLength / self.ReloadSpeed)
			self:PlayAnimation(ReloadDataKey, AnimationName, self.ReloadSpeed)
		else
			AnimationLength = self:PlayAnimation(ReloadDataKey, AnimationName, self.ReloadSpeed)
			self:DoingReload(true, AnimationLength / self.ReloadSpeed)
		end
	else
		self:DefaultReload(self.ReloadAnim)
	end

	self.Owner:SetAnimation(PLAYER_RELOAD)

	return true
end

function SWEP:PerformReload(ReloadDataKey)
	ReloadDataKey = ReloadDataKey or "DefaultReload"

	local ReloadData = self.ReloadAnim[ReloadDataKey] or self.ReloadAnim["DefaultReload"]
	local AnimationName = ReloadData.Animation or ReloadData.Anim or ReloadData.Name
	local AnimationLength = ReloadData.ReloadTime or ReloadData.Time

	if (self.ShotgunReload) then
		self:SendWeaponAnim(self.ShotgunReload)
	elseif (ReloadData.Act) then
		self:SendWeaponAnim(ReloadData.Act)
	end

	if (AnimationLength) then
		self:DoingReload(true, AnimationLength / self.ReloadSpeed)
		self:PlayAnimation(ReloadDataKey, AnimationName, self.ReloadSpeed)
	else
		AnimationLength = self:PlayAnimation(ReloadDataKey, AnimationName, self.ReloadSpeed)
		self:DoingReload(true, AnimationLength / self.ReloadSpeed)
	end

	// self.Owner:SetAnimation(PLAYER_RELOAD)

	return true
end

function SWEP:AfterReload(ReloadDataKey)
	ReloadDataKey = ReloadDataKey or "AfterReload"

	local ReloadData = self.ReloadAnim[ReloadDataKey] or self.ReloadAnim["AfterReload"]
	if (not ReloadData) then

		return self:DoingReload(false)
	end

	local AnimationName = ReloadData.Animation or ReloadData.Anim or ReloadData.Name
	local AnimationLength = ReloadData.ReloadTime or ReloadData.Time
	
	if (self.ShotgunReload) then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	end

	if (AnimationLength) then
		self:DoingReload(false, AnimationLength / self.ReloadSpeed)
		self:PlayAnimation(ReloadDataKey, AnimationName, self.ReloadSpeed)
	else
		AnimationLength = self:PlayAnimation(ReloadDataKey, AnimationName, self.ReloadSpeed)
		self:DoingReload(false, AnimationLength / self.ReloadSpeed)
	end
	
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
	if (self:GetIronsights() == b) then
		return
	end

	if (self.SetZoom) then
		self:SetZoom(b)
	end

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

function SWEP:GetReloading() return false end
function SWEP:SetReloading() end
function SWEP:GetReloadTimer() return 0 end
function SWEP:SetReloadTimer() end

-- Set up ironsights dt bool. Weapons using their own DT vars will have to make
-- sure they call this.
function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Reloading")
	self:NetworkVar("Float", 0, "ReloadTimer")

	self:NetworkVar("Bool", 3, "IronsightsPredicted")
   	self:NetworkVar("Float", 3, "IronsightsTime")

   	local Entity = {
      	Weapon = self,
      	NetworkVar = function(self, ...)
         	table.insert(self.Vars, {n = select("#", ...), ...})
     	 end,
      	Vars = {}
   	}

   	hook.Run("TTTInitializeWeaponVars", Entity)

   	table.sort(Entity.Vars, function(a, b) return a[3] < b[3] end)

   	for _, var in ipairs(Entity.Vars) do
      	self:NetworkVar(unpack(var, 1, var.n))
      	if (SERVER and var[5]) then
         	self["Set" .. var[3]](self, var[5])
      	end
   	end
   	
	hook.Run("TTTWeaponVarsInitialized", self)
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
	local CurrentTime = CurTime()

	self:ReloadThink(CurrentTime)
	-- self:SoundQueueThink(CurrentTime)
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
   	if (not self.IronSightsPos or self.bIron == nil) then
		return pos, ang
	end

   local bIron = self.bIron
   local time = self.fCurrentTime + (SysTime() - self.fCurrentSysTime) * game.GetTimeScale() * host_timescale:GetFloat()

   	if (bIron) then
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

   if (fIronTime > time - IRONSIGHT_TIME) then
      	mul = math.Clamp( (time - fIronTime) / IRONSIGHT_TIME, 0, 1 )

      	if (not bIron) then
			mul = 1 - mul
		end
   	end

   	local offset = self.IronSightsPos + (ttt_lowered:GetBool() and LOWER_POS or vector_origin)

  	if (self.IronSightsAng) then
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
