AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/m590_icon"
end
SWEP.PrintName = "Mossberg"

SWEP.Kind = WEAPON_HEAVY

SWEP.Gun = ("weapon_ttt_m590")
SWEP.HoldType 				= "ar2"

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_mossberg_590a1.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_mossberg_590a1.mdl"	-- Weapon world model
SWEP.Base 				= "weapon_tttbase"
SWEP.ShowWorldModel			= false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.reloadtimer = 0

SWEP.Primary.Sound			= Sound("gunshot_moss_590")		-- script that calls the primary fire sound
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Delay = 1.1 + 0.5
SWEP.Primary.Recoil = 10
-- Cone controls distance for damage falloff
SWEP.Primary.Cone = 0.5
-- If these exist: 
SWEP.Primary.ConeY = 0.18
SWEP.Primary.ConeX = 0.13
SWEP.Primary.Damage = 20
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 28
SWEP.Primary.DefaultClip = 6
SWEP.Primary.NumShots = 7


SWEP.ShellTime			= .45


-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(2.849,-1.836,2.309)
SWEP.IronSightsAng = Vector(0.911,0.717,-4.219)
SWEP.SightsPos = Vector(2.849,-1.836,2.309)
SWEP.SightsAng = Vector(0.911,0.717,-4.219)
SWEP.RunSightsPos = Vector(-5.45,-8.476,1.213)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-13.49,-62.8,5.441)

function SWEP:SetupDataTables()
   self:NetworkVar("Bool", 0, "Reloading")
   self:NetworkVar("Float", 0, "ReloadTimer")

   return BaseClass.SetupDataTables(self)
end

function SWEP:Reload()

   --if self:GetNetworkedBool( "reloading", false ) then return end
   if self:GetReloading() then return end

   if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

      if self:StartReload() then
         return
      end
   end

end

function SWEP:StartReload()
   --if self:GetNWBool( "reloading", false ) then
   if self:GetReloading() then
      return false
   end

   self:SetIronsights( false )

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   local ply = self.Owner

   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then
      return false
   end

   local wep = self

   if wep:Clip1() >= self.Primary.ClipSize then
      return false
   end

   wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

   self:SetReloadTimer(CurTime() + wep:SequenceDuration())

   --wep:SetNWBool("reloading", true)
   self:SetReloading(true)

   return true
end

function SWEP:PerformReload()
   local ply = self.Owner

   -- prevent normal shooting in between reloads
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end

   if self:Clip1() >= self.Primary.ClipSize then return end

   self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
   self:SetClip1( self:Clip1() + 1 )

   self:SendWeaponAnim(ACT_VM_RELOAD)

   self:SetReloadTimer(CurTime() + self:SequenceDuration())
end

function SWEP:FinishReload()
   self:SetReloading(false)
   self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

   self:SetReloadTimer(CurTime() + self:SequenceDuration())
end

function SWEP:CanPrimaryAttack()
   if self:Clip1() <= 0 then
      self:EmitSound( "Weapon_Shotgun.Empty" )
      self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
      return false
   end
   return true
end

function SWEP:Think()
   BaseClass.Think(self)

   if self:GetReloading() then
      if self.Owner:KeyDown(IN_ATTACK) then
         self:FinishReload()
         return
      end

      if self:GetReloadTimer() <= CurTime() then

         if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
            self:FinishReload()
         elseif self:Clip1() < self.Primary.ClipSize then
            self:PerformReload()
         else
            self:FinishReload()
         end
         return
      end
   end
end

function SWEP:Deploy()
   self:SetReloading(false)
   self:SetReloadTimer(0)
   return BaseClass.Deploy(self)
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.

function SWEP:SecondaryAttack()
   if self.NoSights or (not self.IronSightsPos) or self:GetReloading() then return end
   --if self:GetNextSecondaryFire() > CurTime() then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)
end

SWEP.WElements = {
	["moss_590"] = { type = "Model", model = "models/weapons/w_mossberg_590a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.546, 0.797, 0), angle = Angle(0.36, -0.997, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Offset = {
Pos = {
Up = 0,
Right = 1,
Forward = -2,
},
Ang = {
Up = 0,
Right = 355,
Forward = 180,
}
}
function SWEP:DrawWorldModel()
    local hand, offset, rotate
    local pl = self:GetOwner()

    if IsValid(pl) and pl.SetupBones then
        pl:SetupBones()
        pl:InvalidateBoneCache()
        self:InvalidateBoneCache()
    end

    if IsValid(pl) then
        local boneIndex = pl:LookupBone("ValveBiped.Bip01_R_Hand")

        if boneIndex then
            local pos, ang

            local mat = pl:GetBoneMatrix(boneIndex)
            if mat then
                pos, ang = mat:GetTranslation(), mat:GetAngles()
            else
                pos, ang = pl:GetBonePosition( handBone )
            end

            pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
            ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
            ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
            ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
            self:SetRenderOrigin(pos)
            self:SetRenderAngles(ang)
            self:DrawModel()
        end
    else
        self:SetRenderOrigin(nil)
        self:SetRenderAngles(nil)
        self:DrawModel()
    end
end