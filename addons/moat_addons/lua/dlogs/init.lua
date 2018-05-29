dlogs = dlogs or {
	Config = {},
	Version = "MDL",
	Folder = "dlogs"
}

dlogs.IncludeSV = (SERVER) and include or function() end
dlogs.IncludeCL = (SERVER) and AddCSLuaFile or include
dlogs.IncludeSH = function(path) dlogs.IncludeSV(path) dlogs.IncludeCL(path) end

dlogs.IncludeSH "util.lua"
dlogs.IncludeSH(dlogs.Folder .. "/config/config.lua")

dlogs.Print "\ndlogs loading files.\n"

local Files, Folders
if (SERVER) then
	dlogs.Print "parsing serverside files"
	Files, Folders = file.Find(dlogs.Folder .. "/server/*.lua", "LUA")
	for k, v in ipairs(Files) do
		if (v == "sql_mysqloo.lua") then continue end

		dlogs.Print(" | " .. v)
		dlogs.IncludeSV(dlogs.Folder .. "/server/" .. v)
	end
end

dlogs.Print "parsing clientside files"
Files, Folders = file.Find(dlogs.Folder .. "/client/*.lua", "LUA")
for k, v in ipairs(Files) do
	dlogs.Print(" | " .. v)
	dlogs.IncludeCL(dlogs.Folder .. "/client/" .. v)
end

dlogs.Print "parsing shared files"
Files, Folders = file.Find(dlogs.Folder .. "/shared/*.lua", "LUA")
for k, v in ipairs(Files) do
	dlogs.Print(" | " .. v)
	dlogs.IncludeSH(dlogs.Folder .. "/shared/" .. v)
end

dlogs.Print "dlogs loaded successfully."

hook.Add("Initialize", "dlogs.Initialize", function() hook.Call("dlogs_Initialize") end)