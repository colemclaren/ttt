local _this = aCrashScreen

util.AddNetworkString( 'crashscreen_ping' )

RunConsoleCommand('sv_timeout', 9000)
hook.Add( 'InitPostEntity', 'crashscreen_time', function()
	RunConsoleCommand('sv_timeout', 9000)
end)

util.AddNetworkString "crashscreen_ping"
timer.Create("crashscreen_ping", 10, 0, function()
	net.Start "crashscreen_ping"
	net.WriteBool(false)
	net.Broadcast()
end)

-- Once we start switching maps, net doesn't work
-- But the tick hook at client is still working, so it will show the crash screen
-- We don't want that

local net = net
local timer = timer
local string = string

_this.runConsoleCommand = _this.runConsoleCommand or RunConsoleCommand
local runConsoleCommand = _this.runConsoleCommand

_this.consoleCommand = _this.consoleCommand or game.ConsoleCommand
local consoleCommand = _this.consoleCommand

_this.loadNextMap = _this.loadNextMap or game.LoadNextMap
local loadNextMap = _this.loadNextMap

local function initOverrides()
	
	RunConsoleCommand = function( command, ... )
		
		if command == 'changelevel' then
			
			net.Start( 'crashscreen_ping' )
				net.WriteBool( true ) -- Map changing
			net.Broadcast()
			
			local args = { ... }
			timer.Simple( 1, function()
				runConsoleCommand( command, unpack( args ) )
			end)
			
		else
			runConsoleCommand( command, ... )
		end
		
	end
	
	game.ConsoleCommand = function( command )
		
		if string.StartWith( command, 'changelevel' ) then
			
			net.Start( 'crashscreen_ping' )
				net.WriteBool( true ) -- Map changing
			net.Broadcast()
			
			timer.Simple( 1, function()
				consoleCommand( command )
			end)
			
		else
			consoleCommand( command )
		end
		
	end
	
	game.LoadNextMap = function()
		
		net.Start( 'crashscreen_ping' )
			net.WriteBool( true ) -- Map changing
		net.Broadcast()
		
		timer.Simple( 1, function()
			loadNextMap()
		end)
		
	end
	
end
hook.Add( 'PostGamemodeLoaded', 'aCrashScreen', initOverrides )
initOverrides()