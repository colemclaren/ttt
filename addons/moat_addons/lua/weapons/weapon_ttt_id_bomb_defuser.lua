-- Identification Bomb



if SERVER then

   AddCSLuaFile( "weapon_ttt_id_bomb_defuser.lua" )

end



if CLIENT then

   include("weapon_ttt_id_bomb.lua")

   SWEP.Slot      = 6



   SWEP.ViewModelFOV  = 54

   SWEP.ViewModelFlip = false

end


SWEP.PrintName = "Identification Bomb Defuser"


SWEP.Base				= "weapon_tttbase"



SWEP.HoldType			= "knife"



SWEP.Primary.Delay       = 0.3

SWEP.Primary.Automatic   = false

SWEP.Primary.Damage      = 0

SWEP.Primary.Ammo        = "none"

SWEP.Primary.ClipSize    = -1

SWEP.Primary.DefaultClip = -1

SWEP.DrawCrosshair       = false



SWEP.Secondary.Delay     = 1.1

SWEP.Secondary.Automatic = true

SWEP.Secondary.Damage     = 0

SWEP.Secondary.Ammo      = "none"

SWEP.Secondary.ClipSize  = -1

SWEP.Secondary.Defaultclip = -1



SWEP.ViewModel  = "models/weapons/v_knife_t.mdl"

SWEP.WorldModel = "models/weapons/w_knife_t.mdl"



SWEP.Kind = WEAPON_EQUIP

SWEP.AutoSpawnable = false

SWEP.CanBuy = { ROLE_DETECTIVE }

SWEP.InLoadoutFor = nil

SWEP.LimitedStock = true

SWEP.DeploySpeed = 2

SWEP.AllowDrop = true

SWEP.IsSilent = true

SWEP.NoSights = true



if CLIENT then



   SWEP.Icon = "VGUI/ttt/icon_id_bomb_def"



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = "Left-click an ID-bombed corpse to defuse the bomb!"

   };

end



if SERVER then

//   resource.AddFile("VGUI/ttt/icon_id_bomb_def.vmt")

end





function SetIDBomb(rag, bool)

	rag:SetNW2Bool("BOOL_ID_BOMB", bool)

end





function GetBombStatus(rag)

	return rag:GetNW2Bool("BOOL_ID_BOMB", false)

end



function SWEP:PrimaryAttack()

	local tr = self.Owner:GetEyeTrace()

	if tr.Entity.player_ragdoll then

		if GetBombStatus(tr.Entity) == true then

			SetIDBomb(tr.Entity, false)

			self.Owner:ChatPrint("Identification Bomb successfully defused!")

			if (SERVER) then self:Remove() end

			hook.Call("IDBombFade", GAMEMODE, tr.Entity)

		end

	end

end



function SWEP:SecondaryAttack()

end



function SWEP:PreDrop()

   self.fingerprints = {}

end



function SWEP:OnRemove()

   if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then

      RunConsoleCommand("lastinv")

   end

end