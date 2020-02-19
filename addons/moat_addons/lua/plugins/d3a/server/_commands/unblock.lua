COMMAND.Name = "unblock"
COMMAND.Flag = D3A.Config.Commands.PlayTime

COMMAND.Args = {{"player", "Name/SteamID"}}

util.AddNetworkString "moat_unblock"

COMMAND.Run = function(pl, args, supp)
	if (pl:SteamID() == supp[1]:SteamID()) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You cannot unblock yourself!")
		return
	end

	net.Start("moat_unblock")
	net.WriteString(supp[1]:SteamID())
	net.Send(pl)

	D3A.Chat.SendToPlayer2(pl, moat_white," You have ", moat_cyan, "unblocked ", moat_white, "communications with ", moat_green, supp[1]:Name(), moat_white, ".")
	-- D3A.Commands.Discord("unblock", D3A.Commands.NameID(pl), IsValid(supp[1]) and supp[1]:NameID())
end