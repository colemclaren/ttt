local _this = aCrashScreen
_this.menu = _this.menu or nil

-- Set the client's timeout to 900 ( 15 minutes ), so the client doesn't disconnect after 45 seconds ( that would make this feature useless )
RunConsoleCommand( 'cl_timeout', 9000 )
hook.Add( 'InitPostEntity', 'crashscreen_time', function()
	RunConsoleCommand('cl_timeout', 9000)
end)

local LastPing, JoinBuffer, LastProcessTick = SysTime() + 600, SysTime() + 90, SysTime()
local MapChanging = false

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
			LastProcessTick = SysTime()
		end)
		
	end

	-- Remove menu if already exists
	if IsValid( _this.menu ) then

		_this.menu:Remove()
		_this.menu = nil
	end

	-- Create menu
	local menu = vgui.Create( 'aCrashScreen-menu' )
	menu:SetVisible(true)

	_this.menu = menu
	
	-- Set the background
	_this:getRandomBackground(function(backgroundOptions)
		if IsValid(menu) then
			menu:setBackground(backgroundOptions)
		end
	end)
	
	-- On terminated
	menu.onTerminated = function( pnl )

		LastPing = SysTime() + 9999 -- Just set the lastPing way ahead
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

local crashing = false
net.Receive("crashscreen_ping", function()
	LastPing = SysTime() + Either(MapChanging, 60, 20)

	if (net.ReadBool()) then
		MapChanging = true
	end

	if (isProcessActive) then
		stopProcess()
	end

	crashing = false
end)

hook.Add("Think", "crashscreen_check", function()
	if (MapChanging) then
		return
	end

	if (not JoinBuffer or JoinBuffer > SysTime()) then
		return
	end

	if (LastPing and LastPing < SysTime()) then
		if (SysTime() - LastProcessTick >= 1) then
			if (Server and Server.IsDev and not crashing) then
				print("Crashing!", SysTime())
				crashing = true
			else
				processTick()
			end

			LastProcessTick = SysTime()
		end
	elseif (isProcessActive) then
		stopProcess()
	end
end)


/*
concommand.Add( '__acrashscreen_debug', function()
	
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
*/