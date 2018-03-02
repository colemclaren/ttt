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

D3A.IncludeSH "d3a_configs/misc.lua"
D3A.IncludeSH "util.lua"


print "\n"
print "=================================================================================="
print "==================================================================================\n"
print [[
88b           d88   ,ad8888ba,        db       
888b         d888  d8"'    `"8b      d88b      
88`8b       d8'88 d8'               d8'`8b     
88 `8b     d8' 88 88               d8'  `8b    
88  `8b   d8'  88 88      88888   d8YaaaaY8b   
88   `8b d8'   88 Y8,        88  d8""""""""8b  
88    `888'    88  Y8a.    .a88 d8'        `8b 
88     `8'     88   `"Y88888P" d8'          `8b]]


print "\n\n"
D3A.Print("This server runs a heavily modified version of D3A " .. D3A.Version .. " titled MGA. Original D3A was coded by KingofBeast & updated by aStonedPenguin. Heavily modded for MoatGaming TTT by Moat.\n\n")

if (SERVER) then
	D3A.IncludeSV "d3a_configs/mysql.lua"
	if D3A.Config.hostname == "1.2.3.4" then -- for the dev server
		D3A.IncludeSV "d3a_mysql_dev.lua"
	end
	D3A.IncludeSV "d3a/server/mysql/sv_init.lua"
end

local Files, Folders
if (SERVER) then
	D3A.Print("Parsing serverside files")
	Files, Folders = file.Find("d3a/server/*.lua", "LUA")
	for k, v in ipairs(Files) do
		D3A.Print(" | " .. v)
		D3A.IncludeSV("d3a/server/" .. v)
	end
end

D3A.IncludeSV "d3a_configs/ranks.lua"

D3A.Print("Parsing clientside files")
Files, Folders = file.Find("d3a/client/*.lua", "LUA")
for k, v in ipairs(Files) do
	D3A.Print(" | " .. v)
	D3A.IncludeCL("d3a/client/" .. v)
end

D3A.Print("Parsing shared files")
Files, Folders = file.Find("d3a/shared/*.lua", "LUA")
for k, v in ipairs(Files) do
	D3A.Print(" | " .. v)
	D3A.IncludeSH("d3a/shared/" .. v)
end

D3A.Print("Scripts loaded. Initializing when GM is ready.")
print "\n"
print "=================================================================================="
print "==================================================================================\n\n"

hook.Add("Initialize", "D3A.Initialize", function() hook.Call("D3A_Initialize", GAMEMODE) end)
