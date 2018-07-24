COMMAND.Name = "motd"

COMMAND.Flag = D3A.Config.Commands.MoTD

COMMAND.Run = function(pl, args, supp)
	pl:SendLua([[D3A.OpenMoTD()]])
end