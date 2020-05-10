COMMAND.Name = "Comp"
COMMAND.Flag = ""

COMMAND.Run = function(pl, args, supp)
	net.Start "moat.comp.open"
	net.Send(pl)
end