COMMAND.Name = "gag"

COMMAND.Flag = D3A.Config.Commands.MuteVoice
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1].VoiceMuted = (not supp[1].VoiceMuted)

	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white," has " .. ((supp[1].VoiceMuted) and "gagged " or "ungagged "), moat_green, supp[1]:Name() .. "'s", moat_white, " voice.")
	D3A.Commands.Discord((supp[1].VoiceMuted) and "gag" or "ungag", D3A.Commands.NameID(pl), (IsValid(supp[1]) and supp[1]:NameID()) or "Unknown (???)")
end

hook.Add("PlayerCanHearPlayersVoice", "D3A.MuteVoice.PlayerCanHearPlayersVoice", function(listener, talker)
	if talker.VoiceMuted then 
		return false
	end
end)