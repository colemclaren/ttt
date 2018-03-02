if SERVER then

   AddCSLuaFile( "shared.lua" )

//   resource.AddFile("materials/VGUI/ttt/lykrast/icon_minifier.vmt")

end



if( CLIENT ) then

    SWEP.PrintName = "Minifier";

    SWEP.Slot = 7;

    SWEP.DrawAmmo = false;

    SWEP.DrawCrosshair = false;

    SWEP.Icon = "VGUI/ttt/lykrast/icon_minifier";

 

   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = "Activate it to become smaller but more vulnerable.\n\nSets your max health to 100. Sets it to 50 when mini."

   };



end



SWEP.Author= "Lykrast"





SWEP.Base = "weapon_tttbase"

SWEP.Spawnable= false

SWEP.AdminSpawnable= true

SWEP.HoldType = "slam"

 

SWEP.Kind = WEAPON_EQUIP2

SWEP.CanBuy = {nil}

 

SWEP.ViewModelFOV= 60

SWEP.ViewModelFlip= false

SWEP.ViewModel      = "models/weapons/c_slam.mdl"

SWEP.WorldModel      = "models/weapons/w_slam.mdl"

SWEP.UseHands	= true

 

 --- PRIMARY FIRE ---

SWEP.Primary.Delay= 1

SWEP.Primary.Recoil= 0

SWEP.Primary.Damage= 0

SWEP.Primary.NumShots= 1

SWEP.Primary.Cone= 0

SWEP.Primary.ClipSize= -1

SWEP.Primary.DefaultClip= -1

SWEP.Primary.Automatic   = false

SWEP.Primary.Ammo         = "none"

SWEP.NoSights = true

SWEP.AllowDrop = false

function SWEP:SetupDataTables()
end

function SWEP:Initialize()
  self.minified = false
end

function SWEP:Minify()
    self.Owner:SetNW2Bool("minified", true)

    self.Owner:SetModelScale( 0.5, 1 )

    if SERVER then
      self.Owner:SetMaxHealth( 50 )
      self.Owner:SetCollisionGroup(COLLISION_GROUP_WEAPON)

      net.Start("MOAT_PLAYER_CLOAKED")
      net.WriteEntity(self.Owner)
      net.WriteBool(true)
      net.Broadcast()
    end --beevis said so

    self.Owner:SetHealth( self.Owner:Health( ) * 0.5 )

    self.minified = true

end



function SWEP:UnMinify()
    self.Owner:SetNW2Bool("minified", false)

    self.Owner:SetModelScale( 1, 1 )

    if SERVER then
      self.Owner:SetMaxHealth( 100 )
      self.Owner:SetCollisionGroup(COLLISION_GROUP_PLAYER)
      
      net.Start("MOAT_PLAYER_CLOAKED")
      net.WriteEntity(self.Owner)
      net.WriteBool(false)
      net.Broadcast()
    end --beevis said so

    self.Owner:SetHealth( self.Owner:Health() * 2 )

    self.minified = false

end

function SWEP:PrimaryAttack()



self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )



if ( self.minified ) then

    self:UnMinify()

else

    self:Minify()

end



end

/*
function SWEP:CalcView(pl, pos, ang, fov)
  if (self.Owner:GetNW2Bool("minified", false)) then
    pos = pos - Vector(0, 0, 24)
    return pos, ang, fov
  end
end

function SWEP:CalcViewModelView(vm, opos, oang, pos, ang)
  if (self.Owner:GetNW2Bool("minified", false)) then
    pos = pos - Vector(0, 0, 24)
    return pos, ang
  end
end
*/

function SWEP:PreDrop()

if ( self.minified ) then
    self:UnMinify()
end

end

function SWEP:OnDrop()
   self:Remove()
end



hook.Add("TTTPrepareRound", "UnMinifyAll",function()
    for k, v in ipairs(player.GetAll()) do
        v:SetModelScale(1)
	     v.minified = false
       v:SetNW2Bool("minified", false)
    end
end)

if (CLIENT) then
  hook.Add("CalcView", "MinifyCalcView", function(ply, pos, angles, fov)
    if (ply:GetNW2Bool("minified", false)) then
      local view = {}
      view.origin = pos - Vector(0, 0, 20)
      view.angles = angles
      view.fov = fov

      return view
    end
  end)

  local LP

  hook.Add("Think", "Initialize LP CalcView", function()
    if (IsValid(LocalPlayer())) then LP = LocalPlayer() hook.Remove("Think", "Initialize LP CalcView") end
  end)

  hook.Add("CalcViewModelView", "MinifyCalcView", function(wep, vm, oldpos, oldang, pos, ang)
    if (LP and IsValid(LP) and LP:GetNW2Bool("minified", false)) then
      pos = pos - Vector(0, 0, 20)
      return pos, ang
    end
  end)
end