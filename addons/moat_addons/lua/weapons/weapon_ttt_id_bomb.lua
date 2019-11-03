-- Identification Bomb





if SERVER then

   AddCSLuaFile( "weapon_ttt_id_bomb.lua" )

   util.AddNetworkString( "BombCall" )  -- Network strings to communicate between clients and server.

   util.AddNetworkString( "BombRemove" )

end



if CLIENT then

   SWEP.Slot      = 6

   SWEP.ViewModelFOV  = 54

   SWEP.ViewModelFlip = false

end


SWEP.PrintName = "Identification Bomb"


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

SWEP.CanBuy = { ROLE_TRAITOR }

SWEP.InLoadoutFor = nil

SWEP.LimitedStock = true

SWEP.DeploySpeed = 2

SWEP.AllowDrop = true

SWEP.IsSilent = true

SWEP.NoSights = true



-- Network-Hooks



hook.Add("IDBombPlanted", "BOMBUS", function( target )

	net.Start( "BombCall" )

	net.WriteEntity( target )

	net.Broadcast()

end)





hook.Add("IDBombFade", "RemoveBomb", function( rag )

	net.Start( "BombRemove" )

	net.WriteEntity( rag )

	net.Broadcast()

end)





if CLIENT then



	targets_final = {}



	net.Receive("BombRemove", function( len )

		table.RemoveByValue( targets_final, net.ReadEntity())



	end)



	net.Receive("BombCall", function( len )

		table.insert(targets_final, net.ReadEntity())

		

	end)





	hook.Add("PostDrawTranslucentRenderables", "BombIcon", function()

	local surface = surface

	local indicator_mat = Material("vgui/ttt/idbomb")

	local indicator_col = Color(255, 255, 255, 180)

	local client, pos, dir



	   client = LocalPlayer()

	   if client:GetTraitor() then



		  dir = client:GetForward() * -1



		  render.SetMaterial(indicator_mat)

			if #targets_final ~= 0 then

				  for i=1, #targets_final do

					if targets_final[i]:IsValid() == true then

						pos = targets_final[i]:GetPos()

						render.DrawQuadEasy(Vector(pos.x, pos.y, pos.z + 20), dir, 12, 12, indicator_col, 180)

					end

				  end

			end

	   end

	end)



end



if CLIENT then



   SWEP.Icon = "VGUI/ttt/icon_id_bomb2"



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = "Flagged corpse (Left-Click) will explode after identifying."

   };

   

end



-- Functions



function SetIDBomb(rag, bool)

	rag:SetNW2Bool("BOOL_ID_BOMB", bool)

end



function SetBombed(rag, state)

	rag:SetNW2Bool("BOOL_WAS_BOMBED", state)

end



function GetBombStatus(rag)

	return rag:GetNW2Bool("BOOL_ID_BOMB", false)

end



function WasBombed(rag)

	return rag:GetNW2Bool("BOOL_WAS_BOMBED", false)

end



hook.Add("TTTBodyFound", "NormalCorpseIdentified", function( ply, deadply, rag )

	if GetBombStatus(rag) == false then

		SetBombed(rag, true)

	end

end)





if SERVER then

/*   resource.AddFile("materials/VGUI/ttt/icon_id_bomb2.vmt")

   resource.AddFile("materials/VGUI/ttt/idbomb.vmt")*/



end





function SWEP:PrimaryAttack()



	local tr = self.Owner:GetEyeTrace()

	if tr.Entity.player_ragdoll and GetBombStatus(tr.Entity) == false and WasBombed(tr.Entity) == false then

		local target = tr.Entity

		owner = self.Owner

		SetIDBomb(target, true)

		hook.Call( "IDBombPlanted", GAMEMODE, target)		

		if (SERVER) then self:Remove() end

		self.Owner:ChatPrint("Identification Bomb successfully planted!")

		for k, ply in pairs( player.GetAll() ) do

			if ply:GetTraitor() then

				if player.GetByUniqueID(target.uqid) == false then

					ply:ChatPrint("Traitor Warning: The corpse of an NPC will explode after inspecting! (Fake-corpse)")

				else

					ply:ChatPrint("Traitor Warning: The corpse of " .. player.GetByUniqueID(target.uqid):Name() .. " will explode after inspecting!")

				end

		

			end

		end

					

	elseif tr.Entity.player_ragdoll and GetBombStatus(tr.Entity) == true then self.Owner:ChatPrint("This corpse is already attached to a bomb!")

	elseif tr.Entity.player_ragdoll and WasBombed(tr.Entity) == true then self.Owner:ChatPrint("Corpse was already identified!")

	end

	

end



hook.Add("TTTBodyFound", "ArmedBomb" , function( ply, deadply, rag )

	if GetBombStatus(rag) == true then 

		SetIDBomb(rag, false)

		SetBombed(rag, true)

		local explosion = ents.Create("env_explosion") explosion:SetOwner(owner) explosion:SetPos(rag:GetPos()) explosion:SetKeyValue("iMagnitude", "150") explosion:Spawn() explosion:Fire("explode","",0) explosion:Fire("kill","",0)

		hook.Call( "IDBombFade", GAMEMODE, rag)

	end	

end) 



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