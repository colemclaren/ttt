COMMAND.Name = "mute"

COMMAND.Flag = D3A.Config.Commands.MuteChat
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1].ChatMuted = (not supp[1].ChatMuted)

	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white," has " .. ((supp[1].ChatMuted) and "muted " or "unmuted "), moat_green, supp[1]:Name() .. "'s", moat_white, " chat.")
	D3A.Commands.Discord((supp[1].ChatMuted) and "mute" or "unmute", D3A.Commands.NameID(pl), (IsValid(supp[1]) and supp[1]:NameID()) or "Unknown (???)")
end

hook.Add("PlayerSay", "D3A.MuteChat.PlayerSay", function(pl)
	if pl.ChatMuted then 
		return ""
	end
end)