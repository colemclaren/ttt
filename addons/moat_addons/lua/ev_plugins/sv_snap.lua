/*-------------------------------------------------------------------------------------------------------------------------
	Slap a player
-------------------------------------------------------------------------------------------------------------------------*/

local PLUGIN = {}
PLUGIN.Title = "Snap"
PLUGIN.Description = "Perform a snap on a player."
PLUGIN.Author = "Moat"
PLUGIN.ChatCommand = "snap"
PLUGIN.Usage = "[players] [quality]"
PLUGIN.Privileges = { "Snap" }

function PLUGIN:Call(ply, args)
	if ( ply:EV_HasPrivilege( "Snap" ) ) then
		local players = evolve:FindPlayer( args, ply, true )
		
		if ( #players > 0 ) then
			snapper.snap(ply, players[1], (args[3] and tonumber(args[3])) or 70)
		else
			evolve:Notify( ply, evolve.colors.red, evolve.constants.noplayers )
		end
	else
		evolve:Notify( ply, evolve.colors.red, evolve.constants.notallowed )
	end
end

evolve:RegisterPlugin( PLUGIN )