COMMAND.Name = "StopSounds"
COMMAND.Flag = D3A.Config.Commands.StopSounds

COMMAND.Run = function(pl, args, supp)
	for k, v in ipairs(player.GetAll()) do
		v:SendLua("LocalPlayer():ConCommand('stopsound')")
	end
	
	D3A.Chat.Broadcast2(moat_cyan, pl:NameID(), moat_white, " has stopped sounds.")
end