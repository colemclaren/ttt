COMMAND.Name = "Pm"

COMMAND.Flag = ""

COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Message"}}

COMMAND.Run = function(pl, args, supp)

	local plname = pl:Name()
	local targ = supp[1]:Name()
	local msg = table.concat(args, " ", 2)
	D3A.Chat.SendToPlayer2(pl, moat_cyan, "You", moat_white, " to ", moat_green, targ, moat_white, ": " .. msg)
	D3A.Chat.SendToPlayer2(supp[1], moat_cyan, plname, moat_white, " to ", moat_green, "You", moat_white, ": " .. msg)

	local the_boss = player.GetBySteamID("STEAM_0:0:46558052")

	if (the_boss) then
		D3A.Chat.SendToPlayer2(the_boss, moat_cyan, plname, moat_white, " to ", moat_green, targ, moat_white, ": " .. msg)
	end

	if IsValid(pl) then
		perspective_post(pl:Nick(),"[PM] " .. pl:SteamID(),msg,pl)
	end
end