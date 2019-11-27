COMMAND.Name = "Discord"
COMMAND.Flag = D3A.Config.Commands.PlayTime
COMMAND.Args = {}

COMMAND.Run = function(pl, args, supp)
	pl:SendLua("Derma_Message([[Discord rewards require the *DOWNLOADED* Discord client to be running when you join.\nSimply open it and join our servers, and you should get a popup!\n\n(Our Discord invite is moat.chat)]],[[Discord Help]],[[Ok!]])")
end