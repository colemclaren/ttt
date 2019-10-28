COMMAND.Name = "StopSounds"
COMMAND.Flag = D3A.Config.Commands.StopSounds

COMMAND.Run = function(pl, args, supp)
	for k, v in ipairs(player.GetAll()) do
		v:SendLua("LocalPlayer():ConCommand('stopsound')")
	end
	
	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has stopped sounds.")
end