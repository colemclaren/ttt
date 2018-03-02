-- Generated from: glib/lua/glib/garrysmod/servers/playermonitorentry.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/garrysmod/servers/playermonitorentry.lua
-- Timestamp:      2016-02-22 19:22:23
local self = {}
CAC.PlayerMonitorEntry = CAC.MakeConstructor (self)

function self:ctor (ply)
	self.Player = ply
	self.Index = ply:EntIndex ()
	self.SteamId = CAC.GetPlayerId (ply)
	self.UserId = ply:UserID ()
end

function self:GetIndex ()
	return self.Index
end

function self:GetPlayer ()
	return self.Player
end

function self:GetSteamId ()
	return self.SteamId
end

function self:GetUserId ()
	return self.UserId
end