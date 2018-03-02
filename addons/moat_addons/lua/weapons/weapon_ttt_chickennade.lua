if SERVER then

	AddCSLuaFile()

/*	resource.AddFile("materials/vgui/ttt/icon_chicken.png")	

	resource.AddFile("materials/models/weapons/v_models/eggnade/egg.vmt")

	resource.AddFile("materials/models/weapons/w_models/eggnade/egg.vmt")

	resource.AddFile("models/weapons/v_chickeneggnade.mdl")

	resource.AddFile("models/weapons/w_chickeneggnade.mdl")

	resource.AddFile("models/weapons/w_chickeneggnade_thrown.mdl")

	resource.AddFile("sound/chicken/attack1.wav")

	resource.AddFile("sound/chicken/attack2.wav")

	resource.AddFile("sound/chicken/idle1.wav")

	resource.AddFile("sound/chicken/idle2.wav")

	resource.AddFile("sound/chicken/idle3.wav")

	resource.AddFile("sound/chicken/pain1.wav")

	resource.AddFile("sound/chicken/pain2.wav")

	resource.AddFile("sound/chicken/pain3.wav")

	resource.AddFile("sound/chicken/alert.wav")

	resource.AddFile("sound/chicken/death.wav")

	resource.AddFile("sound/chicken/charge.wav")

	resource.AddFile("models/lduke/chicken/chicken3.mdl")

	resource.AddFile("materials/models/lduke/chicken/chicken2.vmt")

	resource.AddFile("materials/particles/feather.vmt")
*/
end



SWEP.HoldType			= "grenade"



SWEP.PrintName			= "Chicken Egg"	



if CLIENT then	



	SWEP.ViewModelFlip		= true



	SWEP.Slot				= 6

	SWEP.SlotPos			= 0

	

	

	SWEP.Author				= "Created by Phoenixf129 and reworked by BocciardoLight"

	SWEP.Contact			= ""

	SWEP.Purpose			= "A chicken dispenser"

	SWEP.Instructions		= "Hold primary fire to throw chickens."

	

	   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = [[An aggressive chicken! Piss it off too much and it explodes!]]

    };



SWEP.Icon = "VGUI/ttt/icon_chicken.png"



end



SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = { ROLE_TRAITOR }

SWEP.LimitedStock = false

SWEP.WeaponID = AMMO_CHICKENEGG



SWEP.NoSights = true



SWEP.Spawnable				= false

SWEP.AdminSpawnable			= true



SWEP.ViewModel				= "models/weapons/v_chickeneggnade.mdl"

SWEP.WorldModel				= "models/weapons/w_chickeneggnade.mdl"



SWEP.Primary.Sound			= ""

SWEP.Primary.Damage			= 1

SWEP.Primary.NumShots		= 1

SWEP.Primary.Delay			= 0

SWEP.Primary.Cone			= 0

SWEP.Primary.Recoil			= 0.001



SWEP.Primary.ClipSize		= 1

SWEP.Primary.DefaultClip	= 1

SWEP.Primary.Automatic		= true

SWEP.Primary.Ammo			= "Grenade"



SWEP.Secondary.ClipSize		= -1

SWEP.Secondary.DefaultClip	= -1

SWEP.Secondary.Automatic	= false

SWEP.Secondary.Ammo			= "none"





function SWEP:Initialize()



	if SERVER then

		self:SetWeaponHoldType( self.HoldType )

	end

	

	self.Attacking = false

	

end





function SWEP:PrimaryAttack()



	self.Attacking = false

	

	if not self.Attacking then

	

		self:SetNextPrimaryFire( CurTime() + 1 )

		self:SendWeaponAnim( ACT_VM_PULLPIN )

		

		self.Attacking = true

		

	end

	

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	

	self:SendWeaponAnim( ACT_VM_THROW )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	

	self:TakePrimaryAmmo( 1 )

	

	if not SERVER then return end

	

	local plrang = self.Owner:EyeAngles()

	local muzzlepos = self.Owner:GetShootPos() + plrang:Right() * 5 - plrang:Up() * 7

	local muzzleforward = ( util.TraceLine( util.GetPlayerTrace( self.Owner ) ).HitPos - muzzlepos ):GetNormalized()

	

	local egg = ents.Create( "sent_chicken_agg" )

	egg:SetPos( muzzlepos + muzzleforward * 5 )

	egg:SetAngles( ( muzzleforward + VectorRand() * 0.4 ):Angle() )

	egg:SetOwner( self.Owner )

	egg:Spawn()

	egg:Activate()

	

	local eggphys = egg:GetPhysicsObject()

	if eggphys:IsValid() then

		eggphys:AddVelocity( muzzleforward * 500 )

		eggphys:AddAngleVelocity( VectorRand() * 200 )

	end

	

	if self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 then

		self.Owner:StripWeapon("weapon_ttt_chickennade")

	end

	

end





function SWEP:SecondaryAttack()





end





function SWEP:Think()



	if self.Attacking and self.Owner:KeyReleased( IN_ATTACK ) then

	

		if self:Ammo1() > 0 then 

			self:SendWeaponAnim( ACT_VM_DRAW )

		end

		

		self.Attacking = false

		

	end



end





function SWEP:Reload()



	return false

	

end





function SWEP:Deploy()



	self:SendWeaponAnim( ACT_VM_DRAW )

	

	return true



end

