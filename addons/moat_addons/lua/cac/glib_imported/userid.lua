-- Generated from: glib/lua/glib/userid.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/userid.lua
-- Timestamp:      2016-02-22 19:22:23
local singleplayerId = nil

function CAC.GetEveryoneId ()
	return "Everyone"
end

if SERVER then
	function CAC.GetLocalId ()
		return "Server"
	end
elseif CLIENT then
	function CAC.GetLocalId ()
		if not LocalPlayer or not LocalPlayer ().SteamID then
			return "STEAM_0:0:0"
		end
		return LocalPlayer ():SteamID ()
	end
end

function CAC.GetPlayerId (ply)
	if not ply then return nil end
	if not ply:IsValid () then return nil end
	if type (ply.SteamID) ~= "function" then return nil end
	
	local steamId = ply:SteamID ()
	
	if SERVER and game.SinglePlayer () and ply == ents.GetByIndex (1) then
		steamId = singleplayerId
	end
	
	if steamId == "NULL" then
		steamId = "BOT"
	end
	
	return steamId
end

function CAC.GetServerId ()
	return "Server"
end

function CAC.GetSystemId ()
	return "System"
end

if game.SinglePlayer () then
	if SERVER then
		concommand.Add ("cac_singleplayerid",
			function (_, _, args)
				singleplayerId = args [1]
			end
		)
		
		umsg.Start ("cac_request_singleplayerid")
		umsg.End ()
	elseif CLIENT then
		local function sendSinglePlayerId ()
			CAC.WaitForLocalPlayer (
				function ()
					RunConsoleCommand ("cac_singleplayerid", CAC.GetLocalId ())
				end
			)
		end
		
		usermessage.Hook ("cac_request_singleplayerid", sendSinglePlayerId)
		sendSinglePlayerId ()
	end
end