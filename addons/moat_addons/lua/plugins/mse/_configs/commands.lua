--[[-------------------------------------------------------------------------
MSE.Commands.Register "Example Name" -- The name of the minigame
	:SetCommand "start_example_minigame" -- Command for console to run
	:SetDescription "Example description" -- Description for the minigame
	:SetMaxPlayers "4" -- Maximum of players that must be out of spectator to start the minigame
	:WhitelistRanks "superadmin, admin, trialstaff" -- Seperate each rank with a comma
	:RankBlacklist() -- Turns the rank whitelist into a blacklist instead
	:WhitelistMaps "ttt_canyon_a4, ttt_clue_se" -- Seperate each map with a comma
	:MapBlacklist() -- Turns the map whitelist into a blacklist instead
	:CommandArguments({
		-- table of functions for the command arguments,
			return true/false if the argument is needed,
			return a string for the label in the menu,
			return a table that the user can choose from
		function(pl) return {} end,
		function(pl) return {} end,
	})


---------------------------------------------------------------------------]]


MSE.Commands.Register "Boss Round"
	:SetCommand "moat_start_boss"
	:SetDescription "Team up with every player to defeat the boss for a prize!"
	:SetMinPlayers "8"
	:CommandArguments({
		function(pl)
			local ids = {"self", "random"}

			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(ids, v:SteamID())
				end
			end

			if (CLIENT and (not LocalPlayer():GetDataVar("EC") or (LocalPlayer():GetDataVar("EC") and LocalPlayer():GetDataVar("EC") < 1)) and MSE.Config.Staff[LocalPlayer():GetUserGroup()]) then
				ids = {"random"}
			end

			return "Select Player", true, ids
		end,
		function(pl)
			local wpns = {}
			local n = 1
			
			for k, v in pairs(weapons.GetList()) do
				if (v.Kind ~= WEAPON_HEAVY and v.Kind ~= WEAPON_PISTOL) then continue end
				if (v.Base ~= "weapon_tttbase" or v.ClassName:find("_oc") or not v.AutoSpawnable) then continue end

				wpns[n] = v.ClassName
				n = n + 1
			end

			return "Select Weapon", false, wpns
		end
	})

MSE.Commands.Register "Contagion Round"
	:SetCommand "moat_start_contagion"
	:SetDescription "Hide and kill the contagion to be the last survivor!"
	:SetMinPlayers "8"

MSE.Commands.Register "Gun Game Round"
	:SetCommand "moat_start_gungame"
	:SetDescription "Each player starts with the same weapon. Kill to advance wepaons."
	:SetMinPlayers "8"

MSE.Commands.Register "Team Deathmatch"
	:SetCommand "moat_start_tdm"
	:SetDescription "Two teams, one loadout. First team to reach the kill limit wins and the highest damage dealing player on the winning team gets the top prize!"
	:SetMinPlayers "8"
	:CommandArguments({
		function(ply)
			local k = {}
			for i = 25,75 do
				table.insert(k,tostring(i))
			end

			return "Kill Goal", true, k
		end,
		function(ply)
			local ids = {"randomply","self"}

			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(ids, v:SteamID())
				end
			end

			local wpns = {}
			local n = 1
			
			for k, v in pairs(weapons.GetList()) do
				if (v.Kind == WEAPON_PISTOL) then continue end
				if (v.Kind ~= WEAPON_HEAVY and v.Kind ~= WEAPON_PISTOL) then continue end
				if (v.Base ~= "weapon_tttbase" or v.ClassName:find("_oc")) then continue end

				wpns[n] = v.ClassName
				n = n + 1
			end

			for i = 1,#wpns do
				ids[#ids + 1] = wpns[i]
			end


			return "Primary weapon", true, ids
		end,
		function(ply)
			local ids = {"randomply", "self", "nothing"}

			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(ids, v:SteamID())
				end
			end

			local wpns = {}
			local n = 1
			
			for k, v in pairs(weapons.GetList()) do
				if (v.Kind == WEAPON_HEAVY) then continue end
				if (v.Kind ~= WEAPON_HEAVY and v.Kind ~= WEAPON_PISTOL) then continue end
				if (v.Base ~= "weapon_tttbase" or v.ClassName:find("_oc")) then continue end

				wpns[n] = v.ClassName
				n = n + 1
			end

			for i = 1,#wpns do
				ids[#ids + 1] = wpns[i]
			end
 
			return "Secondary weapon", true, ids
		end,
		function(ply)
			local a = {"true","false"}
			return "Enable killstreaks", false, a
		end,
	})

MSE.Commands.Register "Free For All"
	:SetCommand "moat_start_ffa"
	:SetDescription "First player to reach the kill count gets the top prize! Everyone must compete in a free-for-all shootout with the same guns!"
	:SetMinPlayers "8"
	:CommandArguments({
		function(ply)
			local k = {}
			for i = 10,30 do
				table.insert(k,tostring(i))
			end

			return "Kill Goal", true, k
		end,
		function(ply)
			local ids = {"randomply","self"}

			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(ids, v:SteamID())
				end
			end

			local wpns = {}
			local n = 1
			
			for k, v in pairs(weapons.GetList()) do
				if (v.Kind == WEAPON_PISTOL) then continue end
				if (v.Kind ~= WEAPON_HEAVY and v.Kind ~= WEAPON_PISTOL) then continue end
				if (v.Base ~= "weapon_tttbase" or v.ClassName:find("_oc")) then continue end

				wpns[n] = v.ClassName
				n = n + 1
			end

			for i = 1,#wpns do
				ids[#ids + 1] = wpns[i]
			end


			return "Primary weapon", true, ids
		end,
		function(ply)
			local ids = {"randomply","self"}

			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(ids, v:SteamID())
				end
			end

			local wpns = {}
			local n = 1
			
			for k, v in pairs(weapons.GetList()) do
				if (v.Kind == WEAPON_HEAVY) then continue end
				if (v.Kind ~= WEAPON_HEAVY and v.Kind ~= WEAPON_PISTOL) then continue end
				if (v.Base ~= "weapon_tttbase" or v.ClassName:find("_oc")) then continue end

				wpns[n] = v.ClassName
				n = n + 1
			end

			for i = 1,#wpns do
				ids[#ids + 1] = wpns[i]
			end
 
			return "Secondary weapon", true, ids
		end
	})

MSE.Commands.Register "Prop Hunt"
	:SetCommand "moat_start_ph"
	:SetDescription "Classic prop hunt! Randomly be a prop or a hunter, only one team can win!"
	:SetMinPlayers "10"

MSE.Commands.Register "Apache Round"
	:SetCommand "moat_start_apache"
	:SetDescription "Team up with every player to defeat the boss for a prize!"
	:SetMinPlayers "14"
	:WhitelistMaps "ttt_canyon_a4, ttt_roy_the_ship, ttt_outpost57_b4, ttt_bb_teenroom_b1, ttt_craftroom, ttt_island_2013, ttt_mw2_highrise, ttt_scarisland_b1, ttt_rats_kitchen_noboom, ttt_bb_teenroom_b2, ttt_mc_teenroom_b2_a2, ttt_scarisland, ttt_old_factory, ttt_mc_skyislands"
	:CommandArguments({
		function(pl)
			local ids = {"self", "random"}

			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(ids, v:SteamID())
				end
			end

			if (CLIENT and (not LocalPlayer():GetDataVar("EC") or (LocalPlayer():GetDataVar("EC") and LocalPlayer():GetDataVar("EC") < 1)) and MSE.Config.Staff[LocalPlayer():GetUserGroup()]) then
				ids = {"random"}
			end

			return "Select Player", true, ids
		end/*,
		function(pl)
			local wpns = {}
			local n = 1
			
			for k, v in pairs(weapons.GetList()) do
				if (v.Kind ~= WEAPON_HEAVY and v.Kind ~= WEAPON_PISTOL) then continue end
				if (v.Base ~= "weapon_tttbase" or v.ClassName:find("_oc")) then continue end

				wpns[n] = v.ClassName
				n = n + 1
			end

			return "Select Weapon", false, wpns
		end*/
	})

MSE.Commands.Register "Stalker Round"
	:SetCommand "moat_start_stalker"
	:SetDescription "Team up with every player to defeat the stalker for a prize!"
	:SetMinPlayers "8"
	:CommandArguments({
		function(pl)
			local ids = {"self", "random"}

			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(ids, v:SteamID())
				end
			end

			if (CLIENT and (not LocalPlayer():GetDataVar("EC") or (LocalPlayer():GetDataVar("EC") and LocalPlayer():GetDataVar("EC") < 1)) and MSE.Config.Staff[LocalPlayer():GetUserGroup()]) then
				ids = {"random"}
			end
			
			return "Select Player", true, ids
		end/*,
		function(pl)
			local wpns = {}
			local n = 1
			
			for k, v in pairs(weapons.GetList()) do
				if (v.Kind ~= WEAPON_HEAVY and v.Kind ~= WEAPON_PISTOL) then continue end
				if (v.Base ~= "weapon_tttbase" or v.ClassName:find("_oc")) then continue end

				wpns[n] = v.ClassName
				n = n + 1
			end

			return "Select Weapon", false, wpns
		end*/
	})

MSE.Commands.Register "One in the Chamber"
	:SetCommand "moat_start_onechamber"
	:SetDescription "One shot gun, one bullet, kill for ammo, 3 lives, last man standing wins."
	:SetMinPlayers "8"

MSE.Commands.Register "Explosive Chickens"
	:SetCommand "moat_start_chickens"
	:SetDescription "Expoding chickens will spawn on you. Be the last alive to win!!"
	:SetMinPlayers "8"

MSE.Commands.Register "The Floor is Lava"
	:SetCommand "moat_start_lava"
	:SetDescription "The floor is lava! Be the last alive to win!!"
	:SetMinPlayers "8"
	:CommandArguments({
		function(ply)
			local a = {"false", "true"}
			return "Explosive eggs", false, a
		end
	})

MSE.Commands.Register "TNT-Tag"
	:SetCommand "moat_start_tnt"
	:SetDescription "Hot-potato style minigame! Be the last alive to win the best prizes!"
	:SetMinPlayers "8"