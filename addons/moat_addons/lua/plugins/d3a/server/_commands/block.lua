COMMAND.Name = "block"
COMMAND.Flag = D3A.Config.Commands.PlayTime

COMMAND.Args = {{"player", "Name/SteamID"}}

util.AddNetworkString "moat_block"

COMMAND.Run = function(pl, args, supp)
	if (pl:SteamID() == supp[1]:SteamID()) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You cannot block yourself!")
		return
	end

	net.Start("moat_block")
	net.WriteString(supp[1]:SteamID())
	net.Send(pl)

	D3A.Chat.SendToPlayer2(pl, moat_white," You have ", moat_cyan, "blocked ", moat_white, "communications with ", moat_green, supp[1]:Name(), moat_white, ".")
	D3A.Commands.Discord("block", (IsValid(pl) and pl:NameID()) or D3A.Console, IsValid(supp[1]) and supp[1]:NameID())
end