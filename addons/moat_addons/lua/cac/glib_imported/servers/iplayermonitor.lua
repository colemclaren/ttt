-- Generated from: glib/lua/glib/servers/iplayermonitor.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/servers/iplayermonitor.lua
-- Timestamp:      2016-02-22 19:22:23
local self = {}
CAC.IPlayerMonitor = CAC.MakeConstructor (self)

--[[
	Events:
		LocalPlayerConnected (Player ply, userId)
			Fired when the local client's player entity has been created.
		PlayerConnected (Player ply, userId, isLocalPlayer)
			Fired when a player has connected and has a player entity.
		PlayerDisconnected (Player ply, userId)
			Fired when a player has disconnected.
]]

function self:ctor ()
	CAC.EventProvider (self)
end

function self:AddPlayerExistenceListener (nameOrCallback, callback)
	CAC.Error ("IPlayerMonitor:AddPlayerExistenceListener : Not implemented.")
end

function self:RemovePlayerExistenceListener (nameOrCallback)
	CAC.Error ("IPlayerMonitor:RemovePlayerExistenceListener : Not implemented.")
end

-- Enumerates connected players.
-- Returns: () -> (userId, Player player)
function self:GetPlayerEnumerator ()
	CAC.Error ("IPlayerMonitor:GetPlayerEnumerator : Not implemented.")
end

function self:GetUserEntity (userId)
	CAC.Error ("IPlayerMonitor:GetUserEntity : Not implemented.")
end

function self:GetUserEntities (userId)
	CAC.Error ("IPlayerMonitor:GetUserEntities : Not implemented.")
end

-- Enumerates user ids.
-- Returns: () -> userId
function self:GetUserEnumerator ()
	CAC.Error ("IPlayerMonitor:GetUserEnumerator : Not implemented.")
end

function self:GetUserName (userId)
	CAC.Error ("IPlayerMonitor:GetUserName : Not implemented.")
end

function self:IsUserPresent (userId)
	CAC.Error ("IPlayerMonitor:IsUserPresent : Not implemented.")
end