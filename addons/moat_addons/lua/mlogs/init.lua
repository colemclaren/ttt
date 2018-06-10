mlogs = mlogs or {
	cfg = {},
	Version = "MDL",
	Folder = "mlogs",
	Database = "moat_logs",
	ip = GetConVarString("ip") .. ":" .. GetConVarString("hostport")
}

mlogs.IncludeSV = (SERVER) and include or function() end
mlogs.IncludeCL = (SERVER) and AddCSLuaFile or include
mlogs.IncludeSH = function(path) mlogs.IncludeSV(path) mlogs.IncludeCL(path) end

mlogs.IncludeSH "util.lua"
mlogs.IncludeSH(mlogs.Folder .. "/config/config.lua")
mlogs.IncludeSH(mlogs.Folder .. "/shared/net.lua")

mlogs.Print "\nmlogs loading files.\n"

local Files, Folders
if (SERVER) then
	mlogs.Print "parsing serverside files"
	Files, Folders = file.Find(mlogs.Folder .. "/server/*.lua", "LUA")
	for k, v in ipairs(Files) do
		if (v == "sql_mysqloo.lua") then continue end

		mlogs.Print(" | " .. v)
		mlogs.IncludeSV(mlogs.Folder .. "/server/" .. v)
	end
end

mlogs.Print "parsing clientside files"
Files, Folders = file.Find(mlogs.Folder .. "/client/*.lua", "LUA")
for k, v in ipairs(Files) do
	mlogs.Print(" | " .. v)
	mlogs.IncludeCL(mlogs.Folder .. "/client/" .. v)
end

mlogs.Print "parsing shared files"
Files, Folders = file.Find(mlogs.Folder .. "/shared/*.lua", "LUA")
for k, v in ipairs(Files) do
	if (v == "sql_mysqloo.lua") then continue end

	mlogs.Print(" | " .. v)
	mlogs.IncludeSH(mlogs.Folder .. "/shared/" .. v)
end

dlogs.Print "mlogs loaded successfully."

hook.Add("Initialize", "mlogs.Initialize", function() hook.Call("mlogs_Initialize") end)