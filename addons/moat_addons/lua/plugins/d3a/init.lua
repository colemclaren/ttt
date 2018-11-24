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
D3A.Print("This server runs a custom admin mod " .. D3A.Version .. " titled MGA by moat.\n\n")

D3A.IncludeSV "server/_mysql.lua"
D3A.IncludeSH "shared/sh_player_extension.lua"

print "\n"
print "=================================================================================="
print "==================================================================================\n\n"

hook.Add("Initialize", "D3A.Initialize", function() hook.Call("D3A_Initialize", GAMEMODE) end)
