AddCSLuaFile()

----
-- Need to report a bug? We'd love to talk with you! <3<3<3"
-- The best way to contact us is on our partnered Discord server. (our dm's are open)
----

Devs = {
	{
		Name = "Motato", 
		SteamID = "STEAM_0:0:46558052", 
		SteamID64 = "76561198053381832",
		DiscordTag = "motato#0001", 
		DiscordID = "207612500450082816"
	},
	{
		Name = "Meepen", 
		SteamID = "STEAM_0:0:44950009", 
		SteamID64 = "76561198050165746", 
		DiscordTag = 'Meepen#0073', 
		DiscordID = '150809682318065664'
	},
	{
		Name = "Velkon", 
		SteamID = "STEAM_0:0:96933728", 
		SteamID64 = "76561198154133184", 
		DiscordTag = 'velkon#1234', 
		DiscordID = '135912347389788160'
	},
	{
		Name = "Ling!!", 
		SteamID = "STEAM_0:0:42138604", 
		SteamID64 = "76561198044542936", 
		DiscordTag = 'Ling#1951', 
		DiscordID = '151709321284026368'
	}
}

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