local _this = aCrashScreen

local PANEL = {}

function PANEL:Init()
	
	local chatURL = _this.config.chatURL
	local chatID = "server_" .. (Server and Server.ID or "Default")
	local nick = LocalPlayer():Nick()
	local steamID = LocalPlayer():SteamID64()
	local nickColor, canUseNoticableErrors = _this.config.getUserProperties( LocalPlayer() )
	nickColor = string.sub( bit.tohex( nickColor.r ), 7, 8 )
		.. string.sub( bit.tohex( nickColor.g ), 7, 8 ) .. string.sub( bit.tohex( nickColor.b ), 7, 8 )
	
	self:DockPadding( 5, 5, 5, 5 )
	
	self.htmlPanel = vgui.Create( "DHTML", self )
	self.htmlPanel:DockMargin( 0, 0, 0, 4 )
	self.htmlPanel:DockPadding( 1, 1, 1, 1 )
	self.htmlPanel:Dock( FILL )
	self.htmlPanel:SetMouseInputEnabled( true )
	
	-- Disable HTML messages
	self.htmlPanel.ConsoleMessage = function() end
	
	-- Open the page
	self.htmlPanel:OpenURL( chatURL .. "?id=" .. chatID .. "&nick=" .. nick .. "&steamid=" .. steamID
		.. "&color=" .. nickColor .. "&admin=" .. ( canUseNoticableErrors and "true" or "false" ) )
	
	self.sendButton = vgui.Create( 'DButton', self )
	self.sendButton:Dock( BOTTOM )
	self.sendButton:SetTall( 26 )
	self.sendButton:SetText( 'Send' )
	
	local textEntryContainer = vgui.Create( 'DPanel', self )
	textEntryContainer:DockMargin( 0, 0, 0, 4 )
	textEntryContainer:Dock( BOTTOM )
	textEntryContainer:SetTall( 26 )
	
	self.textEntry = vgui.Create( 'DTextEntry', textEntryContainer )
	self.textEntry:Dock( FILL )
	
	-- Always focus the text entry
	self.textEntry.Think = function( pnl )
		pnl:RequestFocus()
	end
	
	-- Borders for the html panel
	self.htmlPanel.PaintOver = function( pnl, w, h )
		surface.SetDrawColor( Color( 20, 20, 20 ) )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end
	
	-- Text entry paint
	self.textEntry:SetDrawBackground( false )
	self.textEntry:SetTextColor( Color( 220, 220, 220 ) )
	self.textEntry:SetHighlightColor( Color( 120, 120, 120 ) )
	self.textEntry:SetCursorColor( Color( 220, 220, 220 ) )
	textEntryContainer.Paint = function( pnl, w, h )
		surface.SetDrawColor( Color( 60, 60, 60 ) )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( Color( 0, 0, 0 ) )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end
	
	-- Send button paint
	self.sendButton.Paint = function( pnl, w, h )
		
		if pnl:IsDown() then
			surface.SetDrawColor( Color( 60, 60, 60 ) )
		elseif pnl:IsHovered() then
			surface.SetDrawColor( Color( 80, 80, 80 ) )
		else
			surface.SetDrawColor( Color( 60, 60, 60 ) )
		end
		surface.DrawRect( 0, 0, w, h )
		
		if pnl:IsDown() then
			surface.SetDrawColor( Color( 50, 50, 50 ) )
			surface.DrawOutlinedRect( 1, 1, w, h )
		elseif pnl:IsHovered() then
			surface.SetDrawColor( Color( 120, 120, 120 ) )
			surface.DrawOutlinedRect( -1, -1, w, h )
		else
			surface.SetDrawColor( Color( 80, 80, 80 ) )
			surface.DrawOutlinedRect( 1, 1, w, h )
		end
		
		surface.SetDrawColor( Color( 0, 0, 0 ) )
		surface.DrawOutlinedRect( 0, 0, w, h )
		
	end
	self.sendButton.UpdateColours = function( pnl, skin )
		
		if pnl:IsDown() then
			return pnl:SetTextStyleColor( Color( 190, 190, 190 ) )
		elseif pnl:IsHovered() then
			return pnl:SetTextStyleColor( Color( 220, 220, 220 ) )
		end
		
		return pnl:SetTextStyleColor( Color( 180, 180, 180 ) )
	end
	
	local sendMessage
	do
		
		-- Not going to write an actual (compiler) for this yet, waiting for feedback first
		local config = {}
		
		for m in string.gmatch(_this.config.chatMessageLimit, '{(.-)}') do
			table.insert(config, m)
		end
		
		local messageCooldownEnabled = (config[1] == 'is')
		local messageCooldown = messageCooldownEnabled and tonumber(config[2]) or 0
		
		local messageLimitEnabled = (config[5] == 'will')
		local messageLimit = messageLimitEnabled and tonumber(config[3]) or -1
		local messageLimitResetCooldown = tonumber(config[4])
		local messageLimitCooldown = tonumber(config[6])
		
		local nextMessage = 0
		local messageCountCooldown = 0
		local messageCount = 0
		
		-- Send message
		function sendMessage()
			
			-- Ignore the message if it's empty
			local message = self.textEntry:GetValue()
			if message == "" then return end
			
			-- Ignore the message if our cooldown hasn't worn off yet
			if nextMessage > SysTime() then
				
				-- Show warning that the chat is on cooldown
				self.htmlPanel:RunJavascript(
					[[$('.chat-lines').append('<div class="chat-line noticable"><span class="text" style="color: #ff0000;">Please wait ]]
						..tostring(math.Round(nextMessage - SysTime() + 0.1, 1))..[[ seconds before sending another message.</span></div>')						
							// Scroll to bottom
							$( '.chat-lines' ).animate( { scrollTop: $( '.chat-lines' ).prop( 'scrollHeight' ) }, 'fast' );
						]])
				return
			end
			
			-- Reset message count if there's been no message for x amount of time
			if messageCountCooldown < SysTime() then
				messageCount = 0
			end
			
			-- Add one to message count
			messageCount = messageCount + 1
			
			-- Set cooldown if we hit the limit
			if messageCount == messageLimit then
				nextMessage = SysTime() + messageLimitCooldown
			else
				
				-- Set the time a new message may be send
				nextMessage = SysTime() + messageCooldown
				
				-- Set the message count cooldown
				messageCountCooldown = SysTime() + messageLimitResetCooldown
				
			end
			
			-- Remove text from the text entry
			self.textEntry:SetText( "" )
			
			-- Replace all backslashes with double backslashes
			message = string.Replace(string.Replace(message, "\\", "\\\\"), "\"", "\\\"")
			
			-- Run the javascript function to send a message
			self.htmlPanel:RunJavascript('sendMessage("'..message..'")')
			
		end
		
	end
	self.sendButton.DoClick = sendMessage
	self.textEntry.OnEnter = sendMessage
	
end

function PANEL:Paint( w, h )
	
	surface.SetDrawColor( Color( 40, 40, 40 ) )
	surface.DrawRect( 0, 0, w, h )
	
	surface.SetDrawColor( Color( 20, 20, 20 ) )
	surface.DrawOutlinedRect( 0, 0, w, h )
	
end

vgui.Register( 'aCrashScreen-chat', PANEL, 'DPanel' )