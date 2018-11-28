/* 
	This was coded by Moat.
*/

MSE = MSE or {
	Config = {},
	Version = "1"
}

MSE.IncludeSV = (SERVER) and include or function() end
MSE.IncludeCL = (SERVER) and AddCSLuaFile or include
MSE.IncludeSH = function(path) MSE.IncludeSV(path) MSE.IncludeCL(path) end

MSE.IncludeSH "_configs/misc.lua"
MSE.IncludeSH "util.lua"

MSE.IncludeSV "server/_mysql.lua"

hook.Add("Initialize", "MSE.Initialize", function() hook.Call("MSE_Initialize") end)