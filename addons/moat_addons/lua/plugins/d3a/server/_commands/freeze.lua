COMMAND.Name = "Freeze"

COMMAND.Flag = D3A.Config.Commands.Freeze
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	local targ = supp[1]
	
	if (not targ:IsFrozen()) then
		targ:Freeze(true)
		
		D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has frozen ", moat_green, targ:Name(), moat_white, ".")
	else
		targ:Freeze(false)
		
		D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " unfroze ", moat_green, targ:Name(), moat_white, ".")
	end
end