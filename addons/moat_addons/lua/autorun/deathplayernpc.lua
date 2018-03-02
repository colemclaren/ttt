local Category = "Deathclaw humanoids"
local NPC = {
		 		Name = "Deathclaw Alpha", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/deathclaw_player/deathclaw_player_alpha.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_deathclaw_ap", NPC )
local NPC = {
		 		Name = "Deathclaw", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/deathclaw_player/deathclaw_player.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_deathclaw_p", NPC )
local NPC = {
		Name = "Deathclaw Alpha hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/deathclaw_player/deathclaw_player_alpha.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_deathclaw_aph", NPC )
local NPC = {
		Name = "Deathclaw hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/deathclaw_player/deathclaw_player.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_deathclaw_ph", NPC )
local NPC = {
		 		Name = "Deathclaw Glowing", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/deathclaw_player/deathclaw_player_glowing.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_deathclaw_gp", NPC )
local NPC = {
		Name = "Deathclaw Glowing hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/deathclaw_player/deathclaw_player_glowing.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_deathclaw_gph", NPC )
local NPC = {
		 		Name = "Deathclaw Matriarch", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/deathclaw_player/deathclaw_player_matriarch.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_deathclaw_mp", NPC )
local NPC = {
		Name = "Deathclaw Matriarch hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/deathclaw_player/deathclaw_player_matriarch.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_deathclaw_mph", NPC )
local NPC = {
		 		Name = "Deathclaw Albino", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/deathclaw_player/deathclaw_player_albino.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_deathclaw_alp", NPC )
local NPC = {
		Name = "Deathclaw Albino hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/deathclaw_player/deathclaw_player_albino.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_deathclaw_alph", NPC )
local NPC = {
		 		Name = "Deathclaw Savage", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/deathclaw_player/deathclaw_player_savage.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_deathclaw_sp", NPC )
local NPC = {
		Name = "Deathclaw Savage hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/deathclaw_player/deathclaw_player_savage.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_deathclaw_sph", NPC )