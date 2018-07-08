-- This file simply loads the discord relay. You don't need to edit this file, or anything in autorun anymore.

if SERVER then
	include("discord_relay/server/sv_config.lua") -- Order of operation bullshit.
	include("discord_relay/shared/sh_discordcolors.lua") -- Colors next
	include("discord_relay/server/sv_relay.lua") -- And finally the bulk of the script.
	AddCSLuaFile("discord_relay/shared/sh_discordcolors.lua")
	AddCSLuaFile("discord_relay/client/cl_relay.lua")
end

if CLIENT then
	include("discord_relay/shared/sh_discordcolors.lua")
	include("discord_relay/client/cl_relay.lua")
end

MsgC(COLOR_DISCORD, "[Discord]", COLOR_USERNAME, " Hooray! ", COLOR_MESSAGE, "Relay version 1.2.8 (Hotfix 3) has been loaded!\nThis script is free.!\n")