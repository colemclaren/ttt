
AddCSLuaFile()

SWEP.HoldType			= "melee"
SWEP.PrintName			= "A Candy Cane"
if CLIENT then
   SWEP.Slot				= 0

   SWEP.Icon = "vgui/ttt/icon_cbar"   
   SWEP.ViewModelFOV = 54
end

SWEP.UseHands			= true
SWEP.Base				= "weapon_tttbase"
SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel   = "models/griim/foodpack/candycane.mdl"
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

SWEP.InLoadoutFor = nil

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
	return "weapon_zm_improvised"
end

function SWEP:OnDrop()
	self:Remove()
end

SWEP.Offset = {
Pos = {
Up = 10,
Right = 1,
Forward = 3,
},
Ang = {
Up = 0,
Right = 0,
Forward = -90,
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
            self:SetModelScale(2, 0)
            self:DrawModel()
        end
    else
        self:SetRenderOrigin(nil)
        self:SetRenderAngles(nil)
        self:DrawModel()
    end
end

function SWEP:AttachProp()
   self:RemoveProp()

   local vm = self.Owner:GetViewModel()
   if IsValid(vm) then
      self.Prop = ClientsideModel(self.WorldModel, RENDER_GROUP_VIEW_MODEL_OPAQUE)
      self.Prop:SetModelScale(2, 0 )
      self.Prop:SetNoDraw(true)
      --self.Prop:SetParent(vm)
   end
end

function SWEP:RemoveProp()
   if SERVER and IsValid(self.Prop) then
      self.Prop:Remove()
      self.Prop = nil
   end
end

SWEP.Offset2 = {
Pos = {
Up = 10,
Right = 1.4,
Forward = 3,
},
Ang = {
Up = -5,
Right = 2,
Forward = -90,
}
}

function SWEP:ViewModelDrawn(vm)
   if (not self.Prop) then
      self:AttachProp()
   end

   local hand, offset, rotate

   if IsValid(vm) and vm.SetupBones then
      vm:SetupBones()
      vm:InvalidateBoneCache()
      self:InvalidateBoneCache()
   end

   local boneIndex = vm:LookupBone("ValveBiped.Bip01_R_Hand")
   if boneIndex then
      local pos, ang

      local mat = vm:GetBoneMatrix(boneIndex)
      if mat then
          pos, ang = mat:GetTranslation(), mat:GetAngles()
      else
          pos, ang = vm:GetBonePosition( handBone )
      end

      pos = pos + ang:Forward() * self.Offset2.Pos.Forward + ang:Right() * self.Offset2.Pos.Right + ang:Up() * self.Offset2.Pos.Up
      ang:RotateAroundAxis(ang:Up(), self.Offset2.Ang.Up)
      ang:RotateAroundAxis(ang:Right(), self.Offset2.Ang.Right)
      ang:RotateAroundAxis(ang:Forward(), self.Offset2.Ang.Forward)
      self.Prop:SetRenderOrigin(pos)
      self.Prop:SetRenderAngles(ang)
      self.Prop:DrawModel()
   end
end

function SWEP:Holster()
   self:RemoveProp()
   return true
end

function SWEP:OnRemove()
   self:RemoveProp()
end

   /*local allbones
   local hasGarryFixedBoneScalingYet = false

   function SWEP:UpdateBonePositions(vm)
      
      if self.ViewModelBoneMods then
         
         if (!vm:GetBoneCount()) then return end
         
         // !! WORKAROUND !! //
         // We need to check all model names :/
         local loopthrough = self.ViewModelBoneMods
         if (!hasGarryFixedBoneScalingYet) then
            allbones = {}
            for i=0, vm:GetBoneCount() do
               local bonename = vm:GetBoneName(i)
               if (self.ViewModelBoneMods[bonename]) then 
                  allbones[bonename] = self.ViewModelBoneMods[bonename]
               else
                  allbones[bonename] = { 
                     scale = Vector(1,1,1),
                     pos = Vector(0,0,0),
                     angle = Angle(0,0,0)
                  }
               end
            end
            
            loopthrough = allbones
         end
         // !! ----------- !! //
         
         for k, v in pairs( loopthrough ) do
            local bone = vm:LookupBone(k)
            if (!bone) then continue end
            
            // !! WORKAROUND !! //
            local s = Vector(v.scale.x,v.scale.y,v.scale.z)
            local p = Vector(v.pos.x,v.pos.y,v.pos.z)
            local ms = Vector(1,1,1)
            if (!hasGarryFixedBoneScalingYet) then
               local cur = vm:GetBoneParent(bone)
               while(cur >= 0) do
                  local pscale = loopthrough[vm:GetBoneName(cur)].scale
                  ms = ms * pscale
                  cur = vm:GetBoneParent(cur)
               end
            end
            
            s = s * ms
            // !! ----------- !! //
            
            if vm:GetManipulateBoneScale(bone) != s then
               vm:ManipulateBoneScale( bone, s )
            end
            if vm:GetManipulateBoneAngles(bone) != v.angle then
               vm:ManipulateBoneAngles( bone, v.angle )
            end
            if vm:GetManipulateBonePosition(bone) != p then
               vm:ManipulateBonePosition( bone, p )
            end
         end
      else
         self:ResetBonePositions(vm)
      end
         
   end
    
   function SWEP:ResetBonePositions(vm)
      
      if (!vm:GetBoneCount()) then return end
      for i=0, vm:GetBoneCount() do
         vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
         vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
         vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
      end
      
   end

   function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
      
      local bone, pos, ang
      if (tab.rel and tab.rel != "") then
         
         local v = basetab[tab.rel]
         
         if (!v) then return end
         
         // Technically, if there exists an element with the same name as a bone
         // you can get in an infinite loop. Let's just hope nobody's that stupid.
         pos, ang = self:GetBoneOrientation( basetab, v, ent )
         
         if (!pos) then return end
         
         pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
         ang:RotateAroundAxis(ang:Up(), v.angle.y)
         ang:RotateAroundAxis(ang:Right(), v.angle.p)
         ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
      else
      
         bone = ent:LookupBone(bone_override or tab.bone)

         if (!bone) then return end
         
         pos, ang = Vector(0,0,0), Angle(0,0,0)
         local m = ent:GetBoneMatrix(bone)
         if (m) then
            pos, ang = m:GetTranslation(), m:GetAngles()
         end
         
         if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
            ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
            ang.r = -ang.r // Fixes mirrored models
         end
      
      end
      
      return pos, ang
   end

   function SWEP:CreateModels( tab )

      if (!tab) then return end

      // Create the clientside models here because Garry says we can't do it in the render hook
      for k, v in pairs( tab ) do
         if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
               string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
            
            v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
            if (IsValid(v.modelEnt)) then
               v.modelEnt:SetPos(self:GetPos())
               v.modelEnt:SetAngles(self:GetAngles())
               v.modelEnt:SetParent(self)
               v.modelEnt:SetNoDraw(true)
               v.createdModel = v.model
            else
               v.modelEnt = nil
            end
            
         elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
            and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
            
            local name = v.sprite.."-"
            local params = { ["$basetexture"] = v.sprite }
            // make sure we create a unique name based on the selected options
            local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
            for i, j in pairs( tocheck ) do
               if (v[j]) then
                  params["$"..j] = 1
                  name = name.."1"
               else
                  name = name.."0"
               end
            end

            v.createdSprite = v.sprite
            v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
            
         end
      end
      
   end

SWEP.VElements = {
   ["candycane"] = { type = "Model", model = "models/griim/foodpack/candycane.mdl", bone = "crowbar_new", rel = "", pos = Vector(-4.136, -7.47, -38.938), angle = Angle(3.645, -94.706, 79.666), size = Vector(7.331, 7.331, 7.331), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

   SWEP.vRenderOrder = nil
   function SWEP:ViewModelDrawn()
      
      local vm = self.Owner:GetViewModel()
      if !IsValid(vm) then return end
      
      if (!self.VElements) then return end
      
      self:UpdateBonePositions(vm)

      if (!self.vRenderOrder) then
         
         // we build a render order because sprites need to be drawn after models
         self.vRenderOrder = {}

         for k, v in pairs( self.VElements ) do
            if (v.type == "Model") then
               table.insert(self.vRenderOrder, 1, k)
            elseif (v.type == "Sprite" or v.type == "Quad") then
               table.insert(self.vRenderOrder, k)
            end
         end
         
      end

      for k, name in ipairs( self.vRenderOrder ) do
      
         local v = self.VElements[name]
         if (!v) then self.vRenderOrder = nil break end
         if (v.hide) then continue end
         
         local model = v.modelEnt
         local sprite = v.spriteMaterial
         
         if (!v.bone) then continue end
         
         local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
         
         if (!pos) then continue end
         
         if (v.type == "Model" and IsValid(model)) then

            model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)

            model:SetAngles(ang)
            //model:SetModelScale(v.size)
            local matrix = Matrix()
            matrix:Scale(v.size)
            model:EnableMatrix( "RenderMultiply", matrix )
            
            if (v.material == "") then
               model:SetMaterial("")
            elseif (model:GetMaterial() != v.material) then
               model:SetMaterial( v.material )
            end
            
            if (v.skin and v.skin != model:GetSkin()) then
               model:SetSkin(v.skin)
            end
            
            if (v.bodygroup) then
               for k, v in pairs( v.bodygroup ) do
                  if (model:GetBodygroup(k) != v) then
                     model:SetBodygroup(k, v)
                  end
               end
            end
            
            if (v.surpresslightning) then
               render.SuppressEngineLighting(true)
            end
            
            render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
            render.SetBlend(v.color.a/255)
            model:DrawModel()
            render.SetBlend(1)
            render.SetColorModulation(1, 1, 1)
            
            if (v.surpresslightning) then
               render.SuppressEngineLighting(false)
            end
            
         elseif (v.type == "Sprite" and sprite) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            render.SetMaterial(sprite)
            render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
            
         elseif (v.type == "Quad" and v.draw_func) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
            cam.Start3D2D(drawpos, ang, v.size)
               v.draw_func( self )
            cam.End3D2D()

         end
         
      end
      
   end*/