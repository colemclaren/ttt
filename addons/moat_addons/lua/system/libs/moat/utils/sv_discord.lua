moat.discord = moat.discord or {}

-- webhook urls located in constants/sv_discord.lua
function moat.discord.send(webhook, message, name, no_bot_suffix)
	if (not webhook) then return end

	local webhookurl = moat.discord.webhooks[webhook:lower()]
	if (not webhookurl or not SVDiscordRelay or not SVDiscordRelay.SendToDiscordRaw) then return end

	name = name and name:gsub("^.", string.upper) or webhook:gsub("^.", string.upper)
	if (not no_bot_suffix) then name = name .. " Bot" end
	SVDiscordRelay.SendToDiscordRaw(name, false, message, webhookurl)
end