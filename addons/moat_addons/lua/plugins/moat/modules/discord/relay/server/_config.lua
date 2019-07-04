-- Config
DiscordRelay = DiscordRelay or {}

-- Set this to your webhook URL.
DiscordRelay.WebhookURL = moat.cfg.discord.primarywebhook

-- Set this to your Steam Web API Key
DiscordRelay.SteamWebAPIKey = "13E8032658377F036842094BDD9E7000"

-- Set this to your Bot Token. Your bot must be added to your server.
DiscordRelay.BotToken = "MzEwNDM5MDc0MzQ1NTE3MDU2.C-9-dA.TxjVe6t01UdCaC3PydRm6fJAUxE"

-- Set this to your Channel ID. You can get this number in Discord by typing \#channelnamehere into chat.
-- Remove the <# at the start and the > at the end, so you are left with only a long number.
DiscordRelay.DiscordChannelID = "310440237635600385"


/*----------------------------------------
Non Critical Config Options Below
------------------------------------------*/

-- Set this to the prefix you want on usernames sent to Discord. A space is automatically appended.
DiscordRelay.ServerPrefix = "[In-Game]"

-- Set this to the delay between fetching messages. Increase this if you are getting rate limited. Don't put this below 2.
DiscordRelay.MessageDelay = 2

-- Set this to the max amount of messages to retrieve
DiscordRelay.MaxMessages = 10

-- Disable team chat? Useful for some gamemodes
DiscordRelay.BLockTeamChat = false

-- If the message we detect on gmod starts with anything in this table, we will not relay it.
-- Example: If the message is "!p player HI THERE" and you add "!" to this table, the message will not be relayed.
DiscordRelay.BlockedCommands = {"/","!"}

-- If we detect this at the start of a message, we will send it to discord. If nothing there, we will send all messages.
-- Bypasses BlockedCommands. Set it to {} to disable whitelist.
DiscordRelay.EnableWhitelist = false
DiscordRelay.WhitelistCommands = {}

-- Announce disconnects and connects to Discord? This includes their nickname on join, and their SteamID.
-- AnnounceOnline announces when the server has started up, and gives a link for people to join the server with.
DiscordRelay.AnnounceConnect = true
DiscordRelay.AnnounceDisconnect = true
DiscordRelay.AnnounceOnline = true

-- Use this option to override the text shown to users in discord when AnnounceOnline is enabled.
-- {hostname} is your built in hostname, and {ipaddress} is the ip address (with port) for connecting. {steamconnect} builds a steam connection url.
-- Set this to nil or "" if you want the default one.
DiscordRelay.OverrideOnlineMessage = "{hostname} is currently online!"

-- Use this to override connect messages
-- {username} for their name, {steamid} for their steamid, {hostname} for the server they joined.
-- {ipaddress} is the ip address (with port) for connecting. {steamconnect} builds a steam connection url.
-- Set this to nil or "" if you want the default one.
DiscordRelay.OverrideConnectMessage = "{username} ({steamid}) has joined {hostname}!"

-- Use this to override disconnect messages
-- {username for their name, {steamid} for their steamid, {hostname} for the server they left.
-- {ipaddress} is the ip address (with port) for connecting. {steamconnect} builds a steam connection url.
-- Set this to nil or "" if you want the default one.
DiscordRelay.OverrideDisconnectMessage = "{username} ({steamid}) has left {hostname} ({reason})!"

-- Should we avoid using a bot? You may need to add "sv_hibernate_think 1" to your server.cfg file.
-- If your server isn't announcing online status or you keep saeing "HTTP failed - ISteamHTTP isn't available" in your console, set this to false.
DiscordRelay.AvoidUsingBots = true

-- DEBUG MODE! Do not enable this unless you've been told to. It can get spammy in the console if you enable this.
-- As it stands, this only serves the purpose of identifying problems not identified by discord's json responses.
DiscordRelay.DEBUG_MODE = false