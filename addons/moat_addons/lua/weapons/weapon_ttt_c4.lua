
-- traitor equipment: c4 bomb

AddCSLuaFile()

SWEP.HoldType			= "slam"
SWEP.PrintName			= "C4"
if CLIENT then
   SWEP.Slot				= 6

   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "C4",
      desc  = "c4_desc"
   };

   SWEP.Icon = "vgui/ttt/icon_c4"
   SWEP.IconLetter = "I"
end

SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_EQUIP
local c4block = {}
c4block["ttt_richland"] = true
c4block["ttt_richland_night"] = true
c4block["ttt_minecraftmotel_b2u"] = true
c4block["ttt_innocentmotel_v1"] = true
c4block["ttt_clue_se"] = true
c4block["ttt_mcdonalds_mds_v2"] = true
c4block["ttt_minecraftmotel_b3u"] = true
local map = game.GetMap()
if (c4block[map]) then
	SWEP.CanBuy = {}
else
	SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
end

local c4disable = {
   ["STEAM_0:0:44950009"] = true
}

-- hook.Add("TTTBeginRound", "", function()
--    for _, ply in pairs(player.GetAll()) do
--       if (c4disable[ply:SteamID()]) then
--          weapons.GetStored[[weapon_ttt_c4]].CanBuy = {}
--       end
--    end
-- end)

SWEP.WeaponID = AMMO_C4

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
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:BombDrop()
end

function SWEP:SecondaryAttack()
   self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
   self:BombStick()
end

-- mostly replicating HL2DM slam throw here
function SWEP:BombDrop()
   if SERVER then

      local ply = self.Owner
      if not IsValid(ply) then return end

      if self.Planted then return end

      local vsrc = ply:GetShootPos()
      local vang = ply:GetAimVector()
      local vvel = ply:GetVelocity()

      local vthrow = vvel + vang * 200

      local bomb = ents.Create("ttt_c4")
      if IsValid(bomb) then
         bomb:SetPos(vsrc + vang * 10)
         bomb:SetOwner(ply)
         bomb:SetThrower(ply)
         bomb:Spawn()

         bomb:PointAtEntity(ply)

         local ang = bomb:GetAngles()
         ang:RotateAroundAxis(ang:Up(), 180)
         bomb:SetAngles(ang)

         bomb.fingerprints = self.fingerprints

         bomb:PhysWake()
         local phys = bomb:GetPhysicsObject()
         if IsValid(phys) then
            phys:SetVelocity(vthrow)
         end
         self:Remove()

         self.Planted = true

      end

      ply:SetAnimation( PLAYER_ATTACK1 )
   end

   self:EmitSound(throwsound)
   self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
end

-- again replicating slam, now its attach fn
function SWEP:BombStick()
   if SERVER then
      local ply = self.Owner
      if not IsValid(ply) then return end

      if self.Planted then return end

      local ignore = {ply, self}
      local spos = ply:GetShootPos()
      local epos = spos + ply:GetAimVector() * 80
      local tr = util.TraceLine({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID})

      if tr.HitWorld then
         local bomb = ents.Create("ttt_c4")
         if IsValid(bomb) then
            bomb:PointAtEntity(ply)

            local tr_ent = util.TraceEntity({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID}, bomb)

            if tr_ent.HitWorld then

               local ang = tr_ent.HitNormal:Angle()
               ang:RotateAroundAxis(ang:Right(), -90)
               ang:RotateAroundAxis(ang:Up(), 180)

               bomb:SetPos(tr_ent.HitPos)
               bomb:SetAngles(ang)
               bomb:SetOwner(ply)
               bomb:SetThrower(ply)
               bomb:Spawn()

               bomb.fingerprints = self.fingerprints

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
