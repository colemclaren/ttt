local _this = aCrashScreen

function _this:isServerOnline( callback )
	
	local serverStatusURL = _this.config.serverStatusURL
	local serverIP = _this.config.serverIP
	local serverPort = _this.config.serverPort
	
	http.Fetch( serverStatusURL .. '?ip=' .. serverIP .. '&port=' .. serverPort,
		
		function( body, len, headers, code )
			callback( ( body == 'online' or body == 'offline' ) and body or 'error' )
		end,
		function( _error )
			callback( 'error' )
		end)
	
end

function _this:getHTMLMaterial( url, callback )
	
	-- Create DHTML panel.
	local panel = vgui.Create( "DHTML" )
	panel:SetSize( 2048, 2048 )
	
	-- Hide the panel
	panel:SetAlpha( 0 )
	panel:SetMouseInputEnabled( false )
	
	-- Load the page.
	panel:OpenURL( url )
	
	-- Disable HTML messages
	panel.ConsoleMessage = function() end
	
	panel.destroyTime = SysTime() + 12
	
	-- Callback when we can get the material
	panel.Think = function( pnl )
		
		if panel.destroyTime < SysTime() then
			pnl:Remove()
			return
		end
		
		if pnl:GetHTMLMaterial() then
			
			local material = pnl:GetHTMLMaterial()
			
			-- Call the callback
			callback( material )
			
		end
		
	end
	
end

local downloadQueue = {}

function _this:getSongByURL( url, callback, ignoreQueue )
	
	if not ignoreQueue then
		table.insert( downloadQueue, { url, callback } )
		if #downloadQueue > 1 then return end
	end
	
	sound.PlayURL( url, 'noplay noblock',
		function( channel, errorID, errorName )
			
			if IsValid( channel ) then
				callback( channel )
			else
				callback( channel, errorName, errorID )
			end
			
			table.remove( downloadQueue, 1 )
			if #downloadQueue > 0 then
				_this:getSongByURL( downloadQueue[ 1 ][ 1 ], downloadQueue[ 1 ][ 2 ], true )
			end
			
		end)
	
end
