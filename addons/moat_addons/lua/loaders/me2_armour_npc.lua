local Category = "Mass Effect"

local NPC =
{
	Name = "Inferno Armour",
	Class = "npc_citizen",
	KeyValues =
	{
		citizentype = 4
	},
	Model = "models/Mass Effect 2/player/inferno_armour.mdl",
	Health = "250",
	Category = Category
}

list.Set( "NPC", "npc_inferno_armour", NPC )