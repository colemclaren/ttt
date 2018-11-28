AddCSLuaFile()

----
-- hey welcome to the codebase of moat.gg
-- hope u enjoy ur stay
----
-- careful, there's ghosts
-- u know what that means uwu
----

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