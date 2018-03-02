COMMAND.Name = "menu"

COMMAND.Flag = D3A.Config.Commands.MoTD

COMMAND.Run = function(pl, args, supp)
	pl:SendLua([[LocalPlayer():ConCommand("mga_menu")]])
end