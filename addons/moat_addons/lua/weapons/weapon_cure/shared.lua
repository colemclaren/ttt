AddCSLuaFile()



if SERVER then

//   resource.AddFile("materials/vgui/ttt/icon_cure.vmt")

end



SWEP.Author 				= "jmoak3"

SWEP.Contact 				= "mrjmoak3@gmail.com"

SWEP.Purpose 				= "A cure for the Biohazard Ball's infection"

SWEP.Instructions 			= "Left-Click to throw the Cure"

	

SWEP.Spawnable 				= false

SWEP.UseHands 				= false



SWEP.ViewModel 				= "models/weapons/v_bugbait.mdl"

SWEP.WorldModel				= "models/weapons/w_bugbait.mdl"



SWEP.HoldType = "grenade"

SWEP.Primary.NumberofShots 	= 1

SWEP.Primary.ClipSize 		= 1

SWEP.Primary.DefaultClip	= 1

SWEP.DrawAmmo			= true



SWEP.Base				= "weapon_tttbase"

SWEP.LimitedStock = false

SWEP.CanBuy = { ROLE_DETECTIVE }

SWEP.AllowDrop = true

SWEP.Kind = WEAPON_EQUIP1

SWEP.ViewModelFlip = true

SWEP.ViewModelFOV  = 72





SWEP.Category 				= "jmoak3"



SWEP.EquipMenuData = {

   type = "item_weapon",

   desc = "A Cure that reverts the \ninfection caused by the BioBall \nor zombie!"

};



SWEP.DrawCrosshair = false

SWEP.Primary.Ammo 			= ""



SWEP.Secondary.ClipSize 	= -1

SWEP.Secondary.DefaultClip	= -1

SWEP.Secondary.Automatic	= false

SWEP.Secondary.Ammo			= "none"



SWEP.PrintName 				= "Cure"

SWEP.Slot					= 6



SWEP.Icon = "vgui/ttt/icon_cure"



local testing = false



function SWEP:Initialize()

	self:SetWeaponHoldType(self.HoldType)

	self.CanFire = true

end





function SWEP:Reload()

end



function SWEP:Think()

	

end



function SWEP:Throw()

	if (!SERVER) then return end

	

	self:ShootEffects()

	self.BaseClass.ShootEffects(self)

	

	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

	self.CanFire = false

	

	local ent = ents.Create("sent_cure")

	

	timer.Create("CureFireTimer", 1, 1, function()

						self.CanFire = true

						self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

						self:Remove()

						end) 

	

	ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector()* 16))

	ent:SetAngles(self.Owner:EyeAngles())

	ent:SetColor(Color(0, 0, 255))

	ent:Spawn()

	

	local phys = ent:GetPhysicsObject()

	

	if !(phys && IsValid(phys)) then ent:Remove() return end

	

	phys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() * 1300)

	

end



function SWEP:PrimaryAttack()

	if (self.CanFire) then

		self:Throw()

	end

end



function SWEP:SecondaryAttack()

	local plyr = self.Owner

	if (plyr != nil && plyr != NULL && plyr != null) then

	

		if (plyr:IsPlayer()) then

			if (timer.Exists("InfectionTimer"..plyr:GetName().."")) then

				timer.Destroy("InfectionTimer"..plyr:GetName().."")

				CustomMsg(plyr, "YOU HAVE BEEN CURED AND FORGET WHO THE TRAITORS ARE!!", Color(0, 255, 0))
			end

			

			if (timer.Exists("ShakeTimer"..plyr:GetName().."")) then

				timer.Destroy("ShakeTimer"..plyr:GetName().."")

			end

			

			if (InfectConfig.PZ && plyr:GetActiveWeapon():IsValid() && plyr:GetActiveWeapon():GetClass() == "weapon_zombie") then

				local pos = plyr:GetPos()

				plyr:SetRole(ROLE_INNOCENT)

				plyr:Spawn()

				plyr:StripAll()

				plyr:Give("weapon_crowbar")

				--plyr:EmitSound("npc/zombie/zo_attack"..math.random(1,2)..".wav")

				--plyr:SetModel("models/player/zombie_classic.mdl")

				plyr:SetPos(pos)

				plyr:SelectWeapon("weapon_crowbar")

				plyr:SetHealth(100)

				CustomMsg(plyr, "YOU ARE NOW A HUMAN AND FORGET WHO THE TRAITORS ARE!!", Color(0, 255, 0))

				SendFullStateUpdate()

			end

		end

		

	end

end









