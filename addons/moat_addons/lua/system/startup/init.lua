AddCSLuaFile()

----
-- Need to report a bug? We'd love to talk with you! <3<3<3
-- The best way to contact us is on our partnered Discord server. (our dm's are open)
----

mlib.i "base"

mlib.i "servers"
mlib.i "ranks"
mlib.i "whitelist"

mlib.i "_dev/"

mlib.i "/system/" {
	"constants/",
	"libs/",
	"core/",
	"detours/"
}
mlib.i "plugins/"

mlib.i "print"

hook.Run "moat"