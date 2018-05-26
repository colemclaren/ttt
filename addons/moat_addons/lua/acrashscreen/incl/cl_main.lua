local _this = aCrashScreen
_this.menu = _this.menu or nil

-- Set the client's timeout to 900 ( 15 minutes ), so the client doesn't disconnect after 45 seconds ( that would make this feature useless )
RunConsoleCommand( 'cl_timeout', '900' )

-- Set it back to 45
hook.Add( 'ShutDown', 'aCrashScreen', function()
	RunConsoleCommand( 'cl_timeout', '45' )
end)

-- Start ahead so the screen doesn't pop up when you join the server.
-- If server crashes at this time it's most likely stuck at the 'Sending client info' anyway
local lastPing, lastProcessTick = SysTime() + 9999, SysTime()
local isChangingMaps = false

-- 0 = determining, 1 = reconnecting when server is online, 2 = Delayed reconnection
local TYPE_DETERMINING, TYPE_WAITFORSERVER, TYPE_DELAYED = 0, 1, 2
local reconnectingType = TYPE_DETERMINING

local isProcessActive = false
local isServerOnline = false
local reconnectingTime = 15
local serverOnlineAttempts = 0
local errorStatusAmount = 0

local startProcess, stopProcess, processTick

function startProcess()
	
	-- Set process to active
	isProcessActive = true
	
	-- Reset these values
	isServerOnline = false
	reconnectingType = TYPE_DETERMINING
	reconnectingTime = _this.config.serverOnlineReconnectingTime or 15
	serverOnlineAttempts = 0
	errorStatusAmount = 0
	
	if not _this.config.serverStatusURL then
		
		reconnectingType = TYPE_DELAYED
		reconnectingTime = _this.config.reconnectingTime or 40
		
	else
		
		-- Determine whether we are going to use auto reconnect after a certain time or when the server is back up
		-- If the site isn't working we still want this to be functional
		_this:isServerOnline( function( status )
			
			if not isProcessActive then return end
			
			if status == 'online' or status == 'offline' then
				reconnectingType = TYPE_WAITFORSERVER -- Reconnecting when server is online
				reconnectingTime = _this.config.serverOnlineReconnectingTime or 15
			else
				reconnectingType = TYPE_DELAYED -- Delayed reconnection
				reconnectingTime = _this.config.reconnectingTime or 40
			end
			
			processTick()
			lastProcessTick = SysTime()
			
		end)
		
	end
	
	-- Remove menu if already exists
	if IsValid( _this.menu ) then
		_this.menu:Remove()
		_this.menu = nil
	end
	
	-- Create menu
	local menu = vgui.Create( 'aCrashScreen-menu' )
	menu:SetVisible(false)

	timer.Simple(8, function()
		if (IsValid(menu)) then menu:SetVisible(true) end
	end)
	
	_this.menu = menu
	
	-- Set the background
	_this:getRandomBackground(function(backgroundOptions)
		if IsValid(menu) then
			menu:setBackground(backgroundOptions)
		end
	end)
	
	-- On terminated
	menu.onTerminated = function( pnl )
		lastPing = SysTime() + 9999 -- Just set the lastPing way ahead
		SetGlobalInt( 'acrashscreen_ping', 99999999 )
	end
	
	if _this.config.songUrls then
		
		-- Enable volume slider if we do have a sound
		menu:setVolumeSliderEnabled( true )
		
		-- Play the song
		_this:playSong()
		
		-- When user changes volume
		menu.onVolumeChanged = function( pnl, volume )
			_this:setSongVolume( volume )
		end
	
	else
		menu:setVolumeSliderEnabled( false )
	end
	
end

function stopProcess()
	
	-- Set the process inactive
	isProcessActive = false
	
	-- Remove the menu
	if IsValid( _this.menu ) then
		_this.menu:Remove()
		_this.menu = nil
	end
	
	-- Stop the song
	_this:stopSong()
	
end

function processTick()
	
	-- Start process if not active ( on first tick )
	if not isProcessActive then
		startProcess()
	end
	
	-- Reconnect
	if reconnectingTime <= 0 then
		RunConsoleCommand( 'retry' )
	end
	
	-- Set these values each tick
	local menu = _this.menu
	menu:setReconnectingValues( reconnectingType, isServerOnline, reconnectingTime )
	
	if reconnectingType == TYPE_DETERMINING then
		-- Do nothing when we are determining the type
		
	elseif reconnectingType == TYPE_DELAYED then
		
		-- Subtract one from reconnectingTime each tick
		reconnectingTime = reconnectingTime - 1
	
	elseif reconnectingType == TYPE_WAITFORSERVER then
		
		if isServerOnline then
			-- Subtract one from reconnectingTime each tick when the server is online
			reconnectingTime = reconnectingTime - 1
		else
			-- Reset the timer
			reconnectingTime = _this.config.serverOnlineReconnectingTime or 15
		end
		
		-- Check each second whether the server is online or not
		if not isServerOnline or ( isServerOnline and reconnectingTime%2 == 0 ) then
			
			-- Check if server online
			_this:isServerOnline( function( status )
				
				if not isProcessActive then return end
				
				-- What if the site decides to shit itself after we checked once before?
				-- we check 3 more times, if it's higher than 3 we go over to the auto reconnect
				if status == 'error' then
					
					errorStatusAmount = errorStatusAmount + 1
					
					if errorStatusAmount >= 3 then
						reconnectingType = TYPE_WAITFORSERVER
						reconnectingTime = 40
					end
					
					return
				else
					-- Set this back to 0
					errorStatusAmount = 0
				end
				
				if status == 'online' then
					
					serverOnlineAttempts = serverOnlineAttempts + 1
					
					-- We want to make sure the server is fully online, if the server is starting it will sometimes show as online
					if serverOnlineAttempts >= 3 then
						isServerOnline = true
					else
						isServerOnline = false
					end
					
				else
					isServerOnline = false
				end
				
			end)
		end
		
	end
	
end

net.Receive( 'acrashscreen_ping', function( len )
	
	-- Once the map changes ignore the crash screen
	if net.ReadBit() == 1 then
		isChangingMaps = true
		stopProcess() -- To make sure
	end
	
	-- Wait for the player to load in, so the crash screen doesn't appear while joining
	if IsValid( LocalPlayer() ) then
		lastPing = SysTime()
	end
	
end)

local function tick()
	
	-- Do nothing when we're changing maps
	if isChangingMaps then return end
	
	-- If the server didn't ping for 5 seconds it most likely crashed
	-- This is about the same time when the 'server not responding' text comes up
	if SysTime() - lastPing > 4 and CurTime() - GetGlobalInt( 'acrashscreen_ping', 99999999 ) > 4 then
		
		-- Call this each second when the server is not responding
		if SysTime() - lastProcessTick >= 1 then
			processTick()
			lastProcessTick = SysTime()
		end
		
	-- End the process
	elseif isProcessActive then
		stopProcess()
	end
	
end
hook.Add( 'Tick', 'aCrashScreen', tick ) -- Timers don't work when the server is not responding

concommand.Add( 'acrashscreen_debug', function()
	
	if isProcessActive then
		print( "[aCrashScreen] Can not debug while the original crash screen is active." )
		return
	end
	
	-- Remove menu if already exists
	if IsValid( _this.menu ) then
		_this.menu:Remove()
		_this.menu = nil
	end
	
	-- Create menu
	local menu = vgui.Create( 'aCrashScreen-menu' )
	_this.menu = menu
	
	-- Set the background
	_this:getRandomBackground(function(backgroundOptions)
		if IsValid(menu) then
			menu:setBackground(backgroundOptions)
		end
	end)
	
	-- On terminated
	menu.onTerminated = function( pnl )
		_this.menu:Remove()
		_this:stopSong()
	end
	
	if _this.config.songUrls then
		
		-- Enable volume slider if we do have a sound
		menu:setVolumeSliderEnabled( true )
		
		-- Play the song
		_this:playSong()
		
		-- When user changes volume
		menu.onVolumeChanged = function( pnl, volume )
			_this:setSongVolume( volume )
		end
	
	else
		menu:setVolumeSliderEnabled( false )
	end
	
end)