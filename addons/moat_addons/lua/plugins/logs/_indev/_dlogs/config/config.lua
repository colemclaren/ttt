dlogs.Config:AddGroup("communitylead", 4, true)
dlogs.Config:AddGroup("headadmin", 4, true)
dlogs.Config:AddGroup("senioradmin", 3, true)
dlogs.Config:AddGroup("admin", 3, true)
dlogs.Config:AddGroup("moderator", 3, true)
dlogs.Config:AddGroup("trialstaff", 3, true)
dlogs.Config:AddGroup("hoodninja", 2, false)
dlogs.Config:AddGroup("starplayer", 2, false)
dlogs.Config:AddGroup("nba", 2, false)
dlogs.Config:AddGroup("user", 2, false)
dlogs.Config:AddGroup("guest", 2, false)

dlogs.Config.Key = KEY_F8
dlogs.Config.Config.Use_MySQL = true
dlogs.Config.LogDays = 30
dlogs.Config.NoStaffReports = true
dlogs.Config.MoreReportsPerRound = false
dlogs.Config.ReportsBeforePlaying = false
dlogs.Config.PrivateMessagePrefix = "[RDM Manager]"
dlogs.Config.SoundsURL = "https://i.moat.gg/servers/ttt/dlogs/"

dlogs.Config.Autoslay_DefaultReasons = {
	"accidental rdm",
	"accidental mass rdm",
	"victim doesn't forgive :(",
	"rdm and leave",
	"report response not adding up",
	"lying in report"
}

dlogs.Config.Ban_DefaultReasons = {
	"Purposeful RDM",
	"Purposeful Mass RDM",
	"Attempted Mass RDM",
	"Revenge RDM",
	"Hateful Conduct",
	"Spamming",
	"Trolling",
	"Cheating"
}