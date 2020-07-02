//----------------------------------

//-----Banana Bomb-------

// ------------Updated by GHXX---------

//-----------Made by schnul44----

//----------------------------------





function round(num, numDecimalPlaces)

  local mult = 10^(numDecimalPlaces or 0)

  return math.floor(num * mult + 0.5) / mult

end



--TTT options:

if SERVER then

  --resource.AddFile("weapons/bananaicon")

SWEP.Kind = WEAPON_EQUIP1

SWEP.AutoSpawnable = false

SWEP.CanBuy = {ROLE_TRAITOR}

SWEP.LimitedStock = false

SWEP.HoldType = "melee";

SWEP.InLoadoutFor = nil

end

SWEP.Primary.NumShots = 0

SWEP.CanBuy = { ROLE_TRAITOR }

SWEP.DrawAmmo = true
SWEP.PrintName = "Banana Bomb"
if CLIENT then

  SWEP.Slot = 12



  SWEP.Icon = surface.GetTextureID("weapons/bananaicon");



  SWEP.EquipMenuData = {

    type = "item_weapon",

    name = "Banana Bomb",

    desc = "It smells fresh.\n\nLeft Click to throw,\nRight Click to make the good old squeeze Sound\n + Change Fuse Time"

  }

end

SWEP.IsGrenade = true

SWEP.Kind = WEAPON_EQUIP1;

SWEP.Base = "weapon_tttbase";

//if on server

if SERVER then

	

	//add the file

	AddCSLuaFile("shared.lua");

	SWEP.Icon = "weapons/bananaicon"

	//set the hold type

	SWEP.HoldType			= "melee";



end



//if on client

if CLIENT then

	//set some stuff

	SWEP.PrintName			= "Banana Bomb";

	SWEP.Author				= "GHXX";

	SWEP.Slot				= 3

	SWEP.SlotPos			= 1

	SWEP.Purpose			= "BOOOOM";

	SWEP.Instructions		= "Left Click: Throw Banana, Right Click: awesome Sound + Change Fuse Time";

	//set the category

	SWEP.Category			= "GHXXWeapons";

	SWEP.Icon = "weapons/bananaicon"

	//selection icon



	

	

	

	




end



warnflashcount = 64;

warnflashtime = 1.2;

baseFuseTime = 4;



if CLIENT then

fuseTime = baseFuseTime;

newFuse = true; 

end

if SERVER then

fuseTime = {};

newFuse = {};

end







//is it spawnable?

SWEP.Spawnable				= true;

SWEP.AdminSpawnable			= false;



//models

SWEP.ViewModel				= "models/weapons/v_banana.mdl";

SWEP.WorldModel				= "models/weapons/w_banana.mdl";



//more stuff

SWEP.Weight					= 25;

SWEP.AutoSwitchTo			= false;

SWEP.AutoSwitchFrom			= false;



//primary settings

SWEP.Primary =

{

	ClipSize				= 1,

	DefaultClip				= 1,

	Automatic				= false,

	Ammo					= "none"

}



//secondary settings

SWEP.Secondary =

{

	ClipSize				= 0,

	DefaultClip				= 0,

	Automatic				= false,

	Ammo					= "none"

}



SWEP.Sounds =

{

	Squeeze1 = Sound("weapons/bugbait/bugbait_squeeze1.wav"),

	Squeeze2 = Sound("weapons/bugbait/bugbait_squeeze2.wav"),

	Squeeze3 = Sound("weapons/bugbait/bugbait_squeeze3.wav")

}





if SERVER then



	//too many bananas can crash you

	SWEP.BananaLimit = CreateConVar("smod_bananalimit","30",FCVAR_NOTIFY);



end

if SERVER then

util.AddNetworkString( "smod_Banana_setFuseOnThrow" )



net.Receive("smod_Banana_setFuseOnThrow", function(len,ply)

	local fuseLength = net.ReadFloat();

	fuseTime[ply:SteamID64()] = fuseLength;

	--print("player "..ply:Nick().." ID: "..ply:SteamID64().." send me a new fuseValue: "..fuseLength);

end)

end



//on initialize

function SWEP:Initialize()



	//if on server

	if SERVER then

		//set the hold type

		--self:SetWeaponHoldType(self.HoldType);

	end

	

	--if CLIENT then

	--	print("[CLIENT] fusetimer was reset: old: "..fuseTime);

	--	fuseTime = baseFuseTime;

	--	newFuse = true;

	--	

	--	net.Start("smod_Banana_setFuseOnThrow")

	--	net.WriteFloat(fuseTime);				--notify the server that the value changed

	--	net.SendToServer();

	--end

	

end











//when we want to attack with the primary

function SWEP:PrimaryAttack()

	

	

	

	if SERVER then

		

		self.Owner.BananaList = self.Owner.BananaList or {};

		self.Owner.SpawnedBananas = self.Owner.SpawnedBananas or 0;

		

		if self.Owner.SpawnedBananas < self.BananaLimit:GetInt() then

		

			local Banana = ents.Create("smod_banana");



			if IsValid(Banana) then    --if ValidEntity(Banana) then



				Banana:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				Banana.BananaType = 1;

				Banana.Spawner = self.Owner;



				Banana:SetPos(self.Owner:GetShootPos());

				Banana:Spawn();

				Banana:Activate();

				----PrintMessage(HUD_PRINTTALK,"Test1");

				local Physics = Banana:GetPhysicsObject();



				if IsValid(Physics) then

					----PrintMessage(HUD_PRINTTALK,"Test2");

					Physics:ApplyForceCenter(self.Owner:GetAimVector() * math.Rand(500,800) * Physics:GetMass()*2);



					self.Weapon:SendWeaponAnim(ACT_VM_THROW);



					local function C()



						if IsValid(self.Weapon) then



							self.Weapon:SendWeaponAnim(ACT_VM_DRAW);

							--PrintMessage(HUD_PRINTTALK,"Test4");

						end



					end

					

					--PrintMessage(HUD_PRINTTALK,"Test3");

					

					timer.Simple(0.1,C);

					--print("calculated a delay of: "..warnflashtime*(1/warnflashcount));

					timer.Simple((fuseTime[self.Owner:SteamID64()] or baseFuseTime)-warnflashtime,function() timer.Create("smod_Banana_Flash",warnflashtime*(1/warnflashcount),warnflashcount,function() if Banana:IsValid() then Banana:SetColor(HSVToColor( CurTime()*360 %360,1,1)); end  end); end);

					timer.Simple(fuseTime[self.Owner:SteamID64()] or baseFuseTime,function() Banana:DoBananas(); end);   --replaced 3 with fuseTime

					--print("SERVER: Calculated a fusevalue of: "..(fuseTime[self.Owner:SteamID64()] or baseFuseTime));

					fuseTime[self.Owner:SteamID64()]=baseFuseTime; --resetFuseTime for player

					table.insert(self.Owner.BananaList,Banana);

					

					self.Owner.SpawnedBananas = self.Owner.SpawnedBananas + 1;

					

				else



					Banana:Remove();



				end



			end

			

		else

		

			self.Weapon:EmitSound(Sound("buttons/combine_button_locked.wav"));



		end

		self.Owner:StripWeapon( "weapon_banana" )

	end

		

	//delay the fire

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.14);

	self.Weapon:SetNextSecondaryFire(CurTime() + 1);

		

	if CLIENT then

		fuseTime = baseFuseTime;

		newFuse = true;

	end

	

	//return false

	return false;



end



function SWEP:SecondaryAttack()



	

	if SERVER then

	

		timer.Simple(0.3,

		function()



			--for I,B in pairs(self.Owner.BananaList or {}) do

--

	--			if IsValid(B) then

--

	--				timer.Simple(0.2 * I,B.DoBananas,B);

		--			

			--	end

			--	

			--	self.Owner.BananaList[I] = nil

			--	

			--	self.Owner.SpawnedBananas = self.Owner.SpawnedBananas - 1;



--			end

			

			self.Owner:EmitSound(self.Sounds["Squeeze"..math.random(1,3)]);

			self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK);



		end)



	end

	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK);

	//delay the fire

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.14);

	self.Weapon:SetNextSecondaryFire(CurTime() + 1);

	if newFuse and CLIENT then

		timer.Simple(0.7,function() newFuse = true; end);

		newFuse = false;   --prevent setting of fusetime again in this tick

		

		if fuseTime <= 0.125 then

			fuseTime = baseFuseTime

		else

			if fuseTime >= 2 and fuseTime < 8 then

				fuseTime = fuseTime-1;

			else

				fuseTime = fuseTime/2;

			end

		end

		net.Start("smod_Banana_setFuseOnThrow")

		net.WriteFloat(fuseTime);

		net.SendToServer();

	end

	//return false

	return false;



end

    

function SWEP:DrawHUD()





draw.DrawText( "Current First-Stage Fusetime: "..round(fuseTime,3) , "Trebuchet24", ScrW() * 0.5, ScrH() * 0.45, HSVToColor( CurTime()*360 %360,1,1), TEXT_ALIGN_CENTER )





end

	



function SWEP:Deploy()



	//run the deploy animation

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);

	--if true then

	--	fuseTime = baseFuseTime;

	--	newFuse = true;

	--end

	//and return

	return true;



end

//when we holster

function SWEP:Holster()

	//and return

	return true;



end

