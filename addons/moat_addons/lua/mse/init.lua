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

MSE.IncludeSH "mse_configs/misc.lua"
MSE.IncludeSH "util.lua"

MSE.Print "\nThis server runs MSE coded by Moat for MG.\n"

if (SERVER) then
	MSE.IncludeSV "mse_configs/mysql.lua"
	MSE.IncludeSV "mse/server/mysql/sv_init.lua"
end

local Files, Folders
if (SERVER) then
	MSE.Print "Parsing serverside files"
	Files, Folders = file.Find("mse/server/*.lua", "LUA")
	for k, v in ipairs(Files) do
		MSE.Print(" | " .. v)
		MSE.IncludeSV("mse/server/" .. v)
	end
end

MSE.IncludeSV "mse_configs/ranks.lua"

MSE.Print "Parsing clientside files"
Files, Folders = file.Find("mse/client/*.lua", "LUA")
for k, v in ipairs(Files) do
	MSE.Print(" | " .. v)
	MSE.IncludeCL("mse/client/" .. v)
end
	
MSE.Print "Parsing shared files"
Files, Folders = file.Find("mse/shared/*.lua", "LUA")
for k, v in ipairs(Files) do
	MSE.Print(" | " .. v)
	MSE.IncludeSH("mse/shared/" .. v)
end

MSE.IncludeSH "mse_configs/commands.lua"

MSE.Print "MSE loaded successfully."

hook.Add("Initialize", "MSE.Initialize", function() hook.Call("MSE_Initialize") end)