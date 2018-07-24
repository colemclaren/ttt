COMMAND.Name = "Rewards"
COMMAND.Flag = D3A.Config.Commands.PlayTime
COMMAND.Args = {}

COMMAND.Run = function(pl, args, supp)
	pl:SendLua([[MOAT_DONATE:OpenWindow() MOAT_DONATE:RebuildSelection(2) MOAT_DONATE.CurCat=2]])
end