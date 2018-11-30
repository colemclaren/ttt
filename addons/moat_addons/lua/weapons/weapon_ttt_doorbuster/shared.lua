local detectiveEnabled = CreateConVar("ttt_doorbuster_detective", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Should Detectives be able to buy the Door Buster?")

local traitorEnabled = CreateConVar("ttt_doorbuster_traitor", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Should Traitors be able to buy the Door Buster?")



if (SERVER) then

	--resource.AddWorkshop("621565420")

	AddCSLuaFile()

	SWEP.Weight				= 5

	SWEP.AutoSwitchTo		= false

	SWEP.AutoSwitchFrom		= false		

	local PLAYER = FindMetaTable("Player")

	util.AddNetworkString( "ColoredMessage" )	

	function BroadcastMsg(...)

		local args = {...}

		net.Start("ColoredMessage")

		net.WriteTable(args)

		net.Broadcast()

	end



	function PLAYER:PlayerMsg(...)

		local args = {...}

		net.Start("ColoredMessage")

		net.WriteTable(args)

		net.Send(self)

	end	

end

SWEP.PrintName			= "Door Buster"

if ( CLIENT ) then



	SWEP.DrawAmmo			= true

	SWEP.ViewModelFOV		= 64

	SWEP.ViewModelFlip		= false

	SWEP.CSMuzzleFlashes	= false

	

	
	
	SWEP.Author				= "dante vi almark"

	SWEP.Slot				= 6

	SWEP.SlotPos			= 11

   SWEP.Icon = "VGUI/ttt/icon_doorbust"

   SWEP.EquipMenuData = {

   type = "Weapon",

   desc = "Placeable on doors. \nRight-Click to Explode the Door \nexplode and kill everyone on its way."

};



	net.Receive("ColoredMessage",function(len) 

		local msg = net.ReadTable()

		chat.AddText(unpack(msg))

		chat.PlaySound()

	end)

end

SWEP.ValidDoors = {"func_door","func_door_rotating","prop_door_rotating"}



SWEP.Author			= "-Kenny-"

SWEP.Contact		= ""

SWEP.Purpose		= ""

SWEP.Instructions	= "Place on Door"



//GeneralSettings\\

SWEP.Base				= "weapon_tttbase"

SWEP.AutoSpawnable = !detectiveEnabled:GetBool() and !traitorEnabled:GetBool()

SWEP.AdminSpawnable = true

SWEP.AutoSwitchTo = false

SWEP.AutoSwitchFrom = false

SWEP.Kind = !detectiveEnabled:GetBool() and !traitorEnabled:GetBool() and WEAPON_NADE or WEAPON_EQUIP1

SWEP.HoldType			= "slam"





SWEP.Spawnable			= false

SWEP.AdminSpawnable		= true



SWEP.ViewModel			= "models/weapons/v_c4.mdl"

SWEP.WorldModel			= "models/weapons/w_c4.mdl"





SWEP.Primary.Recoil			= 0

SWEP.Primary.Damage			= -1

SWEP.Primary.NumShots		= 1

SWEP.Primary.Cone			= 0

SWEP.Primary.Delay			= 1

SWEP.Primary.ClipSize		= 2

SWEP.Primary.DefaultClip	= 2

SWEP.Primary.Automatic		= false

SWEP.Primary.Ammo			= "slam"

SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}

SWEP.LimitedStock = false

SWEP.Secondary.ClipSize     = -1

SWEP.Secondary.DefaultClip  = -1

SWEP.Secondary.Automatic    = true

SWEP.Secondary.Ammo     = "none"

SWEP.Secondary.Delay = 2



function SWEP:Initialize()

	self:SetWeaponHoldType(self.HoldType)

	util.PrecacheSound("weapons/gamefreak/beep.wav")

	util.PrecacheSound("weapons/c4/c4_plant.wav")

	util.PrecacheSound("weapons/gamefreak/johncena.wav")

	self:SetMaterial("c4_green/w/c4_green")

end



/*function SWEP:Deploy()

	if SERVER then self:CallOnClient("Deploy","") end

	self.Owner:GetViewModel():SetSubMaterial(1,"c4_green/v/c4_green")

return true

end*/



/*function SWEP:PreDrop()

	if IsValid(self.Owner) then self.Owner:GetViewModel():SetSubMaterial(1,"") end

	return true

end*/





function SWEP:Plant()

	if not SERVER then return end 

	local tr = self.Owner:GetEyeTrace()

	local angle = tr.HitNormal:Angle()

    local bomb = ents.Create("entity_doorbuster")

    bomb:SetPos(tr.HitPos)

	bomb:SetAngles(angle+Angle(-90,0,180))

    bomb:Spawn()

	bomb:EmitSound("weapons/c4/c4_plant.wav")

	bomb:EmitSound("weapons/gamefreak/beep.wav")

	bomb.Owner = self.Owner

	bomb:SetParent(tr.Entity)

	bomb:SetCollisionGroup(1)

	self.DoorBombs = self.DoorBombs or {}

	table.insert(self.DoorBombs,bomb)

	self:TakePrimaryAmmo(1)

	local ply = self.Owner

	

end





function SWEP:CanPrimaryAttack()

    local tr = self.Owner:GetEyeTrace()

	local hitpos = tr.HitPos

	local dist = self.Owner:GetShootPos():Distance(hitpos)

	local InWorld = true;

	if SERVER then

		InWorld = util.IsInWorld(tr.HitNormal*-50 + tr.HitPos)

	end

	return tr.Entity and table.HasValue(self.ValidDoors,tr.Entity:GetClass()) and dist<60 and self.Weapon:Clip1() > 0 and InWorld

end





function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end

	if (self.Weapon:Clip1() <= 0) then return end

	self.Weapon:Plant()

	if SERVER then

		self.Owner:PlayerMsg("Door Buster: ", COLOR_WHITE, "Door Buster placed.")

	end

end







function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire(CurTime()+self.Secondary.Delay)

	if not self.DoorBombs then self.DoorBombs = {} end

	if table.Count(self.DoorBombs) > 0 then

		for k, v in pairs(self.DoorBombs) do

			if v:IsValid() then

				v:BlowDoor()

			end

		end

		if SERVER then

			self.Owner:PlayerMsg("Door Buster: ", COLOR_WHITE, "Door(s) exploded.")

		end

		if (SERVER and self.Weapon:Clip1() <= 0) then

			self:Remove()

		end

	end

end