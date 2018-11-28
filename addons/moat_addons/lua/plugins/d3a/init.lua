/* 
	This was coded by KingofBeast & updated by aStonedPenguin.
	Licensed to http://steamcommunity.com/profiles/76561198053381832/
*/

D3A = D3A or {
	Config = {},
	Alias = "MGA",
	Version = "1.51",
}

D3A.IncludeSV = (SERVER) and include or function() end
D3A.IncludeCL = (SERVER) and AddCSLuaFile or include
D3A.IncludeSH = function(path) D3A.IncludeSV(path) D3A.IncludeCL(path) end

D3A.IncludeSH "_configs/misc.lua"
D3A.IncludeSH "util.lua"
D3A.IncludeSV "server/_mysql.lua"
D3A.IncludeSH "shared/sh_player_extension.lua"

hook.Add("Initialize", "D3A.Initialize", function() hook.Call("D3A_Initialize", GAMEMODE) end)
