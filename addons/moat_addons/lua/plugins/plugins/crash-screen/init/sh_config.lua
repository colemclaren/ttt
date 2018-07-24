aCrashScreen = aCrashScreen or {}
aCrashScreen.config = aCrashScreen.config or {}

if (SERVER) then return end

local _this, ourserver = aCrashScreen.config, moat.servers.get(SERVER_IP)
---------------------------------
-- Chat ID, useful for multiple servers
-- Not case sensitive only letters, numbers and underscores are allowed
_this.chatID = "server_" .. ourserver.id

-- Your community name
_this.communityName = "Moat.GG - " .. ourserver.name .. " has Crashed!"

-- The web-based server status checker
-- This will check if the server is online, if it is it will automatically reconnect
-- Set this to false if you want to use auto reconnection after x amount of seconds
_this.serverStatusURL = false

-- How long to wait for the client to reconnect to the server when it is back up
-- If you're reconnecting before the server is fully loaded, increase this value
_this.serverOnlineReconnectingTime = 15

-- Only if serverStatusURL is false, this will auto reconnect after x amount of seconds
_this.reconnectingTime = 200

-- THIS server's IP address and Port
-- Only needed if you use serverStatusURL
_this.serverIP = SERVER_SHORTIP
_this.serverPort = SERVER_PORT

-- Background image(s), must give the correct image width and height
-- Animated images won't work
-- Maximum size of the image is 2048 pixels in width and height
-- Backgrounds will be chosen randomly
-- Set backgroundUrls to false to use backgroundColor instead
_this.backgroundUrls = {
	{ 
		"https://moat.gg/assets/img/bg-main.png", -- Image URL
		1500, 1080, -- Width, Height
		false -- true is Fill, false is Stretch. Fill and Stretch explained: http://i.imgur.com/jlzYCvT.png
	}
}

-- Color of the background, will only be shown if the background image is disabled
_this.backgroundColor = Color( 0, 75, 130 )

-- Song(s), has to be a direct url to the file
-- Will be chosen randomly, but will only play once until all songs have been played
-- Set this to false if you want this disabled
_this.songUrls = { -- NOTE: These songs are place holders, they most likely will not work
}

-- The web-based chat
-- Set this to false if you want this disabled
_this.chatURL = "https://i.moat.gg/servers/acrashscreen/chat/chat.php"

--[[
-
- Please send feedback from you as a server owner, whether you like this kind of configuration or not and why you do or do not.
-
- There's a cooldown for the chat that can prevent chat spam.
- The configuration for this is written in sentences.
-
- There's a couple of rules associated with this:
- You can only modify everything in between curly brackets {}
- {is}, {will} can be replaced by {is not}, {will not} to disable/invert that feature.
- Floating point numbers are allowed if it was already a floating point number by default like {1.0}, {6.0} and {8.0}
- Make sure you're not making any mistakes in this like adding a trailing space, because that will break it.
-
- I recommend testing the chat beforehand by typing 'acrashscreen_debug' in chat.
-
]]
_this.chatMessageLimit = [[
	
	After a player sends a message, there {is} a cooldown that will last for {0.8} seconds before
	the player can send yet another message.
	
	If that player sends more than {4} messages in a row in less than {5.0} seconds.
	A cooldown {will} start that lasts for {4.0} seconds to prevents the player from sending messages.
	
]]

-- Chat user properties: nick names and noticable messages
local ranks = {}
ranks[ 'manager' ] = { Color( 125, 0, 180 ), true } -- { nick name color, if true user can use ! in front of their text to type a noticable message }
ranks[ 'donator' ] = { Color( 255, 220, 0 ), false }

function _this.getUserProperties( ply ) -- This is somewhat more advanced
	
	local userGroup = ply:GetUserGroup()
	if ranks[ userGroup ] then
		return ranks[ userGroup ][ 1 ], ranks[ userGroup ][ 2 ] or false
	end
	
	if ply:IsSuperAdmin() then return Color( 255, 0, 0 ), true end -- Any superadmin
	if ply:IsAdmin() then return Color( 255, 100, 0 ), true end -- Any admin
	
	return Color( 200, 200, 200 ), false -- Default color
end

-- Custom buttons
_this.buttons = {
	-- "Button text", function or server ip:port to connect to
}

for i = 1, #moat.servers.list do
	local srv = moat.servers.list[i]
	if (not srv.name or not srv.ip or srv.status) then continue end

	table.insert(_this.buttons, {"Join - " .. srv.name, srv.ip})
end

-- If you want to adjust the looks of the crash menu find file 'cl_menu.lua'
-- To enable readable error messages go to 'sh_start.lua'
-- Obviously this will require you to have some GLua knowledge
-- If you do manage to break something while editing this file do not ask for support, revert the changes instead

--[[////////////////////////// Contact & Support /////////////////////////////////
//                                                                              //
//        If you find any bugs or have a problem feel free to contact me:       //
//                    http://steamcommunity.com/id/ikefi                        //
//                     As my profile description states:                        //
//               i might not add you right away or not at all.                  //
//              it'll be better to just create a ticket instead.                //
//                                                                              //
////////////////////////////////////////////////////////////////////////////////]]