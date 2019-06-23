COMMAND.Name = "motd"

COMMAND.Flag = D3A.Config.Commands.MoTD

COMMAND.Run = function(pl, args, supp)
	return net.Do("motd", function() net.WriteInt(0, 32) end, pl)
end