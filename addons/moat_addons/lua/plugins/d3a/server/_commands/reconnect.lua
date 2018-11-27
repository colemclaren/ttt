COMMAND.Name = "Reconnect"
COMMAND.Flag = D3A.Config.Commands.Reconnect

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1]:SendLua("LocalPlayer():ConCommand('retry')")
	
	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has reconnected ", moat_green, supp[1]:NameID(), moat_white, ".")
	D3A.Commands.Discord("reconnect", D3A.Commands.NameID(pl), (IsValid(supp[1]) and supp[1]:NameID()) or "Unknown (???)")
end