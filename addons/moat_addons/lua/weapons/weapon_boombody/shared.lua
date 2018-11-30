if SERVER then

   AddCSLuaFile( "shared.lua" )

end



SWEP.HoldType = "slam"



----------Basic SWEP Stuff----------

SWEP.Base = "weapon_tttbase"

SWEP.UseHands			= true

SWEP.ViewModelFlip		= false

SWEP.ViewModelFOV		= 54

SWEP.ViewModel  = Model("models/weapons/cstrike/c_c4.mdl")

SWEP.WorldModel = Model("models/weapons/w_c4.mdl")

SWEP.NoSights = true



SWEP.DrawCrosshair      = false

SWEP.ViewModelFlip      = false

SWEP.Primary.ClipSize       = 1

SWEP.Primary.DefaultClip    = 1

SWEP.Primary.Automatic      = true

SWEP.Primary.Ammo       = "none"

SWEP.Primary.Delay = 5.0

----------END Basic SWEP Stuff----------





----------TTT Stuff----------

SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = { ROLE_TRAITOR }


SWEP.PrintName 	= "Boom Body"
if CLIENT then

   SWEP.Slot		= 6



   SWEP.EquipMenuData = {

      type  = "Explosive Body",

      name  = "Boom Body",

      desc  = "Spawns an explosive body."

   };



   SWEP.Icon = "vgui/ttt/icon_boombody.png"

end

----------END TTT Stuff----------



throwsound = Sound( "Weapon_SLAM.SatchelThrow" )



function SWEP:PrimaryAttack()

	if SERVER then

		if self:CanPrimaryAttack() then

			self:TakePrimaryAmmo(1)

			self:SpawnExplosiveBody()

		end

	end

end



function SWEP:SecondaryAttack()

end



function SWEP:SpawnExplosiveBody()

	local dmg = DamageInfo()

	

	local ply = table.Random(player.GetAll());

	

	dmg:SetAttacker(ply)

	dmg:SetInflictor(ply)

	dmg:SetDamage(10)

	dmg:SetDamageType( DMG_BULLET ) 

	

	corpse = CORPSE.Create(self.Owner, ply, dmg)

    CORPSE.SetCredits(corpse, 0)

    corpse.killer_sample = nil

    self.Weapon:EmitSound(throwsound)

    self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

   

    local corpse_owner = self.Owner
    corpse.ExplosiveCorpse = corpse_owner

	corpse_owner:StripWeapon("weapon_boombody")
	corpse_owner:ConCommand("use weapon_ttt_unarmed")
end



function SWEP:Reload()

   return false

end