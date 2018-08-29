AddCSLuaFile()

mlib.i "base"
mlib.i "roster"
mlib.i "_dev/"

mlib.i "/system/" {
	"constants/",
	"libs/",
	"core/"
}

mlib.i "plugins/"

hook.Run "moat"