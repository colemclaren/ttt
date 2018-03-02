--[[ Config ]]--

	Prometheus.WebsiteEnabled = true -- If true, the chat command will be enabled (Opens menu)

	Prometheus.WebsiteCmd = "!donatemenu" -- Command they need to type in chat to open your website

	Prometheus.CanCheckRankCmd = false -- Can people re-check their ranks?
		Prometheus.CheckRankCmd = "!checkrank" -- Command they can type in chat to force a re-check on their rank which will assign them the latest rank that they have bought(Can happen in all kinds of cases, admin mod messes up, rank files are lost etc)

	Prometheus.SeperateForSite = true -- Set to true if you want to use seperate chat commands for opening donation page and opening menu
		Prometheus.OpenDonationCmd = "!donate" -- Used only if Prometheus.SeperateForSite is set to true, keep in mind to not have both be same command

	Prometheus.DropPermaWeaponOnDeath = false -- Should a permanent weapon given by Prometheus drop when a person dies
	Prometheus.CanDropPermaWeapon = false -- Can a perma weapon be dropped? If set to false weapon will be destroyed when dropped(Except on DarkRP where it simply cannot be dropped).

	Prometheus.Access.AdminMenu = {"owner"} -- Groups that can access the admin menu. Examples: {"admin"}  {"admin", "superadmin", "owner"}     For AssMod use the number of the rank like: {1, 2}

	Prometheus.NotifyEveryone = true -- If true, it will send a notification to everyone that a person on server has gotten a package

	Prometheus.RefreshTime = 40 -- How often should it check for new actions (In seconds)

	Prometheus.PlayerPackageCooldown = 10 -- How many seconds a person needs to wait before they can refresh their active packages(In menu)

	Prometheus.ServerID = 2 -- ID of this server, will be given to you when you create it on your web side of prometheus

	Prometheus.DebugInfo = false -- If enabled, will show debug info of actions, actions and other things in server console

	Prometheus.LoadSettingsFromDB = true -- If false, will always use the FallBackSettings, useful if you want different servers to have different text in the notifications(Different language servers)

	Prometheus.Mysql.Host = "web-panel01.gmchosting.com"
	Prometheus.Mysql.Port = 3306
	Prometheus.Mysql.Username = "mgdonate"
	Prometheus.Mysql.Password = "h8324ksnawuo89pokx"
	Prometheus.Mysql.DBName = "moatgaming_prometheus"

--[[ End of Config ]]--







--[[ Fallback Config ]]-- No need to edit! In here are settings that are set up using the web interface, but in case of a failed connection, these will be used.

	Prometheus.FallbackSettings.message_receiverPerma = "You have received a donator package. {package}. This package is permanent and does not expire." -- Message that will show up to the package reciever. {name} gets replaced by persons name, {package} gets replaced by packages name.
	Prometheus.FallbackSettings.message_receiverNonPerma = "You have received a donator package. {package}. This package is not permanent and expires {expire}." -- Message that will show up to everyone else(If enabled). {name} gets replaced by persons name, {package} gets replaced by packages name, {expire} gets replaced by date on which package expires (YYYY-MM-DD).
	Prometheus.FallbackSettings.message_receiverRevoke = "Your package, {package} has been revoked. If you believe this is unjustified, please contact an administrator." -- Message that will show up to the package reciever if their package gets revoked. {name} gets replaced by persons name, {package} gets replaced by packages name.
	Prometheus.FallbackSettings.message_receiverExpire = "Your package, {package} has expired." -- Message that will show up to the package reciever when their package expires. {name} gets replaced by persons name, {package} gets replaced by packages name.
	Prometheus.FallbackSettings.message_othersCredits = "{name} has donated and received {amount} credit(s)" -- Message that will show up to everyone when someone buys a credit package. {name} gets replaced by persons name, {amount} gets replaced by the amount of credits they receive.
	Prometheus.FallbackSettings.message_receiverCredits = "You have received {amount} credit(s)" -- Message that will show up to the person when they buy a credit package. {amount} gets replaced by the amount of credits they receive.
	Prometheus.FallbackSettings.message_others = "{name} has received their package, {package} for donating!" -- Message that will show up to everyone else when receiver gets their package. Works if Prometheus.NotifyEveryone is true. {name} gets replaced by persons name, {package} gets replaced by packages name, {expire} gets replaced by date on which package expires (YYYY-MM-DD).

--[[ End of Fallback Config ]]--