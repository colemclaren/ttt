local _this = aCrashScreen

util.AddNetworkString( 'acrashscreen_ping' )

RunConsoleCommand( 'sv_timeout', '900' )

-- I'd rather put this in a tick hook than a timer
local nextPing = 0
hook.Add( 'Tick', 'aCrashScreen', function()
	
	-- Ping all the players once a second
	if nextPing <= SysTime() then
		nextPing = SysTime() + 0.5
		
		--[[ Sorry for terrible english:
		So a server sends data to the client. The client receives the data.
		There's a limit on how much data the client can receive each second ( or package, whatever ).
		So we've got a problem here, what if it reaches the limit?
		Well the server queue's up all data that needs to be send to the client.
		Now if the client reached the limit ( due to like an addon sending a mass amount of data ),
		the queue will become bigger and bigger, because there's a constant data flow.
		Players are walking, props are being moved etc etc.
		This takes a couple of seconds to balance out back to what it is supposed to be.
		Now i ping the client each second, and this ping will end up in this queue also.
		So when the client reaches this limit, the ping will not be received by the client
		for a couple of seconds. If this is more than 4 seconds, the crash screen will pop up.
		TL;DR: Client thinks the server has crashed because of a ping i send to the client
		is stuck in a queue of data to be send to the client over time. If this takes
		longer than 4 seconds, the crash screen appears. ]]
		SetGlobalInt( 'acrashscreen_ping', CurTime() ) -- Seems not to be affected by this issue unlike the net library
		
		-- Want to keep this in also, so we don't have to rely on SetGlobaInt all the time
		-- The safer, the better, right?
		net.Start( 'acrashscreen_ping' )
			net.WriteBit( false ) -- Map not changing
		net.Broadcast()
		
	end
	
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
			
			net.Start( 'acrashscreen_ping' )
				net.WriteBit( true ) -- Map changing
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
			
			net.Start( 'acrashscreen_ping' )
				net.WriteBit( true ) -- Map changing
			net.Broadcast()
			
			timer.Simple( 1, function()
				consoleCommand( command )
			end)
			
		else
			consoleCommand( command )
		end
		
	end
	
	game.LoadNextMap = function()
		
		net.Start( 'acrashscreen_ping' )
			net.WriteBit( true ) -- Map changing
		net.Broadcast()
		
		timer.Simple( 1, function()
			loadNextMap()
		end)
		
	end
	
end
hook.Add( 'PostGamemodeLoaded', 'aCrashScreen', initOverrides )
initOverrides()