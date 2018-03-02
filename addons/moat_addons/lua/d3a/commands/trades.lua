COMMAND.Name = "trades"

COMMAND.Flag = D3A.Config.Commands.MoTD

COMMAND.Run = function(pl, args, supp)
	pl:SendLua([[LocalPlayer():ConCommand('moat_trades')]])
end