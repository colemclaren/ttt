dlogs.Config.SoundsURL = "https://i.moat.gg/servers/ttt/dlogs/"

dlogs.Config:AddGroup("communitylead", 4, true)
dlogs.Config:AddGroup("headadmin", 4, true)
dlogs.Config:AddGroup("senioradmin", 3, true)
dlogs.Config:AddGroup("admin", 3, true)
dlogs.Config:AddGroup("moderator", 3, true)
dlogs.Config:AddGroup("trialstaff", 3, true)
dlogs.Config:AddGroup("credibleclub", 2, false)
dlogs.Config:AddGroup("vip", 2, false)
dlogs.Config:AddGroup("user", 2, false)
dlogs.Config:AddGroup("guest", 2, false)

dlogs.Config.Key = KEY_F8

-- true to enable the RDM Manager, false to disable it

--[[ Set to true if you want to enable MySQL (it needs to be configured on config/mysqloo.lua)
	Setting it to false will make the logs use SQLite (garrysmod/sv.db)
]]--

dlogs.Use_MySQL = true

--[[ Autoslay and Autojail Mode
REQUIRES ULX ! If you are using ServerGuard, set this to 0 (it will use ServerGuard's autoslay automatically)
- 0 : Disables autoslay
- 1 : Enables the !aslay and !aslayid command for ULX, designed to work with the logs.
	  Works like that : !aslay target number_of_slays reason
	  Example : !aslay tommy228 2 RDMing a traitor
	  Example : !aslayid STEAM_0:0:1234567 2 RDMing a traitor
- 2 : Enables the autojail system instead of autoslay. Replaces the !aslay and !aslay commands by !ajail and !ajailid
]]--

dlogs.ULX_AutoslayMode = 1

-- Force autoslain players to be innocents (ULX only)
-- Do not enable this if another addon interferes with roles (Pointshop roles for example)

dlogs.ULX_Autoslay_ForceRole = true

-- Default autoslay reasons (ULX and ServerGuard)

dlogs.Autoslay_DefaultReasons = {
	"accidental rdm",
	"accidental mass rdm",
	"victim doesn't forgive :(",
	"rdm and leave",
	"report response not adding up",
	"lying in report"
}

-- Default ban reasons (ULX and ServerGuard)

dlogs.Ban_DefaultReasons = {
	"Purposeful RDM",
	"Purposeful Mass RDM",
	"Attempted Mass RDM",
	"Revenge RDM",
	"Hateful Conduct",
	"Spamming",
	"Trolling",
	"Cheating"
}

-- The number of days the logs last on the database (to avoid lags when opening the menu)

dlogs.LogDays = 30

-- Use the Workshop to download content files

dlogs.UseWorkshop = false

-- Force a language - When empty use user-defined language

dlogs.ForcedLanguage = ""

-- Allow reports even with no staff online

dlogs.NoStaffReports = true

-- Allow more than 2 reports per round

dlogs.MoreReportsPerRound = false

-- Allow reports before playing

dlogs.ReportsBeforePlaying = false

-- Private message prefix from RDM Manager

dlogs.PrivateMessagePrefix = "[RDM Manager]"