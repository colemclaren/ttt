D3A.Config.Path = "plugins/d3a/"
D3A.Config.MoTD = "https://google.com" -- Set to blank for no motd

-- These are used to determine what ranks IsAdmin and IsAdmin IsSuperAdmin return true on
D3A.Config.IsAdmin 			= "t"
D3A.Config.IsSuperAdmin 	= "*"


-- Misc
D3A.Config.PlayerNoClip 	= "*"
D3A.Config.PlayerPhysgun 	= "*"
D3A.Config.StaffChat	 	= "t"


--[[
	Automatic chat advertisements
]]
D3A.Config.Adverts = {
	{
		Time = 10,
		Reps = 1, -- 0 for it to loop forever
		Message = {Color(245,245,245), "This server runs D",  Color(0,245,0), "3", Color(245,245,245), "A!"},
	},
	{
		Time = 120,
		Repos = 0,
		Message = {Color(255,0,0), "Support us to get dank shit and give us money!"},
	},
}

--[[
	Use this to make D3A pass certain commands through without parsing or blocking them
	i.e. for !logs to work from an external logging addon, add "logs" to this table
]]
D3A.Config.IgnoreChatCommands = {
	"plogs",
	"report",
	"respond",
	"hitreg",
	"trade",
	"steam",
	"mapvote",
	"mv",
	"forums",
	"forum",
	"rm",
	"reloadmaterials",
	"reloadmats",
	"materials",
	"textures",
	"m",
	"rtv",
	"shrug",
	"tableflip",
	"unflip"
}

--[[
	Use this to set the flag for any stock d3a commands
]]
D3A.Config.Commands = {
	Adminmode 	= "*",
	Ban 		= "m",
	Perma 		= "a",
	Bring 		= "m",
	ClearDecals	= "m",
	CrashBan 	= "*",
	ForceMoTD 	= "m",
	Freeze 		= "*",
	GetMoney	= "*",
	Goto 		= "a",
	Jail 		= "m",
	JailTP 		= "m",
	Kick 		= "t",
	MoTD 		= "", -- Empty will just let anyone use it
	MuteChat 	= "t",
	MuteVoice 	= "t",
	NoLag 		= "a",
	PlayTime 	= "",
	PO 			= "t",
	Reconnect 	= "a",
	Reload 		= "s",
	Respawn 	= "*",
	Return 		= "s",
	Send 		= "s",
	SetArmor 	= "*",
	SetGroup 	= "h",
	SetHealth 	= "*",
	Slay 		= "m",
	StopSounds 	= "a",
	StripWeps 	= "*",
	Tele 		= "a",
	Unban 		= "s"
}

-- Used for commands ran by Server Console
D3A.Console = "Console (CONSOLE)"