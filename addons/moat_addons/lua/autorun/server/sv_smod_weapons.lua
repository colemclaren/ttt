//----------------------------------

//----Some 'restrict' script--------

//-----------Made by Schnul44----

//------------Updated BY GHXX

//----------------------------------

//---Part of the SMOD Weapons Pack--

//----------------------------------



smod = smod or {};



smod.Info =

{

	Name = "Banana Bomb",

	Author = "GHXX, Schnul44",

	Version = 1.0,

	Description = "Adds a Banana Bomb"

}



smod.Weapons =

{

	

	"weapon_banana",

	

}



smod.Resources = string.Explode("\n",file.Read("smod_resource_manifest.txt") or "") or {};



for _,File in pairs(smod.Resources) do



	string.Replace(File,"\\","/");



	if file.Exists("../",File) then



		--resource.AddFile(File);



	end



end



CreateConVar("smod_adminonly","0",{FCVAR_NOTIFY , FCVAR_ARCHIVE}); --CreateConVar("smod_adminonly","0",FCVAR_NOTIFY | FCVAR_ARCHIVE);



local SVal = GetConVarNumber("smod_adminonly");



function smod.RestrictPickup(Player,Weapon)



	if GetConVarNumber("smod_adminonly") then



		if IsValid(Player) && IsValid(Weapon) then



			if table.HasValue(smod.Weapons,Weapon:GetClass()) then



				--if !Player:IsAdmin() then



				--	return false;



				--end



			end



		end



	end



end

hook.Add("PlayerCanPickupWeapon","smod.RestrictPickup",smod.RestrictPickup);



function smod.Think()



	local CVal = GetConVarNumber("smod_adminonly");



	if CVal != SVal then



		local Text = "";



		if CVal == 1 then



			Text = "";



		end



		for _,Player in pairs(player.GetAll()) do



			Player:ChatPrint(Text);



		end



		SVal = CVal;



	end



end

hook.Add("Think","smod.Think",smod.Think);