local _this = aCrashScreen

surface.CreateFont( 'acrashscreen_small', {
	font = "Arial",
	size = 28,
	weight = 900
})

surface.CreateFont( 'acrashscreen_medium', {
	font = 'Arial',
	size = 32,
	weight = 900
})

surface.CreateFont( 'acrashscreen_big', {
	font = 'Arial',
	size = 36,
	weight = 900
})

-- Button paint
local buttonPaint = function( pnl, w, h )
	
	if pnl:IsDown() then
		surface.SetDrawColor( 70, 70, 70, 255 )
	elseif pnl:IsHovered() then
		surface.SetDrawColor( 80, 80, 80, 255 )
	else
		surface.SetDrawColor( 40, 40, 40, 255 )
	end
	surface.DrawRect( 0, 0, w, h )
	
	surface.SetDrawColor( 20, 20, 20, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h )
	
end

-- Button text color
local buttonUpdateColours = function( pnl, skin )
	return pnl:SetTextStyleColor( Color( 255, 255, 255 ) )
end

local TYPE_DETERMINING, TYPE_WAITFORSERVER, TYPE_DELAYED = 0, 1, 2

local PANEL = {}

function PANEL:Init()
	
	self:SetPos( 0, 0 )
	self:SetSize( ScrW(), ScrH() )
	self:MakePopup()
	
	-- Reconnect button
	self.reconnectButton = vgui.Create( 'DButton', self )
	self.reconnectButton:SetSize( 280, 46 )
	self.reconnectButton:SetPos( ScrW()*0.5 - 140, 150 )
	self.reconnectButton:SetFont( 'acrashscreen_medium' )
	self.reconnectButton:SetText( "Reconnect now" )
	
	-- Disconnect button
	self.disconnectButton = vgui.Create( 'DButton', self )
	self.disconnectButton:SetSize( 280, 46 )
	self.disconnectButton:SetPos( ScrW()*0.5 - 140, 210 )
	self.disconnectButton:SetFont( 'acrashscreen_medium' )
	self.disconnectButton:SetText( "Disconnect" )
	
	-- Set button paint
	self.reconnectButton.Paint = buttonPaint
	self.disconnectButton.Paint = buttonPaint
	
	-- Set button text color
	self.reconnectButton.UpdateColours = buttonUpdateColours
	self.disconnectButton.UpdateColours = buttonUpdateColours
	
	-- Set button functions
	self.reconnectButton.DoClick = function( pnl )
		RunConsoleCommand( 'retry' )
	end
	self.disconnectButton.DoClick = function( pnl )
		RunConsoleCommand( 'disconnect' )
	end
	
	-- Terminate button
	self.terminateButton = vgui.Create( 'DButton', self )
	self.terminateButton:SetText( "Terminate" )
	self.terminateButton:SizeToContents()
	self.terminateButton:SetPos( 4, ScrH() - self.terminateButton:GetTall() - 3 )
	self.terminateButton.Paint = function( pnl, w, h )
		draw.SimpleText( pnl:GetValue(), pnl:GetFont(), w*0.5 + 1, h*0.5 + 1, Color( 0, 0, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	self.terminateButton.UpdateColours = function( pnl, skin )
		if pnl:IsHovered() then return pnl:SetTextColor( Color( 220, 220, 220, 100 ) ) end
		return pnl:SetTextColor( Color( 220, 220, 220, 50 ) )
	end
	
	self.terminateButton.DoClick = function( pnl )
		
		-- Derma_Query, you so ugly???
		
		local frame = vgui.Create( 'DFrame', self )
		frame:DockPadding( 4, 4, 4, 4 )
		frame:SetSize( 180, 60 )
		frame:SetDraggable( false )
		frame:ShowCloseButton( false )
		frame:SetTitle( "" )
		frame:MakePopup()
		frame:DoModal()
		frame:Center()
		frame.Paint = function( pnl, w, h )
			Derma_DrawBackgroundBlur( pnl )
			surface.SetDrawColor( 60, 60, 60, 255 )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( 20, 20, 20, 255 )
			surface.DrawOutlinedRect( 0, 0, w, h )
		end
		
		local label = vgui.Create( 'DPanel', frame )
		label:Dock( TOP )
		label:SetTall( 32 )
		label.Paint = function( pnl, w, h )
			surface.SetTextColor( 255, 255, 255 )
			surface.SetFont( "DermaDefault" )
			local tw, th = surface.GetTextSize( "Are you sure?" )
			surface.SetTextPos( w*0.5-tw*0.5, h*0.5-th*0.5 )
			surface.DrawText( "Are you sure?" )
		end
		
		local b1 = vgui.Create( 'DButton', frame )
		b1:Dock( LEFT )
		b1:SetWide( 84 )
		b1:SetText( "Yes" )
		b1.Paint = buttonPaint
		b1.UpdateColours = buttonUpdateColours
		
		local b2 = vgui.Create( 'DButton', frame )
		b2:DockMargin( 4, 0, 0, 0 )
		b2:Dock( RIGHT )
		b2:SetWide( 84 )
		b2:SetText( "Cancel" )
		b2.Paint = buttonPaint
		b2.UpdateColours = buttonUpdateColours
		
		b1.DoClick = function( pnl ) self:onTerminated() frame:Remove() end
		b2.DoClick = function( pnl ) frame:Remove() end
		
	end
	
	-- Create custom buttons
	local buttonsTable = _this.config.buttons
	local height = 61 * #buttonsTable - 15
	for n, button in pairs( buttonsTable ) do
		
		local buttonText = button[ 1 ]
		local buttonFunc = button[ 2 ]
		
		local button = vgui.Create( 'DButton', self )
		button:SetSize( 300, 46 )
		button:SetPos( ScrW() - 280 - 40, ScrH()*0.5 - height*0.5 + 61*(n-1) )
		button:SetFont( 'acrashscreen_small' )
		button:SetText( buttonText )
		
		button.Paint = buttonPaint
		button.UpdateColours = buttonUpdateColours
		
		if isstring( buttonFunc ) then
			button.DoClick = function( pnl ) LocalPlayer():ConCommand( 'connect ' .. buttonFunc ) end
		elseif isfunction( buttonFunc ) then
			button.DoClick = function( pnl ) buttonFunc() end
		end
		
	end
	
	-- Volume slider
	self.volumeSliderContainer = vgui.Create( 'DPanel', self )
	self.volumeSliderContainer:SetSize( 180, 40 )
	self.volumeSliderContainer:SetPos( ScrW() - 200 , ScrH() - 60 )
	self.volumeSliderContainer.Paint = function() end
	
	self.volumeSliderText = vgui.Create( 'DLabel', self.volumeSliderContainer )
	self.volumeSliderText:DockMargin( 0, 0, 6, 0 )
	self.volumeSliderText:Dock( LEFT )
	self.volumeSliderText:SetTextColor( Color( 20, 20, 20 ) )
	self.volumeSliderText:SetText( "Volume" )
	self.volumeSliderText:SizeToContents()
	
	self.volumeSlider = vgui.Create( 'DSlider', self.volumeSliderContainer )
	self.volumeSlider:Dock( FILL )
	self.volumeSlider:SetSlideX( file.Read( 'crashscreen-volume.dat', 'DATA' ) or 0.5 )
	self.volumeSlider.Paint = function( pnl, w, h )
		surface.SetDrawColor( 80, 80, 80, 255 )
		surface.DrawRect( 0, h*0.5 - 3, w, 6 )
		surface.SetDrawColor( 10, 10, 10, 255 )
		surface.DrawOutlinedRect( 0, h*0.5 - 3, w, 6 )
	end
	self.volumeSlider.Knob:SetWide( 8 )
	self.volumeSlider.Knob.Paint = function( pnl, w, h )
		surface.SetDrawColor( 160, 160, 160, 255 )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( 200, 200, 200, 255 )
		surface.DrawOutlinedRect( 1, 1, w-1, h-1 )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end
	local volume = 0.5
	self.volumeSlider.Think = function( pnl )
		local sliderVolume = math.Round( pnl.m_fSlideX * 100, 0 ) * 0.01
		if volume != sliderVolume then
			self:onVolumeChanged( sliderVolume )
			volume = sliderVolume
			file.Write( 'crashscreen-volume.dat', tostring( sliderVolume ) ) -- Cookie not working???
		end
	end
	
	-- Chat panel
	if _this.config.chatURL then
		self.chatPanel = vgui.Create( 'aCrashScreen-chat', self )
		self.chatPanel:SetSize( 300, 400 )
		self.chatPanel:SetPos( 20, ScrH() - 480 )
	end
	
	-- Community name
	self.communityName = _this.config.communityName
	
	self.backgroundColor = _this.config.backgroundColor
	
	self.reconnectingType = TYPE_DETERMINING
	self.isServerOnline = false -- Whether the server is online or not
	self.reconnectingInTime = 10 -- Time till player is automatically reconnected
	
	-- Background
	self.backgroundMaterial = nil
	self.backgroundWidth = 1920
	self.backgroundHeight = 1080
	
end

function PANEL:setReconnectingValues( reconnectingType, isServerOnline, time )
	self.reconnectingType = reconnectingType
	self.isServerOnline = isServerOnline
	self.reconnectingInTime = time
end

-- Needs to be overidden
function PANEL:onVolumeChanged()
end

-- Needs to be overidden
function PANEL:onTerminated()
end

function PANEL:setVolumeSliderEnabled( enabled )
	self.volumeSliderContainer:SetVisible( enabled )
end

function PANEL:setBackground( background )
	
	if not ( background and background[ 1 ] ) then return end
	
	local material = background[ 1 ]
	local width, height = background[ 2 ], background[ 3 ]
	local fill = background[ 4 ]
	
	if fill then -- Fill the image, this will cut of a part of the image if the screen ratio is different
		width = ( ScrW() * ( 2048 / width ) ) * ( width / height ) / ( ScrW() / ScrH() )
		height = width
	else -- Stretch the image, will fill up the screen with the entire image, this can make the image look bad if the screen ratio is different
		width, height = ScrW() * ( 2048 / width ), ScrH() * ( 2048 / height )
	end
	
	self.backgroundWidth = width
	self.backgroundHeight = height
	
	self.backgroundMaterial = material
	
end

function PANEL:Paint( w, h )
	
	-- Background color
	surface.SetDrawColor( self.backgroundColor or Color( 0, 75, 130 ) )
	surface.DrawRect( 0, 0, w, h )
	
	-- Draw background
	if self.backgroundMaterial then
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( self.backgroundMaterial )
		surface.DrawTexturedRect( 0, 0, self.backgroundWidth, self.backgroundHeight )
	end
	
	-- Border white bars
	surface.SetDrawColor( 60, 60, 60, 255 )
	surface.DrawRect( 0, 19, w, 42 )
	surface.DrawRect( 0, h - 61, w, 42 )
	
	-- White bars at the bottom and top
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( 0, 20, w, 40 )
	surface.DrawRect( 0, h - 60, w, 40 )
	
	-- Community name
	draw.SimpleText(
		self.communityName, 'acrashscreen_big',
		w*0.5, 40, Color( 0, 0, 0 ),
		TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	-- Auto reconnect when the server is back up
	if self.reconnectingType == TYPE_WAITFORSERVER then
		
		if self.isServerOnline then
			
			draw.SimpleText(
				"The server is back online!", 'acrashscreen_big',
				w*0.5 + 2, 86 + 2, Color( 0, 0, 0 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
			draw.SimpleText(
				"The server is back online!", 'acrashscreen_big',
				w*0.5, 86, Color( 255, 255, 255 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			draw.SimpleText(
				"You will be automatically reconnected in " .. self.reconnectingInTime .. " seconds.", 'acrashscreen_small',
				w*0.5 + 2, 120 + 2, Color( 0, 0, 0 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
			draw.SimpleText(
				"You will be automatically reconnected in " .. self.reconnectingInTime .. " seconds.", 'acrashscreen_small',
				w*0.5, 120, Color( 255, 255, 255 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			
		else
			
			draw.SimpleText(
				"The server is not responding", 'acrashscreen_big',
				w*0.5 + 2, 86 + 2, Color( 0, 0, 0 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
			draw.SimpleText(
				"The server is not responding", 'acrashscreen_big',
				w*0.5, 86, Color( 255, 255, 255 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
			draw.SimpleText(
				"You will be automatically reconnected when the server is back up!", 'acrashscreen_small',
				w*0.5 + 2, 120 + 2, Color( 0, 0, 0 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
			draw.SimpleText(
				"You will be automatically reconnected when the server is back up!", 'acrashscreen_small',
				w*0.5, 120, Color( 255, 255, 255 ),
					TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
		end
	
	-- Delayed reconnection
	elseif self.reconnectingType == TYPE_DELAYED then
	
		draw.SimpleText(
			"The server is not responding", 'acrashscreen_big',
			w*0.5 + 2, 86 + 2, Color( 0, 0, 0 ),
			TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		draw.SimpleText(
			"The server is not responding", 'acrashscreen_big',
			w*0.5, 86, Color( 255, 255, 255 ),
			TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		draw.SimpleText( -- Outline
			"Automatically reconnecting in " .. self.reconnectingInTime .. " seconds.", 'acrashscreen_small',
			w*0.5 + 2, 120 + 2, Color( 0, 0, 0 ),
			TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText(
			"Automatically reconnecting in " .. self.reconnectingInTime .. " seconds.", 'acrashscreen_small',
			w*0.5, 120, Color( 255, 255, 255 ),
			TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
	-- Determining
	elseif self.reconnectingType == TYPE_DETERMINING then
		
		draw.SimpleText(
			"The server is not responding", 'acrashscreen_big',
			w*0.5 + 2, 102 + 2, Color( 0, 0, 0 ),
			TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		draw.SimpleText(
			"The server is not responding", 'acrashscreen_big',
			w*0.5, 102, Color( 255, 255, 255 ),
			TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
	end
	
end

vgui.Register( 'aCrashScreen-menu', PANEL, 'EditablePanel' )