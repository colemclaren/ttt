

AddCSLuaFile()



SWEP.HoldType = "unarmed"

SWEP.PrintName    = "DNA Eradicator"

if CLIENT then

   SWEP.Slot         = 6

   SWEP.ViewModelFOV = 0





   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = "Failing to remove ONE piece of DNA? Want to frame someone else? This will do that!\n\nBe careful though, you could be that ANYone."

   };



   SWEP.Icon = "vgui/ttt/icon_cust_dna.png"

   SWEP.IconLetter = "j"

end



SWEP.Base               = "weapon_tttbase"



SWEP.UseHands			= true

SWEP.ViewModelFlip		= false



SWEP.ViewModel = "models/weapons/v_crowbar.mdl"

SWEP.WorldModel = "models/weapons/w_defuser.mdl"



SWEP.DrawCrosshair      = false

SWEP.Primary.Damage         = 50

SWEP.Primary.ClipSize       = -1

SWEP.Primary.DefaultClip    = -1

SWEP.Primary.Automatic      = true

SWEP.Primary.Delay = 1.1

SWEP.Primary.Ammo       = "none"

SWEP.Secondary.ClipSize     = -1

SWEP.Secondary.DefaultClip  = -1

SWEP.Secondary.Automatic    = true

SWEP.Secondary.Ammo     = "none"

SWEP.Secondary.Delay = 1.4



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy

SWEP.LimitedStock = true -- only buyable once

SWEP.WeaponID = AMMO_FINGER



SWEP.IsSilent = true



-- Pull out faster than standard guns

SWEP.DeploySpeed = 2

SWEP.Done = false

function SWEP:Initialize()
    if CLIENT then self:AddHUDHelp("Primary Attack: Removes ALL DNA from a corpse.", "Secondary Attack: Changes the DNA to ANY person.", false) end
end

function SWEP:PrimaryAttack()

   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

   if self.Done then return end





   if not IsValid(self.Owner) then return end



   self.Owner:LagCompensation(true)



   local spos = self.Owner:GetShootPos()

   local sdest = spos + (self.Owner:GetAimVector() * 70)



   local kmins = Vector(1,1,1) * -10

   local kmaxs = Vector(1,1,1) * 10



   local tr = util.TraceHull({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL, mins=kmins, maxs=kmaxs})



   -- Hull might hit environment stuff that line does not hit

   if not IsValid(tr.Entity) then

      tr = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL})

   end



   local hitEnt = tr.Entity



  

  if !IsValid(tr.Entity) or (IsValid(tr.Entity) and tr.Entity:GetClass() != "prop_ragdoll") then return end

  	if SERVER and !tr.Entity.killer_sample then

  		if CLIENT then

			chat.AddText(Color(255,0,0), "[TTT] ", Color(255,255,255), "DNA already removed!")

		end

		return

  	end





	if CLIENT then

		chat.AddText(Color(255,0,0), "[TTT] ", Color(255,255,255), "DNA removed!")

	end

	if SERVER then

		DamageLog("DNA: ".. self.Owner:Nick() .. " removed the DNA on ".. (tr.Entity.killer_sample.victim and tr.Entity.killer_sample.victim:Nick() or "UNKNOWN").."'s corpse")

    end

     	if SERVER then

   		tr.Entity.killer_sample = nil

	end

   self.Owner:LagCompensation(false)

   self.Done = true

   if (SERVER) then self:Remove() end

end







function SWEP:SecondaryAttack()

   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

   if self.Done then return end

   local spos = self.Owner:GetShootPos()

   local sdest = spos + (self.Owner:GetAimVector() * 70)



   local kmins = Vector(1,1,1) * -10

   local kmaxs = Vector(1,1,1) * 10



   local tr = util.TraceHull({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL, mins=kmins, maxs=kmaxs})



   -- Hull might hit environment stuff that line does not hit

   if not IsValid(tr.Entity) then

      tr = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL})

   end



   local hitEnt = tr.Entity



  

 	if !IsValid(tr.Entity) or tr.Entity:GetClass() != "prop_ragdoll" then return end



  	if SERVER and tr.Entity.killer_sample == nil then

  		if CLIENT then

			chat.AddText(Color(255,0,0), "[TTT] ", Color(255,255,255), "No DNA to change!")

		end

		return 

  	end



  	local targ = table.Random(player.GetAll())

  	if SERVER then

  		tr.Entity.killer_sample.killer = targ

  		tr.Entity.killer_sample.killer_uid = targ:UniqueID()



  		PrintTable(tr.Entity.killer_sample)

  		print(targ:Nick())

  	end



	if CLIENT then

		chat.AddText(Color(255,0,0), "[TTT] ", Color(255,255,255), "DNA changed!")

	end

	if SERVER then

		DamageLog("DNA: ".. self.Owner:Nick() .. " changed the DNA on ".. (tr.Entity.killer_sample.victim and tr.Entity.killer_sample.victim:Nick() or "UNKNOWN").."'s corpse to ".. (targ and targ:Nick() or "UNKNOWN"))

    end

    if (SERVER) then self:Remove() end

    self.Done = true

end



function SWEP:Equip()

   self.Weapon:SetNextPrimaryFire( CurTime() + (self.Primary.Delay * 1.5) )

   self.Weapon:SetNextSecondaryFire( CurTime() + (self.Secondary.Delay * 1.5) )

end





function SWEP:OnRemove()

   if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then

      RunConsoleCommand("lastinv")

   end

end



if CLIENT then

   function SWEP:DrawHUD()

      local tr = self.Owner:GetEyeTrace(MASK_SHOT)



      if tr.HitNonWorld and IsValid(tr.Entity) and tr.Entity:GetClass() == "prop_ragdoll" then



         local x = ScrW() / 2.0

         local y = ScrH() / 2.0



         surface.SetDrawColor(255, 0, 0, 255)



         local outer = 20

         local inner = 10

         surface.DrawLine(x - outer, y - outer, x - inner, y - inner)

         surface.DrawLine(x + outer, y + outer, x + inner, y + inner)



         surface.DrawLine(x - outer, y + outer, x - inner, y + inner)

         surface.DrawLine(x + outer, y - outer, x + inner, y - inner)



         draw.SimpleText([[REMOVE ALL (MOUSE1)]], "TabLarge", x, y - 30, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

         draw.SimpleText([[PLACE RANDOM (MOUSE2)]], "TabLarge", x, y, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

      end



      return self.BaseClass.DrawHUD(self)

   end

end





