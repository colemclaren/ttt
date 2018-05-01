MOAT_INV = MOAT_INV or {
	Config = {},
	Version = "2.0"
}

MOAT_INV.IncludeSV = (SERVER) and include or function() end
MOAT_INV.IncludeCL = (SERVER) and AddCSLuaFile or include
MOAT_INV.IncludeSH = function(path) MOAT_INV.IncludeSV(path) MOAT_INV.IncludeCL(path) end
MOAT_INV.IncludeSH "util.lua"

MOAT_INV.Print "Initializing Moat Inventory."

local Files, Folders
if (SERVER) then
	MOAT_INV.Print "Parsing serverside files"
	Files, Folders = file.Find("moat_inv/server/*.lua", "LUA")
	for k, v in ipairs(Files) do
		MOAT_INV.Print(" | " .. v)
		MOAT_INV.IncludeSV("moat_inv/server/" .. v)
	end
end

MOAT_INV.Print "Parsing clientside files"
Files, Folders = file.Find("moat_inv/client/*.lua", "LUA")
for k, v in ipairs(Files) do
	MOAT_INV.Print(" | " .. v)
	MOAT_INV.IncludeCL("moat_inv/client/" .. v)
end

MOAT_INV.Print "Parsing shared files"
Files, Folders = file.Find("moat_inv/shared/*.lua", "LUA")
for k, v in ipairs(Files) do
	MOAT_INV.Print(" | " .. v)
	MOAT_INV.IncludeSH("moat_inv/shared/" .. v)
end

MOAT_INV.Print "Moat Inventory loaded successfully."

hook.Add("Initialize", "MOAT_INV.Initialize", function() hook.Call("MOAT_INV.Initialize") end)