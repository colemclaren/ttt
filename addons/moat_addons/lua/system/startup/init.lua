AddCSLuaFile()
/*
if (not Server) then
	return error "OOPSIE WOOPSIE!! Uwu We made a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!"
end
*/
mlib.i "base"
mlib.i "roster"
mlib.i "_dev/"
mlib.i "/system/" {
	"constants/",
	"libs/",
	"core/",
	"detours/"
}

mlib.i "plugins/"
hook.Run "moat"