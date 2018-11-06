local _this = aCrashScreen

--[[//////////////////////////////////////////////////////////////////
		Song
////////////////////////////////////////////////////////////////////]]

local playing = false
local currentSong = nil
local playedSongs = {}
local cachedSongs = {}
local failedSongs = 0

local songVolume = 0.5

function _this:loadSong( songUrl )
	
	_this:getSongByURL( songUrl, function( channel, errorName, errorID )
		
		if not IsValid( channel ) then
			MsgC( Color( 255, 0, 0 ), "[aCrashScreen] Failed to load song '" .. songUrl .. "' Error: " .. errorName .. "\n" )
			return
		end
		
		-- Cache the song
		cachedSongs[ songUrl ] = channel
		
	end)
	
end

function _this:getNextSongURL()
	
	local songUrls = _this.config.songUrls
	if not songUrls then return end
	
	-- Reset the played songs list, if we played all songs once
	if #songUrls == table.Count( playedSongs ) then
		playedSongs = {}
	end
	
	-- Loop through all songs randomized
	for _, songUrl in RandomPairs( songUrls ) do
		
		-- If we haven't played the song yet, play it
		if not playedSongs[ songUrl ] then
			
			-- Add it to the list
			playedSongs[ songUrl ] = true
			
			-- Return the song
			return songUrl
		end
		
	end
	
end

function _this:playSong()
	
	local songUrl = _this:getNextSongURL()
	if not songUrl then return end
	
	-- Stop song if already playing
	if playing then _this:stopSong() end
	
	playing = true
	
	if IsValid( cachedSongs[ songUrl ] ) then
		
		local channel = cachedSongs[ songUrl ]
		
		-- Play the song
		channel:SetVolume( songVolume )
		channel:Play()
		
		currentSong = channel
		
	else
		
		-- Load the song
		_this:loadSong( songUrl )
		
		-- Play another song instead
		for i=1, table.Count( cachedSongs ) do
			
			local channel = cachedSongs[ _this:getNextSongURL() ]
			if IsValid( channel ) then
				
				channel:SetVolume( songVolume )
				channel:Play()
				
				currentSong = channel
				
				return
			end
			
		end
		
		-- If no song is playing, set this to false
		playing = false
		
	end
	
end

function _this:setSongVolume( volume )
	
	songVolume = volume
	
	-- Set the volume of the current song playing
	if IsValid( currentSong ) then
		currentSong:SetVolume( songVolume )
	end
	
end

function _this:stopSong()
	
	playing = false
	
	-- Stop the song
	if IsValid( currentSong ) then
		currentSong:Stop()
	end
	currentSong = nil
	
end
/*
local nextTick = 0
hook.Add( 'Tick', 'aCrashScreen-song', function()
	
	if nextTick > SysTime() then return end
	nextTick = SysTime() + 2
	
	if not ( playing and IsValid( currentSong ) ) then return end
	
	if currentSong:GetState() == GMOD_CHANNEL_STOPPED then
		
		-- Stop the song
		currentSong:Stop()
		
		-- Play the next song
		_this:playSong()
		
	end
	
end)

-- sound.playURL does not download while the server does not response...
timer.Simple( 2, function()
	
	if not _this.config.songUrls then return end
	
	-- Download and cache all songs
	for _, songUrl in pairs( _this.config.songUrls ) do
		_this:loadSong( songUrl )
	end
	
end)
*/
--[[//////////////////////////////////////////////////////////////////
		Background
////////////////////////////////////////////////////////////////////]]

local cachedBackgrounds = {}

function _this:getRandomBackground(callback)
	
	local backgroundUrls = _this.config.backgroundUrls
	if not backgroundUrls then return false end
	
	local random = math.random( #backgroundUrls )
	local randomBackground = backgroundUrls[random]
	
	if not cachedBackgrounds[ random ] then
		
		local firstToCache = table.Count(cachedBackgrounds) == 0
		
		_this:getHTMLMaterial( randomBackground[ 1 ], function( material )
			
			-- Cache the background
			cachedBackgrounds[random] = {material, randomBackground[2], randomBackground[3], randomBackground[4]}
			
			if firstToCache then
				callback(cachedBackgrounds[random])
			end
			
		end)
		
		for _, background in RandomPairs(cachedBackgrounds) do
			callback(background)
			break
		end
		
	else
		callback(cachedBackgrounds[random])
	end
	
end

-- Load a single background, so we won't have to wait
-- for our background to load when the crash screen appears
/*timer.Simple(5, function()
	_this:getRandomBackground(function() end)
end)*/