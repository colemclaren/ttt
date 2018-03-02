COMMAND.Name = "reload"

COMMAND.Flag = D3A.Config.Commands.Reload

COMMAND.Args = {}

COMMAND.Run = function(pl, args, supp)
	RunConsoleCommand('changelevel', game.GetMap())
end