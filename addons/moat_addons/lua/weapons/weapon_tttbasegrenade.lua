-- common code for all types of grenade

AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

SWEP.HoldReady = "grenade"
SWEP.HoldNormal = "slam"
SWEP.PrintName			= "Incendiary grenade"

if CLIENT then
   SWEP.Instructions		= "Burn."
   SWEP.Slot				= 3
   SWEP.SlotPos			= 0


   SWEP.Icon = "vgui/ttt/icon_nades"
end

SWEP.Base				= "weapon_tttbase"

SWEP.Kind = WEAPON_NADE

SWEP.ViewModel			= "models/weapons/v_eq_flashbang.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_flashbang.mdl"
SWEP.Weight			= 5

SWEP.ViewModelFlip = true
SWEP.AutoSwitchFrom		= true

SWEP.DrawCrosshair		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Delay = 1.0
SWEP.Primary.Ammo		= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.IsGrenade = true
SWEP.NoSights = true

SWEP.was_thrown = false

SWEP.detonate_timer = 5

SWEP.DeploySpeed = 1.5

AccessorFunc(SWEP, "det_time", "DetTime")

CreateConVar("ttt_no_nade_throw_during_prep", "0")

function SWEP:SetupDataTables()
   self:NetworkVar("Bool", 0, "Pin")
   self:NetworkVar("Int", 0, "ThrowTime")
end

function SWEP:PrimaryAttack()
   self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

   if GetRoundState() == ROUND_PREP and GetConVar("ttt_no_nade_throw_during_prep"):GetBool() then
      return
   end

   self:PullPin()
end

function SWEP:SecondaryAttack()
end

function SWEP:PullPin()
   if self:GetPin() then return end

   local ply = self.Owner
   if not IsValid(ply) then return end

   self:SendWeaponAnim(ACT_VM_PULLPIN)

   if self.SetHoldType then
      self:SetHoldType(self.HoldReady)
   end

   self:SetPin(true)

   self:SetDetTime(CurTime() + self.detonate_timer)
end


function SWEP:Think()
   BaseClass.Think(self)

   local ply = self.Owner
   if not IsValid(ply) then return end

   -- pin pulled and attack loose = throw
   if self:GetPin() then
      -- we will throw now
      if not ply:KeyDown(IN_ATTACK) then
         self:StartThrow()

         self:SetPin(false)
         self:SendWeaponAnim(ACT_VM_THROW)

         if SERVER then
            self.Owner:SetAnimation( PLAYER_ATTACK1 )
         end
      else
         -- still cooking it, see if our time is up
         if SERVER and self:GetDetTime() < CurTime() then
            self:BlowInFace()
         end
      end
   elseif self:GetThrowTime() > 0 and self:GetThrowTime() < CurTime() then
      self:Throw()
   end
end


function SWEP:BlowInFace()
   local ply = self.Owner
   if not IsValid(ply) then return end

   if self.was_thrown then return end

   self.was_thrown = true

   -- drop the grenade so it can immediately explode

   local ang = ply:GetAngles()
   local src = ply:EyePos()
   src = src + (ang:Right() * 10)

   self:CreateGrenade(src, Angle(0,0,0), Vector(0,0,1), Vector(0,0,1), ply)

   self:SetThrowTime(0)
   if (SERVER) then self:Remove() end
end

function SWEP:StartThrow()
   self:SetThrowTime(CurTime() + 0.1)
end

function SWEP:Throw()
   if CLIENT then
      self:SetThrowTime(0)
   elseif SERVER then
      local ply = self.Owner
      if not IsValid(ply) then return end

      if self.was_thrown then return end

      self.was_thrown = true

      local ang = ply:EyeAngles()
      local src = ply:EyePos() + (ang:Forward() * 8) + (ang:Right() * 10)
      local target = ply:GetEyeTraceNoCursor().HitPos
      local tang = (target-src):Angle() -- A target angle to actually throw the grenade to the crosshair instead of fowards
      -- Makes the grenade go upgwards
      if tang.p < 90 then
         tang.p = -10 + tang.p * ((90 + 10) / 90)
      else
         tang.p = 360 - tang.p
         tang.p = -10 + tang.p * -((90 + 10) / 90)
      end
      tang.p=math.Clamp(tang.p,-90,90) -- Makes the grenade not go backwards :/
      local vel = math.min(800, (90 - tang.p) * 6)
      local thr = tang:Forward() * vel + ply:GetVelocity()
      self:CreateGrenade(src, Angle(0,0,0), thr, vector_origin, ply)

      self:SetThrowTime(0)
      self:Remove()
   end
end

-- subclasses must override with their own grenade ent
function SWEP:GetGrenadeName()
   ErrorNoHalt("SWEP BASEGRENADE ERROR: GetGrenadeName not overridden! This is probably wrong!\n")
   return "ttt_firegrenade_proj"
end


function SWEP:CreateGrenade(src, ang, vel, angimp, ply)
   local gren = ents.Create(self:GetGrenadeName())
   if not IsValid(gren) then return end

   gren:SetPos(src)
   gren:SetAngles(ang)

   --   gren:SetVelocity(vel)
   gren:SetOwner(ply)
   gren:SetThrower(ply)

   gren:SetFriction(200000)
   gren:SetElasticity(0)

   gren:Spawn()

   gren:PhysWake()

   local phys = gren:GetPhysicsObject()
   if IsValid(phys) then
      phys:SetVelocity(vel)
      phys:EnableDrag(false)
      phys:AddAngleVelocity(angimp)
   end

   -- This has to happen AFTER Spawn() calls gren's Initialize()
   gren:SetDetonateExact(self:GetDetTime())

   return gren
end

function SWEP:PreDrop()
   -- if owner dies or drops us while the pin has been pulled, create the armed
   -- grenade anyway
   if self:GetPin() then
      self:BlowInFace()
   end
end

function SWEP:Deploy()

   if self.SetHoldType then
      self:SetHoldType(self.HoldNormal)
   end

   self:SetThrowTime(0)
   self:SetPin(false)
   return true
end

function SWEP:Holster()
   if self:GetPin() then
      return false -- no switching after pulling pin
   end

   self:SetThrowTime(0)
   self:SetPin(false)
   return true
end

function SWEP:Reload()
   return false
end

function SWEP:Initialize()
   if self.SetHoldType then
      self:SetHoldType(self.HoldNormal)
   end

   self:SetDeploySpeed(self.DeploySpeed)

   self:SetDetTime(0)
   self:SetThrowTime(0)
   self:SetPin(false)

   self.was_thrown = false
end

function SWEP:OnRemove()
   if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
      RunConsoleCommand("use", "weapon_ttt_unarmed")
   end
end

local function PositionFromPhysicsParams(P, V, G, T)
    -- D = Vi * t + 1/2 * a * t ^ 2
    local A = G * physenv.GetGravity()
    return P + (V * T + 0.5 * A * T ^ 2)
end

local function ColorLerp(from, mid, to, frac)
    local f, t, fr = from, mid, frac * 2
    if (frac > 1) then
        f, t, fr = mid, to, frac - 1
    end
    return Color(Lerp(fr, f.r, t.r), Lerp(fr, f.g, t.g), Lerp(fr, f.b, t.b), 160)
end

local color_green = Color(255, 40, 40)
local color_yellow = Color(220, 40, 40)
local color_red = Color(255, 40, 40)

function SWEP:GetViewModelPosition(pos, ang)
    self.V_pos = pos
end

local on_even_line = false

function SWEP:DrawDefaultThrowPath(wep, ply)
    if (not self.V_pos) then
        return
    end

    local ang = ply:EyeAngles()
    local src = ply:EyePos() + (ang:Forward() * 8) + (ang:Right() * 10)
    local target = ply:GetEyeTraceNoCursor().HitPos
    local tang = (target-src):Angle() -- A target angle to actually throw the grenade to the crosshair instead of fowards
    -- Makes the grenade go upgwards
    if tang.p < 90 then
        tang.p = -10 + tang.p * ((90 + 10) / 90)
    else
        tang.p = 360 - tang.p
        tang.p = -10 + tang.p * -((90 + 10) / 90)
    end
    tang.p = math.Clamp(tang.p,-90,90) -- Makes the grenade not go backwards :/
    local vel = math.min(800, (90 - tang.p) * 6)
    local thr = tang:Forward() * vel + ply:GetVelocity()

    local P = self.V_pos - ply:EyePos() + src
    local V = thr
    local G = 1

    render.SetColorMaterial()
    cam.Start3D(EyePos(), EyeAngles())
        local step = 0.005
        local lastpos = PositionFromPhysicsParams(P, V, G, step)

        local frac = (SysTime() % 1) / 1 * 2

        local i = frac > 1 and 1 or 0
        frac = frac - math.floor(frac)
        for T = step * 2, 1, step do
            local pos = PositionFromPhysicsParams(P, V, G, T)
            local t = util.TraceLine {
                start = lastpos,
                endpos = pos,
                filter = {ply, wep}
            }

            local from, to = lastpos, t.Hit and t.HitPos or pos
            local norm = to - from
            norm:Normalize()
            local len = from:Distance(to)

            i = (i + 1) % 2
            if (i == 0) then
                render.DrawBeam(from, from + norm * (frac * len), 0.2, 0, 1, ColorLerp(color_green, color_yellow, color_red, T))
            else
                render.DrawBeam(to - norm * ((1 - frac) * len), to, 0.2, 0, 1, ColorLerp(color_green, color_yellow, color_red, T))
            end

            if (t.Hit) then
                break
            end
            lastpos = pos
        end
    cam.End3D()

end