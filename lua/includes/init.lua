-- Init
if (CLIENT) then
	RunConsoleCommand("con_filter_enable", "1")
	RunConsoleCommand("con_filter_text", "")
	RunConsoleCommand("con_filter_text_out", "creating")
end

if (SERVER) then
	AddCSLuaFile()
	AddCSLuaFile 'dash/init.lua'
end
include 'dash/init.lua'

dash.IncludeSH '_init.lua'

-- Extensions
for k, v in pairs(dash.LoadDir('extensions')) do
	dash.IncludeSH(v)
end
for k, v in pairs(dash.LoadDir('extensions/server')) do
	dash.IncludeSV(v)
end
for k, v in pairs(dash.LoadDir('extensions/client')) do
	dash.IncludeCL(v)
end